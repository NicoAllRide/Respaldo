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
${TESTING_URL}            https://testing.allrideapp.com
${idComunidad_test}    5a906201d0c7684ad80e2ec6
${tokenAdmin_Test}   Bearer 9fb908f5b43ca450b6ba1fdabccda328282209997fd50cecee285db09ff6cc23f4b956112734685dccabfae1a8d1f559e918f462ccda7ec5fd59941f97194227


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
    ...    ${TESTING_URL}/api/v1/admin/pb/drivers/?community=5a906201d0c7684ad80e2ec6&driverId=653928b01f36db2143507007

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin_Test}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver}=    Evaluate    "Bearer " + "${access_token}"
    ${rtlTokenDriver}=    Set Variable    ${response.json()['rtlToken']}
    Set Global Variable    ${tokenDriver}
    Set Global Variable    ${rtlTokenDriver}

    Log    ${tokenDriver}
    Log    ${response.content}


#------------------------Crear nueva ruta calendarizada alertas y reemplazar Create new service in the selected route----------------------------------##

Create new service in the selected route
    
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"_id":"674f5b7e85ebe5e06592f02a","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyUnboardedPassengers":{"enabled":true,"sendTo":{"destinataries":"specificEmails","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":true,"sendTo":{"destinataries":"specificEmails","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":true,"sendTo":{"destinataries":"specificEmails","emails":[],"adminLevels":[],"roles":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":5,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":5,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"_id":"67505baf85ebe5e065941307","stopId":"646418bc58f76847ca21297e","scheduledDate":"2024-12-03T21:00:00.827Z"},{"_id":"67505baf85ebe5e065941308","stopId":"655f782cb4e1170e95479daf","scheduledDate":null}],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":true,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["674f5b7e85ebe5e06592f02a"],"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"DNIValidation":{"enabled":false},"assistantIds":[],"superCommunities":["618aa8ccb861776f8a8c6fe7","62c49bc3c6b4f27056cc0acf"],"communities":["5a906201d0c7684ad80e2ec6"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":false,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":false,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":false,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":false,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"name":"Prueba Alertas Nico","shapeId":"674f5b7e85ebe5e06592f00e","description":"Alertas Tablero","extraInfo":"","color":"953e3e","canReserve":null,"legOptions":[],"ownerIds":[{"_id":"674f5b7e85ebe5e06592f031","id":"5a906201d0c7684ad80e2ec6","role":"community"}],"segments":[{"_id":"674f5f91e0850b94a0749c62","position":1,"distance":85.69819061701759,"lat":-33.391510000000004,"lon":-70.54690000000001,"loc":[-70.54690000000001,-33.391510000000004]},{"_id":"674f5f91e0850b94a0749c63","position":2,"distance":122.4042591495608,"lat":-33.39184,"lon":-70.54689,"loc":[-70.54689,-33.39184]},{"_id":"674f5f91e0850b94a0749c64","position":3,"distance":151.99947382411028,"lat":-33.39193,"lon":-70.54719,"loc":[-70.54719,-33.39193]},{"_id":"674f5f91e0850b94a0749c65","position":4,"distance":440.2072137010366,"lat":-33.389500000000005,"lon":-70.54827,"loc":[-70.54827,-33.389500000000005]},{"_id":"674f5f91e0850b94a0749c66","position":5,"distance":564.1073177136626,"lat":-33.389970000000005,"lon":-70.54948,"loc":[-70.54948,-33.389970000000005]},{"_id":"674f5f91e0850b94a0749c67","position":6,"distance":659.9129661910988,"lat":-33.390420000000006,"lon":-70.55036000000001,"loc":[-70.55036000000001,-33.390420000000006]},{"_id":"674f5f91e0850b94a0749c68","position":7,"distance":984.9149410962527,"lat":-33.39166,"lon":-70.55353000000001,"loc":[-70.55353000000001,-33.39166]},{"_id":"674f5f91e0850b94a0749c69","position":8,"distance":2255.0094881527853,"lat":-33.39603,"lon":-70.56617,"loc":[-70.56617,-33.39603]},{"_id":"674f5f91e0850b94a0749c6a","position":9,"distance":2364.4357292319432,"lat":-33.39631,"lon":-70.5673,"loc":[-70.5673,-33.39631]},{"_id":"674f5f91e0850b94a0749c6b","position":10,"distance":2798.7835984623125,"lat":-33.397830000000006,"lon":-70.57161,"loc":[-70.57161,-33.397830000000006]},{"_id":"674f5f91e0850b94a0749c6c","position":11,"distance":2820.269008465461,"lat":-33.39777,"lon":-70.57183,"loc":[-70.57183,-33.39777]},{"_id":"674f5f91e0850b94a0749c6d","position":12,"distance":2837.967452637839,"lat":-33.39764,"lon":-70.57194000000001,"loc":[-70.57194000000001,-33.39764]},{"_id":"674f5f91e0850b94a0749c6e","position":13,"distance":2876.8968131945476,"lat":-33.3973,"lon":-70.57184000000001,"loc":[-70.57184000000001,-33.3973]},{"_id":"674f5f91e0850b94a0749c6f","position":14,"distance":2912.1736310885085,"lat":-33.3973,"lon":-70.57146,"loc":[-70.57146,-33.3973]},{"_id":"674f5f91e0850b94a0749c70","position":15,"distance":3969.4062238043994,"lat":-33.406420000000004,"lon":-70.56824,"loc":[-70.56824,-33.406420000000004]},{"_id":"674f5f91e0850b94a0749c71","position":16,"distance":4006.112288307851,"lat":-33.40675,"lon":-70.56823,"loc":[-70.56823,-33.40675]},{"_id":"674f5f91e0850b94a0749c72","position":17,"distance":4277.7807876597435,"lat":-33.409040000000005,"lon":-70.56721,"loc":[-70.56721,-33.409040000000005]},{"_id":"674f5f91e0850b94a0749c73","position":18,"distance":4364.598680750601,"lat":-33.40979,"lon":-70.56695,"loc":[-70.56695,-33.40979]}],"roundOrder":[{"stopId":"646418bc58f76847ca21297e","notifyIfPassed":false},{"stopId":"655f782cb4e1170e95479daf","notifyIfPassed":false}],"communityId":"5a906201d0c7684ad80e2ec6","timeOnRoute":9,"distance":4,"distanceInMeters":4375,"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-12-03T19:26:54.711Z","updatedAt":"2024-12-04T13:39:59.910Z","__v":5,"destinationStop":"655f782cb4e1170e95479daf","originStop":"646418bc58f76847ca21297e","routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":true},"superCommunityId":"618aa8ccb861776f8a8c6fe7","useServiceReservations":false,"routeCost":0,"ticketCost":0}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin_Test}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Put On Session
    ...    mysesion
    ...    url=api/v1/admin/pb/routes/674f5b7e85ebe5e06592f02a?community=5a906201d0c7684ad80e2ec6
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
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin_Test}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://testing.allrideapp.com/api/v1/admin/pb/createServices/${idComunidad_test}?community=${idComunidad_test}
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
    ${url}=    Set Variable    ${TESTING_URL}/api/v1/admin/pb/allServices?community=5a906201d0c7684ad80e2ec6&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin_Test}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

# Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${filtered_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '674f5b7e85ebe5e06592f02a']    json

# Ordenamos los servicios filtrados por la fecha de creación en orden descendente
    ${sorted_services}=    Evaluate    sorted(${filtered_services}, key=lambda service: service['createdAt'], reverse=True)    json

# Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services found in Week 1 with routeId._id = '674f5b7e85ebe5e06592f02a'. Stopping test"

    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id}=    Set Variable    ${service['_id']}

    Set Global Variable    ${service_id}

Resource Assignment(Driver and Vehicle)
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin_Test}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id}?community=5a906201d0c7684ad80e2ec6
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"653928b01f36db2143507007"},"drivers":[],"vehicle":{"vehicleId":"626021ca5ec50b5efc8ddcb0","capacity":"5"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

Get departureId
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/admin/pb/service/${service_id}?community=${idComunidad_test}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin_Test}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${departureId}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    Set Global Variable    ${departureId}

    Log    ${departureId}



Login User With Email(Obtain Token)
        Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+testingb@allrideapp.com","password":"Lolowerty21@"}
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
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id}","departureId":"${departureId}","stopId":"655f782cb4e1170e95479daf","seat":"2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200        Seat reservation not working statusCode ${code}
    Log    ${code}

Start Departure Leg
    Create Session    mysesion    ${TESTING_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/${departureId}
    ...    data={"departureId":"${departureId}","communityId":"${idComunidad_test}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":5,"busCode":"Finn","driverCode":"159","vehicleId":"626021ca5ec50b5efc8ddcb0","shareToUsers":false,"customParams":[]}
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

Connect And Emit Events
    [Documentation]    Test connecting to WebSocket and sending events
    ${URL_with_token}=     Set variable    wss://testing.allrideapp.com/socket.io/?token=${access_token}&EIO=3&transport=websocket
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

    
    ####Send
  #  ...    ${my_websocket}
  #  ...    42/pbDriver,["stop",{}]
  #  Log
 #   ...    Sent: 42/pbDriver,["stop",{}]
  #  Sleep    5s
  #  ${result}=    Recv Data    ${my_websocket}
   # Log    Received: ${result}
   # ${result}=    Recv Data    ${my_websocket}
   # Log    Received: ${result}
   # ${result}=    Recv Data    ${my_websocket}
   # Log    Received: ${result}
    #####


##### GENERAR COORDENADAS DEL TRAZADO PARA SIMULAR UNA RUTA ALTERNA Y ENTRAR A LA SIGUIENTE PARADA


Get User QR(No tickets user)
    Create Session    mysesion    ${TESTING_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin_Test}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad_test}
    ...    data={"ids":["5ed523636897571b96ab4cee"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNoTickets}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNoTickets}
    Log    ${qrCodeNoTickets}
    Log    ${code}

Validation QR Without Tickets
    Create Session    mysesion    ${TESTING_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/validate
    ...    data={"communityId":"${idComunidad_test}","validationString":"${qrCodeNoTickets}","timezone":"Chile/Continental","validationLat":-33.40975694626073,"validationLon":-70.56736916087651}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    10s
    # Enviar más pings periódico

    Sleep    20m
Stop Post Leg Departure
    Create Session    mysesion    ${TESTING_URL}    verify=true

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
