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


Login User With Email(Obtain Token)
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+comunidad2@allrideapp.com","password":"Lolowerty21@"}
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

Seat Reservation(User1-NicoEnd)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/booking
    ...    data={"serviceId":"6818ed66dee018d6a8ed7fe1","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Can Request TD

    skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","routeId":"6818eceadee018d6a8ed7948","serviceId":"6818ed66dee018d6a8ed7fe1","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Create TD
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/transitDeparture
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","endLocation":{"address":"Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"},"estimatedArrival":"2025-05-12T18:00:00.000Z","isEmergency":false,"matchedOption":{"allowedUsers":{},"direction":"in","_id":"681ce3854093cf7169c2eaa3","margin":{"amount":10,"enabled":true,"unit":"minutes"}},"oddType":"Taxis Nico","startLocation":{"address":"Cesfam Rengo -","isUserStop":false,"lat":"-34.3944","loc":["-34.3944","-70.8504"],"lon":"-70.8504","placeId":"666854f90c80b160cb022b90"}}
    ...    headers=${headers}
    
    ${TD_id}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_id}
Login User With Email(Obtain Token) Barbi
        Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+barbara@allrideapp.com","password":"Lowerty21@"}
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
    ${accessTokenBarbi}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenBarbi}


Seat Reservation(User2-Barbi)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/booking
    ...    data={"serviceId":"6818ed66dee018d6a8ed7fe1","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Can Request TD Barbi
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","routeId":"6818eceadee018d6a8ed7948","serviceId":"6818ed66dee018d6a8ed7fe1","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Create TD Barbi
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/transitDeparture
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","endLocation":{"address":"Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"},"estimatedArrival":"2025-05-12T18:00:00.000Z","isEmergency":false,"matchedOption":{"allowedUsers":{},"direction":"in","_id":"681ce3854093cf7169c2eaa3","margin":{"amount":10,"enabled":true,"unit":"minutes"}},"oddType":"Taxis Nico","startLocation":{"address":"Cesfam Rengo -","isUserStop":false,"lat":"-34.3944","loc":["-34.3944","-70.8504"],"lon":"-70.8504","placeId":"666854f90c80b160cb022b90"}}
    ...    headers=${headers}
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s
Delete TD Nico
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/transitDeparture/${TD_id}
    ...    headers=${headers}
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s

Delete TD Barbi
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/transitDeparture/${TD_idBarbi}
    ...    headers=${headers}
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s

Delete Regular reservation Nico
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/booking/6818ed66dee018d6a8ed7fe1
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s

Delete Regular reservation Barbi
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v1/pb/user/booking/6818ed66dee018d6a8ed7fe1
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s

