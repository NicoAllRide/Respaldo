*** Settings ***
Library     WebSocketClient
Library     BuiltIn
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON


*** Variables ***
${TOKEN}            c7c250649d48caaa7a642daf68a5206ad5362e919d74c83abde3a028457a8eb10ffb69e1ee37d24acc0fcab1b2122e212150594c4f23d59482e4d07ecb256f1a
${URL}              ws://stage.allrideapp.com/socket.io/?token=${TOKEN}&EIO=3&transport=websocket
${LATITUDE}         -34.40274888966042
${LONGITUDE}        -70.85938591407319
${NEW_LATITUDE}     -34.40274888966042
${NEW_LONGITUDE}    -70.85938591407319
${IS_FULL}          false
${IS_PANICKING}     false
${CAPACITY}         4
${SPEED}            50.5
${STAGE_URL}            https://stage.allrideapp.com


*** Test Cases ***

Start Route As Driver
    Skip
        Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer 1f7169231ec36bc77996f1f880649e9e0d6fded6955552bca71d1878fd51c868acfaa3295ad24bf58c230e165e43de1956930a7ec6d33d90623422b18b1df35f     Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/cp/round
    ...    data={"routeId":"666b2bd9bfaab8adfaf53f25"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    Sleep    5s

Connect Socket CP
    [Documentation]    Test connecting to WebSocket and sending events
    ${my_websocket}=    Connect    ${URL}
    Set Global Variable    ${my_websocket}
    Log    Connected to WebSocket: ${URL}

    Send    ${my_websocket}    40/cpDriver?token=${TOKEN}
    Log    Sent: 40/cpDriver?token=${TOKEN}
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}


Send Join
    # Enviar evento join
    Send    ${my_websocket}    42/cpDriver,["join"]
    Log    Sent: 42/cpDriver,["join"]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar pings periódicos

Send Start
    # Enviar evento start con latitud y longitud fijos
    Send    ${my_websocket}    42/cpDriver,["start", {"latitude": ${LATITUDE}, "longitude": ${LONGITUDE}}]
    Log    Sent: 42/cpDriver,["start", {"latitude": ${LATITUDE}, "longitude": ${LONGITUDE}}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar evento newPosition con nuevas coordenadas y otros datos
Send newPosition
    Send
    ...    ${my_websocket}
    ...    42/cpDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-34.3941093,"longitude":-70.7813055,"speed":3.9972}]
    Log
    ...    Sent: 42/cpDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-34.3941093,"longitude":-70.7813055,"speed":3.9972}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

Send Stop
    Send
    ...    ${my_websocket}
    ...    42/cpDriver,["stop",{}]
    Log
    ...    Sent: 42/cpDriver,["stop",{}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar más pings periódico


