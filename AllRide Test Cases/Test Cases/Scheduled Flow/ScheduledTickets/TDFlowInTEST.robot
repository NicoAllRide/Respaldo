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

    ${nextMondayDate}=    Convert Date    ${next_monday}    result_format=%Y-%m-%d
    Set Global Variable    ${nextMondayDate}

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

    Sleep    10s

Login User With Email(Obtain Token) Carpool (No precondition to request TD)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${jsonBody}=    Set Variable    {"username":"nicolas+carpool4@allrideapp.com","password":"Lolowerty21@"}
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
    List Should Contain Value    ${response.json()}    accessToken    No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenCarpool4}=    Evaluate    "${accessToken}"
    Set Global Variable    ${accessTokenCarpool4}
    ${realTimeTokenUser}=    Set Variable    ${response.json()}[realTimeToken]
    Set Global Variable    ${realTimeTokenUser}

    Sleep    2s
Find Services For Next Week (IN and OUT)
    [Documentation]     Finds the IN and OUT services for the next Monday using dynamic local dates and a specific route

    # ✅ Calcular fechas dinámicas (lunes a martes)
    ${today}=    Get Current Date    time_zone=local
    ${weekday}=    Convert Date    ${today}    result_format=%w
    ${days_until_monday}=    Evaluate    (7 - int(${weekday}) + 1) % 7 or 7

    ${next_monday}=    Add Time To Date    ${today}    ${days_until_monday} days
    ${next_tuesday}=    Add Time To Date    ${next_monday}    1 day

    ${start_date}=    Convert Date    ${next_monday}    result_format=%Y-%m-%dT03:00:00.000Z
    ${end_date}=      Convert Date    ${next_tuesday}   result_format=%Y-%m-%dT02:59:59.999Z

    Log To Console    ✅ StartDate: ${start_date}
    Log To Console    ✅ EndDate: ${end_date}

    # ✅ Llamada al endpoint con rango del lunes
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/icTable/services?community=6654ae4eba54fe502d4e4187&startDate=${start_date}&endDate=${end_date}
    ...    headers=${headers}

    ${responseJson}=    Set Variable    ${response.json()}

    Should Not Be Empty    ${responseJson}
    ...    msg=❌ No se encontraron servicios para la próxima semana

    # ✅ Filtrar solo los servicios de la ruta específica
    ${filtered_services}=    Evaluate
    ...    [s for s in ${responseJson} if s.get('routeId', {}).get('_id') == '68f6306b7fbaae7e76286a88']
    ...    json
    Should Not Be Empty    ${filtered_services}
    ...    msg=❌ No hay servicios para la ruta 68f6306b7fbaae7e76286a88

    # ✅ Buscar OUT (17:00Z / 14:00 hora CL)
    ${service_out}=    Evaluate
    ...    next((s for s in ${filtered_services} if 'T17:00:00' in s['serviceDate']), None)
    ...    json
    Should Not Be Empty    ${service_out}
    ...    msg=❌ No se encontró el servicio OUT (17:00Z)

    # ✅ Buscar IN (18:00Z / 15:00 hora CL)
    ${service_in}=    Evaluate
    ...    next((s for s in ${filtered_services} if 'T18:00:00' in s['serviceDate']), None)
    ...    json
    Should Not Be Empty    ${service_in}
    ...    msg=❌ No se encontró el servicio IN (18:00Z)

    # ✅ Guardar IDs globalmente
    ${SERVICE_OUT_ID}=    Set Variable    ${service_out['_id']}
    ${SERVICE_IN_ID}=     Set Variable    ${service_in['_id']}

    Set Global Variable    ${SERVICE_OUT_ID}
    Set Global Variable    ${SERVICE_IN_ID}

    Log To Console    ✅ OUT (14:00 CL): ${SERVICE_OUT_ID}
    Log To Console    ✅ IN (15:00 CL): ${SERVICE_IN_ID}
    ## 68f6306b7fbaae7e76286a88 route dia lunes 2pm es TD Out y 3pm es TD in, parámetroo Color, Rojo azul, Amarillo
    # Probar caso de solicitar una TD con paramtetros y con un usuario que no tenga
    #
Seat Reservation(User1-NicoEnd) IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking
    ...    data={"serviceId":"${SERVICE_IN_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
 
    ${reservationIdNico}=  Set Variable  ${response.json()}[0][_id]
    Set Global Variable    ${reservationIdNico}

Can Request TD IN

    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","routeId":"68f6306b7fbaae7e76286a88","serviceId":"${SERVICE_IN_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    
    ${userIsAllowed}=    Set Variable    ${response.json()}[userIsAllowed]
    Should Be True    ${userIsAllowed}        msg= User should be allowed to request TD but is not, TD Failing

Create TD IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","endLocation":{"address":"Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"},"estimatedArrival":"${nextMondayDate}T18:00:00.000Z","isEmergency":false,"matchedOption":{"allowedUsers":{},"direction":"in","_id":"681ce3854093cf7169c2eaa3","margin":{"amount":10,"enabled":true,"unit":"minutes"}},"oddType":"Taxis Nico","startLocation":{"address":"Cesfam Rengo -","isUserStop":false,"lat":"-34.3944","loc":["-34.3944","-70.8504"],"lon":"-70.8504","placeId":"666854f90c80b160cb022b90"}}
    ...    headers=${headers}
    
    ${TD_id}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_id}

Seat Reservation(User2-Barbi) IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking
    ...    data={"serviceId":"${SERVICE_IN_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    ${reservationIdBarbi}=      Set Variable    ${response.json()}[0][_id]
    Set Global Variable    ${reservationIdBarbi}

Can Request TD Barbi IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","routeId":"68f6306b7fbaae7e76286a88","serviceId":"${SERVICE_IN_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    ${userIsAllowed}=    Set Variable    ${response.json()}[userIsAllowed]
    Should Be True    ${userIsAllowed}        msg= User should be allowed to request TD but is not, TD Failing
Create TD Barbi IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","endLocation":{"address":"Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"},"estimatedArrival":"${nextMondayDate}T18:00:00.000Z","isEmergency":false,"matchedOption":{"allowedUsers":{},"direction":"in","_id":"681ce3854093cf7169c2eaa3","margin":{"amount":10,"enabled":true,"unit":"minutes"}},"oddType":"Taxis Nico","startLocation":{"address":"Cesfam Rengo -","isUserStop":false,"lat":"-34.3944","loc":["-34.3944","-70.8504"],"lon":"-70.8504","placeId":"666854f90c80b160cb022b90"}}
    ...    headers=${headers}
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s

## SOlicitar TD con otro usuario que no cumpla con los requisitos para TD


Seat Reservation(User3-Carpool No precondition) IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool4}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking
    ...    data={"serviceId":"${SERVICE_IN_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    ${reservationIdCarpoolUser}=      Set Variable    ${response.json()}[0][_id]
    Set Global Variable    ${reservationIdCarpoolUser}

Can Request TD Carpool user (Should not be able to request TD) IN
    Create Session    mysesion    ${STAGE_URL}    verify=true 
    ${headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool4}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"in","routeId":"68f6306b7fbaae7e76286a88","serviceId":"${SERVICE_IN_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}

    ${userIsAllowed}=    Set Variable    ${response.json()}[userIsAllowed]
    Should Not Be True    ${userIsAllowed}        msg= User should not be allowed to request TD but it is, TD failing
##Soolicitar TD con otro usuario que no tenga el parámetro de poder solicitar TD activo

Delete TD Nico IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture/${TD_id}
    ...    headers=${headers}
    

    Sleep    20s

Delete TD Barbi IN

    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture/${TD_idBarbi}
    ...    headers=${headers}


    Sleep    20s


Delete Regular reservation Nico IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking/${reservationIdNico}
    ...    headers=${headers}

    

Delete Regular reservation Barbi IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking/${reservationIdBarbi}
    ...    headers=${headers}
    
Delete Regular reservation Carpool User IN
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool4}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking/${reservationIdBarbi}
    ...    headers=${headers}
    

#-----------------------------------------------OUT-----------------------------------------------------------#


Seat Reservation(User1-NicoEnd) OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking
    ...    data={"serviceId":"${SERVICE_OUT_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
 
    ${reservationIdNico}=  Set Variable  ${response.json()}[0][_id]
    Set Global Variable    ${reservationIdNico}

    Sleep    10s

Can Request TD OUT

    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"out","routeId":"68f6306b7fbaae7e76286a88","serviceId":"${SERVICE_OUT_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    
    ${userIsAllowed}=    Set Variable    ${response.json()}[userIsAllowed]
    Should Be True    ${userIsAllowed}        msg= User should be allowed to request TD but is not, TD Failing

Create TD OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"out","endLocation":{"address":"Cesfam Rengo -","isUserStop":false,"lat":"-34.3944","loc":["-34.3944","-70.8504"],"lon":"-70.8504","placeId":"666854f90c80b160cb022b90"},"estimatedArrival":"${nextMondayDate}T17:00:00.000Z","isEmergency":false,"matchedOption":{"allowedUsers":{},"direction":"out","_id":"681ce3854093cf7169c2eaa3","margin":{"amount":10,"enabled":true,"unit":"minutes"}},"oddType":"Taxis Nico","startLocation":{"address":"Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"}}
    ...    headers=${headers}
    
    ${TD_id}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_id}


Seat Reservation(User2-Barbi) OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking
    ...    data={"serviceId":"${SERVICE_OUT_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    ${reservationIdBarbi}=      Set Variable    ${response.json()}[0][_id]
    Set Global Variable    ${reservationIdBarbi}

Can Request TD Barbi OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"out","routeId":"68f6306b7fbaae7e76286a88","serviceId":"${SERVICE_OUT_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    ${userIsAllowed}=    Set Variable    ${response.json()}[userIsAllowed]
    Should Be True    ${userIsAllowed}        msg= User should be allowed to request TD but is not, TD Failing
Create TD Barbi OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"out","endLocation":{"address":"Cesfam Rengo -","isUserStop":false,"lat":"-34.3944","loc":["-34.3944","-70.8504"],"lon":"-70.8504","placeId":"666854f90c80b160cb022b90"},"estimatedArrival":"${nextMondayDate}T17:00:00.000Z","isEmergency":false,"matchedOption":{"allowedUsers":{},"direction":"out","_id":"681ce3854093cf7169c2eaa3","margin":{"amount":10,"enabled":true,"unit":"minutes"}},"oddType":"Taxis Nico","startLocation":{"address":"Hospital Rengo","isUserStop":false,"lat":"-34.4111","loc":["-34.4111","-70.8537"],"lon":"-70.8537","placeId":"6654d4acba54fe502d4e6b6a","stopId":"6654d4acba54fe502d4e6b6b"}}
    ...    headers=${headers}
    
    ${TD_idBarbi}=  Set variable    ${response.json()}[_id]
    Set Global Variable    ${TD_idBarbi}
    Should Be Equal As Strings    ${TD_id}    ${TD_idBarbi}    Not joining



    Sleep    20s


Seat Reservation(User3-Carpool No precondition) OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool4}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking
    ...    data={"serviceId":"${SERVICE_OUT_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}
    ${reservationIdCarpoolUser}=      Set Variable    ${response.json()}[0][_id]
    Set Global Variable    ${reservationIdCarpoolUser}

Can Request TD Carpool user (Should not be able to request TD) OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true 
    ${headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool4}    Content-Type=application/json
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/canRequestTD
    ...    data={"communityId":"6654ae4eba54fe502d4e4187","direction":"out","routeId":"68f6306b7fbaae7e76286a88","serviceId":"${SERVICE_OUT_ID}","stopId":"6654d4acba54fe502d4e6b6b"}
    ...    headers=${headers}

    ${userIsAllowed}=    Set Variable    ${response.json()}[userIsAllowed]
    Should Not Be True    ${userIsAllowed}        msg= User should not be allowed to request TD but it is, TD failing
##Soolicitar TD con otro usuario que no tenga el parámetro de poder solicitar TD activo

Delete TD Nico OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture/${TD_id}
    ...    headers=${headers}
    

    Sleep    20s

Delete TD Barbi OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/transitDeparture/${TD_idBarbi}
    ...    headers=${headers}


    Sleep    20s


Delete Regular reservation Nico OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking/${reservationIdNico}
    ...    headers=${headers}

    

Delete Regular reservation Barbi OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenBarbi}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking/${reservationIdBarbi}
    ...    headers=${headers}
    
Delete Regular reservation Carpool User OUT
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool4}    Content-Type=application/json
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/pb/user/booking/${reservationIdBarbi}
    ...    headers=${headers}
    