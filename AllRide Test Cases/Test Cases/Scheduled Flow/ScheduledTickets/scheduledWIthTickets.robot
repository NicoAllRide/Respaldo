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

2 hours local
    ${date}=    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}=    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}=    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}=    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Create Schedule Alto - Apumanque 19:00 hrs
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${endPoint}
    ...    data={"name":"Validaciones Descuento Ticket","description":"templateRobotTickets","communities":["${idComunidad}"],"superCommunities":["${idSuperCommunity}"],"ownerIds":[{"id":"${idComunidad}","role":"community"}],"shapeId":"65ef21aa6f1c17c2eeeb5f98","usesBusCode":false,"usesVehicleList":true,"usesDriverCode":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"dynamicSeatAssignment":true,"usesTickets":true,"startsOnStop":false,"notNearStop":false,"routeCost":"100","ticketCost":"10","excludePassengers":{"active":false,"excludeType":"dontHide"},"restrictPassengers":{"enabled":false,"allowed":[],"visibility":{"enabled":false,"excludes":false,"parameters":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"stopSchedule":[],"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"defaultResources":[]}],"stopOnReservation":true,"restrictions":{"customParams":{"enabled":false,"params":[]}}},"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"allowsServiceSnapshots":false,"allowsNonServiceSnapshots":false,"labels":[],"roundOrder":[{"stopId":"655d11d88a5a1a1ff0328466","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328464","notifyIfPassed":false}],"anchorStops":["655d11d88a5a1a1ff0328466","655d11d88a5a1a1ff0328464"],"originStop":"655d11d88a5a1a1ff0328466","destinationStop":"655d11d88a5a1a1ff0328464","hasBeacons":true,"hasCapacity":true,"isStatic":false,"showParable":false,"extraInfo":"","color":"502929","usesManualSeat":true,"allowsManualValidation":true,"usesDriverPin":false,"hasBoardings":true,"hasUnboardings":true,"allowsDistance":false,"allowGenericVehicles":true,"hasExternalGPS":false,"departureHourFulfillment":{"enabled":false,"ranges":[]},"usesOfflineCount":true,"visible":true,"active":true,"usesTextToSpeech":false,"hasBoardingCount":false,"hasRounds":false,"hasUnboardingCount":false,"timeOnRoute":11,"distance":4,"distanceInMeters":3840,"legOptions":[],"route_type":3}
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

Get Requested Tickets(Must be 0)
    [Documentation]    Verifica que no existan tickets solicitados (requested tickets) al inicio del flujo. La lista de solicitudes debe estar vacía.
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/request/list/?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    Should Be Empty    ${responseJson}    Requested Tickets Should be 0

    Log    ${responseJson}

Get Total Tickets
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad}
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${tickets_list}=    Set Variable    ${response.json()}

    ${ticketGeneral}=    Set Variable    0
    FOR    ${ticket}    IN    @{tickets_list}
        IF    "${ticket['name']}" == "Ticket general"
            ${ticketGeneral}=    Set Variable    ${ticket['total']}
        END
    END

    Log    La cantidad de tickets generales es ${ticketGeneral}
    Set Global Variable    ${ticketGeneral}


Request Tickets
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/request?community=${idComunidad}
    ...    data={"ticketQuantity":10,"cost":100,"voucherUrl":"https://s3.amazonaws.com/allride.uploads/privateBuses_voucher_653fd601f90509541a748683_1710787761571.pdf"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${ticketRequestId}=    Set Variable    ${response.json()}[_id]
    ${ticketRequestQty}=    Set Variable    ${response.json()}[ticketQuantity]
    Set Global Variable    ${ticketRequestId}
    Set Global Variable    ${ticketRequestQty}
    Should Be Equal As Strings
    ...    pendingApproval
    ...    ${response.json()}[state]
    ...    The state of the tickets should be pendingApproval but the state is ${response.json()}[state]
    Log    ${ticketRequestId}
    Log    ${ticketRequestQty}

Get Requested Tickets(Should Not Be 0)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/request/list/?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    Should Not Be Empty    ${responseJson}    The requested tickets should not be 0, but is empty

    Log    ${responseJson}

Treasurer Request Approval
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/request/approve/treasurer?community=${idComunidad}&requestId=${ticketRequestId}&userId=${idAdmin}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${ticketResponseId}=    Set Variable    ${responseJson}[ticketRequestRes][_id]
    ${ticketResponseQty}=    Set Variable    ${responseJson}[ticketRequestRes][ticketQuantity]
    ${ticketResponseState}=    Set Variable    ${responseJson}[ticketRequestRes][state]

    Should Be Equal As Strings
    ...    ${ticketResponseId}
    ...    ${ticketRequestId}
    ...    The ticket requestId is not the same in the response after Treasure Approval, is ${ticketResponseId}
    Should Be Equal As Strings
    ...    ${ticketResponseQty}
    ...    ${ticketRequestQty}
    ...    The ticket request quantity is not the same in the response after Treasure Approval, is ${ticketResponseQty}
    Should Be Equal As Strings
    ...    ${ticketResponseState}
    ...    pendingApproval
    ...    The state after Treasure Approval is ${ticketResponseState}

    Log    ${responseJson}

Seller Request Approval
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/request/approve/seller?community=${idComunidad}&requestId=${ticketRequestId}&userId=${idAdmin}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${ticketResponseId}=    Set Variable    ${responseJson}[ticketRequestRes][_id]
    ${ticketResponseQty}=    Set Variable    ${responseJson}[ticketRequestRes][ticketQuantity]
    ${ticketResponseState}=    Set Variable    ${responseJson}[ticketRequestRes][state]
    ${ticketAssignedQuantity}=    Set Variable    ${responseJson}[ticketRequestRes][assignedQuantity]

    Should Be Equal As Strings    ${ticketResponseId}    ${ticketRequestId}
    Should Be Equal As Strings    ${ticketResponseQty}    ${ticketRequestQty}
    Should Be Equal As Strings    ${ticketResponseState}    approved
    Should Be Equal As Strings    ${ticketAssignedQuantity}    ${ticketRequestQty}

    Log    ${responseJson}

Get Total Tickets(After Request)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad}
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    ${start_time}=    Get Current Date    result_format=%H:%M:%S.%f
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${end_time}=    Get Current Date    result_format=%H:%M:%S.%f

    ${elapsed}=    Subtract Time From Time    ${end_time}    ${start_time}
    Log    Elapsed time: ${elapsed}

    # Guardamos el JSON
    ${tickets_list}=    Set Variable    ${response.json()}

    # Extraemos SOLO el total de "Ticket general"
    ${totalTicketsAfterRequest}=    Evaluate    [t["total"] for t in ${tickets_list} if t["name"]=="Ticket general"][0]

    Convert To Integer    ${ticketGeneral}
    Convert To Integer    ${ticketRequestQty}

    ${ticketsPlus}=    Evaluate    ${ticketGeneral}+${ticketRequestQty}
    Should Be True    ${totalTicketsAfterRequest}==${ticketsPlus}

    Log    La cantidad de tickets generales después de la solicitud es ${totalTicketsAfterRequest}
    Set Global Variable    ${totalTicketsAfterRequest}


Assing Tickets(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=653fd601f90509541a748683&userId=${idNico}&ticketsQuantityToAssign=2
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}





Assing Tickets(Kratos)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=${idKratos}&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}

Assing Tickets(Pedro)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=${idPedro}&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}
Assing Tickets(Loki) No reservation User1
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=67a231824e4333dad7f36f75&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}
Assing Tickets No reservation User2
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=687f9e8b3e5edbeeefe54306&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}
Assing Tickets No reservation User3
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=687f9ea75c72270369d2c5d4&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Should Be True    ${totalTicketsAfterRequest} >=${assignQty}

Get Assigned Tickets (Nico)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=${idComunidad}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyNico}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "${idNico}"    BREAK
        Set Global Variable    ${assignedQtyNico}
    END

    Should Be True
    ...    ${assignedQtyNico}==${assignQty}
    ...    Assigned tickets Nico should be ${assignQty} but it is ${assignedQtyNico} The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyNico}

Get Assigned Tickets (Kratos)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=${idComunidad}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyKratos}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "${idKratos}"    BREAK
        Set Global Variable    ${assignedQtyKratos}
    END

    Should Be True
    ...    ${assignedQtyKratos}==${assignQty}
    ...    Assigned tickets Kratos should be ${assignQty} but it is ${assignedQtyKratos}; The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyKratos}

Get Assigned Tickets (Pedro)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=${idComunidad}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyPedro}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "${idPedro}"    BREAK
        Set Global Variable    ${assignedQtyPedro}
    END

    Should Be True
    ...    ${assignedQtyPedro}==${assignQty}
    ...    Assigned tickets Pedro should be ${assignQty} but it is ${assignedQtyPedro}; The assignment is not working

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyPedro}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)


Get Service Id
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_pastTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id_tickets}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_scheduled_services}=    Get Length    ${responseJson['scheduledServices']}

    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate
    ...    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '${scheduleId}']
    ...    json
    Log    ${sorted_services}

    # Verificar si se encontraron servicios
    IF    ${sorted_services} == []
        Fatal Error
        ...    msg= No services were created with routeId._id = "${scheduleId}" All createSheduledWithTickets Tests Failing(Fatal error)
    END

    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id_tickets}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}

    Set Global Variable    ${service_id_tickets}

    Log    Last created service ID: ${service_id_tickets}

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

Resource Assignment(Driver and Vehicle)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id_tickets}?community=${idComunidad}
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId}"},"drivers":[],"vehicle":{"vehicleId":"${vehicleId}","capacity":"5"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

Get Service Id And Validate Pending States 
   [Documentation]    Obtiene el último servicio creado con un routeId específico y valida que todos los resources[x].departure.state sean 'pending'
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_pastTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id_tickets}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_scheduled_services}=    Get Length    ${responseJson['scheduledServices']}

    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate
    ...    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '${scheduleId}']
    ...    json
    Log    ${sorted_services}

    # Verificar si se encontraron servicios
    IF    ${sorted_services} == []
        Fatal Error
        ...    msg= No services were created with routeId._id = "${scheduleId}" All createSheduledWithTickets Tests Failing(Fatal error)
    END

    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id_tickets}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}

    Set Global Variable    ${service_id_tickets}

    Log    Last created service ID: ${service_id_tickets}

        # Validar que todos los resources[x].departure.state == 'pending'
    FOR    ${resource}    IN    @{last_service['resources']}
        ${res_state}=    Set Variable    ${resource['departure']['state']}
        Should Be Equal As Strings    ${res_state}    pending    msg=Expected resource departure.state to be 'pending' but got '${res_state}'
    END

Verify capacity in vehicle (After assign resources from admin)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets}?community=653fd601f90509541a748683

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacityVehicle}=    Set Variable    ${response.json()}[resources][0][vehicle]
    Should Contain    ${capacityVehicle}    capacity    Vehicle in resources doesn't contain the 'capacity' property

Get departureId
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

Add Order Stops(Alto Las Condes (1))
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${addStopOrder}
    ...    data={"routeId":"${scheduleId}","stopId":"655d11d88a5a1a1ff0328466","stop_sequence":1,"cost":0,"sequence":"1","ownerIds":[{"id":"${idComunidad}","role":"community"}],"communities":["${idComunidad}"],"superCommunities":["${idSuperCommunity}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

Add Order Stops(Mall Apumanque (2))
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${addStopOrder}
    ...    data={"routeId":"${scheduleId}","stopId":"655d11d88a5a1a1ff0328464","stop_sequence":2,"cost":0,"sequence":"2","ownerIds":[{"id":"${idComunidad}","role":"community"}],"communities":["${idComunidad}"],"superCommunities":["${idSuperCommunity}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}



Seat Reservation(User1-NicoEnd)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id_tickets}","departureId":"${departureId}","stopId":"655d11d88a5a1a1ff0328464","seat":"1"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200    Seat reservation not working statusCode ${code}
    Log    ${code}
    Sleep    5s


Seat Reservation(User2-Pedro Pascal Available Seat)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenPedroPascal}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id_tickets}","departureId":"${departureId}","stopId":"655d11d88a5a1a1ff0328464","seat":"2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
   Sleep    5s

Seat Reservation(User3-Kratos Available Seat)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenKratos}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id_tickets}","departureId":"${departureId}","stopId":"655d11d88a5a1a1ff0328464","seat":"3"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    5s

Check services from route_type
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v2/pb/driver/services/routes
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Not Be Empty    ${response.json()}    
    ...    msg=❌ Got an empty response — looks like the scheduled services aren't being retrieved, and there should be at least one.


Driver Accept Service
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/acceptOrReject/${departureId}
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
    ...    data={"departureId":"${departureId}","communityId":"${idComunidad}","startLat":-33.3908833,"startLon":-70.54620129999999,"legType":"pre","customParamsAtStart":[],"preTripChecklist":[],"routeId":"${scheduleId}","capacity":5,"busCode":"1111","driverCode":"753","vehicleId":"${vehicleId}","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${departureToken}

    Log    ${departureToken}
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
    ...    data={"departureId":"${departureId}","communityId":"${idComunidad}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":5,"busCode":"1111","driverCode":"753","vehicleId":"${vehicleId}","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${departureToken}
    Log    ${departureToken}
    Log    ${code}

Get User QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["${idNico}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}

Get User QR(No tickets user)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["661d508c72418a2e98cf7978"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNoTickets}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNoTickets}
    Log    ${qrCodeNoTickets}
    Log    ${code}

Get User QR(Another Community User)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=6654ae4eba54fe502d4e4187
    ...    data={"ids":["66f5bee8f3a0b05c0092e702"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeAnotherCommunity}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeAnotherCommunity}
    Log    ${qrCodeAnotherCommunity}
    Log    ${code}
Get User QR(Loki no reservation)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["67a231824e4333dad7f36f75"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNoReservation1}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNoReservation1}
    Log    ${qrCodeNoReservation1}
    Log    ${code}
Get User QR(No reservation 1)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["687f9e8b3e5edbeeefe54306"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNoReservation2}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNoReservation2}
    Log    ${qrCodeNoReservation2}
    Log    ${code}
Get User QR(No reservation 2)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["687f9ea75c72270369d2c5d4"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNoReservation3}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNoReservation3}
    Log    ${qrCodeNoReservation3}
    Log    ${code}

