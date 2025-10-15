*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Library     WebSocketClient
Resource    ../../../Variables/variablesStage.robot

*** Variables ***
${TOKEN}            d39b2cd278ccdb8e15bd587d386935b2e727876e2ec225044de7ef7858d6f9a0e26378c14a48bd8a997f129ff7bf73843dce49bbcec490c478ae5dcf948e81b8
${URL}              ws://stage.allrideapp.com/socket.io/?token=${TOKEN}&EIO=3&transport=websocket
${LATITUDE}         -33.40783132925352
${LONGITUDE}        -70.56331367840907
${NEW_LATITUDE}     -34.40274888966042
${NEW_LONGITUDE}    -70.85938591407319
${IS_FULL}          false
${IS_PANICKING}     false
${CAPACITY}         4
${SPEED}            50.5
${STAGE_URL}            https://stage.allrideapp.com
${tokenUsuario}        jfsjkdslajksdasdajklassjaklsakls



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
    ${two_hours_later}    Add Time To Date    ${date}    2 hour
    ${formatted_two_hours_later}    Convert Date    ${two_hours_later}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual + 1 hora: ${formatted_two_hours_later}
    Set Global Variable    ${formatted_two_hours_later}
Time + 2,5 Hour
    [Tags]    prueba
    ${date}    Get Current Date    time_zone=UTC    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual: ${formatted_date}
    ${two_hours_later}    Add Time To Date    ${date}    125 minutes
    ${formatted_two_5_hours_later}    Convert Date    ${two_hours_later}    result_format=%Y-%m-%dT%H:%M:%S.%fZ
    Log    Hora Actual + 1 hora: ${formatted_two_5_hours_later}
    Set Global Variable    ${formatted_two_5_hours_later}

Login User With Email(Obtain Token)
    [Tags]    prueba1-2
        Create Session    mysesion    ${STAGE_URL}    verify=true
    ${jsonBody}=    Set Variable    {"username":"nicolas+endauto@allrideapp.com","password":"Equilibriozen123#"}
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


#-------------------VERIFICAR CASCADEO-------------------------#
Create RDD As User
    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${jsonBody}=    Set Variable    {"oddType":"Taxis Coni y Nico","name":"Cascadeo RDD","direction":"in","comments":"Pruebas de asignación automática de provider","serviceDate":"${formatted_two_hours_later}","startLocation":{"placeId":"655d11d88a5a1a1ff0328466","lat":"-33.3908833","lon":"-70.54620129999999","loc":["-70.54620129999999","-33.3908833"],"address":"Alto Las Condes Avenida Presidente Kennedy Lateral, Las Condes, Chile"},"endLocation":{"lat":"-33.409873","lon":"-70.5673477","loc":["-70.5673477","-33.409873"],"address":"Mall Apumanque Avenida Manquehue Sur, Las Condes, Chile","placeId":"655d11f68a5a1a1ff03284b1"}}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}   Content-Type=application/json
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${Stage_URL}/api/v1/pb/user/oddepartures/${idComunidad}
    ...    json=${parsed_json}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    
    ${rddId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${rddId}

Get ODD Details At First

    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}   Content-Type=application/json
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/${rddId}?community=${idComunidad}&populate=true
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    # Obtener el id de la superComunidad == 653fd68233d83952fafcd4be
    # Guardar en variable
    # Guardar en variable Global
    # Verificar mediante should be equal as string que sea igual a 653fd68233d83952fafcd4be    
        #Dejar msg de error en caso de que no se encuentre el proveedor esperado
Get ODD Details After 30 seconds(Should move to next Provider)

    Create Session    mysesion    ${STAGE_URL}    verify=true
    ${headers}=    Create Dictionary    Authorization=${accessTokenNico}   Content-Type=application/json
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/odd/${rddId}?community=${idComunidad}&populate=true
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    # Obtener el id de la superComunidad == 68542c2a3a0d319ed31a72a6
    # Guardar en variable
    # Guardar en variable Global
    # Verificar mediante should be equal as string que sea igual a 68542c2a3a0d319ed31a72a6   
    #Dejar msg de error en caso de que no se encuentre el proveedor esperado