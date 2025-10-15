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
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

1 week local
    ${today}=    Get Current Date    time_zone=local
    ${weekday}=    Convert Date    ${today}    result_format=%w
    ${days_until_monday}=    Evaluate    (7 - int(${weekday}) + 1) % 7 or 7

    ${next_monday}=    Add Time To Date    ${today}    ${days_until_monday} days
    ${next_tuesday}=    Add Time To Date    ${next_monday}    1 day

    ${startDate}=    Convert Date    ${next_monday}    result_format=%Y-%m-%dT03:00:00.000Z
    ${endDate}=      Convert Date    ${next_tuesday}   result_format=%Y-%m-%dT02:59:59.999Z

    Log To Console    StartDate: ${startDate}
    Log To Console    EndDate: ${endDate}
    Set Global Variable    ${startDate}
    Set Global Variable    ${endDate}




Login User With Email(Obtain Token)
        Create Session    mysesion    ${STAGE_URL}    verify=true
    ${jsonBody}=    Set Variable    {"username":"nicolas+comunidad2@allrideapp.com","password":"Lolowerty21@"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${loginUserUrl}
    ...    json=${parsed_json}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    List Should Contain Value    ${response.json()}    accessToken            No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenNico}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenNico}

Find serviceId from other week (IN)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/allServices?community=6654ae4eba54fe502d4e4187&startDate=2025-10-13T03:00:00.000Z&endDate=2025-10-14T02:59:59.999Z&onlyODDs=false
    ...    headers=${headers}
    
    ${responseJson}=    Set Variable    ${response.json()}

        # Obtenemos la cantidad de objetos de scheduledServices
    ${num_scheduled_services}=    Get Length    ${responseJson}

    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate
    ...    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '6818eceadee018d6a8ed7948']
    ...    json
    Log    ${sorted_services}


    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    6818eceadee018d6a8ed7948    ${last_service_route}

    Set Global Variable    ${service_id}

    Log    Last created service ID: ${service_id}


    ## 6818eceadee018d6a8ed7948 route dia lunes 2pm es TD Out y 3pm es TD in, parámetroo Color, Rojo azul, Amarillo
    # Probar caso de solicitar una TD con paramtetros y con un usuario que no tenga
    #
Find serviceId from other week (OUT)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/allServices?community=6654ae4eba54fe502d4e4187&startDate=2025-10-13T03:00:00.000Z&endDate=2025-10-14T02:59:59.999Z&onlyODDs=false
    ...    headers=${headers}
    
    ${responseJson}=    Set Variable    ${response.json()}

        # Obtenemos la cantidad de objetos de scheduledServices
    ${num_scheduled_services}=    Get Length    ${responseJson}

    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate
    ...    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '6818eceadee018d6a8ed7948']
    ...    json
    Log    ${sorted_services}


    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    6818eceadee018d6a8ed7948    ${last_service_route}

    Set Global Variable    ${service_id}

    Log    Last created service ID: ${service_id}


    ## 6818eceadee018d6a8ed7948 route dia lunes 2pm es TD Out y 3pm es TD in, parámetroo Color, Rojo azul, Amarillo
    # Probar caso de solicitar una TD con paramtetros y con un usuario que no tenga
    #
Seat Reservation(User1-NicoEnd)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking
    ...    data={"serviceId":"6818ed66dee018d6a8ed7fe1","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}

Can Request TD

    skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","routeId":"6818eceadee018d6a8ed7948","serviceId":"6818ed66dee018d6a8ed7fe1","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}

Create TD
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","endLocation":{"address":"Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"},"estimatedArrival":"2025-05-12T18:00:00.000Z","isEmergency":false,"matchedOption":{"allowedUsers":{},"direction":"in","_id":"681ce3854093cf7169c2eaa3","margin":{"amount":10,"enabled":true,"unit":"minutes"}},"oddType":"Taxis Nico","startLocation":{"address":"Cesfam Rengo -","isUserStop":false,"lat":"-34.3944","loc":["-34.3944","-70.8504"],"lon":"-70.8504","placeId":"666854f90c80b160cb022b90"}}
    ...    headers=${headers}
    
    ${TD_id}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_id}
Login User With Email(Obtain Token) Barbi
        Create Session    mysesion    ${STAGE_URL}    verify=true
    ${jsonBody}=    Set Variable    {"username":"nicolas+barbara@allrideapp.com","password":"Lowerty21@"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${loginUserUrl}
    ...    json=${parsed_json}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    List Should Contain Value    ${response.json()}    accessToken            No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenBarbi}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenBarbi}


Seat Reservation(User2-Barbi)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking
    ...    data={"serviceId":"6818ed66dee018d6a8ed7fe1","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}

Can Request TD Barbi
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","routeId":"6818eceadee018d6a8ed7948","serviceId":"6818ed66dee018d6a8ed7fe1","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}

Create TD Barbi
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","endLocation":{"address":"Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"},"estimatedArrival":"2025-05-12T18:00:00.000Z","isEmergency":false,"matchedOption":{"allowedUsers":{},"direction":"in","_id":"681ce3854093cf7169c2eaa3","margin":{"amount":10,"enabled":true,"unit":"minutes"}},"oddType":"Taxis Nico","startLocation":{"address":"Cesfam Rengo -","isUserStop":false,"lat":"-34.3944","loc":["-34.3944","-70.8504"],"lon":"-70.8504","placeId":"666854f90c80b160cb022b90"}}
    ...    headers=${headers}
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s
Delete TD Nico
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture/${TD_id}
    ...    headers=${headers}
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s

Delete TD Barbi
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture/${TD_idBarbi}
    ...    headers=${headers}
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s

Delete Regular reservation Nico
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking/6818ed66dee018d6a8ed7fe1
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s

Delete Regular reservation Barbi
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking/6818ed66dee018d6a8ed7fe1
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s

