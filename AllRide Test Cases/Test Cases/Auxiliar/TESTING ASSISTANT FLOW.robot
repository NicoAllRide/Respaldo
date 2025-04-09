*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../Variables/variablesStage.robot



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


Get All users
    Skip
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    url=api/v1/admin/users/listPagination?page=1&pageSize=20&community=65d35f4f1779211359d1bb2e

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdminTesting}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.content}
    ${userQty}=    Set Variable    ${response.json()}[totalItems]
    Set Global Variable    ${userQty}

Create new service in the selected route
    
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminTesting}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://testing.allrideapp.com/api/v1/admin/pb/routes/67cf189784e385aa45ca240e?community=65d35f4f1779211359d1bb2e
    ...    data={"_id":"67cf189784e385aa45ca240e","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":5,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":5,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"mon","time":"14:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"_id":"67cf190f84e385aa45ca2458","stopId":"662693a3b335a40e4fe19bb1","scheduledDate":"2025-03-10T17:00:00.284Z"},{"_id":"67cf190f84e385aa45ca2459","stopId":"662693a3b335a40e4fe19baf","scheduledDate":null}],"defaultResources":[],"_ogIndex":0},{"enabled":true,"day":"mon","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"_id":"67cf1a29e0d44d9c3d271ab2","stopId":"662693a3b335a40e4fe19bb1","scheduledDate":"2025-03-10T19:00:09.285Z"},{"_id":"67cf1a29e0d44d9c3d271ab3","stopId":"662693a3b335a40e4fe19baf","scheduledDate":null}],"defaultResources":[],"_ogIndex":1}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["67cf189784e385aa45ca240e"],"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"DNIValidation":{"enabled":false,"options":"qr"},"validation":{"external":[]},"assistantIds":[],"superCommunities":["65d4ab3b8b93abd1456cf0d1"],"communities":["65d35f4f1779211359d1bb2e"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":false,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":false,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":false,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":false,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"name":"WebControl desactivado para ruta","shapeId":"67cf189684e385aa45ca23ec","description":"WebControl desactivado para ruta","extraInfo":"","color":"854343","canReserve":null,"legOptions":[],"ownerIds":[{"_id":"67cf189784e385aa45ca2413","id":"65d35f4f1779211359d1bb2e","role":"community"}],"segments":[],"roundOrder":[{"stopId":"662693a3b335a40e4fe19bb1","notifyIfPassed":false},{"stopId":"662693a3b335a40e4fe19baf","notifyIfPassed":false}],"communityId":"65d35f4f1779211359d1bb2e","timeOnRoute":10,"distance":5,"distanceInMeters":5107,"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2025-03-10T16:51:35.282Z","updatedAt":"2025-03-10T16:58:17.335Z","__v":2,"autoStartConditions":{"enabled":false,"ignition":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"destinationStop":"662693a3b335a40e4fe19baf","originStop":"662693a3b335a40e4fe19bb1","routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"useServiceReservations":false,"routeCost":0,"ticketCost":0}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}

    Sleep    5s

Create services
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminTesting}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://testing.allrideapp.com/api/v1/admin/pb/createServices/65d35f4f1779211359d1bb2e?community=65d35f4f1779211359d1bb2e
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
    ${url}=    Set Variable    ${TESTING_URL}/api/v1/admin/pb/allServices?community=65d35f4f1779211359d1bb2e&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdminTesting}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

# Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${filtered_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '66954794b24db9885e5aed7e']    json

# Ordenamos los servicios filtrados por la fecha de creación en orden descendente
    ${sorted_services}=    Evaluate    sorted(${filtered_services}, key=lambda service: service['createdAt'], reverse=True)    json

# Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services found in Week 1 with routeId._id = '66954794b24db9885e5aed7e'. Stopping test"

    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id}=    Set Variable    ${service['_id']}

    Set Global Variable    ${service_id}


Make Bulk Reservation(3 should pass, one fail)
    
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminTesting}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://testing.allrideapp.com/api/v1/admin/pb/bookService/bulk/${service_id}?community=65d35f4f1779211359d1bb2e
    ...    data={"users":[{"userId":"67cf1ab6e0d44d9c3d271c48"},{"userId":"67cf1af3e0d44d9c3d271c97"},{"userId":"67cf1b11e0d44d9c3d271cf2"},{"userId":"65d398d9012812368f0eb811"}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${correctReservation1}=      Set Variable    ${response.json()}[correct][0][userId]
    ${correctReservation2}=      Set Variable    ${response.json()}[correct][1][userId]
    ${correctReservation3}=      Set Variable    ${response.json()}[correct][2][userId]
    ${withErrorsUser}=      Set Variable    ${response.json()}[withErrors][0][user]
    ${withErrorsMessage}=      Set Variable    ${response.json()}[withErrors][0][message]
    ${withErrorsCode}=      Set Variable    ${response.json()}[withErrors][0][code]
    Should Be Equal As Strings    ${correctReservation1}    67cf1ab6e0d44d9c3d271c48            The user with certification webcontrol could not reserve, failing
    Should Be Equal As Strings    ${correctReservation2}    67cf1af3e0d44d9c3d271c97            The user with certification webcontrol could not reserve, failing
    Should Be Equal As Strings    ${correctReservation3}    67cf1b11e0d44d9c3d271cf2            The user with certification webcontrol could not reserve, failing
    
    #----WITH ERRORS--#
    Should Be Equal As Strings    ${withErrorsUser}    65d398d9012812368f0eb811
    Should Be Equal As Strings    ${withErrorsMessage}    Unauthorized to book.
    Should Be Equal As Strings    ${withErrorsCode}    webcontrol_failed
    Sleep    5s
    #---------CASO1 Tres usuarios con reservas, con webcontrol sin liberación de asientos, 1 usuario no acreditado----------------------------#
    # Crear reserva masiva con 4 usuarios, 3 deberían pasar, uno debería fallar por webcontrol
    # Asignar recursos para crear dos salidas
    # Verificar que cada salida tenga la misma cantidad de reservas
    # Verificar que cada salida tenga el mismo serviceId
    # Aceptar servicio con ambos conductores
    # Iniciar sesión cómo auxiliar
    # Obtener salidas andando, deberían ser dos, estas salidas deberían tener la misma cantidad de reservas
    # Validar usuarios con QR, solamente aquellos que tienen reserva y webcontrol deberían pasar
    # Usuario que no cuenta con webcontrol no debería funcionar la validación
    # Buses cuentan con solo dos asientos, por lo que solo debería dejar validarme dos usuarios en una salida, y uno en la siguiente.
    # Vincular validaciones con salida correspondiente
    # Revisar en Coordinacion Interna que cada vinculación de validación esté en su salida correspondiente
    # Finalizar viaje con ambos conductores

   #---------CASO2,  Dos usuarios con reservas, con webcontrol sin liberación de asientos, 1 usuario acreditado sin reserva, 1 usuario no acreditado ----------------------------#
    # Crear reserva masiva con tres usuarios, 2 deberían pasar, uno debería fallar por webcontrol
    # Asignar recursos para crear dos salidas
    # Verificar que cada salida tenga la misma cantidad de reservas
    # Verificar que cada salida tenga el mismo serviceId
    # Aceptar servicio con ambos conductores
    # Iniciar sesión cómo auxiliar
    # Obtener salidas andando, deberían ser dos, estas salidas deberían tener la misma cantidad de reservas
    # Validar usuarios con QR, solamente aquellos que tienen webcontrol deberían pasar (3 usuarios, 2 que tienen reserva, 1 que no)
    # Usuario que no cuenta con webcontrol no debería funcionar la validación
    # Buses cuentan con solo dos asientos, por lo que solo debería dejar validarme dos usuarios en una salida, y uno en la siguiente. Hacer el intento de validarme en una salida donde ya hay reservas, no debería dejarme continuar, pero si en la salida siguiente(Luego de validados los dos usuarios)
    # Vincular validaciones con salida correspondiente
    # Revisar en Coordinacion Interna que cada vinculación de validación esté en su salida correspondiente
    # Finalizar viaje con ambos conductores

   #---------CASO3,  Dos usuarios con reservas, con webcontrol con liberación de asientos, 1 usuario acreditado sin reserva, 1 usuario no acreditado ----------------------------#
    # Crear reserva masiva con tres usuarios, 2 deberían pasar, uno debería fallar por webcontrol
    # Asignar recursos para crear dos salidas
    # Verificar que cada salida tenga la misma cantidad de reservas
    # Verificar que cada salida tenga el mismo serviceId
    # Aceptar servicio con ambos conductores
    # Iniciar sesión cómo auxiliar
    # Obtener salidas andando, deberían ser dos, estas salidas deberían tener la misma cantidad de reservas
    # Liberar reservas, verificar que se hayan liberado del servicio completo, no solo de la salida
    # Validar usuarios con QR, solamente aquellos que tienen webcontrol, por lo que el usuario sin reserva y acreditado, debería poder validarse en cualquiera de las dos salidas, (validar, eliminar validación, y validar en otra salida para probar)
    # Usuario que no cuenta con webcontrol no debería funcionar la validación
    # Buses cuentan con solo dos asientos, por lo que solo debería dejar validarme dos usuarios en una salida, y uno en la siguiente. Hacer el intento de validarme en una salida donde ya hay asientos utilizados, no debería dejarme continuar, pero si en la salida siguiente(Luego de validados los dos usuarios)
    # Vincular validaciones con salida correspondiente
    # Revisar en Coordinacion Interna que cada vinculación de validación esté en su salida correspondiente
    # Finalizar viaje con ambos conductores

Make Bulk Reservation(all should failed, already booked)
    
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminTesting}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://testing.allrideapp.com/api/v1/admin/pb/bookService/bulk/${service_id}?community=65d35f4f1779211359d1bb2e
    ...    data={"users":[{"userId":"67cf1ab6e0d44d9c3d271c48"},{"userId":"67cf1af3e0d44d9c3d271c97"},{"userId":"67cf1b11e0d44d9c3d271cf2"},{"userId":"65d398d9012812368f0eb811"}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${correctReservations} =     Set Variable    ${response.json()}[correct]
    Should Be Empty    ${correctReservations}
    ${failedReservations} =    Set Variable    ${response.json()}[withErrors]
    Length Should Be    ${failedReservations}    4

Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/admin/pb/drivers/?community=65d35f4f1779211359d1bb2e&driverId=65d3715d5f461d12b748d469

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdminTesting}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver1}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver1}

    Log    ${tokenDriver1}
    Log    ${response.content}
Get Driver Token 2
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/admin/pb/drivers/?community=65d35f4f1779211359d1bb2e&driverId=65d3918e5f461d12b748ecc5

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdminTesting}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver2}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver2}

    Log    ${tokenDriver2}
    Log    ${response.content}

Resource Assignment(Driver and Vehicle Without reservations assignment)
    Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminTesting}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://testing.allrideapp.com/api/v1/admin/pb/assignServiceResources/${service_id}?community=65d35f4f1779211359d1bb2e
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"65d3715d5f461d12b748d469"},"drivers":[],"vehicle":{"vehicleId":"65d3a683012812368f0ec43d","capacity":2},"passengers":[],"departure":null},{"multipleDrivers":false,"driver":{"driverId":"65d3918e5f461d12b748ecc5"},"drivers":[],"vehicle":{"vehicleId":"67acbf74e14e659f7e402849","capacity":2},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    
    ${routeId2} =     Set Variable    ${response.json()}[routeId]
    Should Be Equal As Strings    ${routeId2}    66954794b24db9885e5aed7e        Departures created dont have the selected route "66954794b24db9885e5aed7e" ,failing
    
    ${resources}=     Set Variable    ${response.json()}[resources]
    Length Should Be    ${resources}    2

    ${departureId_1}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    ${departureId_2}=    Set Variable    ${response.json()}[resources][1][departure][departureId]

    ${reservations}=    Set Variable    ${response.json()}[reservations]
    Length Should Be    ${reservations}    3            

    Set Global Variable    ${departureId_1}
    Set Global Variable    ${departureId_2}

Get departureId
    Skip
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/admin/pb/service/${service_id}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdminTesting}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${departureId}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    Set Global Variable    ${departureId}

    Log    ${departureId}



Get Assistant Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/admin/pb/assistants/list?community=65d35f4f1779211359d1bb2e

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdminTesting}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()[0]['accessToken']}
    ${tokenAssistant}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenAssistant}

    Log    ${tokenAssistant}
    Log    ${response.content}

Get Assistant Info(Self)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/pb/provider/me

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAssistant}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

Login User With Email(Obtain Token)
    Skip
        Create Session    mysesion    ${TESTING_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+userpelambres@allrideapp.com","password":"Lolowerty21@"}
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
    List Should Contain Value    ${response.json()}    accessToken            No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenNico}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenNico}


Driver Accept Service 1
    Create Session    mysesion    ${TESTING_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver1}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/acceptOrReject/${departureId_1}
    ...    data={"state":"accepted"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Driver Accept Service 2
    Create Session    mysesion    ${TESTING_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver2}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/acceptOrReject/${departureId_2}
    ...    data={"state":"accepted"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}


Start Departure Leg 1
    Create Session    mysesion    ${TESTING_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver1}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/${departureId_1}
    ...    data={"departureId":"${departureId_1}","communityId":"65d35f4f1779211359d1bb2e","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":2,"busCode":"1111","driverCode":"159753","vehicleId":"666941a7b8d6ea30f9281110","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken1}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken1}
    Log    ${code}
    Set Global Variable    ${departureToken1}
Start Departure Leg 2
    Create Session    mysesion    ${TESTING_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver2}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/${departureId_2}
    ...    data={"departureId":"${departureId_2}","communityId":"65d35f4f1779211359d1bb2e","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":3,"busCode":"","driverCode":"159159","vehicleId":"66d86aafd60f7ada27c56e23","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken2}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken2}
    Log    ${code}
    Set Global Variable    ${departureToken2}
