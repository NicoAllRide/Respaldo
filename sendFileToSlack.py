import logging
import sys
import os
import re
from robot.api import ExecutionResult
from robot.result.visitor import ResultVisitor
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError
from xml.etree import ElementTree as ET

SLACK_TOKEN = os.environ["SLACK_TOKEN"]
# Configurar el nivel de depuración del registro
logging.basicConfig(level=logging.DEBUG)

class TestResultAnalyzer(ResultVisitor):
    def __init__(self, xml_path):
        self.passed_tests = 0
        self.failed_tests = 0
        self.failed_test_info = []
        self.server_errors = []
        self.current_file = "Unknown File"
        self.xml_path = xml_path

    def visit_suite(self, suite):
        if suite.source:
            self.current_file = os.path.basename(suite.source)
        suite.tests.visit(self)
        suite.suites.visit(self)

    def visit_test(self, test):
        if test.status == 'PASS':
            self.passed_tests += 1
        elif test.status == 'FAIL':
            error_message = self.extract_detailed_error_message(test.message)
            request_info = self.extract_request_info_from_logs(test.name)

            # Determinar el tipo de error
            error_type = self.determine_error_type(error_message)

            # Construir mensaje de error detallado
            detailed_error = (
                f"File Name: {self.current_file}\n"
                f"Error Message: {error_message}\n"
                f"Request Info: {request_info}\n"
            )

            if self.is_server_error(error_message):
                self.server_errors.append(detailed_error)
            else:
                self.failed_tests += 1
                self.failed_test_info.append(detailed_error)

    def extract_detailed_error_message(self, message):
        body_match = re.search(r'(?<=Response Body: ).*', message, re.DOTALL)
        return body_match.group(0) if body_match else message

    def extract_request_info_from_logs(self, test_name):
        tree = ET.parse(self.xml_path)
        root = tree.getroot()

        for test in root.iter('test'):
            if test.attrib['name'] == test_name:
                for kw in test.iter('kw'):
                    for msg in kw.iter('msg'):
                        if re.search(r'(GET|POST|PUT|DELETE) Request : url=', msg.text):
                            # Extract the main part of the request, excluding path_url and headers
                            request_info = msg.text.split('path_url=')[0].strip()
                            return request_info
        return "No request info found"

    def determine_error_type(self, error_message):
        if self.is_server_error(error_message):
            return "Server Error"
        elif "IndexError" in error_message:
            return "Index Error"
        elif "Variable" in error_message:
            return "Variable Error"
        return "General Error"

    def is_server_error(self, message):
        return re.search(r'HTTPError: 5\d\d Server Error', message) is not None

if __name__ == '__main__':
    try:
        output_file = sys.argv[1]
    except IndexError:
        output_file = "output.xml"

    result = ExecutionResult(output_file)
    analyzer = TestResultAnalyzer(output_file)
    result.visit(analyzer)

    total_tests = analyzer.passed_tests + analyzer.failed_tests
    passed_percentage = (analyzer.passed_tests / total_tests) * 100 if total_tests > 0 else 0

    # Construir el mensaje a enviar a Slack
    message_text = (
        f"Resultado de las pruebas:\n"
        f"Total Tests: {total_tests}\n"
        f"Passed Tests: {analyzer.passed_tests}\n"
        f"Failed Tests: {analyzer.failed_tests}\n"
        f"Server Errors: {len(analyzer.server_errors)}\n"
        f"Passed Percentage: {passed_percentage:.2f}%\n"
    )

    # Inicializar el cliente de la API web de Slack con tu token de autenticación
    client = WebClient(token=SLACK_TOKEN)

    try:
        # Enviar el resumen a Slack
        response = client.chat_postMessage(
            channel="C071RRWNYF9",  # Reemplaza con el ID de tu canal
            text=message_text
        )

        if response["ok"]:
            print("Mensaje enviado a Slack exitosamente.")
        else:
            print(f"Error al enviar el mensaje a Slack: {response['error']}")

        # Verificar si hay pruebas fallidas para enviar el archivo con detalles
        if analyzer.failed_tests > 0 or len(analyzer.server_errors) > 0:
            # Guardar el detalle de los errores en un archivo
            with open("detalle_pruebas.txt", "w") as file:
                file.write("Server Errors:\n")
                for error_info in analyzer.server_errors:
                    file.write(f"{error_info}\n")
                    file.write("-" * 50 + "\n")

                file.write("--------------------------------------------------\n\n")
                file.write("Failed Test Cases:\n")
                for test_info in analyzer.failed_test_info:
                    file.write(f"{test_info}\n")
                    file.write("-" * 50 + "\n")

            print("Detalle de las pruebas guardado en 'detalle_pruebas.txt'.")

            # Subir el archivo a Slack
            with open("detalle_pruebas.txt", "r") as file:
                file_content = file.read()

            new_file = client.files_upload_v2(
                title="detalle_pruebas",
                filename="detalle_pruebas.txt",
                content=file_content,
            )

            file_url = new_file.get("file").get("permalink")
            new_message = client.chat_postMessage(
                channel="C071RRWNYF9",  # Reemplaza con el ID de tu canal
                text=f"Detalle de pruebas fallidas: {file_url}",
            )

            print(f"Archivo subido y compartido en Slack: {file_url}")
        else:
            print("Todas las pruebas pasaron. No se enviará archivo de detalles.")

    except SlackApiError as e:
        print(f"Error al enviar el mensaje a Slack: {e.response['error']}")
