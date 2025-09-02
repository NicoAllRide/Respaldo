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

Generate random UUID (DepartureId)
    ${uuid}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid}
    Set Global Variable    ${uuid}
Generate random UUID (DepartureId) 2
    ${uuid2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid2}
    Set Global Variable    ${uuid2}

Generate random UUID (_id Manual validations)
    ${uuid_manual}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_manual}
    Set Global Variable    ${uuid_manual}

Generate random UUID (_id validations customValidations)
    ${uuid_custom}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_custom}
    Set Global Variable    ${uuid_custom}

Generate random UUID (_id validations qrValidations)
    ${uuid_qr}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr}
    Set Global Variable    ${uuid_qr}
Generate random UUID2 (_id validations qrValidations)
    ${uuid_qr2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr2}
    Set Global Variable    ${uuid_qr2}
Generate random UUID2 Cédula (_id validations qrValidations)
    ${uuid_dni}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_dni}
    Set Global Variable    ${uuid_dni}
Generate random UUID (_id events1)
    ${uuid_events}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_events}
    Set Global Variable    ${uuid_events}
Generate random UUID (_id events2)
    ${uuid_events2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_events2}
    Set Global Variable    ${uuid_events2}

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
    List Should Contain Value    ${response.json()}    accessToken            No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenNico}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenNico}



Get Places
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/places/list?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}

Create RDD As User
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"oddType":"Taxis Coni y Nico","name":"Solicitud y comprobación RDD Abierto RF","direction":"in","comments":"Conducir con precaución","serviceDate":"${formatted_one_hour_later}","startLocation":{"placeId":"655d11d88a5a1a1ff0328466","lat":"-33.3908833","lon":"-70.54620129999999","loc":["-70.54620129999999","-33.3908833"],"address":"Alto Las Condes Avenida Presidente Kennedy Lateral, Las Condes, Chile"},"endLocation":{"lat":"-33.409873","lon":"-70.5673477","loc":["-70.5673477","-33.409873"],"address":"Mall Apumanque Avenida Manquehue Sur, Las Condes, Chile","placeId":"655d11f68a5a1a1ff03284b1"}}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}   Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${Stage_URL}/api/v1/pb/user/oddepartures/${idComunidad}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${rddId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${rddId}


Assign Driver
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/assignDriver/${rddId}?community=${idComunidad}
    ...    data={"driver":{"driverId":"${driverId}","driverCode":"${driverCode}"},"drivers":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
Assign Vehicle
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/assignVehicle/${rddId}?community=${idComunidad}
    ...    data={"vehicleId":"${vehicleId}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

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




Sync Departure active false
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v2/pb/driver/departures/sync/${idSuperCommunity}
    ...    data={"departures":[{"active":false,"boardings":1,"busCode":"0602","canResume":false,"capacity":40,"communities":["653fd601f90509541a748683"],"communityId":"653fd601f90509541a748683","createdAt":"2024-10-08T15:47:32.216-04:00","customParams":[{"name":"Km_de_partida","value":1}],"customParamsAtTheEnd":[{"name":"Km_de_salida","value":2}],"direction":"","driverCode":"1712","driverId":"658b4c89f6f903bbee966467","drivers":[],"enabledSeats":[{"available":false,"_id":"667f244c738bca04e08a02e6","seat":"1","userId":"65e092afca7842b1032f12e2"},{"available":false,"_id":"667f244c738bca04e08a02e7","seat":"2","userId":"654a5148bf3e9410d0bcd39a"},{"available":false,"_id":"667f244c738bca04e08a02e8","seat":"3","userId":"663ccf399a0c214e3398f5cd"},{"available":false,"_id":"667f244c738bca04e08a02e9","seat":"4","userId":"661d508c72418a2e98cf7978"},{"available":true,"_id":"667f244c738bca04e08a02ea","seat":"5"},{"available":true,"_id":"667f244c738bca04e08a02eb","seat":"6"},{"available":true,"_id":"667f244c738bca04e08a02ec","seat":"7"},{"available":true,"_id":"667f244c738bca04e08a02ed","seat":"8"},{"available":true,"_id":"667f244c738bca04e08a02ee","seat":"9"},{"available":true,"_id":"667f244c738bca04e08a02ef","seat":"10"},{"available":true,"_id":"667f244c738bca04e08a02f0","seat":"11"},{"available":true,"_id":"667f244c738bca04e08a02f1","seat":"12"},{"available":true,"_id":"667f244c738bca04e08a02f2","seat":"13"},{"available":true,"_id":"667f244c738bca04e08a02f3","seat":"14"},{"available":true,"_id":"667f244c738bca04e08a02f4","seat":"15"},{"available":true,"_id":"667f244c738bca04e08a02f5","seat":"16"},{"available":true,"_id":"667f244c738bca04e08a02f6","seat":"17"},{"available":true,"_id":"667f244c738bca04e08a02f7","seat":"18"},{"available":true,"_id":"667f244c738bca04e08a02f8","seat":"19"},{"available":true,"_id":"667f244c738bca04e08a02f9","seat":"20"},{"available":true,"_id":"667f244c738bca04e08a02fa","seat":"21"},{"available":true,"_id":"667f244c738bca04e08a02fb","seat":"22"},{"available":true,"_id":"667f244c738bca04e08a02fc","seat":"23"},{"available":true,"_id":"667f244c738bca04e08a02fd","seat":"24"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"25"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"26"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"27"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"28"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"29"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"30"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"31"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"32"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"33"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"34"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"35"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"36"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"37"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"38"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"39"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"40"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"41"},{"available":false,"_id":"667f244c738bca04e08a02fe","seat":"42"}],"estimatedDistance":0,"_id":"${rddId}","internal":false,"legs":[{"startLocation":{"lat":-34.394115,"lon":-70.78126},"endLocation":{"lat":-34.395,"lon":-70.782},"type":"pre","customParamsAtStart":{"name":"km_de_inicio_pre","value":1},"customParamsAtTheEnd":[{"name":"km_de_salida_pre","value":1}],"preTripChecklist":[{"name":"Cosas_para_comer_manzana","value":true},{"name":"Cosas_para_comer_naranja","value":false},{"name":"Cosas_para_comer_pera","value":true}]},{"startLocation":{"lat":-34.394115,"lon":-70.78126},"endLocation":{"lat":-34.395,"lon":-70.782},"type":"service","customParamsAtStart":[],"customParamsAtTheEnd":[]},{"startLocation":{"lat":-34.394115,"lon":-70.78126},"endLocation":{"lat":-34.395,"lon":-70.782},"type":"post","customParamsAtStart":[{"name":"como_lo_pasaste","value":"bien"}],"customParamsAtTheEnd":[]}],"name":"","odd":true,"oddType":"","offlineSync":{"historical":[],"internalId":"${rddId}","synced":false},"passengersLinked":[],"passengersToLink":[],"preTripChecklist":[],"previouslyActive":false,"realStartLocation":{"_id":"","internalId":"c60b8cb6-c269-49e1-a6bf-4d1d10598bADb","lat":-34.394115,"lon":-70.78126},"reason":"","reservations":[],"rounds":2,"routeId":"","scheduled":false,"startCapacity":42,"startLocation":{"_id":"","internalId":"448aac16-9362-4385-9b6f-110b174c7b60","lat":-34.394115,"lon":-70.78126},"startedAt":"2024-06-28T15:47:32.216-04:00","state":"","superCommunityId":"653fd68233d83952fafcd4be","tickets":0,"token":"","unboardings":1,"validations":[],"vehicleId":"65b13780fd1711a264653aa1"}],"validations":[{"assignedSeat":"3","communityId":"653fd601f90509541a748683","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${rddId}","_id":"${uuid_qr}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNico}","reason":[],"remainingTickets":0,"routeId":"","synced":false,"token":"","userId":"${idNico}","validated":true}],"events":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Get Stadistics
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/departure/end/statistics/${rddId}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenDriver}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200
    Log    ${response.content}

Get departure Details
    skip
 # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/pb/driver/departure/end/statistics/${rddId}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenDriver}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

   ${json}=    Set Variable    ${response.json()}
    ${shapeId}=    Set Variable    ${json}[_id]
    Set Global Variable    ${shapeId}

    ${expected_community}=    Set Variable    653fd601f90509541a748683
    ${expected_supercommunity}=    Set Variable    653fd68233d83952fafcd4be
    ${expected_name}=    Set Variable    Solicitud de Taxis Coni y Nico
    ${expected_odd_type}=    Set Variable    Taxis Coni y Nico
    ${expected_direction}=    Set Variable    in
    ${expected_state}=    Set Variable    pending
    ${expected_capacity}=    Set Variable    4
    ${expected_start_capacity}=    Set Variable    5
    ${expected_comment}=    Set Variable    Conducir con precaución

    # Validaciones de strings simples
    Should Be Equal As Strings    ${json}[name]             ${expected_name}          msg=❌ Nombre incorrecto. Encontrado: "${json}[name]"
    Should Be Equal As Strings    ${json}[oddType]          ${expected_odd_type}      msg=❌ oddType incorrecto. Encontrado: "${json}[oddType]"
    Should Be Equal As Strings    ${json}[direction]        ${expected_direction}     msg=❌ Dirección incorrecta. Encontrado: "${json}[direction]"
    Should Be Equal As Strings    ${json}[state]            ${expected_state}         msg=❌ Estado incorrecto. Encontrado: "${json}[state]"
    Should Be Equal As Strings    ${json}[comments]         ${expected_comment}       msg=❌ Comentario incorrecto. Encontrado: "${json}[comments]"

    # Validaciones de IDs de comunidad
    Should Be Equal As Strings    ${json}[communityId]      ${expected_community}     msg=❌ communityId incorrecto. Encontrado: "${json}[communityId]"
    Should Be Equal As Strings    ${json}[superCommunityId] ${expected_supercommunity} msg=❌ superCommunityId incorrecto. Encontrado: "${json}[superCommunityId]"

    # Validaciones de arrays
    Should Contain    ${json}[communities][0][_id]         ${expected_community}     msg=❌ Falta ID de comunidad en communities
    Should Contain    ${json}[superCommunities][0][_id]    ${expected_supercommunity} msg=❌ Falta ID de supercomunidad en superCommunities

    # Validaciones numéricas
    Should Be Equal As Integers    ${json}[capacity]        ${expected_capacity}      msg=❌ Capacidad incorrecta. Encontrado: "${json}[capacity]"
    Should Be Equal As Integers    ${json}[startCapacity]   ${expected_start_capacity} msg=❌ startCapacity incorrecto. Encontrado: "${json}[startCapacity]"