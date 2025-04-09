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

2 hours local
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Create new service in route
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/routes/67ebf9082a86e3f7c1f98156?community=67b879e99a2ba09f940ea7c5
    ...    data={"_id":"67ebf9082a86e3f7c1f98156","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":5,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":5,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"tue","time":"12:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"_id":"67ebf9674aa362511cdc4e58","stopId":"67b883869a2ba09f940eaa14","scheduledDate":"2025-04-01T15:00:00.939Z"},{"_id":"67ebf9674aa362511cdc4e59","stopId":"67b883979a2ba09f940eaa20","scheduledDate":null}],"defaultResources":[],"_ogIndex":0},{"enabled":true,"day":"thu","time":"12:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"_id":"67ee7e3d4662e86fe4bbc2f6","stopId":"67b883869a2ba09f940eaa14","scheduledDate":"2025-04-03T15:00:28.001Z"},{"_id":"67ee7e3d4662e86fe4bbc2f7","stopId":"67b883979a2ba09f940eaa20","scheduledDate":null}],"defaultResources":[],"_ogIndex":1},{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"stopSchedule":[{"stopId":"67b883869a2ba09f940eaa14","scheduledDate":"2025-04-07T20:00:00.088Z"},{"stopId":"67b883979a2ba09f940eaa20","scheduledDate":null}],"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"defaultResources":[],"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"_ogIndex":2}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]},"serviceCreationLimit":{"enabled":false,"date":null}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["67ebf9082a86e3f7c1f98156"],"visibility":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"reservation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"validation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"}},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"DNIValidation":{"enabled":false,"options":["qr"]},"validation":{"external":[]},"assistantIds":[],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["67b879e99a2ba09f940ea7c5"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":false,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":false,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":false,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":false,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"hasBarrier":false,"name":"Límite de validaciones por salida","shapeId":"67ebf9072a86e3f7c1f98135","description":"Límite de validaciones por salida","extraInfo":"","color":"6d3232","canReserve":null,"legOptions":[{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100}}],"ownerIds":[{"_id":"67ebf9082a86e3f7c1f9815a","id":"67b879e99a2ba09f940ea7c5","role":"community"}],"segments":[{"_id":"67f3fbab81ca143847ec2fa5","position":1,"distance":400.31395496263815,"lat":-33.41329,"lon":-70.56594000000001,"loc":[-70.56594000000001,-33.41329]},{"_id":"67f3fbab81ca143847ec2fa6","position":2,"distance":420.0656852312048,"lat":-33.41321,"lon":-70.56575000000001,"loc":[-70.56575000000001,-33.41321]},{"_id":"67f3fbab81ca143847ec2fa7","position":3,"distance":426.8016348540154,"lat":-33.41315,"lon":-70.56576000000001,"loc":[-70.56576000000001,-33.41315]},{"_id":"67f3fbab81ca143847ec2fa8","position":4,"distance":864.3831454569074,"lat":-33.40934,"lon":-70.56694,"loc":[-70.56694,-33.40934]},{"_id":"67f3fbab81ca143847ec2fa9","position":5,"distance":1165.5669002580316,"lat":-33.406780000000005,"lon":-70.56800000000001,"loc":[-70.56800000000001,-33.406780000000005]},{"_id":"67f3fbab81ca143847ec2faa","position":6,"distance":2031.3280605838381,"lat":-33.39931,"lon":-70.57063000000001,"loc":[-70.57063000000001,-33.39931]},{"_id":"67f3fbab81ca143847ec2fab","position":7,"distance":2070.948531377471,"lat":-33.39896,"lon":-70.57055000000001,"loc":[-70.57055000000001,-33.39896]},{"_id":"67f3fbab81ca143847ec2fac","position":8,"distance":2221.71996212025,"lat":-33.3977,"lon":-70.56995,"loc":[-70.56995,-33.3977]},{"_id":"67f3fbab81ca143847ec2fad","position":9,"distance":2373.4443011069966,"lat":-33.39701,"lon":-70.56854,"loc":[-70.56854,-33.39701]},{"_id":"67f3fbab81ca143847ec2fae","position":10,"distance":3903.969843627281,"lat":-33.39172,"lon":-70.55332,"loc":[-70.55332,-33.39172]},{"_id":"67f3fbab81ca143847ec2faf","position":11,"distance":4456.390248550009,"lat":-33.38967,"lon":-70.54790000000001,"loc":[-70.54790000000001,-33.38967]},{"_id":"67f3fbab81ca143847ec2fb0","position":12,"distance":4521.616964816106,"lat":-33.38962,"lon":-70.5472,"loc":[-70.5472,-33.38962]},{"_id":"67f3fbab81ca143847ec2fb1","position":13,"distance":4588.407526438279,"lat":-33.38933,"lon":-70.54657,"loc":[-70.54657,-33.38933]},{"_id":"67f3fbab81ca143847ec2fb2","position":14,"distance":4598.272853304532,"lat":-33.38936,"lon":-70.54647,"loc":[-70.54647,-33.38936]},{"_id":"67f3fbab81ca143847ec2fb3","position":15,"distance":4615.055131996575,"lat":-33.38951,"lon":-70.54649,"loc":[-70.54649,-33.38951]},{"_id":"67f3fbab81ca143847ec2fb4","position":16,"distance":4733.715909736707,"lat":-33.389920000000004,"lon":-70.54767000000001,"loc":[-70.54767000000001,-33.389920000000004]},{"_id":"67f3fbab81ca143847ec2fb5","position":17,"distance":4755.444621128199,"lat":-33.39007,"lon":-70.54782,"loc":[-70.54782,-33.39007]},{"_id":"67f3fbab81ca143847ec2fb6","position":18,"distance":4921.098864926679,"lat":-33.391470000000005,"lon":-70.54721,"loc":[-70.54721,-33.391470000000005]},{"_id":"67f3fbab81ca143847ec2fb7","position":19,"distance":4968.901659521694,"lat":-33.3918,"lon":-70.54688,"loc":[-70.54688,-33.3918]},{"_id":"67f3fbab81ca143847ec2fb8","position":20,"distance":4993.644808668844,"lat":-33.391580000000005,"lon":-70.54692,"loc":[-70.54692,-33.391580000000005]},{"_id":"67f3fbab81ca143847ec2fb9","position":21,"distance":5084.140065518888,"lat":-33.39123,"lon":-70.54604,"loc":[-70.54604,-33.39123]}],"roundOrder":[{"stopId":"67b883869a2ba09f940eaa14","notifyIfPassed":false},{"stopId":"67b883979a2ba09f940eaa20","notifyIfPassed":false}],"communityId":"67b879e99a2ba09f940ea7c5","timeOnRoute":10,"distance":5,"distanceInMeters":5084.140065518888,"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2025-04-01T14:32:40.163Z","updatedAt":"2025-04-07T16:22:03.448Z","__v":2,"autoStartConditions":{"enabled":false,"ignition":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"destinationStop":"67b883979a2ba09f940eaa20","externalInfo":{"uuid":""},"originStop":"67b883869a2ba09f940eaa14","routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"superCommunityId":"653fd68233d83952fafcd4be","useServiceReservations":false,"routeCost":0,"ticketCost":0}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s

Create services
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/createServices/67b879e99a2ba09f940ea7c5?community=67b879e99a2ba09f940ea7c5
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s

Get Service Id
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=67b879e99a2ba09f940ea7c5&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_scheduled_services}=    Get Length    ${responseJson['scheduledServices']}
    
    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate    sorted(${responseJson}[scheduledServices], key=lambda x: x['createdAt'])    json
    ${sorted_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '${scheduleId}']    json

    Run Keyword If    ${sorted_services} == []    Fatal Error    msg= No services were created with routeId._id = "${scheduleId}" All createSheduled Tests Failing(Fatal error)
    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}
    
    Set Global Variable    ${service_id}

    Log    Last created service ID: ${service_id}
Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=67b879e99a2ba09f940ea7c5&driverId=67b884c5b5ebd5b87145e5c3

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
Resource Assignment(Driver and Vehicle)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id}?community=67b879e99a2ba09f940ea7c5
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"67b884c5b5ebd5b87145e5c3"},"drivers":[],"vehicle":{"vehicleId":"67ed2e71a45b6aa00234a2ff","capacity":"5"},"passengers":[],"departure":null}]
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
    ...    data={"departureId":"${departureId}","communityId":"67b879e99a2ba09f940ea7c5","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":5,"busCode":"123","driverCode":"753","vehicleId":"67ed2e71a45b6aa00234a2ff","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken}
    Log    ${code}
    Set Global Variable    ${departureToken}

Validate With Cédula, first validation should pass
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json

   ${response}=   POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString": "https://portal.sidiv.registrocivil.cl/docstatus?RUN=21758632-1&type=CEDULA&serial=B54107110&mrz=B541", "validationLat": -34.4111, "validationLon": -70.8537}
    ...    headers=${headers}

    Status Should Be    200


Check validation succeeded

    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/validations/list?community=67b879e99a2ba09f940ea7c5&page=1&pageSize=200
    ...    data={"advancedSearch":false,"startDate":"${fecha_hoy}T03:00:00.000Z","endDate":"${fecha_manana}T02:59:59.999Z","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"Rut","value":""},{"key":"color","value":""},{"key":"animal","value":""},{"key":"Empresa","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos las validaciones por createdAt
    ${sorted_validations}=    Evaluate    sorted(${responseJson}[validations], key=lambda x: x['createdAt'])    json

    # Obtenemos la última validación
    ${last_validation}=    Set Variable    ${sorted_validations[-1]}

    ${last_reason}=    Get From List    ${last_validation['reason']}    0
    ${validated}=    Set Variable    ${last_validation['validated']}

    Should Be True    ${validated}    Validation status should be true, but is false, failing

    Should Be Equal As Strings    ${last_reason}    not_part
    Status Should Be    200

    Log    Última validación: ${last_validation}

Validate With Cédula, second validation should fail

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Run Keyword And Expect Error
    ...    HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v1/pb/provider/departures/validate
    ...    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"https://portal.sidiv.registrocivil.cl/docstatus?RUN=21758632-1&type=CEDULA&serial=B54107110&mrz=B541", "validationLat":-34.4111,"validationLon":-70.8537}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Status Should Be    403    msg=Second validation of the same user should fail but is not

Check validation 2 Failed

    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/validations/list?community=67b879e99a2ba09f940ea7c5&page=1&pageSize=200
    ...    data={"advancedSearch":false,"startDate":"${fecha_hoy}T03:00:00.000Z","endDate":"${fecha_manana}T02:59:59.999Z","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"Rut","value":""},{"key":"color","value":""},{"key":"animal","value":""},{"key":"Empresa","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos las validaciones por createdAt
    ${sorted_validations}=    Evaluate    sorted(${responseJson}[validations], key=lambda x: x['createdAt'])    json

    # Obtenemos la última validación
    ${last_validation}=    Set Variable    ${sorted_validations[-1]}

    ${last_reason}=    Get From List    ${last_validation['reason']}    0
    ${validated}=    Set Variable    ${last_validation['validated']}

    Should Be Equal As Strings    ${validated}    False        Validation status should be false, but is not      
    Status Should Be    200

    Log    Última validación: ${last_validation}

Get User QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=67b879e99a2ba09f940ea7c5
    ...    data={"ids":["67b886639a2ba09f940eab0a"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}
Validate With QR, first validation should pass
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json

       ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString": "${qrCodeNico}"}
    ...    headers=${headers}

    Status Should Be    200

Check validation QR Pass

    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/validations/list?community=67b879e99a2ba09f940ea7c5&page=1&pageSize=200
    ...    data={"advancedSearch":false,"startDate":"${fecha_hoy}T03:00:00.000Z","endDate":"${fecha_manana}T02:59:59.999Z","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"Rut","value":""},{"key":"color","value":""},{"key":"animal","value":""},{"key":"Empresa","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos las validaciones por createdAt
    ${sorted_validations}=    Evaluate    sorted(${responseJson}[validations], key=lambda x: x['createdAt'])    json

    # Obtenemos la última validación
    ${last_validation}=    Set Variable    ${sorted_validations[-1]}

    ${validated}=    Set Variable    ${last_validation['validated']}

    Should Be Equal As Strings    ${validated}    True        Validation status should be true, but is not       
    Status Should Be    200

    Log    Última validación: ${last_validation}

Validate With QR, second validation should fail
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json

       ${response}=   Run Keyword and Expect Error  HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v1/pb/provider/departures/validate   POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString": "${qrCodeNico}", "validationLat": -34.4111, "validationLon": -70.8537}
    ...    headers=${headers}

    Status Should Be    403

Check validation QR Failed

    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/validations/list?community=67b879e99a2ba09f940ea7c5&page=1&pageSize=200
    ...    data={"advancedSearch":false,"startDate":"${fecha_hoy}T03:00:00.000Z","endDate":"${fecha_manana}T02:59:59.999Z","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"Rut","value":""},{"key":"color","value":""},{"key":"animal","value":""},{"key":"Empresa","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos las validaciones por createdAt
    ${sorted_validations}=    Evaluate    sorted(${responseJson}[validations], key=lambda x: x['createdAt'])    json

    # Obtenemos la última validación
    ${last_validation}=    Set Variable    ${sorted_validations[-1]}

    ${last_reason}=    Get From List    ${last_validation['reason']}    0
    ${validated}=    Set Variable    ${last_validation['validated']}

    Should Be Equal As Strings    ${validated}    False        Validation status should be false, but is not
    Length Should Be    ${last_validation['reason']}    1    Reason length should be only one "departure_limit", but is showing more
    Should Be Equal As Strings    ${last_reason}    departure_limit        
    Status Should Be    200

    Log    Última validación: ${last_validation}
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
