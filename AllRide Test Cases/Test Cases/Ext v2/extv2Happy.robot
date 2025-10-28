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



startenddate
    ${start}=    Get Current Date    UTC    increment=${START_OFFSET_MIN} minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${end}=    Get Current Date    UTC    increment=${END_OFFSET_MIN} minutes    result_format=%Y-%m-%dT%H:%M:%SZ
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


Update Route
    ${stops2}=    Set Variable
    ...    [{"name":"Oficina Central","latitude":-33.456,"longitude":-70.678,"order":0},{"name":"Parada Intermedia 1","latitude":-33.463,"longitude":-70.686,"order":1},{"name":"Planta Norte","latitude":-33.471,"longitude":-70.696,"order":2}]
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable
    ...    {"name":"Ruta E2E RF (v2)","description":"Ruta editada","stops":${stops2},"distance":16.2}
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/ext/api/v2/routes/${ROUTE_EXT_ID}?externalClientId=3335
    ...    data=${payload}
    ...    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    # ✅ Status code debe ser 200
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje debe ser el esperado
    Should Be Equal As Strings    ${json}[message]    Route updated successfully
    ...    msg=❌ Expected message 'Route updated successfully' but got "${json}[message]"


Get Route From admin after update (PENDIENTE MENSAJE)
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
    Should Be Equal As Strings    ${last_route}[name]    Ruta E2E RF (v2)
    ...    msg=❌ Route name is incorrect. Expected 'Ruta E2E RF (v2)' but got "${last_route}[name]"


    Should Not Be Empty
    ...    ${lastRoute}[externalInfo]
    ...    msg= External info should not be empty in lastRoute details(should contain uuid)
    Should Be Equal As Strings    ${last_route}[externalInfo][uuid]    ${ROUTE_EXT_ID}    

Read Route After Update
    ${url}=    Set Variable    ${STAGE_URL}/ext/api/v2/routes/${ROUTE_EXT_ID}?externalClientId=3335
    &{headers}=    Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

Create Driver
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable
    ...    {"externalClientId":"3335","externalDriverId":"${DRIVER_EXT_ID}","name":"${driverName}","code":"${driverCode}","email":"${driverMail}","phone":"${driverPhone}"}
    ${response}=    POST On Session    mysesion    url=/ext/api/v2/drivers    data=${payload}    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje
    Should Be Equal As Strings    ${json}[message]    Driver created successfully
    ...    msg=❌ Expected message 'Driver created successfully' but got "${json}[message]"

GET Driver
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/ext/api/v2/drivers/${DRIVER_EXT_ID}?externalClientId=3335
    ...    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status code 200 but got a different one

    Should Be Equal As Strings    ${response.json()["message"]}    Driver retrieved successfully
    ...    msg=❌ Driver retrieval message mismatch

    # ✅ Driver data
    Should Be Equal As Strings    ${response.json()["data"]["externalClientId"]}    3335
    ...    msg=❌ externalClientId is not correct

    Should Not Be Empty    ${response.json()["data"]["externalDriverId"]}
    ...    msg=❌ externalDriverId should not be empty

    Should Be Equal As Strings    ${response.json()["data"]["externalDriverId"]}    ${DRIVER_EXT_ID}
    ...    msg=❌ externalDriverId does not match expected
    
    Should Be Equal As Strings    ${response.json()["data"]["name"]}    ${driverName}
    ...    msg=❌ Driver name does not match expected

    Should Not Be Empty    ${response.json()["data"]["code"]}
    ...    msg=❌ Driver code should not be empty

    Should Be Equal As Strings    ${response.json()["data"]["email"]}    ${driverMail}
    ...    msg=❌ Driver email does not match expected

Get Last Driver From Admin
    Set Log Level    TRACE
    Create Session    mysession    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysession
    ...    url=/api/v1/admin/pb/drivers/list?community=5b8576db00a0355421d76393
    ...    headers=${headers}

    Status Should Be    200

    ${drivers}=    Set Variable    ${response.json()}

    # Validamos que existan drivers
    ${num_drivers}=    Get Length    ${drivers}
    

    # Ordenamos drivers por fecha de creación
    ${sorted_drivers}=    Evaluate    sorted(${drivers}, key=lambda x: x['createdAt'])    json

    # Tomamos el último driver creado
    ${last_driver}=    Set Variable    ${sorted_drivers[-1]}

    # ✅ Core identifiers
    ${driver_id}=    Set Variable    ${last_driver["_id"]}
    Should Not Be Empty    ${driver_id}    msg=❌ Driver _id should not be empty

    ${driver_ext_id}=    Set Variable    ${last_driver["externalInfo"]["uuid"]}
    Should Be Equal As Strings    ${driver_ext_id}    ${DRIVER_EXT_ID}    msg=❌ externalInfo.uuid does not match expected

    ${driver_code}=    Set Variable    ${last_driver["code"]}
    Should Be Equal As Strings    ${driver_code}    ${driverCode}    msg=❌ Driver code mismatch

    ${driver_email}=    Set Variable    ${last_driver["email"]}
    Should Be Equal As Strings    ${driver_email}    ${driverMail}    msg=❌ Driver email mismatch

    ${driver_name}=    Set Variable    ${last_driver["name"]}
    Should Be Equal As Strings    ${driver_name}    ${driverName}    msg=❌ Driver name mismatch

    # ✅ Community link
    Should Be Equal As Strings    ${last_driver["communityId"]["_id"]}    5b8576db00a0355421d76393    msg=❌ Community ID mismatch
    Should Be Equal As Strings    ${last_driver["communityId"]["name"]}    UAI    msg=❌ Community name mismatch

    Log    Último driver creado: ${driver_name} (ID: ${driver_id})
    Set Global Variable    ${driver_id}


Create Vehicle
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable
    ...    {"externalClientId":"3335","externalVehicleId":"${VEHICLE_EXT_ID}","plate":"${VEH_PLATE}","code":"B001","year":"2023","model":"Sprinter","color":"White","capacity":20}
    ${response}=    POST On Session    mysesion    url=/ext/api/v2/vehicles    data=${payload}    headers=${headers}
    Status Should Be    200
    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje
    Should Be Equal As Strings    ${json}[message]    Vehicle created successfully
    ...    msg=❌ Expected message 'Vehicle created successfully' but got "${json}[message]"

GET Last Vehicle From Admin
    Set Log Level    TRACE
    Create Session    mysession    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysession
    ...    url=/api/v1/admin/pb/vehicle?community=5b8576db00a0355421d76393
    ...    headers=${headers}

    Status Should Be    200

    ${vehicles}=    Set Variable    ${response.json()}

    # Validamos que existan vehículos
    ${num_vehicles}=    Get Length    ${vehicles}

    # Ordenamos vehículos por fecha de creación
    ${sorted_vehicles}=    Evaluate    sorted(${vehicles}, key=lambda x: x['createdAt'])    json

    # Tomamos el último vehículo creado
    ${last_vehicle}=    Set Variable    ${sorted_vehicles[-1]}

    # ✅ Core identifiers
    ${vehicle_id}=    Set Variable    ${last_vehicle["_id"]}
    Should Not Be Empty    ${vehicle_id}    msg=❌ Vehicle _id should not be empty

    ${vehicle_ext_id}=    Set Variable    ${last_vehicle["externalInfo"]["id"]}
    Should Be Equal As Strings    ${vehicle_ext_id}    ${VEHICLE_EXT_ID}    msg=❌ externalInfo.uuid mismatch

    ${vehicle_code}=    Set Variable    ${last_vehicle["code"]}
    Should Be Equal As Strings    ${vehicle_code}    ${vehicleCode}    msg=❌ Vehicle code mismatch

    ${vehicle_plate}=    Set Variable    ${last_vehicle["plate"]}
    Should Be Equal As Strings    ${vehicle_plate}    XXYYZZ    msg=❌ Vehicle plate mismatch

    ${vehicle_year}=    Set Variable    ${last_vehicle["year"]}
    Should Be Equal As Numbers    ${vehicle_year}    2023    msg=❌ Vehicle year mismatch

    ${vehicle_color}=    Set Variable    ${last_vehicle["color"]}
    Should Be Equal As Strings    ${vehicle_color}    White    msg=❌ Vehicle color mismatch

    # ✅ Community link
    Should Be Equal As Strings    ${last_vehicle["communityId"]["_id"]}    5b8576db00a0355421d76393    msg=❌ Community ID mismatch
    Should Be Equal As Strings    ${last_vehicle["communityId"]["name"]}    UAI    msg=❌ Community name mismatch

    Log    Último vehículo creado: ${vehicle_plate} (ID: ${vehicle_id})
    Set Global Variable    ${vehicle_id}


Schedule Service
    ${start}=    Get Current Date    UTC    increment=${START_OFFSET_MIN} minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${end}=    Get Current Date    UTC    increment=${END_OFFSET_MIN} minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable
    ...    {"externalServiceId":"${SERVICE_EXT_ID}","externalClientId":"3335","externalRouteId":"${ROUTE_EXT_ID}","scheduledStartTime":"${start}","scheduledEndTime":"${end}"}
    ${response}=    POST On Session    mysesion    url=/ext/api/v2/services    data=${payload}    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje
    Should Be Equal As Strings    ${json}[message]    Service scheduled successfully
    ...    msg=❌ Expected message 'Service scheduled successfully' but got "${json}[message]"

    Sleep    50s
Get Last Service Id from admin
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=5b8576db00a0355421d76393&startDate=${start_date_today}&endDate=${end_date_pastTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos todos los servicios por createdAt
    ${sorted_services}=    Evaluate    sorted(${responseJson}, key=lambda x: x['createdAt'])    json

    # Tomamos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}

    Set Global Variable    ${service_id}
    Log    Last created service ID: ${service_id}


Assign Resources
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable
    ...    {"externalServiceId":"${SERVICE_EXT_ID}","externalClientId":"3335","driver":{"_id":"${DRIVER_EXT_ID}","name":"Driver E2E"},"vehicle":{"_id":"${VEHICLE_EXT_ID}","plate":"${VEH_PLATE}"}}
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/ext/api/v2/services/${SERVICE_EXT_ID}/assign
    ...    data=${payload}
    ...    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje
    Should Be Equal As Strings    ${json}[message]    Resources assigned successfully
    ...    msg=❌ Expected message 'Resources assigned successfully' but got "${json}[message]"

Get Service Detail From admin to see resources
    skip
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}   Content-Type=application/json
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/service/${service_id}?community=5b8576db00a0355421d76393
    ...    headers=${headers}
    Status Should Be    200

    ${last_service}=    Set Variable    ${response.json()}

    # ✅ Route Name
    Should Be Equal As Strings    ${last_service["routeId"]["name"]}    Ruta E2E RF (v2)
    ...    msg=❌ Route name mismatch

    # ✅ Driver name
    ${drivers}=    Set Variable    ${last_service["resources"][0]["drivers"]}
    ${driver_name}=    Set Variable    ${drivers[0]["name"]}
    Should Be Equal As Strings    ${driver_name}    ${driver_name}    msg=❌ Driver name mismatch

    # ✅ Vehicle name/plate
    ${vehicle}=    Set Variable    ${last_service["resources"][0].get("vehicle", None)}
    ${vehicle_name}=    Set Variable    ${vehicle["plate"]}
    Should Be Equal As Strings    ${vehicle_name}    ${VEH_PLATE}    msg=❌ Vehicle plate mismatch


    # ✅ External Info
    Should Be Equal As Strings    ${last_service["routeId"]["externalInfo"]["uuid"]}    ${ROUTE_EXT_ID}
    ...    msg=❌ Route externalInfo.uuid mismatch

    Should Be Equal As Strings    ${last_service["external"]["serviceId"]}    ${SERVICE_EXT_ID}
    ...    msg=❌ Service externalInfo.serviceId mismatch


Start Service
    ${now}=    Get Current Date    UTC    increment=1 minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable
    ...    {"externalClientId":"3335","actualStartTime":"${now}","location":{"latitude":-33.455,"longitude":-70.677}}
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/ext/api/v2/services/${SERVICE_EXT_ID}/start
    ...    data=${payload}
    ...    headers=${headers}
    Status Should Be    200
    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje
    Should Be Equal As Strings    ${json}[message]    Service started successfully
    ...    msg=❌ Expected message 'Service started successfully' but got "${json}[message]"

    Sleep    2s

Get Last Service Id from admin (should be active true)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=5b8576db00a0355421d76393&startDate=${start_date_today}&endDate=${end_date_pastTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos todos los servicios por createdAt
    ${sorted_services}=    Evaluate    sorted(${responseJson}, key=lambda x: x['createdAt'])    json

    # Tomamos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id}=    Set Variable    ${last_service['_id']}

    Set Global Variable    ${service_id}
    Log    Last created service ID: ${service_id}

Submit Location
    ${ts}=    Get Current Date    UTC    result_format=%Y-%m-%dT%H:%M:%SZ
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable
    ...    {"externalClientId":"3335","timestamp":"${ts}","location":{"latitude":-33.465,"longitude":-70.690},"speed":35.5,"heading":180,"accuracy":10}
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/ext/api/v2/services/${SERVICE_EXT_ID}/location
    ...    data=${payload}
    ...    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje
    Should Be Equal As Strings    ${json}[message]    Location received successfully
    ...    msg=❌ Expected message 'Location received successfully' but got "${json}[message]"

Get Service Details
    ${url}=    Set Variable    ${STAGE_URL}/ext/api/v2/services/${SERVICE_EXT_ID}?externalClientId=3335
    &{headers}=    Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

    # ✅ Estado general
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}
    Should Be Equal As Strings    ${json}[message]    Service details get successfully
    ...    msg=❌ Expected message 'Service details get successfully' but got "${json}[message]"

    # ✅ Datos principales
    Should Not Be Empty    ${json}[data][externalServiceId]    ❌ externalServiceId should not be empty
    Should Be Equal As Strings    ${json}[data][externalClientId]    3335
    ...    msg=❌ Expected externalClientId '3335' but got ${json}[data][externalClientId]
    Should Be Equal As Strings    ${json}[data][externalRouteId]    ${ROUTE_EXT_ID}
    ...    msg=❌ Expected externalRouteId '${ROUTE_EXT_ID}' but got ${json}[data][externalRouteId]
    Should Be Equal As Strings    ${json}[data][state]    pending
    ...    msg=❌ Service state should be 'pending' but got ${json}[data][state]

    # ✅ Conductor
    Should Be Equal As Strings    ${json}[data][driver][_id]    ${DRIVER_EXT_ID}
    ...    msg=❌ Expected driver ID '${DRIVER_EXT_ID}' but got ${json}[data][driver][_id]
    Should Be Equal As Strings    ${json}[data][driver][name]    ${driverName}
    ...    msg=❌ Expected driver name '${driverName}' but got ${json}[data][driver][name]

    # ✅ Vehículo
    Should Be Equal As Strings    ${json}[data][vehicle][_id]    ${VEHICLE_EXT_ID}
    ...    msg=❌ Expected vehicle ID '${VEHICLE_EXT_ID}' but got ${json}[data][vehicle][_id]
    Should Be Equal As Strings    ${json}[data][vehicle][plate]    XXYYZZ
    ...    msg=❌ Expected plate 'XXYYZZ' but got ${json}[data][vehicle][plate]

    # ✅ Ubicación inicial
    Should Be Equal As Numbers    ${json}[data][startLocation][lat]    -33.455
    ...    msg=❌ Expected lat -33.455 but got ${json}[data][startLocation][lat]
    Should Be Equal As Numbers    ${json}[data][startLocation][lon]    -70.677
    ...    msg=❌ Expected lon -70.677 but got ${json}[data][startLocation][lon]
    Should Be Equal As Numbers    ${json}[data][startLocation][loc][0]    -70.677
    ...    msg=❌ Expected loc[0] -70.677 but got ${json}[data][startLocation][loc][0]
    Should Be Equal As Numbers    ${json}[data][startLocation][loc][1]    -33.455
    ...    msg=❌ Expected loc[1] -33.455 but got ${json}[data][startLocation][loc][1]

    # ✅ Distancia recorrida
    Should Be Equal As Numbers    ${json}[data][distanceTravelledKm]    0
    ...    msg=❌ Expected distanceTravelledKm to be 0 but got ${json}[data][distanceTravelledKm]

End Service
    ${end_now}=    Get Current Date    UTC    increment=2 minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable
    ...    {"externalClientId":"3335","actualEndTime":"${end_now}","location":{"latitude":-33.470,"longitude":-70.695}}
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/ext/api/v2/services/${SERVICE_EXT_ID}/end
    ...    data=${payload}
    ...    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje
    Should Be Equal As Strings    ${json}[message]    Service ended successfully
    ...    msg=❌ Expected message 'Service ended successfully' but got "${json}[message]"

Cancel Service (NEG)
    skip
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable    {"externalClientId":"3335","reason":"Cancel after finished"}
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/ext/api/v2/services/${SERVICE_EXT_ID}/cancel
    ...    data=${payload}
    ...    headers=${headers}
    Should Be True    ${response.status_code} == 409 or ${response.status_code} == 422

Delete Driver
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/ext/api/v2/drivers/${DRIVER_EXT_ID}?externalClientId=3335
    ...    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    # ✅ Código de estado
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}

    # ✅ Mensaje
    Should Be Equal As Strings    ${json}[message]    Driver deleted successfully
    ...    msg=❌ Expected message 'Driver deleted successfully' but got "${json}[message]"

Verify Driver Deleted From Admin
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysession
    ...    url=/api/v1/admin/pb/drivers/list?community=5b8576db00a0355421d76393
    ...    headers=${headers}

    Status Should Be    200

    ${drivers}=    Set Variable    ${response.json()}

    # ✅ Verificamos que el driver eliminado no esté en la lista
    ${matching_driver}=    Evaluate    [d for d in ${drivers} if d["_id"] == "${driver_id}"]    json
    Should Be Empty    ${matching_driver}    msg=❌ Driver with ID ${driver_id} still exists in the list after deletion

    Log    ✅ Driver with ID ${driver_id} no longer exists in the list


Delete Vehicle
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/ext/api/v2/vehicles/${VEHICLE_EXT_ID}?externalClientId=3335
    ...    headers=${headers}
    Status Should Be    200

Verify Vehicle Deleted From Admin
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysession
    ...    url=/api/v1/admin/pb/vehicle?community=5b8576db00a0355421d76393
    ...    headers=${headers}

    Status Should Be    200

    ${vehicles}=    Set Variable    ${response.json()}

    # ✅ Verificamos que el vehículo eliminado no esté en la lista
    ${matching_vehicle}=    Evaluate    [v for v in ${vehicles} if v["_id"] == "${vehicle_id}"]    json
    Should Be Empty    ${matching_vehicle}    msg=❌ Vehicle with ID ${vehicle_id} still exists in the list after deletion

    Log    ✅ Vehicle with ID ${vehicle_id} no longer exists in the list

Delete Route
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/ext/api/v2/routes/${ROUTE_EXT_ID}?externalClientId=3335
    ...    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    # ✅ Estado general
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}
    Should Be Equal As Strings    ${json}[message]    Route deleted successfully
    ...    msg=❌ Expected message 'Route deleted successfully' but got "${json}[message]"

    # ✅ Validar externalRouteId
    Should Be Equal As Strings    ${json}[data][externalRouteId]    ${ROUTE_EXT_ID}
    ...    msg=❌ Expected externalRouteId '${ROUTE_EXT_ID}' but got ${json}[data][externalRouteId]

Verify Route Deleted From Admin
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysession
    ...    url=/api/v1/admin/pb/routes/list?community=5b8576db00a0355421d76393
    ...    headers=${headers}

    Status Should Be    200

    ${routes}=    Set Variable    ${response.json()}

    # ✅ Verificamos que la ruta eliminada no esté en la lista
    ${matching_route}=    Evaluate    [r for r in ${routes} if r["_id"] == "${route_id}"]    json
    Should Be Empty    ${matching_route}    msg=❌ Route with ID ${route_id} still exists in the list after deletion

    Log    ✅ Route with ID ${route_id} no longer exists in the list



Bulk Create Routes With Random ExternalIds
    Create Session    mysession    ${STAGE_URL}    verify=true

    ${ROUTE_EXT_ID_1}=    Evaluate    f"ROUTE-XYZ-{__import__('random').randint(1000, 9999)}"
    ${ROUTE_EXT_ID_2}=    Set Variable    ${ROUTE_EXT_ID_1}    # Forzamos duplicación
    ${CLIENT_ID}=    Set Variable    3335

    ${payload}=        Set Variable       [{"externalRouteId":"${ROUTE_EXT_ID_1}","externalClientId":"${CLIENT_ID}","name":"Ruta Oficina Central - Planta Norte","description":"Ruta de ida y vuelta","stops":[{"externalStopId":"STOP-01","name":"Oficina Central","latitude":-33.456,"longitude":-70.678,"order":0},{"name":"Planta Norte","latitude":-33.47,"longitude":-70.695,"order":1}],"distance":15.5},{"externalRouteId":"${ROUTE_EXT_ID_2}","externalClientId":"${CLIENT_ID}","name":"Ruta Duplicada"},{"externalClientId":"${CLIENT_ID}","name":"Ruta Sin ID Externo"}]

    ${headers}=    Create Dictionary    Authorization=Bearer ${EXT_API_KEY}    Content-Type=application/json
    ${response}=    POST On Session    
    ...    mysession    
    ...    url=/ext/api/v2/routes/bulk    
    ...    json=${payload}    
    ...    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}
    Log To Console    ✅ Resultado Bulk Create -> ${json}
Get Routes From Admin After Bulk Create
    Set Log Level    TRACE
    Create Session    mysession    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    ${response}=    GET On Session
    ...    mysession
    ...    url=/api/v1/admin/pb/routes/list?community=5b8576db00a0355421d76393
    ...    headers=${headers}

    Status Should Be    200

    ${routes}=    Set Variable    ${response.json()}

    # Validamos que existan rutas
    ${num_routes}=    Get Length    ${routes}

    # ✅ Verificar que la ruta creada en bulk existe
    ${matching_route}=    Evaluate    [r for r in ${routes} if r["externalInfo"]["uuid"] == "${ROUTE_EXT_ID}"]    json
    Should Not Be Empty    ${matching_route}    msg=❌ Bulk-created route with externalInfo.uuid=${ROUTE_EXT_ID} not found in admin

    ${created_route}=    Set Variable    ${matching_route}[0]
    Log    ✅ Bulk-created route found: ${created_route["name"]} (ID: ${created_route["_id"]})

    # ✅ Validar nombre esperado
    Should Be Equal As Strings    ${created_route["name"]}    Ruta Oficina Central - Planta Norte
    ...    msg=❌ Route name mismatch. Expected 'Ruta Oficina Central - Planta Norte' but got "${created_route['name']}"

    # ✅ Verificar que la ruta duplicada no fue creada
    ${duplicate_route}=    Evaluate    [r for r in ${routes} if r["name"] == "Ruta Duplicada"]    json
    Should Be Empty    ${duplicate_route}    msg=❌ Duplicate route 'Ruta Duplicada' should not exist in admin

Bulk Schedule Services
    ${SERVICE_EXT_ID}=    Evaluate    f"SERVICE-{__import__('random').randint(10000, 99999)}"
    ${CLIENT_ID}=    Set Variable    3335
    ${start}=    Get Current Date    UTC    increment=5 minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${end}=      Get Current Date    UTC    increment=65 minutes    result_format=%Y-%m-%dT%H:%M:%SZ

    ${valid_service}=    Create Dictionary
    ...    externalServiceId=${SERVICE_EXT_ID}
    ...    externalClientId=${CLIENT_ID}
    ...    externalRouteId=${ROUTE_EXT_ID}
    ...    scheduledStartTime=${start}
    ...    scheduledEndTime=${end}
    ...    driver={"_id":"${DRIVER_EXT_ID}","name":"${driverName}","email":"${driverMail}"}
    ...    vehicle={"_id":"${VEHICLE_EXT_ID}","plate":"XXYYZZ"}

    ${invalid_route}=    Create Dictionary
    ...    externalServiceId=SERVICE-NOT-FOUND
    ...    externalClientId=${CLIENT_ID}
    ...    externalRouteId=ROUTE-DOES-NOT-EXIST
    ...    scheduledStartTime=${start}
    ...    scheduledEndTime=${end}

    ${duplicate_service}=    Create Dictionary
    ...    externalServiceId=${SERVICE_EXT_ID}
    ...    externalClientId=${CLIENT_ID}
    ...    externalRouteId=${ROUTE_EXT_ID}
    ...    scheduledStartTime=${start}
    ...    scheduledEndTime=${end}

    ${services}=    Create List    ${valid_service}    ${invalid_route}    ${duplicate_service}
    ${payload}=    Evaluate    json.dumps(${services})    json

    Log To Console    Payload enviado: ${payload}

    ${headers}=    Create Dictionary    Authorization=Bearer ${EXT_API_KEY}    Content-Type=application/json
    ${response}=    POST On Session  mysession    url=/ext/api/v2/services/bulkRequest    data=${payload}    headers=${headers}

    Status Should Be    200
    ${json}=    Set Variable    ${response.json()}

    # ✅ Validaciones principales
    ${status}=    Get From Dictionary    ${json}    status
    Should Be Equal As Numbers    ${status}    200

    ${message}=    Get From Dictionary    ${json}    message
    Should Be Equal As Strings    ${message}    Bulk operation finished. 1 services scheduled, 2 failed.

    # ✅ Servicios exitosos
    ${data}=    Get From Dictionary    ${json}    data
    ${success}=    Get From Dictionary    ${data}    successfulServices
    Should Not Be Empty    ${success}    msg=❌ No successful services found

    ${success_msg}=    Get From Dictionary    ${success}[0]    message
    Should Be Equal As Strings    ${success_msg}    Service scheduled successfully

    # ✅ Servicios fallidos
    ${failed}=    Get From Dictionary    ${data}    failedServices
    ${failed_count}=    Get Length    ${failed}
    Should Be True    ${failed_count} == 2    msg=❌ Expected 2 failed services but got ${failed_count}

    ${error1}=    Get From Dictionary    ${failed}[0]    error
    Should Contain    ${error1}    Route with externalRouteId

    ${error2}=    Get From Dictionary    ${failed}[1]    error
    Should Contain    ${error2}    already exists