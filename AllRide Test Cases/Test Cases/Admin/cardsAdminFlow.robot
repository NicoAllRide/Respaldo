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

Generate Random 10 Digit Value
    ${random_value1}=    Evaluate    "".join([str(random.randint(0,9)) for _ in range(10)])    random
    Log    Valor aleatorio generado: ${random_value1}
    Set Global Variable    ${random_value1}
Generate Random 10 Digit Value
    ${random_value2}=    Evaluate    "".join([str(random.randint(0,9)) for _ in range(10)])    random
    Log    Valor aleatorio generado: ${random_value2}
    Set Global Variable    ${random_value2}


Check Community has create cardNotickets
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...   https://stage.allrideapp.com/api/v1/admin/community/67b879e99a2ba09f940ea7c5

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    ${createCard}=    Set Variable    ${response.json()}[config][general][validationParams][params][0][triggeredFns][0]

    Should Be Equal As Strings    ${createCard}    createCard
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas


Create User Bulk No Card
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/communityValidationUsers/bulkInsert?community=67b879e99a2ba09f940ea7c5
    ...    data=[{"community":"67b879e99a2ba09f940ea7c5","values":[{"key":"Rut","value":"${random_value1}","public":true,"check":true},{"key":"color","value":"Dorado","public":true,"check":true},{"key":"animal","value":"Snappig Turtle","public":true,"check":true},{"key":"Empresa","value":"AllRide1","public":true,"check":true}],"validated":false},{"community":"67b879e99a2ba09f940ea7c5","values":[{"key":"Rut","value":"${random_value2}","public":true,"check":true},{"key":"color","value":"Violeta","public":true,"check":true},{"key":"animal","value":"Komodo Dragon","public":true,"check":true},{"key":"Empresa","value":"AllRide2","public":true,"check":true}],"validated":false}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Contain    ${response.json()}[0]    _id        User was created without id
    ${userId1}=    Set Variable    ${response.json()}[0][_id]
    Set Global Variable    ${userId1}
    ${userId2}=    Set Variable    ${response.json()}[0][_id]
    Set Global Variable    ${userId2}

Bulk part 2
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/users/bulkCreateUsers?community=67b879e99a2ba09f940ea7c5
    ...    data=[{"communityId":"67b879e99a2ba09f940ea7c5","country":"cl","name":"Test Usuario1","customValidation":{"Rut":"${random_value1}","color":"Dorado","animal":"Snappig Turtle","Empresa":"AllRide1"},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Automatización","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true}]}},{"communityId":"67b879e99a2ba09f940ea7c5","country":"cl","name":"Test Usuario2","customValidation":{"Rut":"${random_value2}","color":"Violeta","animal":"Komodo Dragon","Empresa":"AllRide2"},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Automatización","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true}]}}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Check Cards Were Created
    ${url}=    Set Variable    https://stage.allrideapp.com/api/v1/admin/pb/card/list/?community=67b879e99a2ba09f940ea7c5
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    ${cards}=    Set Variable   ${response.json()}
    ${last_card}=    Set variable    ${cards}[-1]   
    ${second_last_card}=    Set variable    ${cards}[-2]    

    Log    Última tarjeta: ${last_card}
    Log    Penúltima tarjeta: ${second_last_card}

    ${last_cardId}=     Set Variable    ${cards}[-1][cardId]
    ${second_last_cardId}=     Set Variable    ${cards}[-2][cardId]
    Should Be Equal As Strings    ${random_value1}     ${second_last_cardId}
    Should Be Equal As Strings    ${random_value2}     ${last_cardId}
    
Delete User From community (Delete Validation Too)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=   DELETE On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/users/${userId1}?community=67b879e99a2ba09f940ea7c5
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Delete Community Validation
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=   DELETE On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/communityValidationUsers/userId/${userId2}?community=67b879e99a2ba09f940ea7c5
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)