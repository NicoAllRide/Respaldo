*** Settings ***
Library    RPA.Email.ImapSmtp

*** Variables ***
${EMAIL_SERVER}    imap.gmail.com
${EMAIL_PORT}      993
${EMAIL_USER}      tu_correo@gmail.com
${EMAIL_PASS}      tu_password

*** Test Cases ***
Leer Y Verificar El Último Correo
    # Conectar al servidor IMAP
        ${EMAIL_SERVER}    ${EMAIL_PORT}    ${EMAIL_USER}    ${EMAIL_PASS}    folder=INBOX

    # Obtener los últimos 5 correos (puedes ajustar este número)
    ${EMAILS}=    List Messages    ALL    limit=5

    # Obtener el cuerpo del último correo
    ${LATEST_EMAIL_BODY}=    Get Message Body    ${EMAILS[0]['uid']}

    # Mostrar el cuerpo del correo en los logs
    Log    El cuerpo del último correo es: ${LATEST_EMAIL_BODY}

    # Verificar que el cuerpo del correo contiene el texto esperado
    Should Contain    ${LATEST_EMAIL_BODY}    "Texto esperado"

    # Cerrar la conexión
    Close Mailbox
