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

    ${end_date_pasado_manana}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pasado_manana}

        ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}



Generate Random 10 Digit Value
    ${random_value1}=    Evaluate    "".join([str(random.randint(0,9)) for _ in range(10)])    random
    Log    Valor aleatorio generado: ${random_value1}
    Set Global Variable    ${random_value1}

1 hours local 
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}





Create User
    [Documentation]    Crear código de enrolamiento al crear un usuario
    Create Session    mysesion    ${NewAdmin_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://newadminapi.allrideapp.com/api/v1/admin/communityValidationUsers/?community=672cef828bb0e26b04321fc8
    ...    data={"community":"672cef828bb0e26b04321fc8","values":[{"key":"rut","value":"1938473829","public":true,"check":true}],"validated":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${usersFound}=    Set Variable   ${response.json()}

Create User part 2
    [Documentation]    Crear usuario con código de enrolamiento recientemente creado
    Create Session    mysesion    ${NewAdmin_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://newadminapi.allrideapp.com/api/v1/admin/users/createUser?community=672cef828bb0e26b04321fc8
    ...    data={"communityId":"672cef828bb0e26b04321fc8","country":"cl","name":"Nico QA eliminar","customValidation":{"rut":"421432143"},"phoneNumber":null,"validationId":"68596ced1771aee86115d5e2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${userId}=    Set Variable   ${response.json()}[correct][0][_id]

    Set Global Variable    ${userId}




Find User (Usuario QA Eliminar)
    [Documentation]    Buscar al usuario recién creado
    Create Session    mysesion    ${NewAdmin_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=https://newadminapi.allrideapp.com/api/v1/support/users/list?search=usuario%20qa%20eliminar
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${userFound_name}=    Set Variable   ${response.json()}[0][name]
    ${userFound_id}=    Set Variable    ${response.json()}[0][_id]
    Should Be Equal As Strings    Usuario QA Eliminar    ${userFound_name}

Create new service in the selected route
    [Documentation]     Crear un nuevo servicio en la ruta 66f310608e6c377a3f43968e, si no se encuentra el servicio creado se ejecuta un Fatal error
    Create Session    mysesion    ${NewAdmin_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://newadminapi.allrideapp.com/api/v1/admin/pb/routes/6841f4b4df429d5c67d9f0a8?community=672cef828bb0e26b04321fc8
    ...    data={"_id":"6841f4b4df429d5c67d9f0a8","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"stopSchedule":[{"stopId":"672cf0f5c6b9606aeadd80b3","scheduledDate":"2025-06-23T15:00:00.434Z"},{"stopId":"672cf4e4b915dc6b28e295bf","scheduledDate":null}],"capped":{"enabled":false,"capacity":0,"by":"vehicle"},"vehicleCategoryId":null,"defaultResources":[],"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]},"timeRules":{"booking":{"maxTime":{"enabled":false,"amount":0,"unit":"minutes"}}},"byQuantity":{"enabled":false,"amount":0,"time":0,"unit":"days","userSkip":[]}},"reservations":{"enabled":false,"list":[]},"serviceCreationLimit":{"enabled":false,"date":null}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["6841f4b4df429d5c67d9f0a8"],"visibility":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"reservation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"validation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"},"estimatedDuration":{"byPercentage":{"enabled":false,"amount":0,"timer":{"amount":0,"unit":"minutes"}},"byTime":{"enabled":false,"amount":0,"unit":"minutes","timer":{"amount":0,"unit":"minutes"}}}},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"DNIValidation":{"enabled":false,"options":["qr"]},"validation":{"external":[]},"restrictions":{"external":[]},"assistantIds":[],"superCommunities":[],"communities":["672cef828bb0e26b04321fc8"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":false,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":false,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":false,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":false,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"hasBarrier":false,"name":"COPIAR CONFIG","shapeId":"6841f4b3df429d5c67d9f077","description":"a","extraInfo":"","color":"d61616","legOptions":[{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100},"ETA":{"enabled":null,"update":{"amount":0,"unit":"minutes"},"visibility":"admin","notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}}}],"ownerIds":[{"_id":"6841f4b4df429d5c67d9f0ad","id":"672cef828bb0e26b04321fc8","role":"community"}],"segments":[],"roundOrder":[{"stopId":"672cf0f5c6b9606aeadd80b3","notifyIfPassed":false},{"stopId":"672cf4e4b915dc6b28e295bf","notifyIfPassed":false}],"communityId":"672cef828bb0e26b04321fc8","timeOnRoute":21,"distance":20,"distanceInMeters":19647,"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2025-06-05T19:49:08.228Z","updatedAt":"2025-06-19T13:49:05.492Z","__v":3,"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":true},"externalInfo":{"uuid":""},"routeCost":0,"ticketCost":0,"originStop":"672cf0f5c6b9606aeadd80b3","destinationStop":"672cf106b915dc6b28e22b15","canReserve":true,"useServiceReservations":false,"unassignedDepartures":{"enabled":false,"allowsMultiple":{"enabled":false,"limit":{"amount":5,"unit":"minutes"}}},"autoStartConditions":{"enabled":false,"ignition":false,"allowStop":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"custom":{"ui":{"color":"d61616","marker":{"1x":"","1.5x":"","2x":"","3x":"","4x":""}}}}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    Dictionary Should Contain Key    ${response.json()}    _id        No _id Found when service is created. Failing
    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}

    Sleep    5s

Create services
    [Documentation]    Iniciar la creación de servicios
    Create Session    mysesion    ${NewAdmin_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://newadminapi.allrideapp.com/api/v1/admin/pb/createServices/672cef828bb0e26b04321fc8?community=672cef828bb0e26b04321fc8
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    5s

Get Service Id
    [Documentation]     Obtener servicio creado recientemente, si no se encuentra se ejecuta un fatal error
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${NewAdmin_URL}/api/v1/admin/pb/allServices?community=${idComunidadProd}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id}=    Set Variable    None

    
    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate    sorted([s for s in ${responseJson} if s['routeId']['_id'] == '${scheduleId}'], key=lambda x: x['createdAt'])    json


   Should not be Empty    ${sorted_services}      msg= No services were created with routeId._id = "${scheduleId}" Exit tests
    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}
    
    Set Global Variable    ${service_id}

    Log    Last created service ID: ${service_id}





Make reservation from admin
    [Documentation]    Se realiza la reserva del usuario desde el admin
    Create Session    mysesion    ${NewAdmin_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://newadminapi.allrideapp.com/api/v1/admin/pb/bookService/${service_id}?community=672cef828bb0e26b04321fc8
    ...    data={"userId":"${userId}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Delete user from allride
    [Documentation]    Se elimina el usuario de AllRide

    Create Session    mysesion    ${NewAdmin_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=${NewAdmin_URL}/api/v1/admin/superadmin/user/${userId}
    ...    data={"reason":"qa"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)


Find User (Usuario QA Eliminar)
        [Documentation]    Se busca el usuario recién eliminado, no debería encontrarse

    Create Session    mysesion    ${NewAdmin_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=https://newadminapi.allrideapp.com/api/v1/support/users/list?search=usuario%20qa%20eliminar
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${userFounds}=    Set Variable    ${response.json()}
    Should Be Empty    ${userFounds}

Get service details(Should not have any reservation after user deletion)
    [Documentation]    Se verifica que no hayan reservas en el servicio recién creado luego de la eliminación del usuario
    Create Session    mysesion    ${NewAdmin_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdminProd}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/service/${service_id}?community=672cef828bb0e26b04321fc8
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${reservations}=    Set Variable    ${response.json()}[reservations]
    Should Be Empty    ${reservations}    Reservations should be empty after user delation

