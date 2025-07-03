*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON

Library     WebSocketClient
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
${STAGE_URL}            https://stage.allrideapp.com


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

Time + 1 Hour
    ${date}    Get Current Date    time_zone=UTC    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}


Verify Open RDD in Community
    Skip
        # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/superadmin/communities/${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=     Set variable    ${response.json()}
    ${enabled}=    Set Variable     ${responseJson}[custom][realTimeTransportSystem][buses][oDDServices][0][userRequests][freeRequests][enabled]
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    
    Should Be Equal As Strings    ${enabled}   True

Get Places
        ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/places/list?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}
Create RDD As Admin
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd?community=${idComunidad}

    ...    data={"superCommunityId":"${idSuperCommunity}","adminId":"${idAdmin}","adminName":"Soporte AllRide","oddSimpleFlow":false,"state":"pendingDriverAssignment","name":"RDD Common Destiny Flow","oddType":"Taxis Coni y Nico","placeLat":-33.4098734,"placeLon":-70.5673477,"serviceCost":null,"apportionByParams":[],"direction":"in","comments":"","serviceDate":"${formatted_one_hour_later}","extraMinutes":0,"estimatedArrival":"${r_estimated_arrival1}","reservations":[{"userId":"${idNico}","stopId":"655d11d88a5a1a1ff0328466","placeId":null,"order":0,"estimatedArrival":"${r_estimated_arrival1}","distances":{"fromPrevious":0,"toNext":4334,"distanceToLocation":4334,"pctToLocation":1}}],"waypoints":[[-70.54732,-33.39116],[-70.54727000000001,-33.39133],[-70.54721,-33.391470000000005],[-70.54716,-33.391540000000006],[-70.54705,-33.39162],[-70.54695000000001,-33.3917],[-70.54689,-33.391780000000004],[-70.54689,-33.39181],[-70.54693,-33.39188],[-70.54698,-33.3919],[-70.54719,-33.39193],[-70.54751,-33.391270000000006],[-70.54761,-33.3911],[-70.54766000000001,-33.390950000000004],[-70.54774,-33.390660000000004],[-70.54785000000001,-33.39038],[-70.54812000000001,-33.38983],[-70.54827,-33.389500000000005],[-70.54875000000001,-33.38969],[-70.54948,-33.389970000000005],[-70.54953,-33.390010000000004],[-70.54971,-33.39011],[-70.55007,-33.39025],[-70.55031000000001,-33.390370000000004],[-70.5505,-33.390480000000004],[-70.55272000000001,-33.39135],[-70.55353000000001,-33.39166],[-70.55436,-33.39193],[-70.55537000000001,-33.392300000000006],[-70.55657000000001,-33.39271],[-70.55855000000001,-33.393370000000004],[-70.56148,-33.394400000000005],[-70.56253000000001,-33.394740000000006],[-70.56457,-33.395480000000006],[-70.56617,-33.39603],[-70.56643000000001,-33.396060000000006],[-70.56678000000001,-33.39616],[-70.56710000000001,-33.39627],[-70.5673,-33.39631],[-70.56773000000001,-33.396460000000005],[-70.56902000000001,-33.396910000000005],[-70.56936,-33.39705],[-70.57007,-33.397310000000004],[-70.5706,-33.39745],[-70.57089,-33.397560000000006],[-70.57161,-33.397830000000006],[-70.57183,-33.39777],[-70.5719,-33.39772],[-70.57194000000001,-33.39764],[-70.57193000000001,-33.39746],[-70.5719,-33.397360000000006],[-70.57187,-33.397310000000004],[-70.57182,-33.39728],[-70.57173,-33.397270000000006],[-70.57153000000001,-33.397330000000004],[-70.57133,-33.39791],[-70.57121000000001,-33.398250000000004],[-70.57106,-33.398500000000006],[-70.57043,-33.40035],[-70.56976,-33.40227],[-70.56971,-33.402390000000004],[-70.56920000000001,-33.40377],[-70.56885000000001,-33.40473],[-70.56839000000001,-33.406040000000004],[-70.56824,-33.406420000000004],[-70.56827000000001,-33.406560000000006],[-70.56826000000001,-33.40666],[-70.56773000000001,-33.407790000000006],[-70.56759000000001,-33.408150000000006],[-70.56728000000001,-33.40885],[-70.56711,-33.409330000000004],[-70.56695,-33.40979]],"estimatedDistance":4334,"startLocation":{"lat":-33.3908833,"lon":-70.54620129999999,"loc":[-70.54620129999999,-33.3908833],"placeId":null,"stopId":"655d11d88a5a1a1ff0328466"},"endLocation":{"lat":-33.4098734,"lon":-70.5673477,"loc":[-70.5673477,-33.4098734],"placeId":null,"stopId":"655d11d88a5a1a1ff0328464","referencePoint":true},"placeWaitTime":0,"reason":"","linkedDeparture":null,"reservationsToLink":[],"isPastService":false,"communityId":"","placeId":null,"stopId":"655d11d88a5a1a1ff0328464","serviceHour":"","placeName":"Mall Apumanque Avenida Manquehue Sur, Las Condes, Chile","placeLongName":"Mall Apumanque Avenida Manquehue Sur, Las Condes, Chile","hourIsDepartureOrArrival":"arrival","roundedDistance":"4.33","travelTime":529,"originalEstimatedArrival":"","originalServiceDate":"","originalTravelTime":529,"adjustmentFactor":1,"totalReservations":1,"arrivalDate":"${arrival_date}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${rddId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${rddId}


####################################################
##Get Routes As Driver Pendiente

#######################################################

Assign Driver
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/assignDriver/${rddId}?community=${idComunidad}
    ...    data={"driver":{"driverId":"${driverId}","driverCode":"${driverCode}"},"drivers":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
Assign Vehicle
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/assignVehicle/${rddId}?community=${idComunidad}
    ...    data={"vehicleId":"${vehicleId}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad}&driverId=${driverId}

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

Driver Accept Service
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/acceptOrReject/${rddId}
    ...    data={"state":"accepted"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Start Departure PreLeg
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/leg/start
    ...    data={"departureId":"${rddId}","communityId":"${idComunidad}","startLat":-33.3908833,"startLon":-70.54620129999999,"legType":"pre","customParamsAtStart":[],"preTripChecklist":[],"capacity":3,"busCode":"1111","driverCode":"753","vehicleId":"${vehicleId}","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${departureToken}
    Set Global Variable    ${access_token}

    Log    ${departureToken}
    Log    ${code}

Connect PRE
    ${URL_with_token}=    Set Variable    wss://stage.allrideapp.com/socket.io/?token=${access_token}&EIO=3&transport=websocket
    ${my_websocket}=    Connect    ${URL_with_token}
    Log    Connected to WebSocket

    Send    ${my_websocket}    40/pbDriver?token=${access_token}
    Sleep    2s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received (auth): ${result}

    Send    ${my_websocket}    42/pbDriver,["join"]
    Sleep    2s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received (join): ${result}

    Send    ${my_websocket}    42/pbDriver,["start", {"latitude": -33.408000, "longitude": -70.565000}]
    Sleep    2s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received (start): ${result}

    Send    ${my_websocket}    42/pbDriver,["newPosition",{"latitude": -33.408100, "longitude": -70.565100, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Posición inicial enviada: ${result}

    Send    ${my_websocket}    42/pbDriver,["newPosition",{"latitude": -33.4100434, "longitude": -70.5678520, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Posición inicial desviada final: ${result}
Start Departure Leg
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/${rddId}
    ...    data={"departureId":"${rddId}","communityId":"${idComunidad}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"capacity":2,"busCode":"1111","driverCode":"159753","vehicleId":"666941a7b8d6ea30f9281110","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    Set Global Variable    ${access_token}
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken}
    Log    ${code}
    Set Global Variable    ${departureToken}

Tramo 1
   ${URL_with_token}=    Set Variable    wss://stage.allrideapp.com/socket.io/?token=${access_token}&EIO=3&transport=websocket
    ${my_websocket}=    Connect    ${URL_with_token}
    Log    Connected to WebSocket

    Send    ${my_websocket}    40/pbDriver?token=${access_token}
    Sleep    2s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received (auth): ${result}

    Send    ${my_websocket}    42/pbDriver,["join"]
    Sleep    2s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received (join): ${result}
    Send    ${my_websocket}    42/pbDriver,["newPosition",{"latitude": -33.4087627, "longitude": -70.5670580, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Pos1: ${result}

    Send    ${my_websocket}    42/pbDriver,["newPosition",{"latitude": -33.4100434, "longitude": -70.5678520, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Pos2: ${result}

    Send    ${my_websocket}    42/pbDriver,["newPosition",{"latitude": -33.4100434, "longitude": -70.5678520, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Pos2: ${result}

Stop Departure With Post Leg
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/stop
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":true,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Tramo 2 y Stop
   ${URL_with_token}=    Set Variable    wss://stage.allrideapp.com/socket.io/?token=${access_token}&EIO=3&transport=websocket
    ${my_websocket}=    Connect    ${URL_with_token}
    Log    Connected to WebSocket

    Send    ${my_websocket}    40/pbDriver?token=${access_token}
    Sleep    2s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received (auth): ${result}

    Send    ${my_websocket}    42/pbDriver,["join"]
    Sleep    2s
    Send    ${my_websocket}    42/pbDriver,["newPosition",{"latitude": -33.4099628, "longitude": -70.5680129, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Pos3: ${result}

    Send    ${my_websocket}    42/pbDriver,["newPosition",{"latitude": -33.4098553, "longitude": -70.5711779, "capacity": 0, "speed": 4.0, "panicking": false, "full": false}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Pos4: ${result}

    Send    ${my_websocket}    42/pbDriver,["stop",{}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    STOP: ${result}

Stop Post Leg Departure
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/stop
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":false,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    
    ${legs}=    Get From Dictionary    ${response.json()}    legs

    ${lengthValue}=    Get Length    ${legs}
    # Verify there are exactly 3 legs
    Length Should Be    ${legs}    3    msg=Expected 3 legs but found ${lengthValue}

    # Verify order: pre, service, post
    Should Be Equal As Strings    ${legs[0]["type"]}    pre    msg=The first leg should be 'pre'
    Should Be Equal As Strings    ${legs[1]["type"]}    service    msg=The second leg should be 'service'
    Should Be Equal As Strings    ${legs[2]["type"]}    post    msg=The third leg should be 'post'

    # Check that each leg has a distance greater than 0
    FOR    ${leg}    IN    @{legs}
        ${dist}=    Get From Dictionary    ${leg}    distance
        Should Be True    ${dist} > 0    msg= ${leg["type"]} Leg has distance ${dist}, which should be greater than 0
    END

