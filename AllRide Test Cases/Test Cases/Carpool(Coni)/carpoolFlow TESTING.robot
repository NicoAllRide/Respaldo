*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Library     RPA.Smartsheet
Resource    ../Variables/variablesStage.robot
Library     WebSocketClient


*** Variables ***
${WS_BASE}        wss://testing.allrideapp.com/socket.io/?EIO=3&transport=websocket
${driverIdCarpool}    6495d7764dee6f101ab5ca80
${USER_ID}        ${driverIdCarpool}
${userIdCarpool}    68d2ce6d93cefc68ac24064d
${USER_ID2}        ${userIdCarpool}
${accessTokenCarpool1}        6c40feab1f76212fec4c8e3d634c2c77883c53b129effba64dedae0d3652c2f7c24cff17020fdff0f6bca110b9e3f11b102d5e46b712b98a3fb6a00268440a13
${accessTokenCarpool2}        1457358978f78b8afe7428e0422ce27380fd16d5b3b19cdb4f24984a7dd74491687d3e7eb18d9e9b15046f087f784fe15941d2df8236e69356f2e7f0bead98af
${realTimeToken}            a8ddb9426d3a542315a3f88b1cdf45c3245b8c224fe7864003ae2257291d30427582082b2140c7a72e8a2902e10bd7de83e3af220ca72534d9f487806b0a2031
${realTimeTokenUser}        203f4f6271cee18643a1fb4d24019f16c26898884ad176faba53f64c6b9ea85df4b8ba81a9b9fca1fc5671ebe57b56f615a2b81945eb70aa13f960b1fb9219b1



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
    ${date}=    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}=    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}=    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}=    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}



## Vista Principal Carpoo

Create recurrent route as driver (user1)
    [Documentation]  Crear una ruta recurrente como conductor(usuario 1)
    Create Session    mysesion    ${TESTING_URL}    verify=true
 
    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/trips/
    ...    data={"allowsSectionCost":false,"aproxWaypoints":{"coordinates":[[-70.85381,-34.41107],[-70.85367,-34.41072],[-70.8535,-34.41007],[-70.85308,-34.40853],[-70.85251,-34.4076],[-70.85206,-34.40705],[-70.85159,-34.40653],[-70.85126,-34.4062],[-70.85087,-34.40583],[-70.85045,-34.40546],[-70.85003,-34.40502],[-70.84913,-34.40427],[-70.84813,-34.40353],[-70.84789,-34.40336],[-70.84742,-34.40297],[-70.84739,-34.40294],[-70.84736,-34.40283],[-70.84736,-34.4028],[-70.84715,-34.40279],[-70.84644,-34.40275],[-70.84573,-34.40269],[-70.8454,-34.40264],[-70.84433,-34.40239],[-70.84376,-34.40229],[-70.84337,-34.40227],[-70.84272,-34.40227],[-70.84241,-34.40229],[-70.84184,-34.40239],[-70.84125,-34.4025],[-70.83714,-34.40315],[-70.83642,-34.40327],[-70.8354,-34.40344],[-70.83488,-34.40357],[-70.83406,-34.40379],[-70.83375,-34.4039],[-70.83302,-34.4042],[-70.83145,-34.40482],[-70.83095,-34.40499],[-70.8303,-34.40523],[-70.82964,-34.40545],[-70.8294,-34.40552],[-70.82864,-34.40566],[-70.82751,-34.40584],[-70.82674,-34.40595],[-70.82589,-34.40601],[-70.8242,-34.40606],[-70.82344,-34.4061],[-70.8232,-34.40616],[-70.82282,-34.40633],[-70.82265,-34.40642],[-70.82228,-34.40661],[-70.82046,-34.40749],[-70.81975,-34.40782],[-70.81846,-34.40853],[-70.8176,-34.409],[-70.81725,-34.40913],[-70.81608,-34.40943],[-70.81525,-34.40961],[-70.81484,-34.40975],[-70.81446,-34.40992],[-70.81407,-34.41013],[-70.81334,-34.41055],[-70.81312,-34.41068],[-70.81286,-34.41062],[-70.81253,-34.41052],[-70.8121,-34.41037],[-70.80991,-34.40956],[-70.80924,-34.4093],[-70.80898,-34.40916],[-70.80834,-34.40865],[-70.80719,-34.40769],[-70.80685,-34.40737],[-70.80617,-34.40667],[-70.80582,-34.40635],[-70.80503,-34.40567],[-70.80483,-34.40554],[-70.8044,-34.40537],[-70.80415,-34.40527],[-70.80403,-34.40516],[-70.80382,-34.40491],[-70.80369,-34.40478],[-70.80358,-34.4047],[-70.8035,-34.40466],[-70.80312,-34.40457],[-70.80267,-34.40449],[-70.80251,-34.40444],[-70.80206,-34.40428],[-70.80188,-34.40425],[-70.80164,-34.40424],[-70.80096,-34.40423],[-70.80057,-34.4042],[-70.80041,-34.40421],[-70.80014,-34.40424],[-70.79997,-34.40422],[-70.79917,-34.40404],[-70.79892,-34.40455],[-70.79848,-34.40551],[-70.7984,-34.40561],[-70.79822,-34.40577],[-70.79717,-34.40651],[-70.797,-34.40664],[-70.79688,-34.40679],[-70.79667,-34.40719],[-70.79651,-34.40748],[-70.7962,-34.40792],[-70.79594,-34.4078],[-70.79534,-34.40744],[-70.79477,-34.4071],[-70.79366,-34.40644],[-70.79082,-34.40485],[-70.78907,-34.40384],[-70.78692,-34.40257],[-70.78458,-34.40116],[-70.78446,-34.40109],[-70.78438,-34.40108],[-70.78428,-34.40113],[-70.78417,-34.4012],[-70.78407,-34.40119],[-70.78353,-34.4009],[-70.78304,-34.40056],[-70.7827,-34.40029],[-70.78251,-34.40016],[-70.78235,-34.40008],[-70.78271,-34.3996],[-70.78272,-34.39955],[-70.78254,-34.39927],[-70.78226,-34.39882],[-70.78216,-34.39857],[-70.78178,-34.39746],[-70.78166,-34.39704],[-70.78167,-34.39695],[-70.78207,-34.39635],[-70.78252,-34.39578],[-70.78226,-34.39571],[-70.78214,-34.39566],[-70.78236,-34.39534],[-70.78264,-34.39501],[-70.78255,-34.3948],[-70.78238,-34.39462]],"type":"LineString"},"codedRoute":"d|_qEhsmoLeA[aCa@sHsAyDqBmByAgBAaAaAiAmAiAsAwAsAuCsDsCgEa@o@mAAEEUEE?Ai@GmCKmCIaAq@uESqBCmA?aCB@RqBTuB`CuXVoC`@kEXgBj@cDT@z@qCzByH`@cBn@aCj@cCLo@ZwCb@aFTyCJiDHqIFwCJo@`@kAPa@d@iAnDkJ`AmClCaG|AkDXeAz@iFb@eDZqA`@kAh@mArAqCXk@Ks@SaA]uAaDuLs@eC[s@eB_C_EeF_AcAkCgC_AeAgCCYg@a@uASq@UWq@i@YYOUGOQkAOyAI_@_@yAEc@Ao@AgCEmA@_@Du@Ca@c@_DdBq@~DwARO^c@rCqEXa@WnAi@x@_@vA@Ws@gAwBcAqBcCEHwPiEIFmLyGsMMWAOHSLUASy@kBcAaBu@cAYe@O_@_BfAI@w@c@yAw@q@SEkAsAWQ@wBnAqBxAMs@IW_Aj@aAv@i@Qc@a@","comment":"","cost":0,"currency":"","destination":{"communityId":"","icon":"","location":[-70.7819,-34.3945],"longName":"Media luna cerrillos","placeId":"","reference":"","shortName":"Media Luna Cerrillos"},"dropoutPlaces":[],"fee":0,"filed":false,"followerShards":[],"followers":[],"followersData":[],"_id":"","tripInstances":[],"new":true,"origin":{"communityId":"","icon":"","location":[-70.85381,-34.41107],"longName":"Hospital Rengo","placeId":"","reference":"","shortName":"Hospital Rengo"},"pending":[],"pendingsData":[],"pickupPlaces":[],"recurrent":false,"restrictions":[{"_id":"","restrictionType":"public"}],"seats":4,"sectionCost":true,"startDate":"2025-09-24T00:14:00.000-03:00","studentFee":false,"timezone":"America/Santiago","tripDates":[{"day":"wednesday","_id":"","time":"2025-09-24T00:14:00.000-03:00"}],"userId":""}
    ...    headers=${headers}
    ${code}=    Convert To String    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200

    ${json}=    Set Variable    ${response.json()}
    ${tripId}=    Set Variable    ${json}[_id]
    Set Global Variable    ${tripId}

Get route just created(Driver) And TripInstances 2
        [Documentation]  Obtener la ruta recién creada y los tripInstances, corresponden a los días en los que se genera cada ruta

    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/tripinstances/for_trip/${tripId}
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200

    ${trips}=    Set Variable    ${response.json()}

    ${tripinstance1}=    Set Variable      ${trips}[0][_id]

    Set Global Variable    ${tripinstance1}

#Buscador de rutas


#Seguir ruta
Follow Route(User 2)
    [Documentation]  Seguir ruta recién encontrada como usuario

    Create Session    mysesion    ${TESTING_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool2}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/trips/follow/${tripId}
    ...    data={"pickupPointLat":-34.41107,"pickupPointLon":-70.85381,"pickupPointName":"Punto de inicio","dropoutPointLat":-33.4570,"dropoutPointLon":-70.6500,"dropoutPointName":"Punto de bajada","message":"¡Hola! Me interesa este viaje.","shard":"cl","searchOrigin":null,"searchDestination":null,"originCenter":null,"destinationCenter":null}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}

Get requested user following route as Driver
    [Documentation]    Verificar la información del usuario que está solicitando unirse como conductor

    ${url}=    Set Variable
    ...    ${TESTING_URL}/api/v1/users/${userIdCarpool}
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}

    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${user}=    Set Variable    ${response.json()}


Accept follower as Driver
    [Documentation]  Aceptar seguidor del viaje como Conductor

    Create Session    mysesion    ${TESTING_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/trips/accept/${tripId}/${userIdCarpool}
    ...    data={"pickupPointLat":-34.41107,"pickupPointLon":-70.85381}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${trip}=    Set Variable    ${response.json()}




Start carpool departure
    Create Session    mysesion    ${TESTING_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/tripinstances/start/${tripinstance1}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessTokenDeparture}=    Set Variable    []    ###Reeemplazar

Carpool Realtime - Driver + User Flow
    [Tags]    RUN_PARALLEL    CARPOOL

    # Driver conecta e inicia viaje
    ${WS_URL_1}=    Set Variable    ${WS_BASE}&token=${realTimeToken}
    ${sock1}=       Connect    ${WS_URL_1}
    Log    Connected Driver

    Send    ${sock1}    40/carpoolRealtime?token=${realTimeToken}
    Sleep   5s
    ${r0}=  Recv Data    ${sock1}
    Log     NS Driver: ${r0}

    Send    ${sock1}    42/carpoolRealtime,["join", {"userId":"${DRIVER_ID}","tripInstanceId":"${tripInstance1}"}]
    Sleep   5s
    ${r1}=  Recv Data    ${sock1}
    Log     Join Driver: ${r1}

    Send    ${sock1}    42/carpoolRealtime,["start", {"userId":"${DRIVER_ID}","tripInstanceId":"${tripInstance1}","latitude":-34.41107,"longitude":-70.85381}]
    Sleep   5s
    ${r2}=  Recv Data    ${sock1}
    Log     Start Driver: ${r2}


    # User conecta y se une
    ${WS_URL_2}=    Set Variable    ${WS_BASE}&token=${realTimeTokenUser}
    ${sock2}=       Connect    ${WS_URL_2}
    Log    Connected User

    Send    ${sock2}    40/carpoolRealtime?token=${realTimeTokenUser}
    Sleep   5s
    ${s0}=  Recv Data    ${sock2}
    Log     NS User: ${s0}

    Send    ${sock2}    42/carpoolRealtime,["join", {"userId":"${USER_ID}","tripInstanceId":"${tripInstance1}"}]
    Sleep   5s
    ${s1}=  Recv Data    ${sock2}
    Log     Join User: ${s1}

    Send    ${sock1}    42/carpoolRealtime,["start", {"userId":"${USER_ID}","tripInstanceId":"${tripInstance1}","latitude":-34.41107,"longitude":-70.85381}]
    Sleep   5s
    ${r2}=  Recv Data    ${sock1}
    Log     Start USER: ${r2}


    # Esperar boardingQueryDelay (5s) ANTES de mandar posiciones
    Sleep   5s


    # Intercalar posiciones
    Send    ${sock1}    42/carpoolRealtime,["newPosition", {"latitude":-34.4112,"longitude":-70.8536}]
    Sleep   5s
    ${dnp1}=  Recv Data    ${sock1}
    Log     NP Driver: ${dnp1}

    Send    ${sock2}    42/carpoolRealtime,["newPosition", {"latitude":-34.4113,"longitude":-70.8535}]
    Sleep   5s
    ${unp1}=  Recv Data    ${sock2}
    Log     NP User: ${unp1}
    # Intercalar posiciones
    Send    ${sock1}    42/carpoolRealtime,["newPosition", {"latitude":-34.4112,"longitude":-70.8536}]
    Sleep   5s
    ${dnp1}=  Recv Data    ${sock1}
    Log     NP Driver: ${dnp1}

    Send    ${sock2}    42/carpoolRealtime,["newPosition", {"latitude":-34.4113,"longitude":-70.8535}]
    Sleep   5s
    ${unp1}=  Recv Data    ${sock2}
    Log     NP User: ${unp1}
    # Intercalar posiciones
    Send    ${sock1}    42/carpoolRealtime,["newPosition", {"latitude":-34.4112,"longitude":-70.8536}]
    Sleep   5s
    ${dnp1}=  Recv Data    ${sock1}
    Log     NP Driver: ${dnp1}

    Send    ${sock2}    42/carpoolRealtime,["newPosition", {"latitude":-34.4113,"longitude":-70.8535}]
    Sleep   5s
    ${unp1}=  Recv Data    ${sock2}
    Log     NP User: ${unp1}
    # Intercalar posiciones
    Send    ${sock1}    42/carpoolRealtime,["newPosition", {"latitude":-34.4112,"longitude":-70.8536}]
    Sleep   5s
    ${dnp1}=  Recv Data    ${sock1}
    Log     NP Driver: ${dnp1}

    Send    ${sock2}    42/carpoolRealtime,["newPosition", {"latitude":-34.4113,"longitude":-70.8535}]
    Sleep   5s
    ${unp1}=  Recv Data    ${sock2}
    Log     NP User: ${unp1}
    # Intercalar posiciones
    Send    ${sock1}    42/carpoolRealtime,["newPosition", {"latitude":-34.4112,"longitude":-70.8536}]
    Sleep   5s
    ${dnp1}=  Recv Data    ${sock1}
    Log     NP Driver: ${dnp1}

    Send    ${sock2}    42/carpoolRealtime,["newPosition", {"latitude":-34.4113,"longitude":-70.8535}]
    Sleep   5s
    ${unp1}=  Recv Data    ${sock2}
    Log     NP User: ${unp1}





End trip
    Create Session    mysesion    ${TESTING_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/tripinstances/end/${tripinstance1}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${trip_instance}=    Set Variable    ${response.json()}


    Should Not Be Empty    ${trip_instance["boardingDetails"]}
    ...    msg=❌ boardingDetails should not be empty

Delete trip
    Skip
    Create Session    mysesion    ${TESTING_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenCarpool1}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/trips/${tripId}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}

    # ✅ Check that the API responded with the correct message
    Should Be Equal As Strings    ${response["message"]}    Trip deleted
    ...    msg=❌ Expected 'Trip deleted' message, but got something else

    # ✅ Extra safeguard in case the response is empty
    Should Not Be Empty    ${response["message"]}
    ...    msg=❌ Response message is missing after deletion

##Iniciar el viaje
## Chat
## Eliminar ruta creada por mi DELETE

