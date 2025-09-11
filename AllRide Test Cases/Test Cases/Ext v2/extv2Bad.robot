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

    

Create Route(No name- should fail 400)
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
    ...    {"externalRouteId":"${ROUTE_EXT_ID}","externalClientId":"3335","name":"","description":"Ruta de ida y vuelta","stops":${stops},"distance":15.5}
    ${response}=  Run Keyword And Expect Error   HTTPError: 400 Client Error: Bad Request for url: https://stage.allrideapp.com/ext/api/v2/routes   POST On Session    mysesion    url=/ext/api/v2/routes    data=${payload}    headers=${headers}

Create Route(No externalRouteId- should fail 400)
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
    ...    {"externalRouteId":"","externalClientId":"3335","name":"","description":"Ruta de ida y vuelta","stops":${stops},"distance":15.5}
    ${response}=  Run Keyword And Expect Error   HTTPError: 400 Client Error: Bad Request for url: https://stage.allrideapp.com/ext/api/v2/routes   POST On Session    mysesion    url=/ext/api/v2/routes    data=${payload}    headers=${headers}
Create Route(No externalClientId- should fail 400)
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
    ...    {"externalRouteId":"","externalClientId":"","name":"","description":"Ruta de ida y vuelta","stops":${stops},"distance":15.5}
    ${response}=  Run Keyword And Expect Error   HTTPError: 400 Client Error: Bad Request for url: https://stage.allrideapp.com/ext/api/v2/routes   POST On Session    mysesion    url=/ext/api/v2/routes    data=${payload}    headers=${headers}


Read Route
    ${url}=    Set Variable    ${STAGE_URL}/ext/api/v2/routes/${ROUTE_EXT_ID}?externalClientId=3335
    &{headers}=    Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=  Run Keyword And Expect Error     HTTPError: 404 Client Error: Not Found for url: https://stage.allrideapp.com/ext/api/v2/routes/ROUTE-XYZ-14952?externalClientId=3335      GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    404
    ${json}=    Set Variable    ${response.json()}

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
    ${response}=    GET On Session    mysesion    url=/ext/api/v2/drivers/${DRIVER_EXT_ID}?externalClientId=3335       headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}



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

GET Vehicle
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${response}=    GET On Session    mysesion    url=/ext/api/v2/vehicles/${VEHICLE_EXT_ID}?externalClientId=3335       headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}


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

    #✅ Estado general
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}
    Should Be Equal As Strings    ${json}[message]    Service details get successfully
    ...    msg=❌ Expected message 'Service details get successfully' but got "${json}[message]"

    #✅ Datos principales
    Should Not Be Empty    ${json}[data][externalServiceId]    ❌ externalServiceId should not be empty
    Should Be Equal As Strings    ${json}[data][externalClientId]    3335
    ...    msg=❌ Expected externalClientId '3335' but got ${json}[data][externalClientId]
    Should Be Equal As Strings    ${json}[data][externalRouteId]    ${ROUTE_EXT_ID}
    ...    msg=❌ Expected externalRouteId '${ROUTE_EXT_ID}' but got ${json}[data][externalRouteId]
    Should Be Equal As Strings    ${json}[data][state]    pending
    ...    msg=❌ Service state should be 'pending' but got ${json}[data][state]

    #✅ Conductor
    Should Be Equal As Strings    ${json}[data][driver][_id]    ${DRIVER_EXT_ID}
    ...    msg=❌ Expected driver ID '${DRIVER_EXT_ID}' but got ${json}[data][driver][_id]
    Should Be Equal As Strings    ${json}[data][driver][name]    ${driverName}
    ...    msg=❌ Expected driver name '${driverName}' but got ${json}[data][driver][name]

    #✅ Vehículo
    Should Be Equal As Strings    ${json}[data][vehicle][_id]    ${VEHICLE_EXT_ID}
    ...    msg=❌ Expected vehicle ID '${VEHICLE_EXT_ID}' but got ${json}[data][vehicle][_id]
    Should Be Equal As Strings    ${json}[data][vehicle][plate]    XXYYZZ
    ...    msg=❌ Expected plate 'XXYYZZ' but got ${json}[data][vehicle][plate]

    #✅ Ubicación inicial
    Should Be Equal As Numbers    ${json}[data][startLocation][lat]    -33.455
    ...    msg=❌ Expected lat -33.455 but got ${json}[data][startLocation][lat]
    Should Be Equal As Numbers    ${json}[data][startLocation][lon]    -70.677
    ...    msg=❌ Expected lon -70.677 but got ${json}[data][startLocation][lon]
    Should Be Equal As Numbers    ${json}[data][startLocation][loc][0]    -70.677
    ...    msg=❌ Expected loc[0] -70.677 but got ${json}[data][startLocation][loc][0]
    Should Be Equal As Numbers    ${json}[data][startLocation][loc][1]    -33.455
    ...    msg=❌ Expected loc[1] -33.455 but got ${json}[data][startLocation][loc][1]

    #✅ Distancia recorrida
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

Delete Vehicle
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/ext/api/v2/vehicles/${VEHICLE_EXT_ID}?externalClientId=3335
    ...    headers=${headers}
    Status Should Be    200

Delete Route
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/ext/api/v2/routes/${ROUTE_EXT_ID}?externalClientId=3335
    ...    headers=${headers}
    Status Should Be    200

    ${json}=    Set Variable    ${response.json()}

    #✅ Estado general
    Should Be Equal As Numbers    ${response.status_code}    200
    ...    msg=❌ Expected status 200 but got ${response.status_code}
    Should Be Equal As Strings    ${json}[message]    Route deleted successfully
    ...    msg=❌ Expected message 'Route deleted successfully' but got "${json}[message]"

    #✅ Validar externalRouteId
    Should Be Equal As Strings    ${json}[data][externalRouteId]    ${ROUTE_EXT_ID}
    ...    msg=❌ Expected externalRouteId '${ROUTE_EXT_ID}' but got ${json}[data][externalRouteId]
