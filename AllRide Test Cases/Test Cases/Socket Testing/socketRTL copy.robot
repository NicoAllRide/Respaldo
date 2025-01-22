*** Settings ***
Library     WebSocketClient
Library     BuiltIn
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../Variables/variablesStage.robot


*** Variables ***
# ------------------------DEBE SER DEPARTURE TOKEN, NO RTL-----------------------------------------#
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
${STAGE_URL}        https://stage.allrideapp.com


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

1 hours local
    ${date}=    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}=    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}=    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}=    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}

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

# ------------------------Crear nueva ruta calendarizada alertas y reemplazar Create new service in the selected route----------------------------------##

Create new service in the selected route
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable
    ...    {"_id":"67097560bbc506c3081aee9a","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyUnboardedPassengers":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"${schedule_day}","time":"${formatted_one_hour_later}","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[{"_id":"675b40d5a8381d41ce571bbd","stopId":"66a01968b5b91a562aacb535","scheduledDate":null},{"_id":"675b40d5a8381d41ce571bbe","stopId":"655d11d88a5a1a1ff0328466","scheduledDate":null},{"_id":"675b40d5a8381d41ce571bbf","stopId":"655d11d88a5a1a1ff0328464","scheduledDate":null}],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":true,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"rating":{"enabled":false,"withValidation":false},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["67097560bbc506c3081aee9a"],"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"codeValidationOptions":{"enabled":false,"type":"qr","failureMessage":"El código QR ingresado no es válido."},"assistantIds":[],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["653fd601f90509541a748683"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":true,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":true,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":true,"hasUnboardings":true,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"assistantAssignsSeat":true,"name":"Ruta Alertas Automatización","shapeId":"65ef21aa6f1c17c2eeeb5f98","description":"Ruta Alertas Automatización","extraInfo":"","color":"6b3535","legOptions":[],"useServiceReservations":false,"ownerIds":[{"_id":"67097560bbc506c3081aee9f","id":"653fd601f90509541a748683","role":"community"}],"segments":[{"_id":"67097d55d25fc2c30d71e142","position":1,"distance":66.45425502654004,"lat":-33.390440000000005,"lon":-70.54458000000001,"loc":[-70.54458000000001,-33.390440000000005]},{"_id":"67097d55d25fc2c30d71e143","position":2,"distance":179.17495142181278,"lat":-33.391400000000004,"lon":-70.54419,"loc":[-70.54419,-33.391400000000004]},{"_id":"67097d55d25fc2c30d71e144","position":3,"distance":235.9456040215147,"lat":-33.3918,"lon":-70.54381000000001,"loc":[-70.54381000000001,-33.3918]},{"_id":"67097d55d25fc2c30d71e145","position":4,"distance":318.85344448130417,"lat":-33.392320000000005,"lon":-70.54317,"loc":[-70.54317,-33.392320000000005]},{"_id":"67097d55d25fc2c30d71e146","position":5,"distance":318.85344448130417,"lat":-33.392320000000005,"lon":-70.54317,"loc":[-70.54317,-33.392320000000005]},{"_id":"67097d55d25fc2c30d71e147","position":6,"distance":374.60549726913854,"lat":-33.39267,"lon":-70.54360000000001,"loc":[-70.54360000000001,-33.39267]},{"_id":"67097d55d25fc2c30d71e148","position":7,"distance":442.5520402206282,"lat":-33.393100000000004,"lon":-70.54412,"loc":[-70.54412,-33.393100000000004]},{"_id":"67097d55d25fc2c30d71e149","position":8,"distance":485.31400862345225,"lat":-33.393350000000005,"lon":-70.54447,"loc":[-70.54447,-33.393350000000005]},{"_id":"67097d55d25fc2c30d71e14a","position":9,"distance":611.6057705932019,"lat":-33.39412,"lon":-70.54547000000001,"loc":[-70.54547000000001,-33.39412]},{"_id":"67097d55d25fc2c30d71e14b","position":10,"distance":664.3460425164694,"lat":-33.394360000000006,"lon":-70.54596000000001,"loc":[-70.54596000000001,-33.394360000000006]},{"_id":"67097d55d25fc2c30d71e14c","position":11,"distance":716.3069136909899,"lat":-33.39457,"lon":-70.54646000000001,"loc":[-70.54646000000001,-33.39457]},{"_id":"67097d55d25fc2c30d71e14d","position":12,"distance":751.8700838415805,"lat":-33.3947,"lon":-70.54681000000001,"loc":[-70.54681000000001,-33.3947]},{"_id":"67097d55d25fc2c30d71e14e","position":13,"distance":857.2890337131593,"lat":-33.39504,"lon":-70.54787,"loc":[-70.54787,-33.39504]},{"_id":"67097d55d25fc2c30d71e14f","position":14,"distance":897.1377826292556,"lat":-33.39517,"lon":-70.54827,"loc":[-70.54827,-33.39517]},{"_id":"67097d55d25fc2c30d71e150","position":15,"distance":951.822808519634,"lat":-33.395430000000005,"lon":-70.54877,"loc":[-70.54877,-33.395430000000005]},{"_id":"67097d55d25fc2c30d71e151","position":16,"distance":1022.6529342172724,"lat":-33.395880000000005,"lon":-70.54931,"loc":[-70.54931,-33.395880000000005]},{"_id":"67097d55d25fc2c30d71e152","position":17,"distance":1229.509223602494,"lat":-33.397360000000006,"lon":-70.55066000000001,"loc":[-70.55066000000001,-33.397360000000006]},{"_id":"67097d55d25fc2c30d71e153","position":18,"distance":1354.0558610873222,"lat":-33.39824,"lon":-70.55149,"loc":[-70.55149,-33.39824]},{"_id":"67097d55d25fc2c30d71e154","position":19,"distance":1383.3196977172574,"lat":-33.398450000000004,"lon":-70.55168,"loc":[-70.55168,-33.398450000000004]},{"_id":"67097d55d25fc2c30d71e155","position":20,"distance":1434.296524372645,"lat":-33.398810000000005,"lon":-70.55202,"loc":[-70.55202,-33.398810000000005]},{"_id":"67097d55d25fc2c30d71e156","position":21,"distance":1478.6114178506768,"lat":-33.39912,"lon":-70.55232000000001,"loc":[-70.55232000000001,-33.39912]},{"_id":"67097d55d25fc2c30d71e157","position":22,"distance":1518.005826479858,"lat":-33.3994,"lon":-70.55258,"loc":[-70.55258,-33.3994]},{"_id":"67097d55d25fc2c30d71e158","position":23,"distance":1553.6309120009466,"lat":-33.39965,"lon":-70.55282000000001,"loc":[-70.55282000000001,-33.39965]},{"_id":"67097d55d25fc2c30d71e159","position":24,"distance":1593.7733129182643,"lat":-33.399910000000006,"lon":-70.55312,"loc":[-70.55312,-33.399910000000006]},{"_id":"67097d55d25fc2c30d71e15a","position":25,"distance":1632.9764404383623,"lat":-33.400130000000004,"lon":-70.55345000000001,"loc":[-70.55345000000001,-33.400130000000004]},{"_id":"67097d55d25fc2c30d71e15b","position":26,"distance":1738.474896696409,"lat":-33.40072,"lon":-70.55434000000001,"loc":[-70.55434000000001,-33.40072]},{"_id":"67097d55d25fc2c30d71e15c","position":27,"distance":1777.673033164621,"lat":-33.40095,"lon":-70.55466000000001,"loc":[-70.55466000000001,-33.40095]},{"_id":"67097d55d25fc2c30d71e15d","position":28,"distance":1809.815798065564,"lat":-33.40115,"lon":-70.55491,"loc":[-70.55491,-33.40115]},{"_id":"67097d55d25fc2c30d71e15e","position":29,"distance":1832.7774542089473,"lat":-33.401300000000006,"lon":-70.55508,"loc":[-70.55508,-33.401300000000006]},{"_id":"67097d55d25fc2c30d71e15f","position":30,"distance":1857.7014654130626,"lat":-33.40148,"lon":-70.55524000000001,"loc":[-70.55524000000001,-33.40148]},{"_id":"67097d55d25fc2c30d71e160","position":31,"distance":1871.0728377502157,"lat":-33.40158,"lon":-70.55532000000001,"loc":[-70.55532000000001,-33.40158]},{"_id":"67097d55d25fc2c30d71e161","position":32,"distance":1892.570690737771,"lat":-33.401740000000004,"lon":-70.55545000000001,"loc":[-70.55545000000001,-33.401740000000004]},{"_id":"67097d55d25fc2c30d71e162","position":33,"distance":1924.088458822758,"lat":-33.401990000000005,"lon":-70.55561,"loc":[-70.55561,-33.401990000000005]},{"_id":"67097d55d25fc2c30d71e163","position":34,"distance":2015.6657188701308,"lat":-33.40276,"lon":-70.55596,"loc":[-70.55596,-33.40276]},{"_id":"67097d55d25fc2c30d71e164","position":35,"distance":2141.705125880503,"lat":-33.403800000000004,"lon":-70.5565,"loc":[-70.5565,-33.403800000000004]},{"_id":"67097d55d25fc2c30d71e165","position":36,"distance":2172.708505453443,"lat":-33.40404,"lon":-70.55667000000001,"loc":[-70.55667000000001,-33.40404]},{"_id":"67097d55d25fc2c30d71e166","position":37,"distance":2205.7566919711007,"lat":-33.40428,"lon":-70.55688,"loc":[-70.55688,-33.40428]},{"_id":"67097d55d25fc2c30d71e167","position":38,"distance":2228.7179574025554,"lat":-33.404430000000005,"lon":-70.55705,"loc":[-70.55705,-33.404430000000005]},{"_id":"67097d55d25fc2c30d71e168","position":39,"distance":2252.32679482021,"lat":-33.40458,"lon":-70.55723,"loc":[-70.55723,-33.40458]},{"_id":"67097d55d25fc2c30d71e169","position":40,"distance":2283.823954970235,"lat":-33.404740000000004,"lon":-70.55751000000001,"loc":[-70.55751000000001,-33.404740000000004]},{"_id":"67097d55d25fc2c30d71e16a","position":41,"distance":2512.043834208049,"lat":-33.405910000000006,"lon":-70.55953000000001,"loc":[-70.55953000000001,-33.405910000000006]},{"_id":"67097d55d25fc2c30d71e16b","position":42,"distance":2619.996108284224,"lat":-33.406470000000006,"lon":-70.56048000000001,"loc":[-70.56048000000001,-33.406470000000006]},{"_id":"67097d55d25fc2c30d71e16c","position":43,"distance":2710.1663923589767,"lat":-33.40693,"lon":-70.56128000000001,"loc":[-70.56128000000001,-33.40693]},{"_id":"67097d55d25fc2c30d71e16d","position":44,"distance":2764.846086069969,"lat":-33.40719,"lon":-70.56178,"loc":[-70.56178,-33.40719]},{"_id":"67097d55d25fc2c30d71e16e","position":45,"distance":2819.788785929294,"lat":-33.407410000000006,"lon":-70.56231000000001,"loc":[-70.56231000000001,-33.407410000000006]},{"_id":"67097d55d25fc2c30d71e16f","position":46,"distance":2868.6277794857247,"lat":-33.40757,"lon":-70.56280000000001,"loc":[-70.56280000000001,-33.40757]},{"_id":"67097d55d25fc2c30d71e170","position":47,"distance":2868.6277794857247,"lat":-33.40757,"lon":-70.56280000000001,"loc":[-70.56280000000001,-33.40757]},{"_id":"67097d55d25fc2c30d71e171","position":48,"distance":3016.7988425090143,"lat":-33.40795,"lon":-70.56433000000001,"loc":[-70.56433000000001,-33.40795]},{"_id":"67097d55d25fc2c30d71e172","position":49,"distance":3169.165977467541,"lat":-33.408350000000006,"lon":-70.5659,"loc":[-70.5659,-33.408350000000006]},{"_id":"67097d55d25fc2c30d71e173","position":50,"distance":3190.330111639743,"lat":-33.4084,"lon":-70.56612000000001,"loc":[-70.56612000000001,-33.4084]},{"_id":"67097d55d25fc2c30d71e174","position":51,"distance":3289.654392322431,"lat":-33.40867,"lon":-70.56714000000001,"loc":[-70.56714000000001,-33.40867]},{"_id":"67097d55d25fc2c30d71e175","position":52,"distance":3431.0592983190954,"lat":-33.409060000000004,"lon":-70.56859,"loc":[-70.56859,-33.409060000000004]},{"_id":"67097d55d25fc2c30d71e176","position":53,"distance":3431.0592983190954,"lat":-33.409060000000004,"lon":-70.56859,"loc":[-70.56859,-33.409060000000004]},{"_id":"67097d55d25fc2c30d71e177","position":54,"distance":3470.220064994875,"lat":-33.40872,"lon":-70.5687,"loc":[-70.5687,-33.40872]},{"_id":"67097d55d25fc2c30d71e178","position":55,"distance":3490.7661920072,"lat":-33.40854,"lon":-70.56875000000001,"loc":[-70.56875000000001,-33.40854]},{"_id":"67097d55d25fc2c30d71e179","position":56,"distance":3515.8550322572555,"lat":-33.40832,"lon":-70.56881,"loc":[-70.56881,-33.40832]},{"_id":"67097d55d25fc2c30d71e17a","position":57,"distance":3530.5761464723378,"lat":-33.408190000000005,"lon":-70.56884000000001,"loc":[-70.56884000000001,-33.408190000000005]},{"_id":"67097d55d25fc2c30d71e17b","position":58,"distance":3543.9195376701027,"lat":-33.40807,"lon":-70.56884000000001,"loc":[-70.56884000000001,-33.40807]},{"_id":"67097d55d25fc2c30d71e17c","position":59,"distance":3564.6950337911794,"lat":-33.40789,"lon":-70.56878,"loc":[-70.56878,-33.40789]},{"_id":"67097d55d25fc2c30d71e17d","position":60,"distance":3564.6950337911794,"lat":-33.40789,"lon":-70.56878,"loc":[-70.56878,-33.40789]},{"_id":"67097d55d25fc2c30d71e17e","position":61,"distance":3594.5041291217894,"lat":-33.40796,"lon":-70.56847,"loc":[-70.56847,-33.40796]},{"_id":"67097d55d25fc2c30d71e17f","position":62,"distance":3654.1222526321085,"lat":-33.408100000000005,"lon":-70.56785,"loc":[-70.56785,-33.408100000000005]},{"_id":"67097d55d25fc2c30d71e180","position":63,"distance":3678.8881425063832,"lat":-33.408150000000006,"lon":-70.56759000000001,"loc":[-70.56759000000001,-33.408150000000006]},{"_id":"67097d55d25fc2c30d71e181","position":64,"distance":3678.8881425063832,"lat":-33.408150000000006,"lon":-70.56759000000001,"loc":[-70.56759000000001,-33.408150000000006]},{"_id":"67097d55d25fc2c30d71e182","position":65,"distance":3761.8730737532887,"lat":-33.40885,"lon":-70.56728000000001,"loc":[-70.56728000000001,-33.40885]},{"_id":"67097d55d25fc2c30d71e183","position":66,"distance":3817.5303551295883,"lat":-33.409330000000004,"lon":-70.56711,"loc":[-70.56711,-33.409330000000004]},{"_id":"67097d55d25fc2c30d71e184","position":67,"distance":3817.5303551295883,"lat":-33.409330000000004,"lon":-70.56711,"loc":[-70.56711,-33.409330000000004]}],"roundOrder":[{"stopId":"66a01968b5b91a562aacb535","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328466","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328464","notifyIfPassed":false}],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"653fd601f90509541a748683","timeOnRoute":11,"distance":4,"distanceInMeters":3840,"originStop":"66a01968b5b91a562aacb535","destinationStop":"655d11d88a5a1a1ff0328464","customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-10-11T18:58:40.731Z","updatedAt":"2024-12-12T20:00:21.340Z","__v":39,"hasBarrier":false,"minimumTimeToForceDeparture":{"amount":5,"enabled":false,"unit":"minutes"},"DNIValidation":{"enabled":false},"routeCost":0,"ticketCost":0,"routeDeviation":{"maxDistance":100,"maxTime":1,"enabled":true}}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Put On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/routes/67097560bbc506c3081aee9a?community=653fd601f90509541a748683
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
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/createServices/${idComunidad}?community=${idComunidad}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    Sleep    2s

Get Today Service Id
    [Tags]    test:retry(1)

    # Define la URL del recurso que requiere autenticación para la semana 1
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad}&startDate=${start_date_today}&endDate=${end_date_tomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

# Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${filtered_services}=    Evaluate
    ...    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '67097560bbc506c3081aee9a']
    ...    json

# Ordenamos los servicios filtrados por la fecha de creación en orden descendente
    ${sorted_services}=    Evaluate
    ...    sorted(${filtered_services}, key=lambda service: service['createdAt'], reverse=True)
    ...    json

# Verificamos que se encuentre exactamente un servicio para la semana 1
    IF    ${sorted_services} == []
        Fatal Error    "No services found in Week 1 with routeId._id = '66f310608e6c377a3f43968e'. Stopping test"
    END

    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id}=    Set Variable    ${service['_id']}

    Set Global Variable    ${service_id}

Resource Assignment(Driver and Vehicle)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id}?community=${idComunidad}
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId}"},"drivers":[],"vehicle":{"vehicleId":"${vehicleId}","capacity":"${vehicleCapacity}"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

Get departureId
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${departureId}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    Set Global Variable    ${departureId}

    Log    ${departureId}

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
    ...    ${seatReservation}
    ...    data={"serviceId":"${service_id}","departureId":"${departureId}","stopId":"655d11d88a5a1a1ff0328464","seat":"2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200    Seat reservation not working statusCode ${code}
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
    ...    data={"departureId":"${departureId}","communityId":"${idComunidad}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${scheduleId}","capacity":2,"busCode":"1111","driverCode":"159753","vehicleId":"666941a7b8d6ea30f9281110","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    Set Global Variable    ${access_token}
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Log    ${departureToken}
    Log    ${code}
    Set Global Variable    ${departureToken}

Connect And Emit Events
    [Documentation]    Test connecting to WebSocket and sending events
    ${URL_with_token}=    Set variable
    ...    wss://stage.allrideapp.com/socket.io/?token=${access_token}&EIO=3&transport=websocket
    ${my_websocket}=    Connect    ${URL_with_token}
    Log    Connected to WebSocket

    Send    ${my_websocket}    40/pbDriver?token=${access_token}
    Log    Sent: 40/pbDriver?token=${access_token}
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar evento join
    Send    ${my_websocket}    42/pbDriver,["join"]
    Log    Sent: 42/pbDriver,["join"]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar pings periódicos

    # Enviar evento start con latitud y longitud fijos
    Send    ${my_websocket}    42/pbDriver,["start", {"latitude": ${LATITUDE}, "longitude": ${LONGITUDE}}]
    Log    Sent: 42/pbDriver,["start", {"latitude": ${LATITUDE}, "longitude": ${LONGITUDE}}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

    # Enviar evento newPosition con nuevas coordenadas y otros datos

    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40824331065313,"longitude":-70.56498737648734,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.40876276266083,"longitude":-70.56705804166151,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.41004346727125,"longitude":-70.56785197544258,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.4099628640414,"longitude":-70.56801290796575,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}
    Send
    ...    ${my_websocket}
    ...    42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.409855392954086,"longitude":-70.57117791476863,"speed":3.9972}]
    Log
    ...    Sent: 42/pbDriver,["newPosition",{"full":false,"panicking":false,"capacity":0,"latitude":-33.3908833,"longitude":-70.54620129999999,"speed":3.9972}]
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

   # Send
    ###  Log
  #  ...    Sent: 42/pbDriver,["stop",{}]
   # Sleep    5s
   # ${result}=    Recv Data    ${my_websocket}
   # Log    Received: ${result}
   # ${result}=    Recv Data    ${my_websocket}
   # Log    Received: ${result}
   # ${result}=    Recv Data    ${my_websocket}
   # Log    Received: ${result}

##### GENERAR COORDENADAS DEL TRAZADO PARA SIMULAR UNA RUTA ALTERNA Y ENTRAR A LA SIGUIENTE PARADA

Get User QR(No tickets user)

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["661d508c72418a2e98cf7978"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNoTickets}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNoTickets}
    Log    ${qrCodeNoTickets}
    Log    ${code}

Validation QR Without Tickets
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/validate
    ...    data={"communityId":"${idComunidad}","validationString":"${qrCodeNoTickets}","timezone":"Chile/Continental","validationLat":-33.40975694626073,"validationLon":-70.56736916087651}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    5s
    # Enviar más pings periódico

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

    Sleep    10s
