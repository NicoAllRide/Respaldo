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
    ${start_date_tickets}=    Set Variable    ${fecha_hoy}T04:00:00.000Z
    Set Global Variable    ${start_date_tickets}
    ${end_date_tickets}=    Set Variable    ${fecha_manana}T03:59:59.999Z
    Set Global Variable    ${end_date_tickets}

    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}

Generate random UUID (_id validations qrValidations)
    ${uuid_qr}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr}
    Set Global Variable    ${uuid_qr}

2 hours local
    ${date}=    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}=    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}=    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}=    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

Crate Product (Pass)
    [Documentation]     Creación de productos desde el admin (Pases)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/createProduct?community=653fd601f90509541a748683
    ...    data={"active":true,"name":"Automation Test Passes","description":"Automation Test Passes","communities":["653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"expiration":"","price":10,"discount":0,"stock":1,"values":[{"communities":["653fd601f90509541a748683"],"superCommunities":["653fd68233d83952fafcd4be"],"ref":"pb_pass","quantity":1,"options":{"name":"Automation Test Passes","description":"Automation Test Passes","startDate":"${fecha_hoy}","endDate":"${fecha_manana}","unlimitedUses":false,"maxUses":2,"maxDailyUses":2,"state":"available","allRoutes":true,"routeIds":[],"routeNames":[],"oddTypes":[]}}],"productType":"pb_pass"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
 
    ${last_pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${last_pass}[active]    True
    ...    msg=❌ The pass should be active. Found: "${last_pass}[active]"

    Should Be Equal As Integers    ${last_pass}[stock]    1
    ...    msg=❌ The stock should be 1. Found: "${last_pass}[stock]"

    Should Be Equal As Integers    ${last_pass}[price]    10
    ...    msg=❌ The price should be 10. Found: "${last_pass}[price]"

    Should Contain    ${last_pass}[communities]    653fd601f90509541a748683
    ...    msg=❌ Expected community ID not found. Found: "${last_pass}[communities]"

    Should Contain    ${last_pass}[superCommunities]    653fd68233d83952fafcd4be
    ...    msg=❌ Expected superCommunity ID not found. Found: "${last_pass}[superCommunities]"

    ${pass_values}=    Get From List    ${last_pass}[values]    0

    Should Be Equal As Strings    ${pass_values}[ref]    pb_pass
    ...    msg=❌ The 'ref' should be 'pb_pass'. Found: "${pass_values}[ref]"

    Should Be Equal As Integers    ${pass_values}[quantity]    1
    ...    msg=❌ The quantity should be 1. Found: "${pass_values}[quantity]"

    ${options}=    Set Variable    ${pass_values}[options]

    Should Be Equal As Strings    ${options}[name]    Automation Test Passes
    ...    msg=❌ The pass name should be 'Automation Test Passes'. Found: "${options}[name]"

    Should Be Equal As Strings    ${options}[description]    Automation Test Passes
    ...    msg=❌ The pass description should be 'Automation Test Passes'. Found: "${options}[description]"

    Should Be Equal As Strings    ${options}[startDate]    ${fecha_hoy}
    ...    msg=❌ The start date should be '${fecha_hoy}'. Found: "${options}[startDate]"

    Should Be Equal As Strings    ${options}[endDate]    ${fecha_manana}
    ...    msg=❌ The end date should be '${fecha_manana}'. Found: "${options}[endDate]"

    Should Be Equal As Strings    ${options}[unlimitedUses]    False
    ...    msg=❌ 'unlimitedUses' should be False. Found: "${options}[unlimitedUses]"

    Should Be Equal As Integers    ${options}[maxUses]    2
    ...    msg=❌ 'maxUses' should be 2. Found: "${options}[maxUses]"

    Should Be Equal As Integers    ${options}[maxDailyUses]    2
    ...    msg=❌ 'maxDailyUses' should be 2. Found: "${options}[maxDailyUses]"

    Should Be Equal As Strings    ${options}[state]    available
    ...    msg=❌ The pass state should be 'available'. Found: "${options}[state]"

    Should Be True    ${options}[allRoutes]
    ...    msg=❌ 'allRoutes' should be True. Found: "${options}[allRoutes]"

    Length Should Be    ${options}[routeIds]    0
    ...    msg=❌ 'routeIds' should be empty. Found: "${options}[routeIds]"

    Length Should Be    ${options}[routeNames]    0
    ...    msg=❌ 'routeNames' should be empty. Found: "${options}[routeNames]"

    Length Should Be    ${options}[oddTypes]    0
    ...    msg=❌ 'oddTypes' should be empty. Found: "${options}[oddTypes]"

    ${pass_id}=    Set Variable    ${last_pass}[_id]
    Set Global Variable    ${pass_id}
    Log    ✅ Pass ID: ${pass_id}

Login User With Email(Obtain Token)
    [Documentation]    Inicio de sesión de usuario con correo y contraseña, se obtiene token
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+usuarioeliminar2@allrideapp.com","password":"Lolowerty21@"}
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
    List Should Contain Value    ${response.json()}    accessToken    No accesToken found in Login!, Failing
    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenNico}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenNico}

Get active product List (Before assign)
    [Documentation]     Se obtiene la lista de prodcutos activos, se verifica que haya stock(1) y precio(10)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/products/listActive?community=653fd601f90509541a748683

    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${passes}=    Set Variable    ${response.json()}
    ${found}=     Set Variable    False
    ${product_id}=    Set Variable    NONE

    FOR    ${pass}    IN    @{passes}
    ${name}=         Set Variable    ${pass}[name]
    ${description}=  Set Variable    ${pass}[description]
    ${price}=        Set Variable    ${pass}[price]
    ${stock}=        Set Variable    ${pass}[stock]
    Run Keyword If    '${name}' == 'Automation Test Passes' and '${description}' == 'Automation Test Passes' and '${price}' == '10' and ${stock} == 1
    ...    Set Test Variable    ${found}    True
    Run Keyword If    '${name}' == 'Automation Test Passes' and '${description}' == 'Automation Test Passes' and '${price}' == '10' and ${stock} == 1
    ...    Set Test Variable    ${product_id}    ${pass}[_id]
    END

    Should Be True    ${found}    msg=❌ Product 'Automation Test Passes' with stock=0 not found in active product list.
    Log    ✅ Found Product ID: ${product_id}
    Set Global Variable    ${product_id}



Search user to assign passes
    [Documentation]     Se busca al usario para asignarle los productos
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/searchUser?community=653fd601f90509541a748683&searchText=nico%20eliminar
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)


    ${user}=    Set Variable    ${response.json()}[0]

    Should Be Equal As Strings    ${user}[name]    nico eliminar
    ...    msg=❌ Expected name to be 'nico eliminar', but got: ${user}[name]

    Should Be Equal As Strings    ${user}[email]    nicolas+usuarioeliminar2@allrideapp.com
    ...    msg=❌ Expected email to be 'nicolas+usuarioeliminar2@allrideapp.com', but got: ${user}[email]

    Should Be Equal As Strings    ${user}[communityCustom][0][key]    rut
    ...    msg=❌ Expected first custom key to be 'rut', but got: ${user}[communityCustom][0][key]

    Should Be Equal As Strings    ${user}[communityCustom][0][value]    06980988
    ...    msg=❌ Expected rut to be '06980988', but got: ${user}[communityCustom][0][value]

    ${user_id}=    Set Variable    ${user}[id]
    Log    ✅ User ID found: ${user_id}
    Set Global Variable    ${user_id}

Assing Passes Manually From Admin
    [Documentation]    Se asigna el pase al usuario y se verifica que los usos restantes correspondan a lo configurado
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/assignToUser?community=653fd601f90509541a748683
    ...    data={"userId":"${user_id}","productId":"${pass_id}","quantity":1,"userName":"nico eliminar"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${pass}=    Set Variable    ${response.json()}[0]

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes
    ...    msg=❌ Expected name to be 'Automation Test Passes' but got: ${pass}[name]

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes
    ...    msg=❌ Expected description to be 'Automation Test Passes' but got: ${pass}[description]

    Should Be Equal As Strings    ${pass}[productId]    ${product_id}
    ...    msg=❌ Expected productId to be '${product_id}' but got: ${pass}[productId]

    Should Be Equal As Strings    ${pass}[userId]    ${user_id}
    ...    msg=❌ Expected userId to be '${user_id}' but got: ${pass}[userId]

    Should Be Equal As Strings    ${pass}[maxUses]    2
    ...    msg=❌ Expected maxUses to be 2 but got: ${pass}[maxUses]

    Should Be Equal As Strings    ${pass}[maxDailyUses]    2
    ...    msg=❌ Expected maxDailyUses to be 2 but got: ${pass}[maxDailyUses]

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True but got: ${pass}[allRoutes]

    ${assigned_pass_id}=    Set Variable    ${pass}[_id]
    Log    ✅ Assigned pass ID: ${assigned_pass_id}
    Set Global Variable    ${assigned_pass_id}

Get active product List (After assign-should be 0 passes left)
    [Documentation]    Se obtiene la lista de prodcutos activos, se verifica que NO haya stock(0) y precio(10)
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/products/listActive?community=653fd601f90509541a748683

    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${passes}=    Set Variable    ${response.json()}
    ${stock}=     Set Variable    NONE
    ${product_id}=    Set Variable    NONE

    FOR    ${pass}    IN    @{passes}
    ${name}=         Set Variable    ${pass}[name]
    ${description}=  Set Variable    ${pass}[description]
    ${price}=        Set Variable    ${pass}[price]
    ${stock_check}=  Set Variable    ${pass}[stock]
    Run Keyword If    '${name}' == 'Automation Test Passes' and '${description}' == 'Automation Test Passes' and '${price}' == '10'
    ...    Set Test Variable    ${stock}    ${stock_check}
    Run Keyword If    '${name}' == 'Automation Test Passes' and '${description}' == 'Automation Test Passes' and '${price}' == '10'
    ...    Set Test Variable    ${product_id}    ${pass}[_id]
    END

    Should Be Equal As Numbers    ${stock}    0
    ...    msg=❌ Expected stock to be 0 for product 'Automation Test Passes', but got: ${stock}

    Log    ✅ Found Product ID with stock=0: ${product_id}
    Set Global Variable    ${product_id}

 

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Get Passes From User (Step2 - Should be 1+)
    [Documentation]    Se verifica que se haya agregado correctamente el pase al usuario
    # Define the URL for authenticated resource
    ${url}=    Set Variable    ${STAGE_URL}/api/v2/products/user/purchased

    # Set request headers with token
    &{headers}=    Create Dictionary    Authorization=${accessTokenNico}

    # Perform the GET request
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    # Extract transaction and passes
    ${transactions}=    Set Variable    ${response.json()}[transactions]
    ${first_transaction}=    Get From List    ${transactions}    0
    ${passes}=    Get From Dictionary    ${first_transaction}    passes

    # Ensure passes list is not empty
    Should Not Be Empty    ${passes}
    ...    msg=❌ 'passes' list is empty. No passes found in the transaction.

    # Get the last pass
    ${pass}=    Get From List    ${passes}    -1

    # Validate pass fields
    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes
    ...    msg=❌ Expected pass name to be 'Automation Test Passes' but got '${pass}[name]'

    Should Be Equal As Numbers    ${pass}[maxDailyUses]    2
    ...    msg=❌ Expected maxDailyUses to be 2 but got '${pass}[maxDailyUses]'

    Should Be Equal As Strings    ${pass}[service]    privateBus
    ...    msg=❌ Expected service to be 'privateBus' but got '${pass}[service]'

    # Save _id globally for next steps
    ${passId}=    Get From Dictionary    ${pass}    _id
    Log    ✅ Found pass with _id: ${passId}
    Set Global Variable    ${passId}

Get Pass Detail Before validation
    [Documentation]    Se verifica el pase comprado desde la app usuario y que tenga 2 usos aún
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/products/user/purchased/${passId}/passes/privateBus

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${accessTokenNico}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

# Tomar el primer pase
    ${pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes
    ...    msg=❌ Expected name to be 'Automation Test Passes', but got '${pass}[name]'

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes
    ...    msg=❌ Expected description to be 'Automation Test Passes', but got '${pass}[description]'

    Should Be Equal As Numbers    ${pass}[remaining]    2
    ...    msg=❌ Expected remaining to be 2, but got '${pass}[remaining]'

    Should Be Equal As Strings    ${pass}[unlimitedUses]    False
    ...    msg=❌ Expected unlimitedUses to be False, but got '${pass}[unlimitedUses]'

    Should Be Equal As Numbers    ${pass}[maxDailyUses]    2
    ...    msg=❌ Expected maxDailyUses to be 2, but got '${pass}[maxDailyUses]'

    Should Be Equal As Numbers    ${pass}[used]    0
    ...    msg=❌ Expected used to be 0, but got '${pass}[used]'

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True, but got '${pass}[allRoutes]'

    Should Be Equal As Strings    ${pass}[allLots]    False
    ...    msg=❌ Expected allLots to be False, but got '${pass}[allLots]'

    Should Be Equal As Numbers    ${pass}[remainingDailyUses]    2
    ...    msg=❌ Expected remainingDailyUses to be 2, but got '${pass}[remainingDailyUses]'



Create new service in the selected route
    
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"_id":"68488d2a4ff298af70023813","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":5,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":5,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0,"by":"vehicle"},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"transitDepartures":{"options":{"allowedUsers":{"byParams":{"params":[]}}}},"_id":"68488de04ff298af70023f5c","stopId":"655d11d88a5a1a1ff0328466","scheduledDate":"2025-06-10T21:00:00.953Z"},{"transitDepartures":{"options":{"allowedUsers":{"byParams":{"params":[]}}}},"_id":"68488de04ff298af70023f5d","stopId":"655d11d88a5a1a1ff0328464","scheduledDate":null}],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]},"timeRules":{"booking":{"maxTime":{"enabled":false,"amount":0,"unit":"minutes"}}},"byQuantity":{"enabled":false,"amount":0,"time":0,"unit":"days","userSkip":[]}},"reservations":{"enabled":false,"list":[]},"serviceCreationLimit":{"enabled":false,"date":null}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["68488d2a4ff298af70023813"],"visibility":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"reservation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"},"validation":{"enabled":false,"excludes":false,"parameters":[],"conditional":"or"}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToForceDeparture":{"enabled":false,"amount":5,"unit":"minutes"},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"},"estimatedDuration":{"byPercentage":{"enabled":false,"amount":0,"timer":{"amount":0,"unit":"minutes"}},"byTime":{"enabled":false,"amount":0,"unit":"minutes","timer":{"amount":0,"unit":"minutes"}}}},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"Solo puedes presentar el código de AllRide o de tu cédula de identidad."},"DNIValidation":{"enabled":false,"options":["qr"]},"validation":{"external":[]},"restrictions":{"external":[]},"assistantIds":[],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["653fd601f90509541a748683"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":true,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":true,"usesTextToSpeech":false,"allowsManualValidation":false,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":false,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"hasBarrier":false,"name":"Scheduled with Passes RF","shapeId":"68488d2a4ff298af700237f5","description":"Scheduled with Passes RF","extraInfo":"","color":"753737","legOptions":[{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}},"moveToNextLegAutomatically":{"enabled":false,"stopId":null,"distance":100},"ETA":{"enabled":null,"update":{"amount":0,"unit":"minutes"},"visibility":["admin"],"notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}}}],"ownerIds":[{"_id":"68488d2a4ff298af70023818","id":"653fd601f90509541a748683","role":"community"}],"segments":[],"roundOrder":[{"stopId":"655d11d88a5a1a1ff0328466","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328464","notifyIfPassed":false}],"communityId":"653fd601f90509541a748683","timeOnRoute":9,"distance":4,"distanceInMeters":4375,"customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2025-06-10T19:53:14.867Z","updatedAt":"2025-06-10T19:56:16.198Z","__v":1,"autoStartConditions":{"enabled":false,"ignition":false,"allowStop":false,"acceptedStatus":false,"delay":{"enabled":false,"time":0,"unit":"minutes"},"nearRoute":{"enabled":false,"distance":0}},"custom":{"ui":{"color":"753737","marker":{"1x":"","1.5x":"","2x":"","3x":"","4x":""}}},"destinationStop":"655d11d88a5a1a1ff0328464","externalInfo":{"uuid":""},"originStop":"655d11d88a5a1a1ff0328466","routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false},"superCommunityId":"653fd68233d83952fafcd4be","unassignedDepartures":{"enabled":true,"allowsMultiple":{"enabled":true,"limit":{"amount":5,"unit":"minutes"}}},"useServiceReservations":true,"routeCost":0,"ticketCost":0}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Put On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/68488d2a4ff298af70023813?community=653fd601f90509541a748683
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${scheduleId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${scheduleId}

Create services
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/createServices/653fd601f90509541a748683?community=653fd601f90509541a748683
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s

Get Service Id
    [Documentation]     Obtener servicio creado recientemente, si no se encuentra se ejecuta un fatal error
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_pastTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}[scheduledServices]
    ${service_id}=    Set Variable    None

    
    # Ordenamos los servicios por createdAt
    ${sorted_services}=    Evaluate    sorted([s for s in ${responseJson} if s['routeId']['_id'] == '${scheduleId}'], key=lambda x: x['createdAt'])    json


    Run Keyword If    ${sorted_services} == []    Fatal Error    msg= No services were created with routeId._id = "${scheduleId}" All createSheduled Tests Failing(Fatal error)
    # Obtenemos el último servicio creado
    ${last_service}=    Set Variable    ${sorted_services[-1]}
    ${service_id_tickets}=    Set Variable    ${last_service['_id']}
    ${last_service_route}=    Set Variable    ${last_service['routeId']['_id']}
    Should Be Equal As Strings    ${scheduleId}    ${last_service_route}
    
    Set Global Variable    ${service_id_tickets}

    Log    Last created service ID: ${service_id_tickets}

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

Resource Assignment(Driver and Vehicle)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id_tickets}?community=${idComunidad}
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId}"},"drivers":[],"vehicle":{"vehicleId":"${vehicleId}","capacity":"5"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${departureId}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    Set Global Variable    ${departureId}

Verify capacity in vehicle (After assign resources from admin)
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id_tickets}?community=653fd601f90509541a748683

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${capacityVehicle}=    Set Variable    ${response.json()}[resources][0][vehicle]
    Should Contain    ${capacityVehicle}    capacity    Vehicle in resources doesn't contain the 'capacity' property



Driver Accept Service
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/acceptOrReject/${departureId}
    ...    data={"state":"accepted"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}


Start Departure Leg
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/${departureId}
    ...    data={"departureId":"${departureId}","communityId":"${idComunidad}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":5,"busCode":"1111","driverCode":"753","vehicleId":"${vehicleId}","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${departureToken}
    Log    ${departureToken}
    Log    ${code}

Get User QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["68421176a7bd942520758734"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}

Validate With QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeNico}","timezone":"America/Santiago","validationLat":-33.39073098922399,"validationLon":-70.54616911670284}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    10s


Get Pass Detail After validation (Online)
    [Documentation]    Se verifica el descuento del pase luego de la validación online, debería quedan 1 solo uso
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/products/user/purchased/${passId}/passes/privateBus

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${accessTokenNico}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

# Tomar el primer pase
    ${pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes
    ...    msg=❌ Expected name to be 'Automation Test Passes', but got '${pass}[name]'

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes
    ...    msg=❌ Expected description to be 'Automation Test Passes', but got '${pass}[description]'

    Should Be Equal As Numbers    ${pass}[remaining]    1
    ...    msg=❌ Expected remaining to be 1, but got '${pass}[remaining]'

    Should Be Equal As Strings    ${pass}[unlimitedUses]    False
    ...    msg=❌ Expected unlimitedUses to be False, but got '${pass}[unlimitedUses]'

    Should Be Equal As Numbers    ${pass}[maxDailyUses]    2
    ...    msg=❌ Expected maxDailyUses to be 2, but got '${pass}[maxDailyUses]'

    Should Be Equal As Numbers    ${pass}[used]    1
    ...    msg=❌ Expected used to be 1, but got '${pass}[used]'

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True, but got '${pass}[allRoutes]'

    Should Be Equal As Strings    ${pass}[allLots]    False
    ...    msg=❌ Expected allLots to be False, but got '${pass}[allLots]'

    Should Be Equal As Numbers    ${pass}[remainingDailyUses]    1
    ...    msg=❌ Expected remainingDailyUses to be 1, but got '${pass}[remainingDailyUses]'

Sync pass validation offline
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${STAGE_URL}/api/v2/pb/driver/validations/sync/${idSuperCommunity}
    ...    data={"validations":[{"assignedSeat":"3","communityId":"${idComunidad}","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNico}","reason":[],"remainingTickets":0,"routeId":"68488d2a4ff298af70023813","synced":false,"token":"","userId":"${user_id}","validated":true}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
        ${validations}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${response.json()}
    Status Should Be    200

    FOR    ${validation}    IN    @{validations}
    # Verifica que cada objeto no esté vacío
        Should Not Be Empty    ${validation}    Validations info is empty
    END

Get Pass Detail After validation (Offline)
    [Documentation]    Se verifica el descuento del pase luego de la validación offline, no deberían quedar usos

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v2/products/user/purchased/${passId}/passes/privateBus

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${accessTokenNico}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

# Tomar el primer pase
    ${pass}=    Set Variable    ${response.json()}

    Should Be Equal As Strings    ${pass}[name]    Automation Test Passes
    ...    msg=❌ Expected name to be 'Automation Test Passes', but got '${pass}[name]'

    Should Be Equal As Strings    ${pass}[description]    Automation Test Passes
    ...    msg=❌ Expected description to be 'Automation Test Passes', but got '${pass}[description]'

    Should Be Equal As Numbers    ${pass}[remaining]    0
    ...    msg=❌ Expected remaining to be 0, but got '${pass}[remaining]'

    Should Be Equal As Strings    ${pass}[unlimitedUses]    False
    ...    msg=❌ Expected unlimitedUses to be False, but got '${pass}[unlimitedUses]'

    Should Be Equal As Numbers    ${pass}[maxDailyUses]    2
    ...    msg=❌ Expected maxDailyUses to be 2, but got '${pass}[maxDailyUses]'

    Should Be Equal As Numbers    ${pass}[used]    2
    ...    msg=❌ Expected used to be 2, but got '${pass}[used]'

    Should Be Equal As Strings    ${pass}[allRoutes]    True
    ...    msg=❌ Expected allRoutes to be True, but got '${pass}[allRoutes]'

    Should Be Equal As Strings    ${pass}[allLots]    False
    ...    msg=❌ Expected allLots to be False, but got '${pass}[allLots]'

    Should Be Equal As Numbers    ${pass}[remainingDailyUses]    0
    ...    msg=❌ Expected remainingDailyUses to be 0, but got '${pass}[remainingDailyUses]'


Stop Post Leg Departure
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/stop
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":false,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
Delete Product from Admin
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/products/${product_id}?community=653fd601f90509541a748683
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    ${product}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${product}[active]    False
...    msg=❌ Expected product to be inactive (False), but got '${product}[active]'

