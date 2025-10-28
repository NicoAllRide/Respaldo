*** Settings ***
Documentation       E2E AllRide EXT API (stage) — todas las requests inline sin uso de *** Keywords ***

Library             RequestsLibrary
Library             OperatingSystem
Library             Collections
Library             String
Library             DateTime
Library             SeleniumLibrary
Library             RPA.JSON
Resource            ../Variables/variablesStage.robot

Suite Setup         Create Session    mysesion    ${STAGE_URL}    verify=true
Suite Teardown      Delete All Sessions


*** Variables ***
${VEH_PLATE}            XXYYZZ

${START_OFFSET_MIN}     10
${END_OFFSET_MIN}       70




*** Test Cases ***
Generate random UUIDs
    ${uuid_qr}=    Evaluate    str(__import__('uuid').uuid4())
    ${uuid_qr2}=    Evaluate    str(__import__('uuid').uuid4())
    ${uuid_qr3}=    Evaluate    str(__import__('uuid').uuid4())
    Log    ${uuid_qr}
    Log    ${uuid_qr2}
    Log    ${uuid_qr3}


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
    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}

Create Route
    ${ROUTE_EXT_ID}=    Evaluate    f"ROUTE-XYZ-{__import__('random').randint(10000, 99999)}"
    ${SERVICE_EXT_ID}=    Evaluate    f"SERVICE-XYZ-{__import__('random').randint(10000, 99999)}"
    ${DRIVER_EXT_ID}=    Evaluate    f"DRIVER-XYZ-{__import__('random').randint(10000, 99999)}"
    ${VEHICLE_EXT_ID}=    Evaluate    f"VEH-XYZ-{__import__('random').randint(10000, 99999)}"

    ${driverName}=    Evaluate    f"Juan Pérez {__import__('random').randint(1, 999)}"
    ${driverCode}=    Evaluate    f"JP{__import__('random').randint(1000, 9999)}"
    ${driverMail}=    Evaluate    f"{'juan.perez'}{__import__('random').randint(1, 999)}@gmail.com"
    ${driverPhone}=    Evaluate    f"+5691234{__import__('random').randint(1000, 9999)}"

    Set Global Variable    ${driverName}
    Set Global Variable    ${driverCode}
    Set Global Variable    ${driverMail}
    Set Global Variable    ${driverPhone}

    Set Global Variable    ${ROUTE_EXT_ID}
    Set Global Variable    ${DRIVER_EXT_ID}
    Set Global Variable    ${VEHICLE_EXT_ID}
    Set Global Variable    ${SERVICE_EXT_ID}

    ${stops}=    Set Variable
    ...    [{"name":"Oficina Central","latitude":-33.456,"longitude":-70.678,"order":0},{"name":"Parada Intermedia 1","latitude":-33.460,"longitude":-70.685,"order":1},{"name":"Planta Norte","latitude":-33.470,"longitude":-70.695,"order":2}]
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable
    ...    {"externalRouteId":"${ROUTE_EXT_ID}","externalClientId":"3335","name":"Ruta E2E RF 2","description":"Ruta de ida y vuelta","stops":${stops},"distance":15.5}
    ${response}=    POST On Session    mysesion    url=/ext/api/v2/routes    data=${payload}    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje de éxito
    Should Be Equal As Strings    ${json}[message]    Route created successfully
    ...    msg=❌ Route creation message mismatch. Got: "${json}[message]"

    # ✅ Nombre de la ruta
    Should Be Equal As Strings    ${json}[route][name]    Ruta E2E RF 2
    ...    msg=❌ Route name is incorrect. Expected 'Ruta E2E RF 2' but got "${json}[route][name]"

    # ✅ Distancia en metros mayor a 0
    ${distance}=    Set Variable    ${json}[route][distanceInMeters]
    Should Be True    ${distance} > 0
    ...    msg=❌ Distance in meters should be greater than 0 but got ${distance}

    # ✅ Community ID correcto
    Should Be Equal As Strings    ${json}[route][communityId]    5b8576db00a0355421d76393
    ...    msg=❌ CommunityId mismatch. Expected '5b8576db00a0355421d76393' but got "${json}[route][communityId]"

    # ✅ ShapeId presente
    Should Not Be Empty    ${json}[route][shapeId]
    ...    msg=❌ ShapeId is missing

    # ✅ Estado activo
    Should Be Equal As Strings    ${json}[route][active]    True
    ...    msg=❌ Route should be active but got "${json}[route][active]"

Get Last Route From Admin
    Set Log Level    TRACE
    Create Session    mysession    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session    mysession
    ...    url=/api/v1/admin/pb/routes/list?community=5b8576db00a0355421d76393
    ...    headers=${headers}

    # Guardamos el JSON completo
    ${routes}=    Set Variable    ${response.json()}

    # Validamos que existan rutas
    ${num_routes}=    Get Length    ${routes}
    Should not be empty  ${num_routes}  msg=No routes found

    # Ordenamos por createdAt
    ${sorted_routes}=    Evaluate    sorted(${routes}, key=lambda x: x['createdAt'])    json

    # Tomamos la última ruta
    ${last_route}=    Set Variable    ${sorted_routes[-1]}
    ${route_id}=    Set Variable    ${last_route['_id']}
    ${route_name}=    Set Variable    ${last_route['name']}

    Log    Última ruta creada: ${route_name} (ID: ${route_id})
    Set Global Variable    ${route_id}

        # ✅ Nombre de la ruta
    Should Be Equal As Strings    ${last_route}[name]    Ruta E2E RF 2
    ...    msg=❌ Route name is incorrect. Expected 'Ruta E2E RF 2' but got "${last_route}[name]"


    Should Not Be Empty
    ...    ${lastRoute}[externalInfo]
    ...    msg= External info should not be empty in lastRoute details(should contain uuid)
    Should Be Equal As Strings    ${last_route}[externalInfo][uuid]    ${ROUTE_EXT_ID}    

Read Route
    ${url}=    Set Variable    ${STAGE_URL}/ext/api/v2/routes/${ROUTE_EXT_ID}?externalClientId=3335
    &{headers}=    Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje de éxito
    Should Be Equal As Strings    ${json}[message]    Route get successfully
    ...    msg=❌ Route GET message mismatch. Got: "${json}[message]"

    # ✅ ExternalRouteId correcto con prefijo
    ${extRouteId}=    Set Variable    ${json}[data][externalRouteId]
    Should Start With    ${extRouteId}    ROUTE-XYZ-
    ...    msg=❌ ExternalRouteId must start with ROUTE-XYZ- but got "${extRouteId}"

    # ✅ ExternalClientId esperado
    Should Be Equal As Strings    ${json}[data][externalClientId]    3335
    ...    msg=❌ ExternalClientId mismatch. Expected '3335' but got "${json}[data][externalClientId]"

    # ✅ Nombre de la ruta
    Should Be Equal As Strings    ${json}[data][name]    Ruta E2E RF 2
    ...    msg=❌ Route name mismatch. Expected 'Ruta E2E RF 2' but got "${json}[data][name]"

    # ✅ Descripción de la ruta
    Should Be Equal As Strings    ${json}[data][description]    Ruta de ida y vuelta
    ...    msg=❌ Route description mismatch. Got: "${json}[data][description]"

    # ✅ Distancia mayor a 0
    ${distance}=    Set Variable    ${json}[data][distance]
    Should Be True    ${distance} > 0
    ...    msg=❌ Distance must be greater than 0 but got ${distance}

