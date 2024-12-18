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

2 hours local
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Create Product
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/products/createProduct?community=6654ae4eba54fe502d4e4187
    ...    data={"active":true,"name":"Ticket de Bus ","description":"Todas las comunidades/ sin termino de publicación","communities":["6654ae4eba54fe502d4e4187"],"superCommunities":["653fd68233d83952fafcd4be"],"expiration":"","price":100,"discount":0,"stock":2,"values":[{"communities":["6654ae4eba54fe502d4e4187"],"superCommunities":["653fd68233d83952fafcd4be"],"ref":"pb_ticket","quantity":1,"options":{"name":"Ticket de Bus ","description":"Todas las comunidades/ sin termino de publicación","startDate":null,"endDate":null,"state":"available","allRoutes":true,"routeIds":[],"routeNames":[],"oddTypes":[]}}],"productType":"pb_ticket"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}


Get Service Id
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${service_id_tickets}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_scheduled_services}=    Get Length    ${responseJson['scheduledServices']}
    
    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate    sorted(${responseJson}[scheduledServices], key=lambda x: x['createdAt'])    json
    
    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id_tickets}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}
    
    Set Global Variable    ${service_id_tickets}

    Log    Last created service ID: ${service_id_tickets}
    
Make User reservation Admin(No resources)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/bookService/${service_id_tickets}?community=653fd601f90509541a748683
    ...    data={"userId":"663ccf399a0c214e3398f5cd"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}

Check Reservation Admin
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets}?community=${idComunidad}


    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservationUser}=    Set Variable    ${response.json()}[reservations][0][userId][_id]
    Should Be Equal As Strings    ${reservationUser}   663ccf399a0c214e3398f5cd

    Log    ${response.content}
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

Check Reservation Admin After Resource Assignment
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets}?community=${idComunidad}


    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservationUser}=    Set Variable    ${response.json()}[reservations][0][userId][_id]
    Should Be Equal As Strings    ${reservationUser}   663ccf399a0c214e3398f5cd

    Log    ${response.content}

Assign Reservation to resources
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id_tickets}?community=653fd601f90509541a748683
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"6582e724938e4e7b3bcf9f0a"},"drivers":[],"vehicle":{"vehicleId":"6553b81315e27f4db2b45935","capacity":5},"departure":{"departureId":"${departureId}"},"passengers":[{"userId":{"_id":"663ccf399a0c214e3398f5cd","communities":[{"confirmed":true,"_id":"663cd38e9a0c214e3398f60e","communityId":"653fd601f90509541a748683","isAdmin":false,"isStudent":false,"custom":[{"listValue":[],"private":true,"_id":"663cd38e9a0c214e3398f60f","key":"rut","value":"190778045"}],"privateBus":{"odd":{"canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true,"providers":[]},"enabled":true,"favoriteRoutes":["65ef5d3dbe0acad9ce58e64e","664e71b6b4dd46b0430ec350","66983955176a3e8a0bc83231","66a7f1ee62c957614888477f","65fc4d72294a72ec80a6e03f"],"suggestedRoutes":["664f4fb231dda0aeb62b388e","65faf386137abd9662f15a45","65faf386137abd9662f15a45","65e88349110e5655e1583ca6","6613f13f4d7ba0b1c8ace6ef","65e8827b110e5655e1583a45","667ad5d7cf548a520da96965","6643e86737f11b33d6a2d203","6643e86737f11b33d6a2d203","65a7d0d784c8d426152d3b7b","65faecf0137abd9662f156f6","6657adf63fab993cca75789e","65e9c851b131f0962a5474c8","66a92fecba7b5716c878e6b0"],"_id":"663cd38e9a0c214e3398f610","oDDServices":[]},"createdAt":"2024-05-09T13:45:50.019Z","updatedAt":"2024-08-08T13:32:04.699Z"}],"emails":[{"fromCommunity":false,"_id":"663ccf399a0c214e3398f5ce","email":"nicolas+exclusive@allrideapp.com","validationToken":"cf2d2a417bbc401768783d154ccb28eeacef1563f3543f64163c1ee8fa2015aa70c996487306447a3e2292749d80aea11e92a9128f6d8534adc859e25e09f214","active":true}],"name":"undefined undefined"}}]}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

Check Reservation in Departure As Driver

    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/departures/${departureId}


    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenDriver}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${responseJson}=     Set Variable    ${response.json()}
    ${reservationInDeparture}=    Set Variable    ${responseJson}[reservations][0][userId]

    Should Be Equal As Strings    ${reservationInDeparture}    663ccf399a0c214e3398f5cd
    Log    ${response.content}

Delete Reservation in Admin
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/service/removeReservation/${service_id_tickets}?community=653fd601f90509541a748683
    ...    data={"_id":"663ccf399a0c214e3398f5cd","communities":[{"confirmed":true,"_id":"663cd38e9a0c214e3398f60e","communityId":"653fd601f90509541a748683","isAdmin":false,"isStudent":false,"custom":[{"listValue":[],"private":true,"_id":"663cd38e9a0c214e3398f60f","key":"rut","value":"190778045"}],"privateBus":{"odd":{"canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true,"providers":[]},"enabled":true,"favoriteRoutes":["65ef5d3dbe0acad9ce58e64e","664e71b6b4dd46b0430ec350","66983955176a3e8a0bc83231","66a7f1ee62c957614888477f","65fc4d72294a72ec80a6e03f"],"suggestedRoutes":["664f4fb231dda0aeb62b388e","65faf386137abd9662f15a45","65faf386137abd9662f15a45","65e88349110e5655e1583ca6","6613f13f4d7ba0b1c8ace6ef","65e8827b110e5655e1583a45","667ad5d7cf548a520da96965","6643e86737f11b33d6a2d203","6643e86737f11b33d6a2d203","65a7d0d784c8d426152d3b7b","65faecf0137abd9662f156f6","6657adf63fab993cca75789e","65e9c851b131f0962a5474c8","66a92fecba7b5716c878e6b0"],"_id":"663cd38e9a0c214e3398f610","oDDServices":[]},"createdAt":"2024-05-09T13:45:50.019Z","updatedAt":"2024-08-08T13:32:04.699Z"}],"emails":[{"fromCommunity":false,"_id":"663ccf399a0c214e3398f5ce","email":"nicolas+exclusive@allrideapp.com","validationToken":"cf2d2a417bbc401768783d154ccb28eeacef1563f3543f64163c1ee8fa2015aa70c996487306447a3e2292749d80aea11e92a9128f6d8534adc859e25e09f214","active":true}],"name":"undefined undefined","custom":[{"listValue":[],"private":true,"_id":"663cd38e9a0c214e3398f60f","key":"rut","value":"190778045"}],"validated":false,"reservationId":"hasReservation"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    Sleep    1.5s

Check Reservation Admin After Delete Reservation
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets}?community=${idComunidad}


    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${reservationUser}=    Set Variable    ${response.json()}[reservations]
    Should Be Empty    ${reservationUser}

    Log    ${response.content}

    Sleep    2

Check Reservation After delete in Departure As Driver
    Skip
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/departures/${departureId}


    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenDriver}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${responseJson}=     Set Variable    ${response.json()}
    ${reservationInDeparture}=    Set Variable    ${responseJson}[reservations]

    Should Be Empty    ${reservationInDeparture}
    Log    ${response.content}

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
    ...    url=/api/v1/admin/pb/routes/66ba67efe7323a17ad7624ea?community=653fd601f90509541a748683
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    5s