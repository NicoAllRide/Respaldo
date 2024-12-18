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
        self.custom_failed_test_info = []
        self.server_errors = []
        self.current_file = "Unknown File"
        self.xml_path = xml_path

    def visit_suite(self, suite):
        if suite.source:
            self.current_file = os.path.basename(suite.source)
        suite.tests.visit(self)
        suite.suites.visit(self)

    def visit_test(self, test):
        # Log each test name and status for debugging
        logging.debug(f"Visiting test: {test.name}, Status: {test.status}")
        
        if test.status == 'PASS':
            self.passed_tests += 1
        elif test.status == 'FAIL':
            self.failed_tests += 1  # Increment failed test count
            error_message = self.extract_detailed_error_message(test.message)
            request_info = self.extract_request_info_from_logs(test.name)
            
            # Log the failure details for debugging
            logging.debug(f"Test Failed: {test.name}, Error Message: {error_message}")

            # Categorize failures
            if self.has_custom_message(error_message):
                fail_reason = self.extract_custom_message(error_message)
                self.custom_failed_test_info.append({
                    "file_name": self.current_file,
                    "fail_reason": fail_reason,
                    "request_info": request_info,
                    "test_name": test.name,
                    "error_message": error_message,
                })
            else:
                self.failed_test_info.append({
                    "file_name": self.current_file,
                    "test_name": test.name,
                    "error_message": error_message,
                    "request_info": request_info,
                })

    def has_custom_message(self, error_message):
        # Determinar si el error tiene un mensaje personalizado usando patrones
        patterns = [
            "No accesToken found",
            "Validation failed",
            "Missing fields",
            r"No services were created with routeId\._id",
            "Doesn't discounts tickets after validation",
            "Total tickets after validation should be",
            "User validated, should not be able to validate",
            "no tickets assigned",
            "could not reserve, failing",
            "Departures created dont have the selected route",
            "Reservations should be empty but is not",
            "release seats not working",
            "passenger couldn't validate in service with available seats"
        ]
        return any(re.search(pattern, error_message) for pattern in patterns)

    def extract_custom_message(self, error_message):
        # Extraer el mensaje personalizado basado en patrones
        if "No accesToken found" in error_message:
            return "No accessToken found in Login!, Failing"
        if "Validation failed" in error_message:
            return "User validation failed due to missing fields"
        if re.search(r"No services were created with routeId\._id", error_message):
            return "No services were created with routeId._id. All related tests failing."
        if "Doesn't discounts tickets after validation" in error_message:
            return "Ticket discount validation failed. Tickets were not discounted after validation."
        if "Total tickets after validation should be" in error_message:
            return "Ticket total after validation does not match expectations."
        if "User validated, should not be able to validate" in error_message:
            return "User improperly validated but should not have access."
        if "no tickets assigned" in error_message:
            return "Tickets were not assigned as expected."
        if "could not reserve, failing" in error_message:
            return "Reservation failed for user with certification webcontrol."
        if "Departures created dont have the selected route" in error_message:
            return "Departures created do not match the selected route."
        if "Reservations should be empty but is not" in error_message:
            return "Reservations list is not empty when it should be. Release seats functionality is not working."
        if "release seats not working" in error_message:
            return "Release seats functionality failed to work properly."
        if "passenger couldn't validate in service with available seats" in error_message:
            return "Passenger validation failed despite service having available seats."
        return "Custom error message not defined"

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

    def generate_fail_report(self):
        # Debugging counts
        logging.debug(f"Custom failed tests count: {len(self.custom_failed_test_info)}")
        logging.debug(f"General failed tests count: {len(self.failed_test_info)}")

        # Construir secciones separadas
        custom_fail_section = "\nFailed Test Cases (Summary):\n" + "-" * 50 + "\n"
        for test in self.custom_failed_test_info:
            custom_fail_section += (
                f"Failed ({test['file_name']}) Test Cases:\n"
                f"Fail reason: {test['fail_reason']}\n"
                f"Request Info: {test['request_info']}\n"
                + "-" * 50 + "\n"
            )

        all_fail_section = "\nAll Failed Test Cases:\n" + "-" * 50 + "\n"
        for test in self.failed_test_info + self.custom_failed_test_info:
            all_fail_section += (
                f"[Test Name: {test['test_name']}]\n"
                f"File Name: {test['file_name']}\n"
                f"Error Message: {test['error_message']}\n"
                f"Request Info: {test['request_info']}\n"
                + "-" * 50 + "\n"
            )

        return custom_fail_section + all_fail_section

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
                file.write(analyzer.generate_fail_report())

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
