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

        ${end_date_tomorrow}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_tomorrow}
    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}

Generate random UUID (DepartureId)
    ${uuid}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid}
    Set Global Variable    ${uuid}

Generate random UUID (_id Manual validations)
    ${uuid_manual}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_manual}
    Set Global Variable    ${uuid_manual}

Generate random UUID (_id validations customValidations)
    ${uuid_custom}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_custom}
    Set Global Variable    ${uuid_custom}

Generate random UUID (_id validations qrValidations)
    ${uuid_qr}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr}
    Set Global Variable    ${uuid_qr}
Generate random UUID2 (_id validations qrValidations)
    ${uuid_qr2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr2}
    Set Global Variable    ${uuid_qr2}
Generate random UUID2 Cédula (_id validations qrValidations)
    ${uuid_dni}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_dni}
    Set Global Variable    ${uuid_dni}
Generate random UUID (_id events1)
    ${uuid_events}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_events}
    Set Global Variable    ${uuid_events}
Generate random UUID (_id events2)
    ${uuid_events2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_events2}
    Set Global Variable    ${uuid_events2}


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
    [Documentation]    Se obtiene el token del conductor
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


#------------------------Guardar distancia en REGULARES----------------------------------##

Create new service in the selected route
    
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"_id":"675059ea3c067a6cd3e2ed80","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":true,"anchorStops":["657b1eb82dce4d35c8fdd308","657b040610ed9619f92caedb"]},"notifyUsersByStop":{"enabled":true,"sendTo":{"destinataries":"specificEmails","emails":["nico2795@gmail.com"],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}," ":"","excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":5,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":5,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0,"by":"vehicle"},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"transitDepartures":{"options":{"allowedUsers":{"byParams":{"params":[]}}}},"_id":"67505a4efdee9ba9e9416903","stopId":"655d11d88a5a1a1ff0328464","scheduledDate":"2024-12-04T14:00:00.600Z"},{"transitDepartures":{"options":{"allowedUsers":{"byParams":{"params":[]}}}},"_id":"67505a4efdee9ba9e9416904","stopId":"655d11d88a5a1a1ff0328466","scheduledDate":null}],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]},"timeRules":{"booking":{"maxTime":{"enabled":false,"amount":0,"unit":"minutes"}}},"byQuantity":{"enabled":false,"amount":0,"time":0,"unit":"days","userSkip":[]}},"reservations":{"enabled":false,"list":[]},"serviceCreationLimit":{"enabled":false,"date":null}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["675059ea3c067a6cd3e2ed80"],"visibility":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"reservation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"validation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"},"estimatedDuration":{"byPercentage":{"enabled":false,"amount":0,"timer":{"amount":0,"unit":"minutes"}},"byTime":{"enabled":false,"amount":0,"unit":"minutes","timer":{"amount":0,"unit":"minutes"}}}},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"assistantIds":["66ce519a3851012ba459ab1f"],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["653fd601f90509541a748683"],"active":true,"visible":true,"internal":false,"anchorStops":["657b1eb82dce4d35c8fdd308","657b040610ed9619f92caedb"],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":true,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":false,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":true,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":false,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"hasBarrier":false,"name":"Ruta userByStops","shapeId":"675059ea3c067a6cd3e2ed61","description":"Correo validaciones parciales","extraInfo":"","color":"704646","canReserve":null,"legOptions":[{"legType":"pre","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100},"ETA":{"enabled":null,"update":{"amount":0,"unit":"minutes"},"visibility":"admin","notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}}},{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100},"ETA":{"enabled":null,"update":{"amount":0,"unit":"minutes"},"visibility":"admin","notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}}},{"legType":"post","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100},"ETA":{"enabled":null,"update":{"amount":0,"unit":"minutes"},"visibility":"admin","notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}}}],"ownerIds":[{"_id":"675059ea3c067a6cd3e2ed84","id":"653fd601f90509541a748683","role":"community"}],"segments":[{"_id":"675060f8c46fdbfcb4f9c28b","position":1,"distance":228.38354663818956,"lat":-33.41179,"lon":-70.56639000000001,"loc":[-70.56639000000001,-33.41179]},{"_id":"675060f8c46fdbfcb4f9c28c","position":2,"distance":243.73803577799396,"lat":-33.4119,"lon":-70.56629000000001,"loc":[-70.56629000000001,-33.4119]},{"_id":"675060f8c46fdbfcb4f9c28d","position":3,"distance":401.3047439750116,"lat":-33.41329,"lon":-70.56596,"loc":[-70.56596,-33.41329]},{"_id":"675060f8c46fdbfcb4f9c28e","position":4,"distance":444.4501680371242,"lat":-33.41292,"lon":-70.56582,"loc":[-70.56582,-33.41292]},{"_id":"675060f8c46fdbfcb4f9c28f","position":5,"distance":855.8782542465394,"lat":-33.40934,"lon":-70.56694,"loc":[-70.56694,-33.40934]},{"_id":"675060f8c46fdbfcb4f9c290","position":6,"distance":1157.0620090476637,"lat":-33.406780000000005,"lon":-70.56800000000001,"loc":[-70.56800000000001,-33.406780000000005]},{"_id":"675060f8c46fdbfcb4f9c291","position":7,"distance":2022.8231693734701,"lat":-33.39931,"lon":-70.57063000000001,"loc":[-70.57063000000001,-33.39931]},{"_id":"675060f8c46fdbfcb4f9c292","position":8,"distance":2062.4436401671032,"lat":-33.39896,"lon":-70.57055000000001,"loc":[-70.57055000000001,-33.39896]},{"_id":"675060f8c46fdbfcb4f9c293","position":9,"distance":2213.215070909882,"lat":-33.3977,"lon":-70.56995,"loc":[-70.56995,-33.3977]},{"_id":"675060f8c46fdbfcb4f9c294","position":10,"distance":2364.9394098966286,"lat":-33.39701,"lon":-70.56854,"loc":[-70.56854,-33.39701]},{"_id":"675060f8c46fdbfcb4f9c295","position":11,"distance":3895.4649524169135,"lat":-33.39172,"lon":-70.55332,"loc":[-70.55332,-33.39172]},{"_id":"675060f8c46fdbfcb4f9c296","position":12,"distance":4447.885357339642,"lat":-33.38967,"lon":-70.54790000000001,"loc":[-70.54790000000001,-33.38967]},{"_id":"675060f8c46fdbfcb4f9c297","position":13,"distance":4513.112073605738,"lat":-33.38962,"lon":-70.5472,"loc":[-70.5472,-33.38962]},{"_id":"675060f8c46fdbfcb4f9c298","position":14,"distance":4579.902635227912,"lat":-33.38933,"lon":-70.54657,"loc":[-70.54657,-33.38933]},{"_id":"675060f8c46fdbfcb4f9c299","position":15,"distance":4589.767962094164,"lat":-33.38936,"lon":-70.54647,"loc":[-70.54647,-33.38936]},{"_id":"675060f8c46fdbfcb4f9c29a","position":16,"distance":4606.550240786208,"lat":-33.38951,"lon":-70.54649,"loc":[-70.54649,-33.38951]},{"_id":"675060f8c46fdbfcb4f9c29b","position":17,"distance":4725.211018526339,"lat":-33.389920000000004,"lon":-70.54767000000001,"loc":[-70.54767000000001,-33.389920000000004]},{"_id":"675060f8c46fdbfcb4f9c29c","position":18,"distance":4746.939729917832,"lat":-33.39007,"lon":-70.54782,"loc":[-70.54782,-33.39007]},{"_id":"675060f8c46fdbfcb4f9c29d","position":19,"distance":4912.593973716312,"lat":-33.391470000000005,"lon":-70.54721,"loc":[-70.54721,-33.391470000000005]},{"_id":"675060f8c46fdbfcb4f9c29e","position":20,"distance":4960.396768311326,"lat":-33.3918,"lon":-70.54688,"loc":[-70.54688,-33.3918]},{"_id":"675060f8c46fdbfcb4f9c29f","position":21,"distance":4985.139917458477,"lat":-33.391580000000005,"lon":-70.54692,"loc":[-70.54692,-33.391580000000005]},{"_id":"675060f8c46fdbfcb4f9c2a0","position":22,"distance":5075.635174308521,"lat":-33.39123,"lon":-70.54604,"loc":[-70.54604,-33.39123]}],"roundOrder":[{"stopId":"655d11d88a5a1a1ff0328464","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328466","notifyIfPassed":false}],"communityId":"653fd601f90509541a748683","timeOnRoute":9,"distance":5,"distanceInMeters":5107,"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-12-04T13:32:26.585Z","updatedAt":"2025-06-17T15:42:31.232Z","__v":49,"destinationStop":"655d11d88a5a1a1ff0328466","originStop":"655d11d88a5a1a1ff0328464","routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"superCommunityId":"653fd68233d83952fafcd4be","useServiceReservations":false,"DNIValidation":{"enabled":false,"options":["qr"]},"custom":{"ui":{"color":"704646","marker":{"1x":"","1.5x":"","2x":"","3x":"","4x":""}}},"restrictions":{"external":[]},"validation":{"external":[]},"autoStartConditions":{"enabled":false,"ignition":false,"allowStop":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"externalInfo":{"uuid":""},"unassignedDepartures":{"enabled":false,"allowsMultiple":{"enabled":false,"limit":{"amount":5,"unit":"minutes"}}},"routeCost":0,"ticketCost":0}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Put On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/675059ea3c067a6cd3e2ed80?community=653fd601f90509541a748683
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

Get Service Id
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_pastTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}[scheduledServices]
    ${service_id}=    Set Variable    None

    
    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate    sorted([s for s in ${responseJson} if s['routeId']['_id'] == '${scheduleId}'], key=lambda x: x['createdAt'])    json


    Run Keyword If    ${sorted_services} == []    Fatal Error    msg= No services were created with routeId._id = "${scheduleId}" All createSheduled Tests Failing(Fatal error)
    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}
    
    Set Global Variable    ${service_id}

    Log    Last created service ID: ${service_id}

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
    ...    data={"serviceId":"${service_id}","departureId":"${departureId}","stopId":"655d11d88a5a1a1ff0328464","seat":"2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200        Seat reservation not working statusCode ${code}
    Log    ${code}

Start Departure PreLeg
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v2/pb/driver/leg/start
    ...    data={"departureId":"${departureId}","communityId":"${idComunidad}","startLat":-33.408000,"startLon":-70.565000,"legType":"pre","customParamsAtStart":[],"preTripChecklist":[],"routeId":"${scheduleId}","capacity":3,"busCode":"1111","driverCode":"753","vehicleId":"${vehicleId}","shareToUsers":false,"customParams":[]}
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

##### GENERAR COORDENADAS DEL TRAZADO PARA SIMULAR UNA RUTA ALTERNA Y ENTRAR A LA SIGUIENTE PARADA

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
    ...    url=${STAGE_URL}/api/v2/pb/driver/departure/${departureId}
    ...    data={"departureId":"${departureId}","communityId":"${idComunidad}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":2,"busCode":"1111","driverCode":"159753","vehicleId":"666941a7b8d6ea30f9281110","shareToUsers":false,"customParams":[]}
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


##### GENERAR COORDENADAS DEL TRAZADO PARA SIMULAR UNA RUTA ALTERNA Y ENTRAR A LA SIGUIENTE PARADA

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
    ...    url=${STAGE_URL}/api/v2/pb/driver/departure/stop
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



#------------------------Guardar distancia en RDD----------------------------------##