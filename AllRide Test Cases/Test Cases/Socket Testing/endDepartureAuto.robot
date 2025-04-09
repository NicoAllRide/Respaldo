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
Resource    ../Variables/variablesStage.robot


*** Variables ***
#------------------------DEBE SER DEPARTURE TOKEN, NO RTL-----------------------------------------#
${TOKEN}            d39b2cd278ccdb8e15bd587d386935b2e727876e2ec225044de7ef7858d6f9a0e26378c14a48bd8a997f129ff7bf73843dce49bbcec490c478ae5dcf948e81b8
${URL}              ws://stage.allrideapp.com/socket.io/?token=${TOKEN}&EIO=3&transport=websocket
${LATITUDE}         -33.40783132925352
${LONGITUDE}        -70.56331367840907
${NEW_LATITUDE}     -34.40274888966042
${NEW_LONGITUDE}    -70.85938591407319
${IS_FULL}          false
${IS_PANICKING}     false
${CAPACITY}         4
${SPEED}            50.5
${STAGEQA_URL}            https://stage.allrideapp.com


*** Test Cases ***

Set Date Variables
    ${fecha_hoy}=    Get Current Date    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_hoy}

    ${fecha_manana}=    Add Time To Date    ${fecha_hoy}    1 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_manana}

    ${fecha_pasado_manana}=    Add Time To Date    ${fecha_hoy}    2 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_pasado_manana}
    ${fecha_pasado_pasado_manana}=    Add Time To Date    ${fecha_hoy}    3 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_pasado_pasado_manana}

    ${dia_actual}=    Convert Date    ${fecha_hoy}    result_format=%a
    ${dia_actual_lower}=    Set Variable    ${dia_actual.lower()}

    ${arrival_date}=    Set Variable    ${fecha_manana}T01:00:00.000Z
    Set Global Variable    ${arrival_date}
    ${r_estimated_arrival1}=    Set Variable    ${fecha_manana}T14:45:57.000Z
    Set Global Variable    ${r_estimated_arrival1}
    ${service_date}=    Set Variable    ${fecha_manana}T00:25:29.000Z
    Set Global Variable    ${service_date}
    ${modified_arrival_date}=    Set Variable    ${fecha_manana}T01:00:00.000Z
    Set Global Variable    ${modified_arrival_date}
    ${r_modified_estimated_arrival}=    Set Variable    ${fecha_pasado_manana}T14:45:57.000Z
    Set Global Variable    ${r_modified_estimated_arrival}
    ${modified_service_date}=    Set Variable    ${fecha_manana}T00:25:29.000Z
    Set Global Variable    ${modified_service_date}
    ${service_date_20min}=    Set Variable    ${fecha_manana}T00:20:00.000Z
    Set Global Variable    ${service_date_20min}
    ${service_date_22min}=    Set Variable    ${fecha_manana}T00:47:00.000Z
    Set Global Variable    ${service_date_22min}
    ${start_date}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    Set Global Variable    ${start_date}
    ${end_date_4weeks}=    Set Variable    2023-12-30T02:59:59.999Z
    Set Global Variable    ${end_date_4weeks}
    ${end_date}=    Set Variable    ${fecha_pasado_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date}
    ${end_date_tomorrow}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_tomorrow}
    ${schedule_day}=    Set Variable    ${dia_actual_lower}
    Set Global Variable    ${schedule_day}
    ${start_date_today}=    Set Variable    ${fecha_hoy}T03:00:00.000Z
    Set Global Variable    ${start_date_today}
    ${today_date}=    Set Variable    ${fecha_hoy}
    Set Global Variable    ${today_date}
    ${end_date_tomorrow2}=    Set Variable    ${fecha_manana}T02:59:59.999Z
    Set Global Variable    ${end_date_tomorrow}
    ${expiration_date_qr}=    Set Variable    ${fecha_manana}T14:10:37.968Z
    Set Global Variable    ${expiration_date_qr}
    ${start_date_tickets}=     Set Variable     ${fecha_hoy}T04:00:00.000Z
        Set Global Variable    ${start_date_tickets}
    ${end_date_tickets}=     Set Variable     ${fecha_manana}T03:59:59.999Z
        Set Global Variable    ${end_date_tickets}

1 hours local 
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}


Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGEQA_URL}/api/v1/admin/pb/drivers/?community=${idComunidad}&driverId=668309b8bb41bfd79a461dc3

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver}

    Log    ${tokenDriver}
    Log    ${response.content}


#------------------------Crear nueva ruta calendarizada alertas y reemplazar Create new service in the selected route----------------------------------##


Start Departure Leg
    Create Session    mysesion    ${STAGEQA_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure
    ...    data={"communityId":"653fd601f90509541a748683","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"67166fb78361574e33c76b3b","capacity":2,"busCode":"1111","driverCode":"159753","vehicleId":"666941a7b8d6ea30f9281110","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    Set Global Variable    ${access_token}
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    ${departureId}=    Set Variable    ${response.json()}[_id]
    Log    ${departureToken}
    Log    ${code}
    Set Global Variable    ${departureToken}
    Set Global Variable    ${departureId}

Connect And Emit Events
    [Documentation]    Test connecting to WebSocket and sending events
    ${URL_with_token}=     Set variable    wss://stageqa.allrideapp.com/socket.io/?token=${access_token}&EIO=3&transport=websocket
    ${my_websocket}=    Connect    ${URL_with_token}
    Log    Connected to WebSocket

    Send    ${my_websocket}    40/pbDriver?token=${access_token}
    Log    Sent: 40/pbDriver?token=${access_token}
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar evento join
    Send    ${my_websocket}    42/pbDriver,["join"]
    Log    Sent: 42/pbDriver,["join"]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar pings periódicos

    # Enviar evento start con latitud y longitud fijos
    Send    ${my_websocket}    42/pbDriver,["start", {"latitude": ${LATITUDE}, "longitude": ${LONGITUDE}}]
    Log    Sent: 42/pbDriver,["start", {"latitude": ${LATITUDE}, "longitude": ${LONGITUDE}}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar evento newPosition con nuevas coordenadas y otros datos

    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40824331065313,"longitude":-70.56498737648734,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40876276266083,"longitude":-70.56705804166151,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.41004346727125,"longitude":-70.56785197544258,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.4099628640414,"longitude":-70.56801290796575,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}



    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["stop",{}]
    Log
    ...    Sent: 42/pbDriver,["stop",{}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

##### GENERAR COORDENADAS DEL TRAZADO PARA SIMULAR UNA RUTA ALTERNA Y ENTRAR A LA SIGUIENTE PARADA


Get Departure in admin, should be activeFalse

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGEQA_URL}/api/v1/admin/pb/departures/${departureId}?community=653fd601f90509541a748683


    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${responseJson}=    Set Variable    ${response.json()}
    ${activeDeparture}=    Set Variable    ${responseJson}[active]
    Should Be Equal As Strings    ${activeDeparture}    False
    Log    ${response.content}
