import logging
import sys
import os
import re
from robot.api import ExecutionResult
from robot.result.visitor import ResultVisitor
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError
from xml.etree import ElementTree as ET
import openai

SLACK_TOKEN = "xoxb-3501329970642-7009206964070-Wk86svxwZwdJaY11UpUJ1qP1"
OPENAI_API_KEY = "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"
openai.api_key = OPENAI_API_KEY

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
        if test.status == 'PASS':
            self.passed_tests += 1
        elif test.status == 'FAIL':
            self.failed_tests += 1
            error_message = self.extract_detailed_error_message(test.message)
            request_info = self.extract_request_info_from_logs(test.name)

            if self.is_server_error(error_message):
                self.server_errors.append({
                    "file_name": self.current_file,
                    "test_name": test.name,
                    "error_message": error_message,
                    "request_info": request_info,
                })

            self.failed_test_info.append({
                "file_name": self.current_file,
                "test_name": test.name,
                "error_message": error_message,
                "request_info": request_info,
            })

    def is_server_error(self, error_message):
        return re.search(r'5\d{2} Server Error', error_message) is not None

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
                            return msg.text.split('path_url=')[0].strip()
        return "No request info found"

    def generate_fail_report(self):
        report_sections = []

        if self.server_errors:
            section = "\nServer Errors:\n" + "-" * 50 + "\n"
            for error in self.server_errors:
                section += (
                    f"[Test Name: {error['test_name']}]\n"
                    f"File Name: {error['file_name']}\n"
                    f"Error Message: {error['error_message']}\n"
                    f"Request Info: {error['request_info']}\n"
                    + "-" * 50 + "\n"
                )
            report_sections.append(section)

        if self.failed_test_info:
            section = "\nAll Failed Test Cases:\n" + "-" * 50 + "\n"
            for test in self.failed_test_info:
                section += (
                    f"[Test Name: {test['test_name']}]\n"
                    f"File Name: {test['file_name']}\n"
                    f"Error Message: {test['error_message']}\n"
                    f"Request Info: {test['request_info']}\n"
                    + "-" * 50 + "\n"
                )
            report_sections.append(section)

        return "\n".join(report_sections)

def get_ai_summary_from_failures(failed_cases):
    prompt = (
        "Eres un asistente QA. Resume los errores siguientes para desarrolladores. Agrúpalos si son similares y sugiere posibles causas:\n\n"
    )
    for case in failed_cases:
        prompt += f"- Test: {case['test_name']}\n  Error: {case['error_message']}\n  Request: {case['request_info']}\n\n"

    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "Eres un ingeniero QA experto."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.4,
        max_tokens=800
    )

    return response.choices[0].message.content.strip()

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

    message_text = (
        f"Resultado de las pruebas:\n"
        f"Total Tests: {total_tests}\n"
        f"Passed Tests: {analyzer.passed_tests}\n"
        f"Failed Tests: {analyzer.failed_tests}\n"
        f"Server Errors: {len(analyzer.server_errors)}\n"
        f"Passed Percentage: {passed_percentage:.2f}%\n"
    )

    client = WebClient(token=SLACK_TOKEN)

    try:
        response = client.chat_postMessage(
            channel="C070FNX0CHG",
            text=message_text
        )

        if analyzer.failed_tests > 0:
            with open("detalle_pruebas.txt", "w", encoding="utf-8") as file:
                file.write(analyzer.generate_fail_report())

            ai_summary = get_ai_summary_from_failures(analyzer.failed_test_info)

            with open("detalle_pruebas.txt", "a", encoding="utf-8") as file:
                file.write("\n\nResumen generado por IA:\n")
                file.write("=" * 50 + "\n")
                file.write(ai_summary)

            with open("detalle_pruebas.txt", "r", encoding="utf-8") as file:
                file_content = file.read()

            new_file = client.files_upload_v2(
                title="detalle_pruebas",
                filename="detalle_pruebas.txt",
                content=file_content,
            )

            file_url = new_file.get("file").get("permalink")
            client.chat_postMessage(
                channel="C070FNX0CHG",
                text=f"Detalle de pruebas fallidas: {file_url}",
            )

    except SlackApiError as e:
        print(f"Error al enviar el mensaje a Slack: {e.response['error']}")
