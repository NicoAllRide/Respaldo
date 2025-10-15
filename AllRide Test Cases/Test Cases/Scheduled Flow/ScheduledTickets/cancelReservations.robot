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
    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}
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

Create new service in the selected route
    
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=  PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/routes/67f7e2fe52999601de99bca2?community=6654ae4eba54fe502d4e4187
    ...    data={"_id":"67f7e2fe52999601de99bca2","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0,"by":"vehicle"},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]},"serviceCreationLimit":{"enabled":false,"date":null}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["67f7e2fe52999601de99bca2"],"visibility":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"reservation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"validation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"}},"DNIValidation":{"enabled":false,"options":["qr"]},"validation":{"external":[]},"assistantIds":["66ccdf58193998eca49014c3"],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":true,"hasBeacons":true,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":false,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":true,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":true,"hasUnboardings":true,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"hasBarrier":false,"name":"Cancel reservation","shapeId":"6654d514713b9a5184cfe21e","description":"Cancel reservation","extraInfo":"","color":"652525","legOptions":[{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100}}],"ownerIds":[{"_id":"66954794b24db9885e5aed83","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[],"communityId":"6654ae4eba54fe502d4e4187","timeOnRoute":13,"distance":9,"distanceInMeters":8521,"createdAt":"2025-04-10T15:25:50.512Z","updatedAt":"2025-04-22T16:06:39.555Z","__v":55,"superCommunityId":"653fd68233d83952fafcd4be","routeCost":10,"ticketCost":100,"externalInfo":{"uuid":""},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"roundOrder":[],"useServiceReservations":false,"autoStartConditions":{"enabled":false,"ignition":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"custom":{"ui":{"color":"563f3f","marker":{"1x":"","1.5x":"","2x":"","3x":"","4x":""}}}}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Status Should Be    200
    
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
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/createServices/6654ae4eba54fe502d4e4187?community=6654ae4eba54fe502d4e4187
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    202
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    15s
    Sleep    4s

Get Service Id
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/icTable/services?community=${idComunidad2}&startDate=${start_date_today}&endDate=${end_date_pasttomorrow}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
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



Make User reservation Admin(No resources)(Paulina pasajero)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/bookService/${service_id}?community=${idComunidad2}
    ...    data={"userId":"65e5d25bb23585cc1d6720b4"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}

Get reservation before cancel
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/service/${service_id}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    1        More reservations found in service, there should only be one
    ${reservation_userid}=    Set Variable    ${response.json()}[reservations][0][userId][_id]
    ${reservationId}=    Set Variable    ${response.json()}[reservations][0][_id]

    Should Be Equal As Strings    ${reservation_userid}    65e5d25bb23585cc1d6720b4
    Set Global Variable    ${reservationId}

    Log    ${response.content}

Cancel reservation 
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"_id":"65e5d25bb23585cc1d6720b4","communities":[{"confirmed":true,"_id":"6757581a0045ccd021173bea","communityId":"6654ae4eba54fe502d4e4187","isAdmin":false,"isStudent":false,"custom":[{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e7","key":"rut","value":"190778045"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e8","key":"address","value":"Brown Sur 48, 7760066 Ñuñoa, Región Metropolitana, Chile"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e9","key":"coordinates","value":"-33.45584580063265,-70.5919211272842"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1ea","key":"Color","value":"Color"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1eb","key":"Animal","value":"Animal2"}],"privateBus":{"odd":{"canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false,"providers":[]},"validation":{"external":{"required":true}},"enabled":true,"favoriteRoutes":[],"suggestedRoutes":["66954794b24db9885e5aed7e","66cc94821125fb1232f990a1","668456ea56270b3e81594b60","6798bd8be494cc12a9d737d4"],"_id":"6757581a0045ccd021173bf0","oDDServices":[{"canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false,"providers":["653fd68233d83952fafcd4be"],"_id":"67cb1f0956535c5b75cba9a8","name":"Taxis Nico"}]},"createdAt":"2024-12-09T20:50:34.207Z","updatedAt":"2025-03-07T16:30:01.698Z"}],"emails":[{"fromCommunity":false,"_id":"65e5d25bb23585cc1d6720b5","email":"florencia+paulina@allrideapp.com","validationToken":"cd2d45a0c96c46f51a837537c0779c4f0321d71b0b1f9462df6faa2607e2021a7ad6a8944a31624c71972ca0e1c33a2911d9971e77dbfe6fa0289061a97bcde7","active":true}],"name":"Paulina Pasajero","custom":[{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e7","key":"rut","value":"190778045"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e8","key":"address","value":"Brown Sur 48, 7760066 Ñuñoa, Región Metropolitana, Chile"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e9","key":"coordinates","value":"-33.45584580063265,-70.5919211272842"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1ea","key":"Color","value":"Color"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1eb","key":"Animal","value":"Animal2"}],"validated":false,"reservationId":"hasReservation"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Put On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/service/removeReservation/${service_id}?community=6654ae4eba54fe502d4e4187
    ...    json=${parsed_json}
    ...    headers=${headers}

Get reservation after cancel (before resource assignment)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/service/${service_id}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    0        Has found a reservation when it should be none
Resource Assignment(Driver and Vehicle)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id}?community=${idComunidad2}
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId2}"},"drivers":[],"vehicle":{"vehicleId":"${vehicleId2}","capacity":"5"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${departureId}=     Set Variable    ${response.json()}[resources][0][departure][departureId]

    Set Global Variable    ${departureId}
    Log    ${code}

Get Departure Info After Resource Assignment
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]
    
    
    Should Be Equal As Numbers    ${capacity}    46
    ...    msg=❌ 'capacity' should be 46 but was ${capacity}
    
        Should Be Equal As Strings    ${startCapacity}    46
    ...    msg=❌ 'startCapacity' should be 46 but was ${startCapacity}

Make User reservation Admin(Paulina pasajero) After resource Assignment
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/bookService/${service_id}?community=${idComunidad2}
    ...    data={"departureId":"${departureId}","space":{"enabled":true,"locked":false,"disabled":false,"_id":"66830b1a30b7052ec77432a0","seat":"22","seatNumber":22},"userId":"65e5d25bb23585cc1d6720b4","seat":"22"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}

Get Departure Info After User Reservation
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]
    
    
    Should Be Equal As Numbers    ${capacity}    45
    ...    msg=❌ 'capacity' should be 45 but was ${capacity}
    
        Should Be Equal As Strings    ${startCapacity}    46
    ...    msg=❌ 'startCapacity' should be 46 but was ${startCapacity}

Get reservation before cancel (After resource assignment)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/service/${service_id}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    1        More reservations found in service, there should only be one
    ${reservation_userid}=    Set Variable    ${response.json()}[reservations][0][userId][_id]
    ${reservationId}=    Set Variable    ${response.json()}[reservations][0][_id]

    Should Be Equal As Strings    ${reservation_userid}    65e5d25bb23585cc1d6720b4
    Set Global Variable    ${reservationId}

    Log    ${response.content}



Cancel reservation After Resources
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"_id":"65e5d25bb23585cc1d6720b4","communities":[{"confirmed":true,"_id":"6757581a0045ccd021173bea","communityId":"6654ae4eba54fe502d4e4187","isAdmin":false,"isStudent":false,"custom":[{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e7","key":"rut","value":"190778045"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e8","key":"address","value":"Brown Sur 48, 7760066 Ñuñoa, Región Metropolitana, Chile"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e9","key":"coordinates","value":"-33.45584580063265,-70.5919211272842"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1ea","key":"Color","value":"Color"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1eb","key":"Animal","value":"Animal2"}],"privateBus":{"odd":{"canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false,"providers":[]},"validation":{"external":{"required":true}},"enabled":true,"favoriteRoutes":[],"suggestedRoutes":["66954794b24db9885e5aed7e","66cc94821125fb1232f990a1","668456ea56270b3e81594b60","6798bd8be494cc12a9d737d4"],"_id":"6757581a0045ccd021173bf0","oDDServices":[{"canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":false,"asapDepartures":false,"providers":["653fd68233d83952fafcd4be"],"_id":"67cb1f0956535c5b75cba9a8","name":"Taxis Nico"}]},"createdAt":"2024-12-09T20:50:34.207Z","updatedAt":"2025-03-07T16:30:01.698Z"}],"emails":[{"fromCommunity":false,"_id":"65e5d25bb23585cc1d6720b5","email":"florencia+paulina@allrideapp.com","validationToken":"cd2d45a0c96c46f51a837537c0779c4f0321d71b0b1f9462df6faa2607e2021a7ad6a8944a31624c71972ca0e1c33a2911d9971e77dbfe6fa0289061a97bcde7","active":true}],"name":"Paulina Pasajero","departureId":"${departureId}","busCode":"MORISC","custom":[{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e7","key":"rut","value":"190778045"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e8","key":"address","value":"Brown Sur 48, 7760066 Ñuñoa, Región Metropolitana, Chile"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1e9","key":"coordinates","value":"-33.45584580063265,-70.5919211272842"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1ea","key":"Color","value":"Color"},{"listValue":[],"private":true,"_id":"67af4e004fe3a577d333d1eb","key":"Animal","value":"Animal2"}],"validated":false,"reservationId":"hasReservation","seat":"22"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Put On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/service/removeReservation/${service_id}?community=6654ae4eba54fe502d4e4187
    ...    json=${parsed_json}
    ...    headers=${headers}

Get reservation after cancel (After resource assignment) in service
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/service/${service_id}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    0        Has found a reservation when it should be none
Get reservation after cancel (After resource assignment) in departure
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    0        Has found a reservation when it should be none
    
    
    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]
    
    
    Should Be Equal As Numbers    ${capacity}    46
    ...    msg=❌ 'capacity' should be 46 but was ${capacity}
    
        Should Be Equal As Strings    ${startCapacity}    46
    ...    msg=❌ 'startCapacity' should be 46 but was ${startCapacity}



Login User With Email(Obtain Token)
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+usuario3comunidad2@allrideapp.com","password":"Lolowerty21@"}
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


Seat Reservation(User1 Should be the only one who can reserve)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id}","departureId":"${departureId}", "seat": "22"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200        Seat reservation not working statusCode ${code}
    Log    ${code}


Get reservation before cancel (After resource assignment) user2
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/service/${service_id}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    1        More reservations found in service, there should only be one
    ${reservation_userid}=    Set Variable    ${response.json()}[reservations][0][userId][_id]
    ${reservationId}=    Set Variable    ${response.json()}[reservations][0][_id]

    Should Be Equal As Strings    ${reservation_userid}    666748b30c80b160cb019c0a        Another user found in reservation, failing
    Set Global Variable    ${reservationId}

    Log    ${response.content}


Cancel reservation From app
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/pb/user/booking/${service_id}
    ...    headers=${headers}

Get reservation after cancel from app(service)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/service/${service_id}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    0        Has found a reservation when it should be none

Get reservation after cancel from app (After resource assignment) in departure
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservations}=    Set Variable  ${response.json()}[reservations]
    Length Should Be    ${reservations}    0        Has found a reservation when it should be none
    
    
    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]
    
    