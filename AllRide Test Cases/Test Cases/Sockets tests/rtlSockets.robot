*** Settings ***
Library  WebSocketClient
Library  Collections
Library  DateTime
Library  RPA.JSON
Library    RPA.HTTP

*** Variables ***
${SERVER}    ws://localhost:3000/socket.io/?EIO=3&transport=websocket

*** Test Cases ***
Connect And Send Location
    [Documentation]    Conecta al WebSocket, envía ubicación, recibe respuesta y se desconecta
    ${my_websocket}=  WebSocketClient.Connect  ${SERVER}
    
    # Preparar datos de ubicación
    ${latitude}=  Evaluate  40.712776
    ${longitude}=  Evaluate  -74.005974
    ${speed}=  Evaluate  50.0
    ${createdAt}=  Get Current Date  result_format=%Y-%m-%dT%H:%M:%S.%LZ
    ${location}=  Create Dictionary  latitude=${latitude}  longitude=${longitude}  speed=${speed}  createdAt=${createdAt}
    ${json}=   Set Variable    ${location.json()}
    
    # Enviar datos de ubicación
    WebSocketClient.Send  ${my_websocket}  ${json}
    
    # Recibir respuesta
    ${response}=  WebSocketClient.Recv  ${my_websocket}  
    Log  ${response}
    
    # Verificar que el mensaje contiene datos de ubicación
    ${received_location}=  Get value from JSON  str  ${response}
    Log  ${received_location}
    Should Not Be Empty  ${received_location.latitude}
    Should Not Be Empty  ${received_location.longitude}
    Should Not Be Empty  ${received_location.speed}
    Should Not Be Empty  ${received_location.createdAt}

    # Cerrar conexión
    WebSocketClient.Close  ${my_websocket}
