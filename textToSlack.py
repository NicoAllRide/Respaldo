import logging
import sys
import re
import os
import xml.etree.ElementTree as ET
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

# Configurar el nivel de depuración del registro
logging.basicConfig(level=logging.DEBUG)

def parse_robot_output(output_file):
    tree = ET.parse(output_file)
    root = tree.getroot()
    
    test_info_list = []
    passed_tests = 0
    failed_tests = 0
    
    for suite in root.findall('.//suite'):
        source = suite.get('source', 'Unknown Source')
        if source.endswith('.robot'):
            filename = os.path.basename(source)
        else:
            filename = 'Unknown File'
        
        for test in suite.findall('.//test'):
            test_name = test.get('name', 'Unknown Test')
            error_message = None
            url = "Unknown URL"
            
            # Verificar el estado de la prueba
            status = test.find('status').get('status', 'UNKNOWN')
            if status == 'PASS':
                passed_tests += 1
            elif status == 'FAIL':
                failed_tests += 1
                
                # Buscar mensaje de error y URL
                for kw in test.findall('kw'):
                    for msg in kw.findall('msg'):
                        if msg.get('level') == 'FAIL':
                            error_message = msg.text
                    for arg in kw.findall('arg'):
                        if 'url=' in arg.text:
                            url_match = re.search(r'url=(\S+)', arg.text)
                            if url_match:
                                url = url_match.group(1)
                
                if error_message:
                    test_info_list.append({
                        'File Name': filename,
                        'Test Name': test_name,
                        'Error Message': error_message,
                        'URL': url,
                    })
    
    return test_info_list, passed_tests, failed_tests

if __name__ == '__main__':
    try:
        output_file = sys.argv[1]
    except IndexError:
        output_file = "output.xml"
    
    test_info_list, passed_tests, failed_tests = parse_robot_output(output_file)
    total_tests = passed_tests + failed_tests
    passed_percentage = (passed_tests / total_tests) * 100 if total_tests > 0 else 0
    
    # Construir el mensaje a enviar a Slack
    message = f"Resultado de las pruebas:\nTotal Tests: {total_tests}\nPassed Tests: {passed_tests}\nFailed Tests: {failed_tests}\nPassed Percentage: {passed_percentage:.2f}%\n\n"

    # Inicializar el cliente de la API web de Slack con tu token de autenticación
    client = WebClient(token="xoxb-3501329970642-7009206964070-Pz6gtf7ezzwAoYWQPHuRjCtL")

    try:
        # Enviar el mensaje a Slack
        response = client.chat_postMessage(
            channel="C070FNX0CHG",
            text=message
        )
        if response["ok"]:
            print("Mensaje enviado a Slack exitosamente.")
        else:
            print(f"Error al enviar el mensaje a Slack: {response['error']}")
    except SlackApiError as e:
        print(f"Error al enviar el mensaje a Slack: {e.response['error']}")

    # Guardar el detalle en un archivo
    with open("detalle_pruebas.txt", "w") as file:
        file.write("Failed Test Cases:\n")
        for test_info in test_info_list:
            file.write(f"File Name: {test_info['File Name']}\n")
            file.write(f"Test Name: {test_info['Test Name']}\n")
            file.write(f"Error Message: {test_info['Error Message']}\n")
            file.write(f"URL: {test_info['URL']}\n")
            file.write("-" * 50 + "\n")
    
    print("Detalle de las pruebas guardado en 'detalle_pruebas.txt'.")

    # Leer el contenido del archivo
    with open("detalle_pruebas.txt", "r") as file:
        file_content = file.read()

    try:
        # Aumentar el tiempo de espera y subir el archivo
        new_file = client.files_upload_v2(
            title="detalle_pruebas",
            filename="detalle_pruebas.txt",
            content=file_content,
            timeout=600,  # Aumentar el tiempo de espera a 10 minutos
        )
        # Compartir el archivo en un canal
        file_url = new_file.get("file").get("permalink")
        client.chat_postMessage(
            channel="C070FNX0CHG",
            text=f"Detalle de pruebas fallidas: {file_url}",
        )
    except SlackApiError as e:
        print(f"Error al subir el archivo a Slack: {e.response['error']}")
