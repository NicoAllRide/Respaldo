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
    [Documentation]    Se obtiene el total de ticket
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
# Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Obtiene el tiempo de inicio
    ${start_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Obtiene el tiempo de finalización
    ${end_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Calcula el tiempo transcurrido (elapsed)
    ${elapsed}=    Subtract Time From Time    ${end_time}    ${start_time}
    Log    Elapsed time: ${elapsed}

    # Almacena la respuesta JSON en una variable para poder manipularla
    ${totalTickets}=    Set Variable    ${response.json()}
    Set Global Variable    ${totalTickets}

    Log    La cantidad total de tickets es ${totalTickets}

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

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Obtiene el tiempo de inicio
    ${start_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Obtiene el tiempo de finalización
    ${end_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Calcula el tiempo transcurrido (elapsed)
    ${elapsed}=    Subtract Time From Time    ${end_time}    ${start_time}
    Log    Elapsed time: ${elapsed}

    # Almacena la respuesta JSON en una variable para poder manipularla
    ${totalTicketsAfterRequest}=    Set Variable    ${response.json()}
    Convert To Integer    ${totalTickets}
    Convert To Integer    ${ticketRequestQty}

    ${ticketsPlus}=    Evaluate    ${totalTickets}+${ticketRequestQty}
    Should Be True    ${totalTicketsAfterRequest}==${ticketsPlus}
    Log    La cantidad total de tickets es ${totalTicketsAfterRequest}

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
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
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
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
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
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
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
    ...    url=/api/v2/pb/driver/departure
    ...    data={"communityId":"${idComunidad}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"68488d2a4ff298af70023813","capacity":5,"busCode":"1111","driverCode":"753","vehicleId":"${vehicleId}","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${departureToken}
    Log    ${departureToken}
    
    ${departureId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${departureId}


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
Get User QR(passes)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["689621cf4081482e6464bdac"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodePasesNoReservation}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodePasesNoReservation}
    Log    ${qrCodePasesNoReservation}
    Log    ${code}

Validate With QR(Loki No reservation)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeNoReservation1}","timezone":"America/Santiago","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    10s

Get Departure Info After QR Validation(No reservation, capacity left)
    [Documentation]    Capacity debería ser 4 (5 - la validación recién hecha)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]

   
        Should Be Equal As Numbers    ${capacity}    4
    ...    msg=❌ 'capacity' should be 4 but was ${capacity}
    
        Should Be Equal As Strings   ${startCapacity}    5
    ...    msg=❌ 'startCapacity' should be 5 but was ${startCapacity}
    

Validate With No reservation User Pases(Should be able to validate)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodePasesNoReservation}","timezone":"America/Santiago","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    10s
Get Departure Info After Custom Validation (No reservation)
    [Documentation]    Capacity debería ser 3 (5 - 2 validaciones)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]

   
        Should Be Equal As Numbers    ${capacity}    3
    ...    msg=❌ 'capacity' should be 3 but was ${capacity}
    
        Should Be Equal as Strings   ${startCapacity}    5
    ...    msg=❌ 'startCapacity' should be 5 but was ${startCapacity}


Validate With user No reservation( Should not be able to validate, no seats left, only for reservations) Tickets
    [Documentation]    Pasajero sin reserva no debería poder validar, no quedan asientos libres, solo asientos con reserva
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=  Run Keyword and expect error     HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v1/pb/provider/departures/validate     POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeNoReservation3}","timezone":"America/Santiago","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Validate With user No reservation( Should not be able to validate, no seats left, only for reservations) Pases
    [Documentation]    Pasajero sin reserva no debería poder validar, no quedan asientos libres, solo asientos con reserva
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=  Run Keyword and expect error     HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v1/pb/provider/departures/validate     POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeNoReservation3}","timezone":"America/Santiago","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)


Validation QR Without Tickets (Should Fail)
    [Documentation]    Pasajero sin tickets no debería poder validarse(QR)

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
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeNoTickets}","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Status Should Be    403    msg= User validated, should not be able to validate, no tickets assigned

    Sleep    10s

Validation Custom Without Tickets (Should Fail)

    [Documentation]    Pasajero sin tickets no debería poder validarse(custom)

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Run Keyword and expect Error
    ...    HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v2/pb/driver/departures/validateWithCustom
    ...    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/validateWithCustom
    ...    data={"communityId":"${idComunidad}","key":"rut","value":"258258258","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Status Should Be    403

Validate With NFC(No tickets Should fail)
    [Documentation]    Pasajero sin tickets no debería poder validarse(card)

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Run Keyword And Expect Error
    ...    HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v2/pb/driver/tickets/validation/USERNOTICKET123
    ...    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/tickets/validation/${cardNotickets}
    ...    data={"communityId":"${idComunidad}","key":"rut","value":"${userNoTicketRut}","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Status Should Be    403

Validate With User From another community QR(Should fail)
    [Documentation]    Pasajero de otra comunidad no debería poder validarse
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
    ...    data={"communityId":"${idComunidad2}","validationString":"${qrCodeAnotherCommunity}","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}

    Status Should Be    403
    Sleep    10s

Validate With ''X'' QR From internet ( Should Fail)
    [Documentation]    Códido de internet no debería poder validarse

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
    ...    data={"communityId":"","validationString":"https://www.youtube.com/watch?v=dQw4w9WgXcQ","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}

    Status Should Be    403
    Sleep    10s


Get Departure Info After reservations(Capacity and Start Capacity)
    [Documentation]    Capacity debería seguir siendo 3, no hubo validación exitosa previa

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]

        Should Be Equal As Numbers    ${capacity}    3
    ...    msg=❌ 'capacity' should be 2 but was ${capacity}
    
        Should Be Equal As Strings    ${startCapacity}    5
    ...    msg=❌ 'startCapacity' should be 5 but was ${startCapacity}
Validate With QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeNico}","timezone":"America/Santiago","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    10s

Get Departure Info After QR Validation(Has reservation)
    [Documentation]    Capacity debería ser 2

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]

   
        Should Be Equal As Numbers    ${capacity}    2
    ...    msg=❌ 'capacity' should be 2 but was ${capacity}
    
        Should Be Equal As Strings  ${startCapacity}    5
    ...    msg=❌ 'startCapacity' should be 5 but was ${startCapacity}
    

Get Assigned Tickets After Validation(Nico)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
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
    Convert To Integer    ${assignedQtyNico}
    ${assignQtyMinus}=    Evaluate    ${assignQty}-1
    Convert To Integer    ${assignQtyMinus}
    Should Be True
    ...    ${assignedQtyNico}==${assignQtyMinus}
    ...    Doesn't discounts tickets after validation with QR, Expected tickets: ${assignQtyMinus}, Actual Tickets ${assignedQtyNico}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyNico}

Get Total Tickets After Validation(Nico)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Obtiene el tiempo de inicio
    ${start_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Obtiene el tiempo de finalización
    ${end_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Calcula el tiempo transcurrido (elapsed)
    ${elapsed}=    Subtract Time From Time    ${end_time}    ${start_time}
    Log    Elapsed time: ${elapsed}

    # Almacena la respuesta JSON en una variable para poder manipularla
    ${totalTicketsAfterValidation}=    Set Variable    ${response.json()}

    Convert To Integer    ${totalTicketsAfterRequest}
    Convert To Integer    ${totalTicketsAfterValidation}
    ${ticketsMinus}=    Evaluate    ${totalTicketsAfterRequest}-3
    Should Be Equal As Integers
    ...    ${totalTicketsAfterValidation}
    ...    ${ticketsMinus}
    ...    Doesn't discounts Total tickets after validation with QR, Expected tickets: ${ticketsMinus}, Actual Tickets ${totalTicketsAfterValidation}
    Log    La cantidad total de tickets es ${totalTicketsAfterValidation}

    Set Global Variable    ${totalTicketsAfterValidation}

Get Movement Historic Nico After Validation
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/movementHistory?community=${idComunidad}&startDate=${start_date_tickets}&endDate=${end_date_tickets}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}[0]
    Should Be Equal As Strings    ${responseJson}[movementType]    cash
    ${responseQty}=    Evaluate    ${responseJson}[amountOfTickets] == 1
    Log    ${responseQty}
    ${previousQty}=    Evaluate    ${responseJson}[previousTickets] == 2
    Log    ${previousQty}
    ${currentQty}=    Evaluate    ${responseJson}[currentTickets] == 1
    Log    ${currentQty}

Validate With Custom(Kratos)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/validateWithCustom
    ...    data={"communityId":"${idComunidad}","key":"rut","value":"126606826","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Get Departure Info After Custom Validation (Has reservation)
    [Documentation]    Capacity debe seguir siendo 2, el usuario tiene reserva

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]

   
        Should Be Equal As Numbers    ${capacity}    1
    ...    msg=❌ 'capacity' should be 1 but was ${capacity}
    
        Should Be Equal As Strings    ${startCapacity}    5
    ...    msg=❌ 'startCapacity' should be 5 but was ${startCapacity}

Get Assigned Tickets After Validation(Kratos)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
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
    Convert To Integer    ${assignedQtyKratos}
    Convert To Integer    ${assignQty}
    ${ticketAssignedQuantity}=    Evaluate    ${assignQty}-1
    Should Be True
    ...    ${assignedQtyKratos}==${ticketAssignedQuantity}
    ...    Doesn't discounts tickets after validation with Custom, Expected tickets: ${ticketAssignedQuantity}, Actual Tickets ${assignedQtyKratos}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyKratos}

Get Total Tickets After Validation(Kratos)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Obtiene el tiempo de inicio
    ${start_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Obtiene el tiempo de finalización
    ${end_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Calcula el tiempo transcurrido (elapsed)
    ${elapsed}=    Subtract Time From Time    ${end_time}    ${start_time}
    Log    Elapsed time: ${elapsed}

    # Almacena la respuesta JSON en una variable para poder manipularla
    ${totalTicketsAfterValidation}=    Set Variable    ${response.json()}
    Convert To Integer    ${totalTicketsAfterRequest}
    Convert To Integer    ${totalTicketsAfterValidation}
    ${ticketsAfterValidation}=    Evaluate    ${totalTicketsAfterRequest}-4
    Should Be True
    ...    ${totalTicketsAfterValidation}==${ticketsAfterValidation}
    ...    Doesn't discounts Total tickets after validation with QR, Expected tickets: ${ticketsAfterValidation}, Actual Tickets ${totalTicketsAfterValidation}
    Log    La cantidad total de tickets es ${totalTicketsAfterValidation}

    Set Global Variable    ${totalTicketsAfterValidation}

Get Movement Historic Kratos After Validation
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/movementHistory?community=${idComunidad}&startDate=${start_date_tickets}&endDate=${end_date_tickets}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}[0]
    Should Be Equal As Strings    ${responseJson}[movementType]    cash
    ${responseQty}=    Evaluate    ${responseJson}[amountOfTickets] == 1
    Log    ${responseQty}
    ${previousQty}=    Evaluate    ${responseJson}[previousTickets] == 2
    Log    ${previousQty}
    ${currentQty}=    Evaluate    ${responseJson}[currentTickets] == 1
    Log    ${currentQty}

Validate With NFC(Pedro)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/tickets/validation/${cardIdPedro}
    ...    data={"communityId":"${idComunidad}","key":"rut","value":"126606826","timezone":"Chile/Continental","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Get Departure Info After reservations(Capacity should be 0 but able to validate, has reservation)

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/departures/${departureId}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacity}=    Set Variable  ${response.json()}[capacity]
    ${startCapacity}=    Set Variable  ${response.json()}[startCapacity]

        Should Be Equal As Numbers    ${capacity}    0
    ...    msg=❌ 'capacity' should be 0 but was ${capacity}
    
        Should Be Equal As Strings    ${startCapacity}    5
    ...    msg=❌ 'startCapacity' should be 5 but was ${startCapacity}

Get Assigned Tickets After Validation(Pedro)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
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
    Convert To Integer    ${assignedQtyPedro}
    ${ticketAssignedQuantity}=    Evaluate    ${assignQty}-1
    Should Be True
    ...    ${assignedQtyPedro}==${ticketAssignedQuantity}
    ...    Doesn't discounts tickets after validation with Custom, Expected tickets: ${ticketAssignedQuantity}, Actual Tickets ${assignedQtyPedro}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyPedro}

Get Total Tickets After Validation(Pedro)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/ticket/list?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Obtiene el tiempo de inicio
    ${start_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Obtiene el tiempo de finalización
    ${end_time}=    Get Current Date    result_format=%H:%M:%S.%f

    # Calcula el tiempo transcurrido (elapsed)
    ${elapsed}=    Subtract Time From Time    ${end_time}    ${start_time}
    Log    Elapsed time: ${elapsed}

    # Almacena la respuesta JSON en una variable para poder manipularla
    ${totalTicketsAfterValidation}=    Set Variable    ${response.json()}
    Convert To Integer    ${totalTicketsAfterRequest}
    Convert To Integer    ${totalTicketsAfterValidation}
    ${ticketsAfterValidation}=    Evaluate    ${totalTicketsAfterRequest}-5
    Should Be True
    ...    ${totalTicketsAfterValidation}==${ticketsAfterValidation}
    ...    Total tickets after validation should be ${ticketsAfterValidation} but it is ${totalTicketsAfterValidation}
    Log    La cantidad total de tickets es ${totalTicketsAfterValidation}

    Set Global Variable    ${totalTicketsAfterValidation}

Get Movement Historic Pedro After Validation
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/movementHistory?community=${idComunidad}&startDate=${start_date_tickets}&endDate=${end_date_tickets}
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}[0]
    Should Be Equal As Strings    ${responseJson}[movementType]    cash
    ${responseQty}=    Evaluate    ${responseJson}[amountOfTickets] == 1
    Log    ${responseQty}
    ${previousQty}=    Evaluate    ${responseJson}[previousTickets] == 2
    Log    ${previousQty}
    ${currentQty}=    Evaluate    ${responseJson}[currentTickets] == 1
    Log    ${currentQty}



Get Passenger List
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/passengerList

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${departureToken}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    Log    ${response.content}

Get Current departure
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/departures/current

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenDriver}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    Log    ${response.content}

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
    ...    url=/api/v2/pb/driver/departure/stop
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":true,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

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
