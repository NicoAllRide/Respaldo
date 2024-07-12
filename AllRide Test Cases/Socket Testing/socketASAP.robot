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
#------------------------DEBE SER RTL TOKEN DEL CONDUCTOR-----------------------------------------#
${TOKEN}            9859ee27c2f566d314f6f520e5d8e7f36141523c497531f475a1639f29fd407eec9101c4496bfbed16b9673698ba217695f5b28b89cf135b6a77da653ee5c4fb
${URL}              ws://stage.allrideapp.com/socket.io/?token=${TOKEN}&communityId=653fd601f90509541a748683&EIO=3&transport=websocket
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


Connect And Emit Events
    [Documentation]    Test connecting to WebSocket and sending events
    ${my_websocket}=    Connect    ${URL}
    Log    Connected to WebSocket: ${URL}

    Send    ${my_websocket}    40/pbStandby?token=${TOKEN}
    Log    Sent: 40/pbStandby?token=${TOKEN}&communityId=653fd601f90509541a748683
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar evento join

    # Enviar pings periódicos

    # Enviar evento updatePosition con nuevas coordenadas y otros datos

    Send
    ...    ${my_websocket}
    ...    42/pbStandby,["updatePosition",{"latitude":-34.3941125,"longitude":-70.7812899,"speed":0.0033060382,"createdAt":"Tue Jun 25 11:52:55 GMT-04:00 2024"}]
    Log
    ...    Sent: 42/pbStandby,["updatePosition",{"latitude":-34.3941125,"longitude":-70.7812899,"speed":0.0033060382,"createdAt":"Tue Jun 25 11:52:55 GMT-04:00 2024"}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}



    # Enviar más pings periódico

Stop Post Leg Departure
    Skip
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
