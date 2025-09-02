*** Settings ***
Documentation     E2E AllRide EXT API (stage) — todas las requests inline sin uso de *** Keywords ***
Library           RequestsLibrary
Library           OperatingSystem
Library           Collections
Library           String
Library           DateTime
Library           SeleniumLibrary
Library           RPA.JSON
Resource          ../Variables/variablesStage.robot
Suite Setup       Create Session    mysesion    ${STAGE_URL}    verify=true
Suite Teardown    Delete All Sessions

*** Variables ***
${ROUTE_EXT_ID}           ROUTE-XYZ-${RANDOM}
${SERVICE_EXT_ID}         SERVICE-XYZ-${RANDOM}
${DRIVER_EXT_ID}          DRIVER-XYZ-${RANDOM}
${VEHICLE_EXT_ID}         VEH-XYZ-${RANDOM}
${VEH_PLATE}              XXYYZZ

${START_OFFSET_MIN}       10
${END_OFFSET_MIN}         70

*** Test Cases ***

Generate random UUIDs
    ${uuid_qr}=    Evaluate    str(__import__('uuid').uuid4())
    ${uuid_qr2}=   Evaluate    str(__import__('uuid').uuid4())
    ${uuid_qr3}=   Evaluate    str(__import__('uuid').uuid4())
    Log    ${uuid_qr}
    Log    ${uuid_qr2}
    Log    ${uuid_qr3}



Create Route
    ${ROUTE_EXT_ID}=    Evaluate    f"ROUTE-XYZ-{__import__('random').randint(10000, 99999)}"
    ${SERVICE_EXT_ID}=  Evaluate    f"SERVICE-XYZ-{__import__('random').randint(10000, 99999)}"
    ${DRIVER_EXT_ID}=   Evaluate    f"DRIVER-XYZ-{__import__('random').randint(10000, 99999)}"
    ${VEHICLE_EXT_ID}=  Evaluate    f"VEH-XYZ-{__import__('random').randint(10000, 99999)}"


    ${stops}=    Set Variable    [{"name":"Oficina Central","latitude":-33.456,"longitude":-70.678,"order":0},{"name":"Parada Intermedia 1","latitude":-33.460,"longitude":-70.685,"order":1},{"name":"Planta Norte","latitude":-33.470,"longitude":-70.695,"order":2}]
    ${headers}=    Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=    Set Variable    {"externalRouteId":"${ROUTE_EXT_ID}","externalClientId":"3335","name":"Ruta E2E RF 2","description":"Ruta de ida y vuelta","stops":${stops},"distance":15.5}
    ${response}=   POST On Session    mysesion    url=/ext/api/v2/routes    data=${payload}    headers=${headers}
    Status Should Be    200

Read Route
    ${url}=       Set Variable    ${STAGE_URL}/ext/api/v2/routes/${ROUTE_EXT_ID}?externalClientId=${idComunidad2}
    &{headers}=   Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=  GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=      RPA.JSON.Load JSON From String    ${response.text}
    Should Be Equal    ${json[data"]["externalRouteId"]}    ${ROUTE_EXT_ID}

Update Route
    ${stops2}=    Set Variable    [{"name":"Oficina Central","latitude":-33.456,"longitude":-70.678,"order":0},{"name":"Parada Intermedia 1","latitude":-33.463,"longitude":-70.686,"order":1},{"name":"Planta Norte","latitude":-33.471,"longitude":-70.696,"order":2}]
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=   Set Variable    {"name":"Ruta E2E RF (v2)","description":"Ruta editada","stops":${stops2},"distance":16.2}
    ${response}=  PUT On Session    mysesion    url=/ext/api/v2/routes/${ROUTE_EXT_ID}?externalClientId=${idComunidad2}    data=${payload}    headers=${headers}
    Status Should Be    200

Create Driver
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=   Set Variable    {"externalClientId":"${idComunidad2}","externalDriverId":"${DRIVER_EXT_ID}","name":"Juan Pérez","code":"JP001","email":"juan.perez@example.com","phone":"+56912345678"}
    ${response}=  POST On Session    mysesion    url=/ext/api/v2/drivers    data=${payload}    headers=${headers}
    Status Should Be    200

Create Vehicle
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=   Set Variable    {"externalClientId":"${idComunidad2}","externalVehicleId":"${VEHICLE_EXT_ID}","plate":"${VEH_PLATE}","code":"B001","year":"2023","model":"Sprinter","color":"White","capacity":20}
    ${response}=  POST On Session    mysesion    url=/ext/api/v2/vehicles    data=${payload}    headers=${headers}
    Status Should Be    200

Schedule Service
    ${start}=     Get Current Date    UTC    increment=${START_OFFSET_MIN} minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${end}=       Get Current Date    UTC    increment=${END_OFFSET_MIN} minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=   Set Variable    {"externalServiceId":"${SERVICE_EXT_ID}","externalClientId":"${idComunidad2}","externalRouteId":"${ROUTE_EXT_ID}","scheduledStartTime":"${start}","scheduledEndTime":"${end}"}
    ${response}=  POST On Session    mysesion    url=/ext/api/v2/services    data=${payload}    headers=${headers}
    Status Should Be    200

Assign Resources
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=   Set Variable    {"externalServiceId":"${SERVICE_EXT_ID}","externalClientId":"${idComunidad2}","driver":{"_id":"${DRIVER_EXT_ID}","name":"Driver E2E"},"vehicle":{"_id":"${VEHICLE_EXT_ID}","plate":"${VEH_PLATE}"}}
    ${response}=  POST On Session    mysesion    url=/ext/api/v2/services/${SERVICE_EXT_ID}/assign    data=${payload}    headers=${headers}
    Status Should Be    200

Start Service
    ${now}=       Get Current Date    UTC    increment=1 minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=   Set Variable    {"externalClientId":"${idComunidad2}","actualStartTime":"${now}","location":{"latitude":-33.455,"longitude":-70.677}}
    ${response}=  POST On Session    mysesion    url=/ext/api/v2/services/${SERVICE_EXT_ID}/start    data=${payload}    headers=${headers}
    Status Should Be    200

Submit Location
    ${ts}=        Get Current Date    UTC    result_format=%Y-%m-%dT%H:%M:%SZ
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=   Set Variable    {"externalClientId":"${idComunidad2}","timestamp":"${ts}","location":{"latitude":-33.465,"longitude":-70.690},"speed":35.5,"heading":180,"accuracy":10}
    ${response}=  POST On Session    mysesion    url=/ext/api/v2/services/${SERVICE_EXT_ID}/location    data=${payload}    headers=${headers}
    Status Should Be    200

Get Service Details
    ${url}=       Set Variable    ${STAGE_URL}/ext/api/v2/services/${SERVICE_EXT_ID}?externalClientId=${idComunidad2}
    &{headers}=   Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=  GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

End Service
    ${end_now}=   Get Current Date    UTC    increment=2 minutes    result_format=%Y-%m-%dT%H:%M:%SZ
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=   Set Variable    {"externalClientId":"${idComunidad2}","actualEndTime":"${end_now}","location":{"latitude":-33.470,"longitude":-70.695}}
    ${response}=  POST On Session    mysesion    url=/ext/api/v2/services/${SERVICE_EXT_ID}/end    data=${payload}    headers=${headers}
    Status Should Be    200

Cancel Service (NEG)
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}    Content-Type=application/json
    ${payload}=   Set Variable    {"externalClientId":"${idComunidad2}","reason":"Cancel after finished"}
    ${response}=  POST On Session    mysesion    url=/ext/api/v2/services/${SERVICE_EXT_ID}/cancel    data=${payload}    headers=${headers}
    Should Be True    ${response.status_code} == 409 or ${response.status_code} == 422

Delete Driver
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=  DELETE On Session    mysesion    url=/ext/api/v2/drivers/${DRIVER_EXT_ID}?externalClientId=${idComunidad2}    headers=${headers}
    Status Should Be    200

Delete Vehicle
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=  DELETE On Session    mysesion    url=/ext/api/v2/vehicles/${VEHICLE_EXT_ID}?externalClientId=${idComunidad2}    headers=${headers}
    Status Should Be    200

Delete Route
    ${headers}=   Create Dictionary    Authorization=${EXT_API_KEY}
    ${response}=  DELETE On Session    mysesion    url=/ext/api/v2/routes/${ROUTE_EXT_ID}?externalClientId=${idComunidad2}    headers=${headers}
    Status Should Be    200
