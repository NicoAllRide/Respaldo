*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../../Variables/variablesStage.robot

*** Variables ***
${continue_flow}    True


*** Keywords ***
Stop Execution If Previous Failed
    [Arguments]    ${flag}    ${reason}
    Run Keyword If    '${flag}' == 'False'    Skip    ${reason}

Mark Flow As Failed
    [Arguments]    ${reason}
    Log    ${reason}
    Set Global Variable    ${continue_flow}    False


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
    ${start_date_tickets}=    Set Variable    ${fecha_hoy}T04:00:00.000Z
    Set Global Variable    ${start_date_tickets}
    ${end_date_tickets}=    Set Variable    ${fecha_manana}T03:59:59.999Z
    Set Global Variable    ${end_date_tickets}

    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}

    # Días relativos al actual (en minúsculas, formato igual a mon, tue, wed...)
    ${schedule_day_minus1}=    Evaluate    (datetime.datetime.utcnow() - datetime.timedelta(days=1)).strftime("%a").lower()    datetime
    Set Global Variable    ${schedule_day_minus1}

    ${schedule_day_minus4}=    Evaluate    (datetime.datetime.utcnow() - datetime.timedelta(days=4)).strftime("%a").lower()    datetime
    Set Global Variable    ${schedule_day_minus4}

    ${schedule_day_plus1}=    Evaluate    (datetime.datetime.utcnow() + datetime.timedelta(days=1)).strftime("%a").lower()    datetime
    Set Global Variable    ${schedule_day_plus1}

    ${schedule_day_plus2}=    Evaluate    (datetime.datetime.utcnow() + datetime.timedelta(days=2)).strftime("%a").lower()    datetime
    Set Global Variable    ${schedule_day_plus2}


2 hours local
    ${date}=    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}=    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}=    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}=    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

4 weeks later
    ${end_date_4weeks}=    Evaluate
    ...    (datetime.datetime.utcnow() + datetime.timedelta(weeks=4)).strftime("%Y-%m-%dT03:00:00.000Z")
    ...    datetime
    Set Global Variable    ${end_date_4weeks}



Create Schedule Alto - Apumanque 19:00 hrs
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${endPoint}
    ...    data={"name":"Visualización calendarizada","description":"Visualización debe ser para dos semanas pero la creación para 4","communities":["${idComunidad}"],"superCommunities":["${idSuperCommunity}"],"ownerIds":[{"id":"${idComunidad}","role":"community"}],"shapeId":"65ef21aa6f1c17c2eeeb5f98","usesBusCode":false,"usesVehicleList":true,"usesDriverCode":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"dynamicSeatAssignment":true,"usesTickets":false,"startsOnStop":false,"notNearStop":false,"routeCost":"100","ticketCost":"10","excludePassengers":{"active":false,"excludeType":"dontHide"},"restrictPassengers":{"enabled":false,"allowed":[],"visibility":{"enabled":false,"excludes":false,"parameters":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"schedule":[{"enabled":true,"day":"sat","time":"16:00","estimatedArrival":null,"stopSchedule":[],"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"defaultResources":[]}],"stopOnReservation":true,"restrictions":{"customParams":{"enabled":false,"params":[]}}},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"allowsServiceSnapshots":false,"allowsNonServiceSnapshots":false,"labels":[],"roundOrder":[{"stopId":"655d11d88a5a1a1ff0328466","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328464","notifyIfPassed":false}],"anchorStops":["655d11d88a5a1a1ff0328466","655d11d88a5a1a1ff0328464"],"originStop":"655d11d88a5a1a1ff0328466","destinationStop":"655d11d88a5a1a1ff0328464","hasBeacons":true,"hasCapacity":true,"isStatic":false,"showParable":false,"extraInfo":"","color":"502929","usesManualSeat":true,"allowsManualValidation":true,"usesDriverPin":false,"hasBoardings":true,"hasUnboardings":true,"allowsDistance":false,"allowGenericVehicles":true,"hasExternalGPS":false,"departureHourFulfillment":{"enabled":false,"ranges":[]},"usesOfflineCount":true,"visible":true,"active":true,"usesTextToSpeech":false,"hasBoardingCount":false,"hasRounds":false,"hasUnboardingCount":false,"timeOnRoute":11,"distance":4,"distanceInMeters":3840,"legOptions":[],"route_type":3}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}
    Sleep    2s

Create services
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/createServices/653fd601f90509541a748683?community=653fd601f90509541a748683
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    25s


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
    List Should Contain Value    ${response.json()}    accessToken    No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenNico}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenNico}


Get services should be 2 (No anchor-limit 2)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)

    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/services/${idComunidad}/${scheduleId}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Length Should Be    ${response.json()}    1

Get Service Id(4 weeks Default- 4 services)
    skip
    [Documentation]    Verifica que existan 4 servicios calendarizados para la ruta actual en las próximas 4 semanas
    [Tags]    services    scheduling    visibility4weeks

    # Definimos fechas de inicio y fin (4 semanas)
    ${end_date_4weeks}=    Evaluate    (datetime.datetime.utcnow() + datetime.timedelta(weeks=4)).strftime("%Y-%m-%dT03:00:00.000Z")    datetime
    Set Global Variable    ${end_date_4weeks}

    # Define la URL del recurso
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_4weeks}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Filtrar servicios por la ruta actual
    ${filtered_services}=    Evaluate
    ...    [service for service in ${responseJson} if service['routeId']['_id'] == '${scheduleId}']
    ...    json
    ${num_filtered}=    Get Length    ${filtered_services}

    Log To Console    \nServicios encontrados para la ruta ${scheduleId}: ${num_filtered}

    # Validar que haya exactamente 4 servicios calendarizados
    Should Be Equal As Integers    ${num_filtered}    4
    ...    msg=Expected 4 scheduled services for route ${scheduleId}, but found ${num_filtered}


    # Obtener el último servicio creado
    ${last_service}=    Set Variable    ${filtered_services[-1]}
    ${service_id_tickets}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}

    Set Global Variable    ${service_id_tickets}
    Log To Console    Último servicio creado: ${service_id_tickets}
Get Service Id(2 weeks limit no Anchor - 2 services)
    skip
    [Documentation]    Verifica que existan 2 servicios calendarizados para la ruta actual en las próximas 4 semanas
    [Tags]    services    scheduling    visibility4weeks

    # Definimos fechas de inicio y fin (4 semanas)
    ${end_date_4weeks}=    Evaluate    (datetime.datetime.utcnow() + datetime.timedelta(weeks=4)).strftime("%Y-%m-%dT03:00:00.000Z")    datetime
    Set Global Variable    ${end_date_4weeks}

    # Define la URL del recurso
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_4weeks}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Filtrar servicios por la ruta actual
    ${filtered_services}=    Evaluate
    ...    [service for service in ${responseJson} if service['routeId']['_id'] == '${scheduleId}']
    ...    json
    ${num_filtered}=    Get Length    ${filtered_services}

    Log To Console    \nServicios encontrados para la ruta ${scheduleId}: ${num_filtered}

    # Validar que haya exactamente 4 servicios calendarizados
    Should Be Equal As Integers    ${num_filtered}    2
    ...    msg=Expected 2 scheduled services for route ${scheduleId}, but found ${num_filtered}


    # Obtener el último servicio creado
    ${last_service}=    Set Variable    ${filtered_services[-1]}
    ${service_id_tickets}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}

    Set Global Variable    ${service_id_tickets}
    Log To Console    Último servicio creado: ${service_id_tickets}

Get Service Id - Anchor 4 Days Before (1 -service)
    skip
    [Documentation]    Verifica la visibilidad de servicios calendarizados cuando el anchorDay está 4 días antes del día actual (manteniendo 4 semanas de rango de búsqueda)  1 servicio solamente
    [Tags]    services    scheduling    anchor4daysbefore

    # --- 1️⃣ Fechas normales: de hoy a 4 semanas ---
    ${end_date_4weeks}=    Evaluate    (datetime.datetime.utcnow() + datetime.timedelta(weeks=4)).strftime("%Y-%m-%dT03:00:00.000Z")    datetime
    Set Global Variable    ${end_date_4weeks}

    # --- 2️⃣ Request al endpoint ---
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_4weeks}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # --- 3️⃣ Filtrar servicios de la ruta actual ---
    ${filtered_services}=    Evaluate
    ...    [service for service in ${responseJson} if service['routeId']['_id'] == '${scheduleId}']
    ...    json
    ${num_filtered}=    Get Length    ${filtered_services}

    Log To Console    \nServicios encontrados (anchor 4 días antes): ${num_filtered}

    # --- 4️⃣ Validar resultado esperado ---
    # En este escenario, el anchor está 4 días antes del schedule_day.
    # Si limit=2, el segundo servicio quedaría fuera del rango visible → debería verse solo 1.
    Should Be Equal As Integers    ${num_filtered}    1
    ...    msg=Expected 1 scheduled service for route ${scheduleId} with anchor 4 days before, but found ${num_filtered}

    # --- 5️⃣ Guardar el servicio visible ---
    ${service_visible}=    Set Variable    ${filtered_services[-1]}
    ${service_id_tickets}=    Set Variable    ${service_visible['_id']}
    ${service_route}=    Set Variable    ${service_visible['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${service_route}

    Set Global Variable    ${service_id_tickets}
    Log To Console    Único servicio visible (anchor 4 días antes): ${service_id_tickets}

Get Service Id - Anchor 1 day after today (2 -services) 
    skip

    [Documentation]    Verifica la visibilidad de servicios calendarizados cuando el anchorDay está para el día de mañana, debería mostrarse el servicio de hoy y de la prox semana ya que cuenta 2 semanas desde el día de mañana pero de la semana pasada
    [Tags]    services    scheduling    anchor4daysbefore

    # --- 1️⃣ Fechas normales: de hoy a 4 semanas ---
    ${end_date_4weeks}=    Evaluate    (datetime.datetime.utcnow() + datetime.timedelta(weeks=4)).strftime("%Y-%m-%dT03:00:00.000Z")    datetime
    Set Global Variable    ${end_date_4weeks}

    # --- 2️⃣ Request al endpoint ---
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_4weeks}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # --- 3️⃣ Filtrar servicios de la ruta actual ---
    ${filtered_services}=    Evaluate
    ...    [service for service in ${responseJson} if service['routeId']['_id'] == '${scheduleId}']
    ...    json
    ${num_filtered}=    Get Length    ${filtered_services}

    Log To Console    \nServicios encontrados (anchor 4 días antes): ${num_filtered}

    # --- 4️⃣ Validar resultado esperado ---
    # En este escenario, el anchor está 4 días antes del schedule_day.
    # Si limit=2, el segundo servicio quedaría fuera del rango visible → debería verse solo 1.
    Should Be Equal As Integers    ${num_filtered}    1
    ...    msg=Expected 1 scheduled service for route ${scheduleId} with anchor 4 days before, but found ${num_filtered}

    # --- 5️⃣ Guardar el servicio visible ---
    ${service_visible}=    Set Variable    ${filtered_services[-1]}
    ${service_id_tickets}=    Set Variable    ${service_visible['_id']}
    ${service_route}=    Set Variable    ${service_visible['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${service_route}

    Set Global Variable    ${service_id_tickets}
    Log To Console    Único servicio visible (anchor 4 días antes): ${service_id_tickets}


Get Service Id - Anchor today, anchor time(11:00 am, no services)
    skip

    [Documentation]    Verifica la visibilidad de servicios calendarizados cuando el anchorDay está para el día de mañana, debería mostrarse el servicio de hoy y de la prox semana ya que cuenta 2 semanas desde el día de mañana pero de la semana pasada
    [Tags]    services    scheduling    anchor4daysbefore

    # --- 1️⃣ Fechas normales: de hoy a 4 semanas ---
    ${end_date_4weeks}=    Evaluate    (datetime.datetime.utcnow() + datetime.timedelta(weeks=4)).strftime("%Y-%m-%dT03:00:00.000Z")    datetime
    Set Global Variable    ${end_date_4weeks}

    # --- 2️⃣ Request al endpoint ---
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_4weeks}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # --- 3️⃣ Filtrar servicios de la ruta actual ---
    ${filtered_services}=    Evaluate
    ...    [service for service in ${responseJson} if service['routeId']['_id'] == '${scheduleId}']
    ...    json
    ${num_filtered}=    Get Length    ${filtered_services}

    Log To Console    \nServicios encontrados (anchor 4 días antes): ${num_filtered}

    # --- 4️⃣ Validar resultado esperado ---
    # En este escenario, el anchor está 4 días antes del schedule_day.
    # Si limit=2, el segundo servicio quedaría fuera del rango visible → debería verse solo 1.
    Should Be Equal As Integers    ${num_filtered}    1
    ...    msg=Expected 1 scheduled service for route ${scheduleId} with anchor 4 days before, but found ${num_filtered}

    # --- 5️⃣ Guardar el servicio visible ---
    ${service_visible}=    Set Variable    ${filtered_services[-1]}
    ${service_id_tickets}=    Set Variable    ${service_visible['_id']}
    ${service_route}=    Set Variable    ${service_visible['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${service_route}

    Set Global Variable    ${service_id_tickets}
    Log To Console    Único servicio visible (anchor 4 días antes): ${service_id_tickets}
Get Service Id - Anchor today, anchor time(13:00 am, no services)
    skip

    [Documentation]    Verifica la visibilidad de servicios calendarizados cuando el anchorDay está para el día de mañana, debería mostrarse el servicio de hoy y de la prox semana ya que cuenta 2 semanas desde el día de mañana pero de la semana pasada
    [Tags]    services    scheduling    anchor4daysbefore

    # --- 1️⃣ Fechas normales: de hoy a 4 semanas ---
    ${end_date_4weeks}=    Evaluate    (datetime.datetime.utcnow() + datetime.timedelta(weeks=4)).strftime("%Y-%m-%dT03:00:00.000Z")    datetime
    Set Global Variable    ${end_date_4weeks}

    # --- 2️⃣ Request al endpoint ---
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_4weeks}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # --- 3️⃣ Filtrar servicios de la ruta actual ---
    ${filtered_services}=    Evaluate
    ...    [service for service in ${responseJson} if service['routeId']['_id'] == '${scheduleId}']
    ...    json
    ${num_filtered}=    Get Length    ${filtered_services}

    Log To Console    \nServicios encontrados (anchor 4 días antes): ${num_filtered}

    # --- 4️⃣ Validar resultado esperado ---
    # En este escenario, el anchor está 4 días antes del schedule_day.
    # Si limit=2, el segundo servicio quedaría fuera del rango visible → debería verse solo 1.
    Should Be Equal As Integers    ${num_filtered}    1
    ...    msg=Expected 1 scheduled service for route ${scheduleId} with anchor 4 days before, but found ${num_filtered}

    # --- 5️⃣ Guardar el servicio visible ---
    ${service_visible}=    Set Variable    ${filtered_services[-1]}
    ${service_id_tickets}=    Set Variable    ${service_visible['_id']}
    ${service_route}=    Set Variable    ${service_visible['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${service_route}

    Set Global Variable    ${service_id_tickets}
    Log To Console    Único servicio visible (anchor 4 días antes): ${service_id_tickets}


    Sleep    10
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


### Faltaría implementar otra validación de un usuario que tampoco tenga reserva para verificar que si no hay capacity no deje validar al usuario, también verificar que si hay reservas no deje validar a más usuiarios sin reserva hasta que los usuarios qu si tienen reserva ya se hayan validado en el viaje
## Validaciones offline también deben descontar el capacity al sincronizar