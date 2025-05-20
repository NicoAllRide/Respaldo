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

#### Edición masiva de usuarios no está funcionando, no entrega bien el payload

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
    skip
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
Get total cards
    
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...   https://stage.allrideapp.com/api/v1/admin/pb/card/list/?community=67b879e99a2ba09f940ea7c5

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    ${totalCards}=    Get Length    ${response.json()}

    Set Global Variable    ${totalCards}
    
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
    ...    data=[{"community":"67b879e99a2ba09f940ea7c5","values":[{"key":"Rut","value":"1414141414","public":true,"check":true},{"key":"color","value":"Dorado","public":true,"check":true},{"key":"animal","value":"Snappig Turtle","public":true,"check":true},{"key":"Empresa","value":"AllRide1","public":true,"check":true}],"validated":false},{"community":"67b879e99a2ba09f940ea7c5","values":[{"key":"Rut","value":"721873291","public":true,"check":true},{"key":"color","value":"Violeta","public":true,"check":true},{"key":"animal","value":"Komodo Dragon","public":true,"check":true},{"key":"Empresa","value":"AllRide2","public":true,"check":true}],"validated":false}]  
    ...     headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Contain    ${response.json()}[0]    _id        User was created without id
    ${userId1}=    Set Variable    ${response.json()}[0][_id]
    Set Global Variable    ${userId1}
    ${userId2}=    Set Variable    ${response.json()}[1][_id]
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
    ...    data=[{"communityId":"67b879e99a2ba09f940ea7c5","country":"cl","name":"Test Usuario1","customValidation":{"Rut":"1414141414","color":"Dorado","animal":"Snappig Turtle","Empresa":"AllRide1"},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Automatización","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true}]}},{"communityId":"67b879e99a2ba09f940ea7c5","country":"cl","name":"Test Usuario2","customValidation":{"Rut":"721873291","color":"Violeta","animal":"Komodo Dragon","Empresa":"AllRide2"},"buses":{"enabled":true,"oDDServices":[{"name":"Taxis Automatización","canCreate":true,"needsAdminApproval":true,"exclusiveDepartures":true,"asapDepartures":true}]}}]
    ...    headers=${headers}

      ${json}=    Set Variable    ${response.json()}
    ${EXPECTED_ERROR}=  Set Variable         existing_card
    ${EXPECTED_USER_1_ID}=    Set Variable   681813b9d86b61c613e8b05a
    ${EXPECTED_USER_1_NAME}=  Set Variable   Test Usuario1
    ${EXPECTED_USER_2_ID}=    Set Variable   681813b9d86b61c613e8b064
    ${EXPECTED_USER_2_NAME}=  Set Variable   Test Usuario2    
    # Verifica que 'correct' tenga exactamente 2 usuarios
    ${correct}=    Get From Dictionary    ${json}    correct
    Length Should Be    ${correct}    2

    # Verifica que 'withErrors' esté vacío
    ${with_errors}=    Get From Dictionary    ${json}    withErrors
    Length Should Be    ${with_errors}    0

    # Verifica que 'cardsWithError' tenga 2 elementos
    ${cards_with_error}=    Get From Dictionary    ${json}    cardsWithError
    Length Should Be    ${cards_with_error}    2

    # Verifica detalles de cada error
    ${card1}=    Get From List    ${cards_with_error}    0
    ${card2}=    Get From List    ${cards_with_error}    1

    # Validar Card 1
    Should Be Equal    ${card1['error']}            ${EXPECTED_ERROR}
    Should Be Equal    ${card1['currentUser']}      ${EXPECTED_USER_1_ID}
    Should Be Equal    ${card1['currentUserName']}  ${EXPECTED_USER_1_NAME}

    # Validar Card 2
    Should Be Equal    ${card2['error']}            ${EXPECTED_ERROR}
    Should Be Equal    ${card2['currentUser']}      ${EXPECTED_USER_2_ID}
    Should Be Equal    ${card2['currentUserName']}  ${EXPECTED_USER_2_NAME}

    #Obtener los nombres de los usuarios
    ${user1}=    Get From List    ${correct}    0
    ${user2}=    Get From List    ${correct}    1

    ${user1_name}=    Get From Dictionary    ${user1}    name
    ${user2_name}=    Get From Dictionary    ${user2}    name

    Set Global Variable    ${user1_name}
    Set Global Variable    ${user2_name}

    Log    Nombre usuario 1: ${user1_name}
    Log    Nombre usuario 2: ${user2_name}


Reasign card with error

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/card/bulkReassign?community=67b879e99a2ba09f940ea7c5
    ...    data=[{"cardId":"1414141414","username":"Elizabeth Solis"}]
    ...    headers=${headers}

    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}    # Reemplaza esto por la variable que contenga el JSON real

    ${correct}=    Get From Dictionary    ${json}    correct
    ${user}=    Get From List    ${correct}    0

    ${expected_user_id}=    Set Variable    67ffe4c453b582b41e2095f4
    ${expected_last_action}=    Set Variable    assign
    ${expected_second_last_action}=    Set Variable    unassign

    ${user_id}=    Get From Dictionary    ${user}    userId
    Should Be Equal    ${user_id}    ${expected_user_id}

    ${history}=    Get From Dictionary    ${user}    history
    ${history_length}=    Get Length    ${history}

    ${second_last_entry}=    Get From List    ${history}    ${history_length - 2}
    ${last_entry}=          Get From List    ${history}    ${history_length - 1}

    ${second_last_action}=    Get From Dictionary    ${second_last_entry}    action
    ${last_action}=          Get From Dictionary    ${last_entry}    action

    Should Be Equal    ${second_last_action}    ${expected_second_last_action}
    Should Be Equal    ${last_action}           ${expected_last_action}

    ${last_target_user}=    Get From Dictionary    ${last_entry}    targetUser
    Should Be Equal    ${last_target_user}    ${expected_user_id}
Reasign card with error 2

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/card/bulkReassign?community=67b879e99a2ba09f940ea7c5
    ...    data=[{"cardId":"1414141414","username":"Test Usuario1"}]
    ...    headers=${headers}

    Status Should Be    200

     ${json}=    Set Variable    ${response.json()}    # Reemplaza esto por la variable que contenga el JSON real

    ${correct}=    Get From Dictionary    ${json}    correct
    ${user}=    Get From List    ${correct}    0

    ${expected_user_id}=    Set Variable    681813b9d86b61c613e8b05a
    ${expected_last_action}=    Set Variable    assign
    ${expected_second_last_action}=    Set Variable    unassign

    ${user_id}=    Get From Dictionary    ${user}    userId
    Should Be Equal    ${user_id}    ${expected_user_id}

    ${history}=    Get From Dictionary    ${user}    history
    ${history_length}=    Get Length    ${history}

    ${second_last_entry}=    Get From List    ${history}    ${history_length - 2}
    ${last_entry}=          Get From List    ${history}    ${history_length - 1}

    ${second_last_action}=    Get From Dictionary    ${second_last_entry}    action
    ${last_action}=          Get From Dictionary    ${last_entry}    action

    Should Be Equal    ${second_last_action}    ${expected_second_last_action}
    Should Be Equal    ${last_action}           ${expected_last_action}

    ${last_target_user}=    Get From Dictionary    ${last_entry}    targetUser
    Should Be Equal    ${last_target_user}    ${expected_user_id}

Get total cards after user creation WITH REASIGN

# Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable    https://stage.allrideapp.com/api/v1/admin/pb/card/list/?community=67b879e99a2ba09f940ea7c5

# Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

# Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

# Guarda la cantidad actual de tarjetas
    ${totalCards2}=    Get Length    ${response.json()}
    Set Global Variable    ${totalCards2}

# Verifica que la cantidad total de tarjetas después de la reasignación sea igual al total inicial
    Should Be Equal As Numbers    ${totalCards2}    ${totalCards}

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

Bulk Delete Card
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=   DELETE On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/card/bulkDelete?community=653fd601f90509541a748683
    ...    data=[{"cardId":"0882322222"},{"cardId":"8696685245"}]
    ...    json={"correct":[{"active":false,"_id":"681818ae867ed57a99a2ad60","cardId":"0882322222","communityId":"653fd601f90509541a748683","history":[{"_id":"681818ae867ed57a99a2ad61","action":"assign","actionUser":"681818ae867ed57a99a2ad5a","targetUser":"681818ae867ed57a99a2ad5a","createdAt":"2025-05-05T01:47:26.038Z","updatedAt":"2025-05-05T01:47:26.038Z"},{"_id":"6824d8dfaaf7c542d199c6dc","action":"unassign","actionUser":"66d75c62a1b7bc9a1dd231c6","createdAt":"2025-05-14T17:54:39.601Z","updatedAt":"2025-05-14T17:54:39.601Z"},{"_id":"6824d8dfaaf7c542d199c6dd","action":"setToDeactivate","actionUser":"66d75c62a1b7bc9a1dd231c6","reason":"bulkDelete","createdAt":"2025-05-14T17:54:39.601Z","updatedAt":"2025-05-14T17:54:39.601Z"}],"state":"deactivated","createdAt":"2025-05-05T01:47:26.039Z","updatedAt":"2025-05-14T17:54:39.601Z","__v":1},{"active":false,"_id":"68181966d86b61c613e8d9bc","cardId":"8696685245","communityId":"653fd601f90509541a748683","history":[{"_id":"68181966d86b61c613e8d9bd","action":"assign","actionUser":"68181966d86b61c613e8d9b6","targetUser":"68181966d86b61c613e8d9b6","createdAt":"2025-05-05T01:50:30.326Z","updatedAt":"2025-05-05T01:50:30.326Z"},{"_id":"6824d8dfaaf7c542d199c6df","action":"unassign","actionUser":"66d75c62a1b7bc9a1dd231c6","createdAt":"2025-05-14T17:54:39.612Z","updatedAt":"2025-05-14T17:54:39.612Z"},{"_id":"6824d8dfaaf7c542d199c6e0","action":"setToDeactivate","actionUser":"66d75c62a1b7bc9a1dd231c6","reason":"bulkDelete","createdAt":"2025-05-14T17:54:39.612Z","updatedAt":"2025-05-14T17:54:39.612Z"}],"state":"deactivated","createdAt":"2025-05-05T01:50:30.326Z","updatedAt":"2025-05-14T17:54:39.612Z","__v":1}],"withErrors":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

