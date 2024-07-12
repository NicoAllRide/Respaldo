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
#------------------------DEBE SER DEPARTURE TOKEN, NO RTL-----------------------------------------#
${TOKEN}            d39b2cd278ccdb8e15bd587d386935b2e727876e2ec225044de7ef7858d6f9a0e26378c14a48bd8a997f129ff7bf73843dce49bbcec490c478ae5dcf948e81b8
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

Start Departure Leg
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=Bearer f646104e4f6c325d06217a6874adec2b58be606ff5e4ff8648667a902e6068afc7cc97e7679fb83a6a6911f1efead7f521bf15a2f615cc99964196420fe27c49
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures
    ...    data={"communityId":"653fd601f90509541a748683","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"routeId":"65a6f25e43fd7b6e52391fac","capacity":3,"busCode":"1111","vehicleId":"65b8f12320443b7f47d68315","shareToUsers":false,"customParams":[],"pin":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${departureToken}
    Log    ${departureToken}
    Log    ${code}

Connect And Emit Events
    [Documentation]    Test connecting to WebSocket and sending events
    ${my_websocket}=    Connect    ${URL}
    Log    Connected to WebSocket: ${URL}

    Send    ${my_websocket}    40/pbDriver?token=${TOKEN}
    Log    Sent: 40/pbDriver?token=${TOKEN}
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar evento join
    Send    ${my_websocket}    42/pbDriver,["join"]
    Log    Sent: 42/pbDriver,["join"]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar pings periódicos

    # Enviar evento start con latitud y longitud fijos
    Send    ${my_websocket}    42/pbDriver,["start", {"latitude": ${LATITUDE}, "longitude": ${LONGITUDE}}]
    Log    Sent: 42/pbDriver,["start", {"latitude": ${LATITUDE}, "longitude": ${LONGITUDE}}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar evento newPosition con nuevas coordenadas y otros datos

    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-34.3941093,"longitude":-70.7813055,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-34.3941093,"longitude":-70.7813055,"speed":3.9972}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["stop",{}]
    Log
    ...    Sent: 42/pbDriver,["stop",{}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar más pings periódico

Stop Post Leg Departure
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=Bearer d39b2cd278ccdb8e15bd587d386935b2e727876e2ec225044de7ef7858d6f9a0e26378c14a48bd8a997f129ff7bf73843dce49bbcec490c478ae5dcf948e81b8
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/stop
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":false,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

    Sleep    10s
