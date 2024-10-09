*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../Variables/variablesStage.robot





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
    ${start_date_tickets}=     Set Variable     ${fecha_hoy}T04:00:00.000Z
        Set Global Variable    ${start_date_tickets}
    ${end_date_tickets}=     Set Variable     ${fecha_manana}T03:59:59.999Z
        Set Global Variable    ${end_date_tickets}
    ${fecha_4weekslater}=    Add Time To Date    ${fecha_hoy}    28 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_4weekslater}

    ##Fecha proxima semana
    
    ${fecha_1weeklater}=    Add Time To Date    ${start_date_today}    7 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_1weeklater}

    ${fecha_1weeklaterTomorrow}=    Add Time To Date    ${end_date_tomorrow}    7 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_1weeklaterTomorrow}

    ##Fecha dos semanas después
    
    ${fecha_2weeklater}=    Add Time To Date    ${start_date_today}     14 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_2weeklater}

    ${fecha_2weeklaterTomorrow}=    Add Time To Date    ${end_date_tomorrow}    14 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_2weeklaterTomorrow}

    ## Fecha 3 semans despues
    ${fecha_3weeklater}=    Add Time To Date    ${start_date_today}     21 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_3weeklater}

    ${fecha_3weeklaterTomorrow}=    Add Time To Date    ${end_date_tomorrow}    21 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_3weeklaterTomorrow}






### Crear una ruta calendarizada con reserva por defecto sin Recursos por defecto
#Verificar en 4 semanas más que haya un servicio con el id de la ruta, verificar de la misma forma el último que se creó y que estas rutas tienen la reserva
#Asignar Recursos a un servicio y asignar la reseerva a un recurso
#Hacer una reserva aparte en este servicio
#Eliminar la reserva por defecto, debería borrarse en todos los servicios calendarizados de 4 semanas más, menos la que se hizo una reserva

###Crear una ruta calendarizada con reservas por defecto con recursos por defecto


#----------------Mensajería a miembros de la comunidad--------------------------#

App Messaging to Community Members
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/appMessaging/send/?community=6654ae4eba54fe502d4e4187
    ...    data={"pushNotification":{"title":"Notificación Push Test RF","content":"Notificación Push Test RF"},"fullMessage":{"title":"Notificación Push Test RF","content":"Notificación Push Test RF","image":"","externalURL":"","cta":"pb_reservations","buttonText":"¡Vamos!"},"destinataries":"communityMembers"}
    ...    headers=${headers}
    # Verifica el código de estado esperado 2222
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200        No se pueden enviar mensajes a la comunidad
    Log    ${code}

App Messaging to Parameters (Color azul)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/appMessaging/send/?community=6654ae4eba54fe502d4e4187
    ...    data={"pushNotification":{"title":"Notificación para parámetro azul","content":"Azul"},"fullMessage":{"title":"Notificación para parámetro azul","content":"AZUUUL","image":"","externalURL":"","cta":"","buttonText":""},"destinataries":"customParams","customParams":[{"key":"Color","value":"Azul","multi":false}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado 2222
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200        No se pueden enviar mensajes a la comunidad
    Log    ${code}


Modify Route (Reservation Allow to User Only)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=api/v1/admin/pb/routes/66cc94821125fb1232f990a1?community=6654ae4eba54fe502d4e4187
    ...    data={"_id":"66cc94821125fb1232f990a1","trail":{"enabled":true,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyUnboardedPassengers":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifySkippedStop":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"mon","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":0},{"enabled":true,"day":"tue","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":1},{"enabled":true,"day":"wed","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":2},{"enabled":true,"day":"thu","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":3},{"enabled":true,"day":"fri","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":4},{"enabled":true,"day":"sat","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":5},{"enabled":true,"day":"sun","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":6}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":true,"allowed":["66cc94821125fb1232f990a1"],"visibility":{"enabled":false,"excludes":true,"parameters":[{"key":"Color","values":["Azul"]}]},"reservation":{"enabled":true,"excludes":false,"parameters":[{"key":"Color","values":["Azul"]}]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"assistantIds":[],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":true,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":false,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"name":"Ruta Restricciones RF","shapeId":"6654d532713b9a5184cfe2e3","description":"Probar distintos casos de restricciones de manera automatizada","extraInfo":"","color":"712a2a","legOptions":[],"ownerIds":[{"_id":"66cc94821125fb1232f990a5","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[{"_id":"66ccd5c21125fb1232f9a968","position":1,"distance":290.2660419534011,"lat":-34.408530000000006,"lon":-70.85308,"loc":[-70.85308,-34.408530000000006]},{"_id":"66ccd5c21125fb1232f9a969","position":2,"distance":488.1040403831149,"lat":-34.40699,"lon":-70.852,"loc":[-70.852,-34.40699]},{"_id":"66ccd5c21125fb1232f9a96a","position":3,"distance":781.9113593811135,"lat":-34.40496,"lon":-70.84995,"loc":[-70.84995,-34.40496]},{"_id":"66ccd5c21125fb1232f9a96b","position":4,"distance":1104.6940260856932,"lat":-34.40296,"lon":-70.84740000000001,"loc":[-70.84740000000001,-34.40296]},{"_id":"66ccd5c21125fb1232f9a96c","position":5,"distance":1122.8597601245997,"lat":-34.402800000000006,"lon":-70.84736000000001,"loc":[-70.84736000000001,-34.402800000000006]},{"_id":"66ccd5c21125fb1232f9a96d","position":6,"distance":1292.2891375798047,"lat":-34.40267,"lon":-70.84552000000001,"loc":[-70.84552000000001,-34.40267]},{"_id":"66ccd5c21125fb1232f9a96e","position":7,"distance":1459.1985795046444,"lat":-34.40229,"lon":-70.84376,"loc":[-70.84376,-34.40229]},{"_id":"66ccd5c21125fb1232f9a96f","position":8,"distance":1583.0555768914546,"lat":-34.40229,"lon":-70.84241,"loc":[-70.84241,-34.40229]},{"_id":"66ccd5c21125fb1232f9a970","position":9,"distance":2238.7794491503846,"lat":-34.40344,"lon":-70.8354,"loc":[-70.8354,-34.40344]},{"_id":"66ccd5c21125fb1232f9a971","position":10,"distance":2367.730135581892,"lat":-34.40379,"lon":-70.83406000000001,"loc":[-70.83406000000001,-34.40379]},{"_id":"66ccd5c21125fb1232f9a972","position":11,"distance":2813.2702156190876,"lat":-34.40545,"lon":-70.82964000000001,"loc":[-70.82964000000001,-34.40545]},{"_id":"66ccd5c21125fb1232f9a973","position":12,"distance":2907.937653439918,"lat":-34.405660000000005,"lon":-70.82864000000001,"loc":[-70.82864000000001,-34.405660000000005]},{"_id":"66ccd5c21125fb1232f9a974","position":13,"distance":3103.8542952895764,"lat":-34.40598,"lon":-70.82654000000001,"loc":[-70.82654000000001,-34.40598]},{"_id":"66ccd5c21125fb1232f9a975","position":14,"distance":3399.7333701489256,"lat":-34.406130000000005,"lon":-70.82332000000001,"loc":[-70.82332000000001,-34.406130000000005]},{"_id":"66ccd5c21125fb1232f9a976","position":15,"distance":3777.3304160935245,"lat":-34.40782,"lon":-70.81975,"loc":[-70.81975,-34.40782]},{"_id":"66ccd5c21125fb1232f9a977","position":16,"distance":4027.852872329667,"lat":-34.409060000000004,"lon":-70.81747,"loc":[-70.81747,-34.409060000000004]},{"_id":"66ccd5c21125fb1232f9a978","position":17,"distance":4262.946941118368,"lat":-34.40968,"lon":-70.81502,"loc":[-70.81502,-34.40968]},{"_id":"66ccd5c21125fb1232f9a979","position":18,"distance":4331.54548643874,"lat":-34.40997,"lon":-70.81436000000001,"loc":[-70.81436000000001,-34.40997]},{"_id":"66ccd5c21125fb1232f9a97a","position":19,"distance":4470.011462521272,"lat":-34.41068,"lon":-70.81312000000001,"loc":[-70.81312000000001,-34.41068]},{"_id":"66ccd5c21125fb1232f9a97b","position":20,"distance":4569.730370049159,"lat":-34.41037,"lon":-70.8121,"loc":[-70.8121,-34.41037]},{"_id":"66ccd5c21125fb1232f9a97c","position":21,"distance":4885.998380967774,"lat":-34.40916,"lon":-70.80898,"loc":[-70.80898,-34.40916]},{"_id":"66ccd5c21125fb1232f9a97d","position":22,"distance":5117.696468148955,"lat":-34.40769,"lon":-70.80719,"loc":[-70.80719,-34.40769]},{"_id":"66ccd5c21125fb1232f9a97e","position":23,"distance":5264.734491572538,"lat":-34.406670000000005,"lon":-70.80617000000001,"loc":[-70.80617000000001,-34.406670000000005]},{"_id":"66ccd5c21125fb1232f9a97f","position":24,"distance":5425.207136314769,"lat":-34.405620000000006,"lon":-70.80497000000001,"loc":[-70.80497000000001,-34.405620000000006]},{"_id":"66ccd5c21125fb1232f9a980","position":25,"distance":5509.906626643151,"lat":-34.40527,"lon":-70.80415,"loc":[-70.80415,-34.40527]},{"_id":"66ccd5c21125fb1232f9a981","position":26,"distance":5600.221898860165,"lat":-34.40466,"lon":-70.8035,"loc":[-70.8035,-34.40466]},{"_id":"66ccd5c21125fb1232f9a982","position":27,"distance":5755.68153334114,"lat":-34.404250000000005,"lon":-70.80188000000001,"loc":[-70.80188000000001,-34.404250000000005]},{"_id":"66ccd5c21125fb1232f9a983","position":28,"distance":5915.319583664183,"lat":-34.40424,"lon":-70.80014,"loc":[-70.80014,-34.40424]},{"_id":"66ccd5c21125fb1232f9a984","position":29,"distance":6007.047842778099,"lat":-34.40404,"lon":-70.79917,"loc":[-70.79917,-34.40404]},{"_id":"66ccd5c21125fb1232f9a985","position":30,"distance":6182.3341417231395,"lat":-34.40551,"lon":-70.79848000000001,"loc":[-70.79848000000001,-34.40551]},{"_id":"66ccd5c21125fb1232f9a986","position":31,"distance":6367.330377715924,"lat":-34.40664,"lon":-70.79700000000001,"loc":[-70.79700000000001,-34.40664]},{"_id":"66ccd5c21125fb1232f9a987","position":32,"distance":6527.46821540092,"lat":-34.407920000000004,"lon":-70.7962,"loc":[-70.7962,-34.407920000000004]},{"_id":"66ccd5c21125fb1232f9a988","position":33,"distance":7287.353626388585,"lat":-34.404030000000006,"lon":-70.78939000000001,"loc":[-70.78939000000001,-34.404030000000006]},{"_id":"66ccd5c21125fb1232f9a989","position":34,"distance":7845.43322025191,"lat":-34.40109,"lon":-70.78446000000001,"loc":[-70.78446000000001,-34.40109]},{"_id":"66ccd5c21125fb1232f9a98a","position":35,"distance":7882.902565797689,"lat":-34.40119,"lon":-70.78407,"loc":[-70.78407,-34.40119]},{"_id":"66ccd5c21125fb1232f9a98b","position":36,"distance":8083.244366156947,"lat":-34.40008,"lon":-70.78235000000001,"loc":[-70.78235000000001,-34.40008]},{"_id":"66ccd5c21125fb1232f9a98c","position":37,"distance":8151.255642391474,"lat":-34.399550000000005,"lon":-70.78272000000001,"loc":[-70.78272000000001,-34.399550000000005]},{"_id":"66ccd5c21125fb1232f9a98d","position":38,"distance":8242.744317444498,"lat":-34.39882,"lon":-70.78226000000001,"loc":[-70.78226000000001,-34.39882]},{"_id":"66ccd5c21125fb1232f9a98e","position":39,"distance":8448.184416414158,"lat":-34.397040000000004,"lon":-70.78166,"loc":[-70.78166,-34.397040000000004]},{"_id":"66ccd5c21125fb1232f9a98f","position":40,"distance":8467.636269238845,"lat":-34.39687,"lon":-70.78171,"loc":[-70.78171,-34.39687]},{"_id":"66ccd5c21125fb1232f9a990","position":41,"distance":8609.810198718747,"lat":-34.39578,"lon":-70.78252,"loc":[-70.78252,-34.39578]},{"_id":"66ccd5c21125fb1232f9a991","position":42,"distance":8702.762775926865,"lat":-34.395430000000005,"lon":-70.78160000000001,"loc":[-70.78160000000001,-34.395430000000005]},{"_id":"66ccd5c21125fb1232f9a992","position":43,"distance":8729.30555711264,"lat":-34.395250000000004,"lon":-70.78141000000001,"loc":[-70.78141000000001,-34.395250000000004]},{"_id":"66ccd5c21125fb1232f9a993","position":44,"distance":8771.583165938728,"lat":-34.3949,"lon":-70.78123000000001,"loc":[-70.78123000000001,-34.3949]}],"roundOrder":[],"communityId":"6654ae4eba54fe502d4e4187","timeOnRoute":14,"distance":9,"distanceInMeters":8784,"originStop":"6654d4acba54fe502d4e6b6b","destinationStop":"6654d4c8713b9a5184cfe1df","customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-08-26T14:43:15.040Z","updatedAt":"2024-08-27T13:21:29.326Z","__v":18,"superCommunityId":"653fd68233d83952fafcd4be","routeCost":0,"ticketCost":0}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Login User With Email(Color Azul)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+comunidad2@allrideapp.com","password":"Lolowerty21@"}
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

Login User 2 (Sin color)
    

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+usuario2comunidad2@allrideapp.com","password":"Lolowerty21@"}
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
    ${accessTokenUser2}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenUser2}