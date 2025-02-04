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
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad}&driverId=${driverId2}

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

Create new service in the selected route
    
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"_id":"67a0f450b68d7ccc758d6857","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":5,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":5,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"_id":"67a0f4beb68d7ccc758d69c0","stopId":"67506a5fc46fdbfcb4fa0202","scheduledDate":"2025-02-03T17:05:00.286Z"},{"_id":"67a0f4beb68d7ccc758d69c1","stopId":"67a0f40cb68d7ccc758d62c7","scheduledDate":null},{"_id":"67a0f4beb68d7ccc758d69c2","stopId":"67506a5fc46fdbfcb4fa01ff","scheduledDate":null}],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["67a0f450b68d7ccc758d6857"],"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"DNIValidation":{"enabled":false},"assistantIds":[],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":true,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":false,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"hasBarrier":false,"name":"Notify Users by Stop(paradas intermedias)","shapeId":"67a0f450b68d7ccc758d6822","description":"rutaprueba","extraInfo":"","color":"944f4f","canReserve":null,"legOptions":[],"ownerIds":[{"_id":"67a0f450b68d7ccc758d685b","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[],"roundOrder":[{"stopId":"67506a5fc46fdbfcb4fa0202","notifyIfPassed":false},{"stopId":"67a0f40cb68d7ccc758d62c7","notifyIfPassed":false},{"stopId":"67506a5fc46fdbfcb4fa01ff","notifyIfPassed":false}],"communityId":"6654ae4eba54fe502d4e4187","timeOnRoute":12,"distance":5,"distanceInMeters":5422,"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2025-02-03T16:52:32.567Z","updatedAt":"2025-02-03T16:54:22.681Z","__v":1,"destinationStop":"67506a5fc46fdbfcb4fa01ff","originStop":"67506a5fc46fdbfcb4fa0202","routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"superCommunityId":"653fd68233d83952fafcd4be","useServiceReservations":true,"routeCost":0,"ticketCost":0}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Put On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/67a0f450b68d7ccc758d6857?community=${idComunidad}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}

Create services
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/createServices/${idComunidad}?community=${idComunidad}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s   

Get Today Service Id
    [Tags]    test:retry(1)
    
    # Define la URL del recurso que requiere autenticación para la semana 1
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

# Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${filtered_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '67a0f450b68d7ccc758d6857']    json

# Ordenamos los servicios filtrados por la fecha de creación en orden descendente
    ${sorted_services}=    Evaluate    sorted(${filtered_services}, key=lambda service: service['createdAt'], reverse=True)    json

# Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services found in Week 1 with routeId._id = '67a0f450b68d7ccc758d6857'. Stopping test"

    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id}=    Set Variable    ${service['_id']}

    Set Global Variable    ${service_id}

Resource Assignment(Driver and Vehicle)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id}?community=${idComunidad}
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId}"},"drivers":[],"vehicle":{"vehicleId":"${vehicleId}","capacity":"${vehicleCapacity}"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

Get departureId
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${departureId}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    Set Global Variable    ${departureId}

    Log    ${departureId}



Login User With Email(Obtain Token)
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+endauto@allrideapp.com","password":"Equilibriozen123#"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${loginUserUrl}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenNico}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenNico}

Seat Reservation(User1-NicoEnd)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id}","departureId":"${departureId}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200        Seat reservation not working statusCode ${code}
    Log    ${code}

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
    ...    url=/api/v2/pb/driver/departure/${departureId}
    ...    data={"departureId":"${departureId}","communityId":"${idComunidad}","startLat":-33.409703210605215,"startLon":-70.56737988971138,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":2,"busCode":"1111","driverCode":"159753","vehicleId":"666941a7b8d6ea30f9281110","shareToUsers":false,"customParams":[]}
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

##### GENERAR COORDENADAS DEL TRAZADO PARA SIMULAR UNA RUTA ALTERNA Y ENTRAR A LA SIGUIENTE PARADA


Get User QR
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["666078059a5ece0ee6e95904"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNoTickets}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNoTickets}
    Log    ${qrCodeNoTickets}
    Log    ${code}

Validation QR With reservation
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeNoTickets}","timezone":"Chile/Continental","validationLat":-33.409703210605215, "validationLon":-70.56737988971138}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    ${validationIdNico}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${validationIdNico}
    Log    ${code}
    Sleep    10s

Get User QR(Np reservation)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["66d8cf4f4a7101503b01f84a"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}


Connect And Emit Events
    [Documentation]    Test connecting to WebSocket and sending events
    ${URL_with_token}=    Set variable
    ...    wss://stage.allrideapp.com/socket.io/?token=${access_token}&EIO=3&transport=websocket
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
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40586894524867,"longitude":-70.56830468885286,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40586894524867,"longitude":-70.56830468885286,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40168411545458,"longitude":-70.56972829788883,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40168411545458,"longitude":-70.56972829788883,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40168411545458,"longitude":-70.56972829788883,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40168411545458,"longitude":-70.56972829788883,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.393278312004895,"longitude":-70.56187929746478,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.393278312004895,"longitude":-70.56187929746478,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    

Validation QR With Tickets
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeNico}","timezone":"Chile/Continental","validationLat":-33.393278312004895, "validationLon":-70.56187929746478}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    10s

Connect And Emit Events 2
    [Documentation]    Test connecting to WebSocket and sending events
    ${URL_with_token}=    Set variable
    ...    wss://stage.allrideapp.com/socket.io/?token=${access_token}&EIO=3&transport=websocket
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
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.393278312004895,"longitude":-70.56187929746478,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.393278312004895,"longitude":-70.56187929746478,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.39111942223352,"longitude":-70.55173088644868,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.393278312004895,"longitude":-70.55173088644868,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.39060720166747,"longitude":-70.55072044050422,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.393278312004895,"longitude":-70.55173088644868,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.39024563231229,"longitude":-70.54606517089847,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.393278312004895,"longitude":-70.55173088644868,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.386388799735556,"longitude":-70.53967770888042,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.393278312004895,"longitude":-70.55173088644868,"speed":3.9972}]
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
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

    Sleep    10s
