*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../../../Variables/variablesStage.robot



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

Time + 2 Hour
    ${date}    Get Current Date    time_zone=UTC    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    2 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Get Next Monday At 14 CLT (UTC 18)
    # Obtener fecha actual en UTC
    ${now}=    Get Current Date    time_zone=UTC

    # Obtener día actual de la semana (0 = domingo, 1 = lunes, ..., 6 = sábado)
    ${weekday}=    Convert Date    ${now}    result_format=%w
    ${weekday}=    Convert To Integer    ${weekday}

    # Calcular días hasta el próximo lunes
    ${days_until_monday}=    Evaluate    (8 - ${weekday}) if ${weekday} != 1 else 7

    # Sumar días para obtener el próximo lunes
    ${next_monday}=    Add Time To Date    ${now}    ${days_until_monday} days
    Set Global Variable    ${next_monday}

    # Obtener solo la fecha y combinarla con hora 18:00:00 UTC (14:00 hora Chile UTC-4)
    ${next_monday_date}=    Convert Date    ${next_monday}    result_format=%Y-%m-%d
    ${next_monday_at_18}=    Set Variable    ${next_monday_date}T18:00:00.000000Z

    Log    Próximo lunes a las 14:00 CLT (UTC 18:00): ${next_monday_at_18}
    Set Global Variable    ${next_monday_at_18}
    Set Global Variable    ${next_monday_date}

Get Next 4 Mondays At 14 CLT (UTC 18)
    # Obtener fecha actual en UTC
    ${now}=    Get Current Date    time_zone=UTC
    ${weekday}=    Convert Date    ${now}    result_format=%w
    ${weekday}=    Convert To Integer    ${weekday}
    ${days_until_monday}=    Evaluate    (8 - ${weekday}) if ${weekday} != 1 else 7
    ${first_monday}=    Add Time To Date    ${now}    ${days_until_monday} days

    # Lunes 1
    ${monday1_date}=    Convert Date    ${first_monday}    result_format=%Y-%m-%d
    ${next_monday_1_at_18}=    Set Variable    ${monday1_date}T18:00:00.000000Z
    Set Global Variable    ${next_monday_1_at_18}    ${next_monday_1_at_18}
    Log    Lunes 1: ${next_monday_1_at_18}

    # Lunes 2
    ${monday2}=    Add Time To Date    ${first_monday}    7 days
    ${monday2_date}=    Convert Date    ${monday2}    result_format=%Y-%m-%d
    ${next_monday_2_at_18}=    Set Variable    ${monday2_date}T18:00:00.000000Z
    Set Global Variable    ${next_monday_2_at_18}    ${next_monday_2_at_18}
    Log    Lunes 2: ${next_monday_2_at_18}

    # Lunes 3
    ${monday3}=    Add Time To Date    ${first_monday}    14 days
    ${monday3_date}=    Convert Date    ${monday3}    result_format=%Y-%m-%d
    ${next_monday_3_at_18}=    Set Variable    ${monday3_date}T18:00:00.000000Z
    Set Global Variable    ${next_monday_3_at_18}    ${next_monday_3_at_18}
    Log    Lunes 3: ${next_monday_3_at_18}

    # Lunes 4
    ${monday4}=    Add Time To Date    ${first_monday}    21 days
    ${monday4_date}=    Convert Date    ${monday4}    result_format=%Y-%m-%d
    ${next_monday_4_at_18}=    Set Variable    ${monday4_date}T18:00:00.000000Z
    Set Global Variable    ${next_monday_4_at_18}    ${next_monday_4_at_18}
    Log    Lunes 4: ${next_monday_4_at_18}


Get Next Wednesday At 14 CLT (UTC 18)
    # Obtener fecha actual en UTC
    ${now}=    Get Current Date    time_zone=UTC

    # Obtener día actual de la semana (0 = domingo, 1 = lunes, ..., 6 = sábado)
    ${weekday}=    Convert Date    ${now}    result_format=%w
    ${weekday}=    Convert To Integer    ${weekday}

    # Calcular días hasta el próximo miércoles (3)
    ${days_until_wednesday}=    Evaluate    (10 - ${weekday}) if ${weekday} != 3 else 7

    # Sumar días para obtener el próximo miércoles
    ${next_wednesday}=    Add Time To Date    ${now}    ${days_until_wednesday} days

    # Obtener solo la fecha y combinarla con hora 18:00:00 UTC (14:00 hora Chile UTC-4)
    ${next_wednesday_date}=    Convert Date    ${next_wednesday}    result_format=%Y-%m-%d
    ${next_wednesday_at_18}=    Set Variable    ${next_wednesday_date}T18:00:00.000000Z

    Log    Próximo miércoles a las 14:00 CLT (UTC 18:00): ${next_wednesday_at_18}
    Set Global Variable    ${next_wednesday_at_18}

Get Next Thursday At 18 CLT (UTC 22)
    # Obtener fecha actual en UTC
    ${now}=    Get Current Date    time_zone=UTC

    # Obtener día actual de la semana (0 = domingo, 1 = lunes, ..., 6 = sábado)
    ${weekday}=    Convert Date    ${now}    result_format=%w
    ${weekday}=    Convert To Integer    ${weekday}

    # Calcular días hasta el próximo jueves (4)
    ${days_until_thursday}=    Evaluate    (11 - ${weekday}) if ${weekday} != 5 else 7

    # Sumar días para obtener el próximo jueves
    ${next_thursday}=    Add Time To Date    ${now}    ${days_until_thursday} days

    # Obtener solo la fecha y combinarla con hora 22:00:00 UTC (18:00 hora Chile UTC-4)
    ${next_thursday_date}=    Convert Date    ${next_thursday}    result_format=%Y-%m-%d
    ${next_thursday_at_22}=    Set Variable    ${next_thursday_date}T22:00:00.000000Z

    Log    Próximo jueves a las 18:00 CLT (UTC 22:00): ${next_thursday_at_22}
    Set Global Variable    ${next_thursday_at_22}

Login User With Email(Obtain Token)
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+limitadanico@allrideapp.com","password":"Lolowerty21@"}
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

Login User With Email(Obtain Token) Limitada 2
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+limitadanico2@allrideapp.com","password":"Lolowerty21@"}
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
    ${accessTokenLimitada2}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenLimitada2}
Login User With Email(Obtain Token) Limitada 3
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+limitadanico3@allrideapp.com","password":"Lolowerty21@"}
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
    ${accessTokenLimitada3}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenLimitada3}


Get Providers (Should be two)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"startLocation":{"placeId":"6852fa6a402dddfa16b72eee","stopId":"6862e536e036e36d0ebc80c3","lat":"-34.40302280653645","lon":"-70.83805069327354","loc":["-70.83805069327354","-34.40302280653645"],"address":"Dirección personalizada Los Césares 905Rengo, Chile","isUserStop":true},"endLocation":{"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","lat":"-34.4111","lon":"-70.8537","loc":["-70.8537","-34.4111"],"address":"Hospital Rengo","isUserStop":false},"direction":"in","oddType":"Limitada Nico"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/providers/6654ae4eba54fe502d4e4187
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    # Length Should Be   ${response.json()}    2 


Create ODD Limited As User(Restricted:userLocation) (Stop exist)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"startLocation":{"placeId":"6852fa6a402dddfa16b72eee","stopId":"6862e536e036e36d0ebc80c3","lat":"-34.40302280653645","lon":"-70.83805069327354","loc":["-70.83805069327354","-34.40302280653645"],"address":"Dirección personalizada Los Césares 905Rengo, Chile","isUserStop":true},"endLocation":{"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","lat":"-34.4111","lon":"-70.8537","loc":["-70.8537","-34.4111"],"address":"Hospital Rengo","isUserStop":false},"direction":"in","oddType":"Limitada Nico","comments":"","serviceDate":"${next_monday_at_18}","name":"Solicitud Limitada Nico"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad2}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=    Set Variable    ${response.json()}

    ${oddId}=   Set Variable     ${json}[_id]
    Set Global Variable    ${oddId}

    # Verifica que el estado del ODD sea "waitingForCreation"
    Should Be Equal As Strings    ${json}[state]    waitingForCreation
    ...    msg=❌ Expected state to be 'waitingForCreation' but got '${json}[state]'

    # Verifica que el tipo de ODD sea "Limitada Nico"
    Should Be Equal As Strings    ${json}[oddType]    Limitada Nico
    ...    msg=❌ Expected oddType to be 'Limitada Nico' but got '${json}[oddType]'

    # Verifica que isLimited en oDDInfo sea True
    Should Be True    ${json}[oDDInfo][isLimited]
    ...    msg=❌ Expected oDDInfo.isLimited to be True but got ${json}[oDDInfo][isLimited]

    # Verifica que isLimitedODD esté en True
    Should Be True    ${json}[isLimitedODD]
    ...    msg=❌ Expected isLimitedODD to be True but got ${json}[isLimitedODD]

    # Verifica que haya una sola reserva

    # Verifica que la reserva no esté validada
    Should Be Equal As Strings    ${json}[reservations][0][validated]    False
    ...    msg=❌ Reservation should not be validated

    # Verifica que joined sea False
    Should Be Equal As Strings    ${json}[reservations][0][joined]    False
    ...    msg=❌ Reservation should not be joined

    # Verifica que approvedByDriver sea True
    Should Be Equal As Strings    ${json}[reservations][0][approvedByDriver]    True
    ...    msg=❌ Reservation should be approved by driver

    # Verifica que stopId exista en la reserva
    Should Contain    ${json}[reservations][0]    stopId
    ...    msg=❌ Reservation is missing stopId

    # Verifica que placeId en endLocation no sea null
    Should Not Be Empty    ${json}[endLocation][placeId]
    ...    msg=❌ placeId in endLocation should not be null

    # Verifica que isLimited en endLocation sea True
    Should Be True    ${json}[endLocation][isLimited]
    ...    msg=❌ endLocation.isLimited should be True but got ${json}[endLocation][isLimited]

    # Verifica que el startLocation tenga referencePoint en True
    Should Be True    ${json}[startLocation][referencePoint]
    ...    msg=❌ startLocation.referencePoint should be True but got ${json}[startLocation][referencePoint]

Create ODD Limited As User(Restricted:userLocation) Limitada 3
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"startLocation":{"placeId":"68f7b5461f3a177dcd4e1051","stopId":"68f7b609c7d1bd92300b61cc","lat":"-34.40818872843232","lon":"-70.86180735379457","loc":["-70.86180735379457","-34.40818872843232"],"address":"Dirección personalizada Los Césares 905Rengo, Chile","isUserStop":true},"endLocation":{"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","lat":"-34.4111","lon":"-70.8537","loc":["-70.8537","-34.4111"],"address":"Hospital Rengo","isUserStop":false},"direction":"in","oddType":"Limitada Nico","comments":"","serviceDate":"${next_monday_at_18}","name":"Solicitud Limitada Nico"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenLimitada3}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad2}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=    Set Variable    ${response.json()}

    ${oddId3}=   Set Variable     ${json}[_id]
    Set Global Variable    ${oddId3}

    # Verifica que el estado del ODD sea "waitingForCreation"
    Should Be Equal As Strings    ${json}[state]    waitingForCreation
    ...    msg=❌ Expected state to be 'waitingForCreation' but got '${json}[state]'

    # Verifica que el tipo de ODD sea "Limitada Nico"
    Should Be Equal As Strings    ${json}[oddType]    Limitada Nico
    ...    msg=❌ Expected oddType to be 'Limitada Nico' but got '${json}[oddType]'

    # Verifica que isLimited en oDDInfo sea True
    Should Be True    ${json}[oDDInfo][isLimited]
    ...    msg=❌ Expected oDDInfo.isLimited to be True but got ${json}[oDDInfo][isLimited]

    # Verifica que isLimitedODD esté en True
    Should Be True    ${json}[isLimitedODD]
    ...    msg=❌ Expected isLimitedODD to be True but got ${json}[isLimitedODD]

    # Verifica que haya una sola reserva

    # Verifica que la reserva no esté validada
    Should Be Equal As Strings    ${json}[reservations][0][validated]    False
    ...    msg=❌ Reservation should not be validated

    # Verifica que joined sea False
    Should Be Equal As Strings    ${json}[reservations][0][joined]    False
    ...    msg=❌ Reservation should not be joined

    # Verifica que approvedByDriver sea True
    Should Be Equal As Strings    ${json}[reservations][0][approvedByDriver]    True
    ...    msg=❌ Reservation should be approved by driver

    # Verifica que stopId exista en la reserva
    Should Contain    ${json}[reservations][0]    stopId
    ...    msg=❌ Reservation is missing stopId

    # Verifica que placeId en endLocation no sea null
    Should Not Be Empty    ${json}[endLocation][placeId]
    ...    msg=❌ placeId in endLocation should not be null

    # Verifica que isLimited en endLocation sea True
    Should Be True    ${json}[endLocation][isLimited]
    ...    msg=❌ endLocation.isLimited should be True but got ${json}[endLocation][isLimited]

    # Verifica que el startLocation tenga referencePoint en True
    Should Be True    ${json}[startLocation][referencePoint]
    ...    msg=❌ startLocation.referencePoint should be True but got ${json}[startLocation][referencePoint]

    Sleep    30s



Create ODD Limited As User(Restricted:userLocation) Limitada 2
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"startLocation":{"placeId":"68f79ceec7d1bd92300affd9","stopId":"68f79e92c7d1bd92300b19ed","lat":"-34.4111338","lon":"-70.8529956","loc":["-70.8529956","-34.4111338"],"address":"Dirección personalizada 331, - Av. El Rodeo 97, 2941118 Rengo, O'Higgins, Chile 331, - Av. El Rodeo 97, 2941118 Rengo, O'Higgins, Chile","isUserStop":true},"endLocation":{"placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b","lat":"-34.4111","lon":"-70.8537","loc":["-70.8537","-34.4111"],"address":"Hospital Rengo","isUserStop":false},"direction":"in","oddType":"Limitada Nico","comments":"","serviceDate":"${next_monday_at_18}","name":"Solicitud Limitada Nico"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenLimitada2}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/${idComunidad2}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=    Set Variable    ${response.json()}

    ${oddId2}=   Set Variable     ${json}[_id]
    Set Global Variable    ${oddId2}

    # Verifica que el estado del ODD sea "waitingForCreation"
    Should Be Equal As Strings    ${json}[state]    waitingForCreation
    ...    msg=❌ Expected state to be 'waitingForCreation' but got '${json}[state]'

    # Verifica que el tipo de ODD sea "Limitada Nico"
    Should Be Equal As Strings    ${json}[oddType]    Limitada Nico
    ...    msg=❌ Expected oddType to be 'Limitada Nico' but got '${json}[oddType]'

    # Verifica que isLimited en oDDInfo sea True
    Should Be True    ${json}[oDDInfo][isLimited]
    ...    msg=❌ Expected oDDInfo.isLimited to be True but got ${json}[oDDInfo][isLimited]

    # Verifica que isLimitedODD esté en True
    Should Be True    ${json}[isLimitedODD]
    ...    msg=❌ Expected isLimitedODD to be True but got ${json}[isLimitedODD]

    # Verifica que haya una sola reserva

    # Verifica que la reserva no esté validada
    Should Be Equal As Strings    ${json}[reservations][0][validated]    False
    ...    msg=❌ Reservation should not be validated

    # Verifica que joined sea False
    Should Be Equal As Strings    ${json}[reservations][0][joined]    False
    ...    msg=❌ Reservation should not be joined

    # Verifica que approvedByDriver sea True
    Should Be Equal As Strings    ${json}[reservations][0][approvedByDriver]    True
    ...    msg=❌ Reservation should be approved by driver

    # Verifica que stopId exista en la reserva
    Should Contain    ${json}[reservations][0]    stopId
    ...    msg=❌ Reservation is missing stopId

    # Verifica que placeId en endLocation no sea null
    Should Not Be Empty    ${json}[endLocation][placeId]
    ...    msg=❌ placeId in endLocation should not be null

    # Verifica que isLimited en endLocation sea True
    Should Be True    ${json}[endLocation][isLimited]
    ...    msg=❌ endLocation.isLimited should be True but got ${json}[endLocation][isLimited]

    # Verifica que el startLocation tenga referencePoint en True
    Should Be True    ${json}[startLocation][referencePoint]
    ...    msg=❌ startLocation.referencePoint should be True but got ${json}[startLocation][referencePoint]

    Sleep    30s



Cancel first reservation
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=      DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/reservation/${oddid}
    ...    headers=${headers}
    Sleep    30s


Cancel first reservation limitada 3
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenLimitada3}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=      DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/reservation/${oddid3}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Cancel last reservation
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenLimitada2}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=      DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/oddepartures/reservation/${oddid2}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)


Check ODD detail



    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)


