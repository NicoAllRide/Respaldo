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
    ${fecha_4weekslater}=    Add Time To Date    ${fecha_hoy}    28 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_4weekslater}

    ##Fecha proxima semana
    
    ${fecha_1weeklater}=    Add Time To Date    ${start_date_today}    7 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_1weeklater}

    ${fecha_1weeklaterTomorrow}=    Add Time To Date    ${end_date_tomorrow}    7 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_1weeklaterTomorrow}

    ##Fecha dos semanas después
    
    ${fecha_2weeklater}=    Add Time To Date    ${start_date_today}     14 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_2weeklater}

    ${fecha_2weeklaterTomorrow}=    Add Time To Date    ${end_date_tomorrow}    14 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_2weeklaterTomorrow}

    ## Fecha 3 semans despues
    ${fecha_3weeklater}=    Add Time To Date    ${start_date_today}     21 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_3weeklater}

    ${fecha_3weeklaterTomorrow}=    Add Time To Date    ${end_date_tomorrow}    21 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_3weeklaterTomorrow}



2 hours local
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}





### Crear una ruta calendarizada con reserva por defecto sin Recursos por defecto
#Verificar en 4 semanas más que haya un servicio con el id de la ruta, verificar de la misma forma el último que se creó y que estas rutas tienen la reserva
#Asignar Recursos a un servicio y asignar la reseerva a un recurso
#Hacer una reserva aparte en este servicio
#Eliminar la reserva por defecto, debería borrarse en todos los servicios calendarizados de 4 semanas más, menos la que se hizo una reserva

###Crear una ruta calendarizada con reservas por defecto con recursos por defecto

Create Schedule Alto - Apumanque 19:00 hrs
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${endPoint}
    ...    data={"name":"Reserva por defecto","description":"templateRobotTickets","communities":["${idComunidad}"],"superCommunities":["${idSuperCommunity}"],"ownerIds":[{"id":"${idComunidad}","role":"community"}],"shapeId":"65ef21aa6f1c17c2eeeb5f98","usesBusCode":false,"usesVehicleList":true,"usesDriverCode":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"dynamicSeatAssignment":true,"usesTickets":true,"startsOnStop":false,"notNearStop":false,"routeCost":"100","ticketCost":"10","excludePassengers":{"active":false,"excludeType":"dontHide"},"restrictPassengers":{"enabled":false,"allowed":[],"visibility":{"enabled":false,"excludes":false,"parameters":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"stopSchedule":[],"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"defaultResources":[],"reservations":{"enabled":true,"list":[{"userId":"653ff52433d83952fafcf397"}]}}],"stopOnReservation":true,"restrictions":{"customParams":{"enabled":false,"params":[]}}},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"allowsServiceSnapshots":false,"allowsNonServiceSnapshots":false,"labels":[],"roundOrder":[{"stopId":"655d11d88a5a1a1ff0328466","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328464","notifyIfPassed":false}],"anchorStops":["655d11d88a5a1a1ff0328466","655d11d88a5a1a1ff0328464"],"originStop":"655d11d88a5a1a1ff0328466","destinationStop":"655d11d88a5a1a1ff0328464","hasBeacons":true,"hasCapacity":true,"isStatic":false,"showParable":false,"extraInfo":"","color":"502929","usesManualSeat":true,"allowsManualValidation":true,"usesDriverPin":false,"hasBoardings":true,"hasUnboardings":true,"allowsDistance":false,"allowGenericVehicles":true,"hasExternalGPS":false,"departureHourFulfillment":{"enabled":false,"ranges":[]},"usesOfflineCount":true,"visible":true,"active":true,"usesTextToSpeech":false,"hasBoardingCount":false,"hasRounds":false,"hasUnboardingCount":false,"timeOnRoute":11,"distance":4,"distanceInMeters":3840,"legOptions":[],"route_type":3}
    ...    headers=${headers}
    # Verifica el código de estado esperado 2222
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}
*** Test Cases ***
Get Service Id And Check Reservations - Week 1
    [Tags]    test:retry(1)
    
    # Define la URL del recurso que requiere autenticación para la semana 1
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${sorted_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '${scheduleId}']    json

    # Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services found in Week 1 with routeId._id = "${scheduleId}". Stopping test"
    Run Keyword If    ${sorted_services.__len__()} != 1    Fatal Error    "Not exactly one service found in Week 1 with routeId._id = ${scheduleId}. Stopping test"

    # Asignamos las variables del servicio encontrado
    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id_tickets}=    Set Variable    ${service['_id']}
    ${service_route}=    Set Variable    ${service['routeId']['_id']}
    ${service_reservation_default}=    Set Variable    ${service['reservations'][0]['defaultBooked']}
    ${service_reservation_id}=    Set Variable    ${service['reservations'][0]['userId']['_id']}

    # Verificamos que el service_route y service_reservation_id sean los esperados
    Should Be Equal As Strings    ${scheduleId}    ${service_route}    The service ${service_route} doesn't contain the routeId._id ${scheduleId}
    Should Be Equal As Strings    ${service_reservation_id}    653ff52433d83952fafcf397    The service ${service_route} doesn't contain the reservation made by default with user 653ff52433d83952fafcf397

    # Asignamos la variable global para el ID del servicio
    Set Global Variable    ${service_id_tickets}
    Log    Last created service ID: ${service_id_tickets}

Get Service Id And Check Reservations - Week 2
    [Tags]    test:retry(1)
    
    # Define la URL del recurso que requiere autenticación para la semana 1
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${fecha_1weeklater}&endDate=${fecha_1weeklaterTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${sorted_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '${scheduleId}']    json

    # Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services found in Week 1 with routeId._id = "${scheduleId}". Stopping test"
    Run Keyword If    ${sorted_services.__len__()} != 1    Fatal Error    "Not exactly one service found in Week 1 with routeId._id = ${scheduleId}. Stopping test"

    # Asignamos las variables del servicio encontrado
    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id_tickets2}=    Set Variable    ${service['_id']}
    ${service_route}=    Set Variable    ${service['routeId']['_id']}
    ${service_reservation_default}=    Set Variable    ${service['reservations'][0]['defaultBooked']}
    ${service_reservation_id}=    Set Variable    ${service['reservations'][0]['userId']['_id']}

    # Verificamos que el service_route y service_reservation_id sean los esperados
    Should Be Equal As Strings    ${scheduleId}    ${service_route}    The service ${service_route} doesn't contain the routeId._id ${scheduleId}
    Should Be Equal As Strings    ${service_reservation_id}    653ff52433d83952fafcf397    The service ${service_route} doesn't contain the reservation made by default with user 653ff52433d83952fafcf397

    # Asignamos la variable global para el ID del servicio
    Set Global Variable    ${service_id_tickets2}
    Log    Last created service ID: ${service_id_tickets2}

Get Service Id And Check Reservations - Week 3
    [Tags]    test:retry(1)
    
    # Define la URL del recurso que requiere autenticación para la semana 1
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${fecha_2weeklater}&endDate=${fecha_2weeklaterTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${sorted_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '${scheduleId}']    json

    # Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services found in Week 1 with routeId._id = "${scheduleId}". Stopping test"
    Run Keyword If    ${sorted_services.__len__()} != 1    Fatal Error    "Not exactly one service found in Week 1 with routeId._id = ${scheduleId}. Stopping test"

    # Asignamos las variables del servicio encontrado
    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id_tickets3}=    Set Variable    ${service['_id']}
    ${service_route}=    Set Variable    ${service['routeId']['_id']}
    ${service_reservation_default}=    Set Variable    ${service['reservations'][0]['defaultBooked']}
    ${service_reservation_id}=    Set Variable    ${service['reservations'][0]['userId']['_id']}

    # Verificamos que el service_route y service_reservation_id sean los esperados
    Should Be Equal As Strings    ${scheduleId}    ${service_route}    The service ${service_route} doesn't contain the routeId._id ${scheduleId}
    Should Be Equal As Strings    ${service_reservation_id}    653ff52433d83952fafcf397    The service ${service_route} doesn't contain the reservation made by default with user 653ff52433d83952fafcf397

    # Asignamos la variable global para el ID del servicio
    Set Global Variable    ${service_id_tickets3}
    Log    Last created service ID: ${service_id_tickets3}

Get Service Id And Check Reservations - Week 4
    [Tags]    test:retry(1)
    
    # Define la URL del recurso que requiere autenticación para la semana 1
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${fecha_3weeklater}&endDate=${fecha_3weeklaterTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${sorted_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '${scheduleId}']    json

    # Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services found in Week 1 with routeId._id = "${scheduleId}". Stopping test"
    Run Keyword If    ${sorted_services.__len__()} != 1    Fatal Error    "Not exactly one service found in Week 1 with routeId._id = ${scheduleId}. Stopping test"

    # Asignamos las variables del servicio encontrado
    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id_tickets4}=    Set Variable    ${service['_id']}
    ${service_route}=    Set Variable    ${service['routeId']['_id']}
    ${service_reservation_default}=    Set Variable    ${service['reservations'][0]['defaultBooked']}
    ${service_reservation_id}=    Set Variable    ${service['reservations'][0]['userId']['_id']}

    # Verificamos que el service_route y service_reservation_id sean los esperados
    Should Be Equal As Strings    ${scheduleId}    ${service_route}    The service ${service_route} doesn't contain the routeId._id ${scheduleId}
    Should Be Equal As Strings    ${service_reservation_id}    653ff52433d83952fafcf397    The service ${service_route} doesn't contain the reservation made by default with user 653ff52433d83952fafcf397

    # Asignamos la variable global para el ID del servicio
    Set Global Variable    ${service_id_tickets4}
    Log    Last created service ID: ${service_id_tickets}





Assign Resources
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id_tickets}?community=${idComunidad}
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId}"},"drivers":[],"vehicle":{"vehicleId":"${vehicleId}","capacity":"${vehicleCapacity}"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    Sleep    2s

Get departureId And verify reservation on departure 0
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets}?community=${idComunidad}

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


Assign Reservation to resources
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id_tickets}?community=653fd601f90509541a748683
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId}"},"drivers":[],"vehicle":{"vehicleId":"${vehicleId}","capacity":5},"departure":{"departureId":"${departureId}"},"passengers":[{"userId":{"_id":"653ff52433d83952fafcf397","communities":[{"confirmed":true,"_id":"653ff52433d83952fafcf39b","communityId":"653fd601f90509541a748683","custom":[{"listValue":[],"private":false,"_id":"665f14c1328406af89490e8d","key":"rut","value":"191866819"}],"isAdmin":false,"createdAt":"2023-10-30T18:25:40.457Z","updatedAt":"2024-06-04T13:21:05.840Z","privateBus":{"odd":{"canCreate":true,"needsAdminApproval":false,"exclusiveDepartures":false,"providers":[]},"enabled":true,"favoriteRoutes":[],"suggestedRoutes":[],"_id":"653ff54633d83952fafcf3cf"}}],"emails":[{"fromCommunity":true,"_id":"653ff52433d83952fafcf39d","active":false,"validationToken":"7770bd4550d5e435811e6d716e3f971152d0374207995724072b35244386f0441aebb49f242c0c85e0621ce0bf010d39cb1dc8de53fe3cb26e4229b13148c3ec"}],"name":"Nico1"}}]}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

Get departureId And verify reservation on departure 1
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets}?community=${idComunidad}

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

    ${departurePassengerId}=    Set Variable    ${response.json()}[resources][0][departure][passengers][0][_id]
    
    Should Be Equal As Strings    ${departurePassengerId}    653ff52433d83952fafcf397

Make an admin reservation
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/bookService/${service_id_tickets}?community=653fd601f90509541a748683
    ...    data={"userId":"${idNaruto}","departureId":"${departureId}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}


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
    ...    data={"serviceId":"${service_id_tickets}","departureId":"${departureId}","stopId":"655d11d88a5a1a1ff0328464","seat":"2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Run Keyword If    '${code}' == '200' or '${code}' == '409'    Log    Status code is acceptable: ${code}
    ...    ELSE    Fail    Unexpected status code: ${code}
    Log    ${code}

Get departureId And verify reservation on departure 2
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets}?community=${idComunidad}

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

    ${departurePassengerId1}=    Set Variable    ${response.json()}[resources][0][departure][passengers][0][_id]
    ${departurePassengerId2}=    Set Variable    ${response.json()}[resources][0][departure][passengers][1][_id]
    ${departurePassengerId3}=    Set Variable    ${response.json()}[resources][0][departure][passengers][2][_id]
    
    Should Be Equal As Strings    ${departurePassengerId1}    653ff52433d83952fafcf397
    Should Be Equal As Strings    ${departurePassengerId2}    ${idNaruto}
    Should Be Equal As Strings    ${departurePassengerId3}    ${idNico}

Modify route (Delete default Reservation)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/${scheduleId}?community=653fd601f90509541a748683
    ...    data={"name":"Reserva por defecto","description":"templateRobotTickets","communities":["${idComunidad}"],"superCommunities":["${idSuperCommunity}"],"ownerIds":[{"id":"${idComunidad}","role":"community"}],"shapeId":"65ef21aa6f1c17c2eeeb5f98","usesBusCode":false,"usesVehicleList":true,"usesDriverCode":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"dynamicSeatAssignment":true,"usesTickets":true,"startsOnStop":false,"notNearStop":false,"routeCost":"100","ticketCost":"10","excludePassengers":{"active":false,"excludeType":"dontHide"},"restrictPassengers":{"enabled":false,"allowed":[],"visibility":{"enabled":false,"excludes":false,"parameters":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"stopSchedule":[],"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"defaultResources":[],"reservations":{"enabled":false,"list":[]}}],"stopOnReservation":true,"restrictions":{"customParams":{"enabled":false,"params":[]}}},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"allowsServiceSnapshots":false,"allowsNonServiceSnapshots":false,"labels":[],"roundOrder":[{"stopId":"655d11d88a5a1a1ff0328466","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328464","notifyIfPassed":false}],"anchorStops":["655d11d88a5a1a1ff0328466","655d11d88a5a1a1ff0328464"],"originStop":"655d11d88a5a1a1ff0328466","destinationStop":"655d11d88a5a1a1ff0328464","hasBeacons":true,"hasCapacity":true,"isStatic":false,"showParable":false,"extraInfo":"","color":"502929","usesManualSeat":true,"allowsManualValidation":true,"usesDriverPin":false,"hasBoardings":true,"hasUnboardings":true,"allowsDistance":false,"allowGenericVehicles":true,"hasExternalGPS":false,"departureHourFulfillment":{"enabled":false,"ranges":[]},"usesOfflineCount":true,"visible":true,"active":true,"usesTextToSpeech":false,"hasBoardingCount":false,"hasRounds":false,"hasUnboardingCount":false,"timeOnRoute":11,"distance":4,"distanceInMeters":3840,"legOptions":[],"route_type":3}
    ...    headers=${headers}
    # Verifica el código de estado esperado 2222
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}


Get departureId And verify reservation on departure (1)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets}?community=${idComunidad}

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

    ${departurePassengerId1}=    Set Variable    ${response.json()}[resources][0][departure][passengers][0][_id]
    ${departurePassengerId2}=    Set Variable    ${response.json()}[resources][0][departure][passengers][1][_id]
    ${departurePassengerId3}=    Set Variable    ${response.json()}[resources][0][departure][passengers][2][_id]
    
    Should Be Equal As Strings    ${departurePassengerId1}    653ff52433d83952fafcf397        The default reservation is erased from a service with another reservation, it shouldnt be erased
    Should Be Equal As Strings    ${departurePassengerId2}    ${idNaruto}        
    Should Be Equal As Strings    ${departurePassengerId3}    ${idNico}            
Get departureId And verify reservation on departure (2)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets2}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${reservations}=    Set Variable    ${responseJson}[reservations]

    Should Be Empty    ${reservations}    No se borraron las reservas permanentes del servicio

Get departureId And verify reservation on departure (3)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets3}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${reservations}=    Set Variable    ${responseJson}[reservations]

    Should Be Empty    ${reservations}    No se borraron las reservas permanentes del servicio           
Get departureId And verify reservation on departure (4)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets4}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${reservations}=    Set Variable    ${responseJson}[reservations]

    Should Be Empty    ${reservations}    No se borraron las reservas permanentes del servicio              

Delete Route
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/${scheduleId}?community=653fd601f90509541a748683
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    5s