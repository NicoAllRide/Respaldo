*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Library    RPA.Smartsheet
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



Get trip list at start
    [Documentation]    Se verifica el descuento del pase luego de la validación offline, no deberían quedar usos

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/trips/list
    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella
Get community places
    [Documentation]    Se verifica el descuento del pase luego de la validación offline, no deberían quedar usos

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/communities/places
    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Almacenamos la respuesta de json en una variable para poder jugar con ella

## Crear ruta
Create recurrent route as driver (user1)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/trips/
    ...    data={"allowsSectionCost":false,"aproxWaypoints":{"coordinates":[[-70.85381,-34.41107],[-70.85367,-34.41072],[-70.8535,-34.41007],[-70.85308,-34.40853],[-70.85251,-34.4076],[-70.85206,-34.40705],[-70.85159,-34.40653],[-70.85126,-34.4062],[-70.85087,-34.40583],[-70.85045,-34.40546],[-70.85003,-34.40502],[-70.84913,-34.40427],[-70.84813,-34.40353],[-70.84789,-34.40336],[-70.84742,-34.40297],[-70.84739,-34.40294],[-70.84736,-34.40283],[-70.84736,-34.4028],[-70.84715,-34.40279],[-70.84644,-34.40275],[-70.84573,-34.40269],[-70.8454,-34.40264],[-70.84433,-34.40239],[-70.84376,-34.40229],[-70.84337,-34.40227],[-70.84272,-34.40227],[-70.84241,-34.40229],[-70.84184,-34.40239],[-70.84125,-34.4025],[-70.83714,-34.40315],[-70.83642,-34.40327],[-70.8354,-34.40344],[-70.83488,-34.40357],[-70.83406,-34.40379],[-70.83375,-34.4039],[-70.83302,-34.4042],[-70.83145,-34.40482],[-70.83095,-34.40499],[-70.8303,-34.40523],[-70.82964,-34.40545],[-70.8294,-34.40552],[-70.82864,-34.40566],[-70.82751,-34.40584],[-70.82674,-34.40595],[-70.82589,-34.40601],[-70.8242,-34.40606],[-70.82344,-34.4061],[-70.8232,-34.40616],[-70.82282,-34.40633],[-70.82265,-34.40642],[-70.82228,-34.40661],[-70.82046,-34.40749],[-70.81975,-34.40782],[-70.81846,-34.40853],[-70.8176,-34.409],[-70.81725,-34.40913],[-70.81608,-34.40943],[-70.81525,-34.40961],[-70.81484,-34.40975],[-70.81446,-34.40992],[-70.81407,-34.41013],[-70.81334,-34.41055],[-70.81312,-34.41068],[-70.81286,-34.41062],[-70.81253,-34.41052],[-70.8121,-34.41037],[-70.80991,-34.40956],[-70.80924,-34.4093],[-70.80898,-34.40916],[-70.80834,-34.40865],[-70.80719,-34.40769],[-70.80685,-34.40737],[-70.80617,-34.40667],[-70.80582,-34.40635],[-70.80503,-34.40567],[-70.80483,-34.40554],[-70.8044,-34.40537],[-70.80415,-34.40527],[-70.80403,-34.40516],[-70.80382,-34.40491],[-70.80369,-34.40478],[-70.80358,-34.4047],[-70.8035,-34.40466],[-70.80312,-34.40457],[-70.80267,-34.40449],[-70.80251,-34.40444],[-70.80206,-34.40428],[-70.80188,-34.40425],[-70.80164,-34.40424],[-70.80096,-34.40423],[-70.80057,-34.4042],[-70.80041,-34.40421],[-70.80014,-34.40424],[-70.79997,-34.40422],[-70.79917,-34.40404],[-70.79892,-34.40455],[-70.79848,-34.40551],[-70.7984,-34.40561],[-70.79822,-34.40577],[-70.79717,-34.40651],[-70.797,-34.40664],[-70.79688,-34.40679],[-70.79667,-34.40719],[-70.79651,-34.40748],[-70.7962,-34.40792],[-70.79594,-34.4078],[-70.79534,-34.40744],[-70.79477,-34.4071],[-70.79366,-34.40644],[-70.79082,-34.40485],[-70.78907,-34.40384],[-70.78692,-34.40257],[-70.78458,-34.40116],[-70.78446,-34.40109],[-70.78438,-34.40108],[-70.78428,-34.40113],[-70.78417,-34.4012],[-70.78407,-34.40119],[-70.78353,-34.4009],[-70.78304,-34.40056],[-70.7827,-34.40029],[-70.78251,-34.40016],[-70.78235,-34.40008],[-70.78271,-34.3996],[-70.78272,-34.39955],[-70.78254,-34.39927],[-70.78226,-34.39882],[-70.78216,-34.39857],[-70.78178,-34.39746],[-70.78166,-34.39704],[-70.78167,-34.39695],[-70.78207,-34.39635],[-70.78252,-34.39578],[-70.78226,-34.39571],[-70.78214,-34.39566],[-70.78236,-34.39534],[-70.78264,-34.39501],[-70.78255,-34.3948],[-70.78238,-34.39462]],"type":"LineString"},"codedRoute":"d|_qEhsmoLeA[aCa@sHsAyDqBmByAgBAaAaAiAmAiAsAwAsAuCsDsCgEa@o@mAAEEUEE?Ai@GmCKmCIaAq@uESqBCmA?aCB@RqBTuB`CuXVoC`@kEXgBj@cDT@z@qCzByH`@cBn@aCj@cCLo@ZwCb@aFTyCJiDHqIFwCJo@`@kAPa@d@iAnDkJ`AmClCaG|AkDXeAz@iFb@eDZqA`@kAh@mArAqCXk@Ks@SaA]uAaDuLs@eC[s@eB_C_EeF_AcAkCgC_AeAgCCYg@a@uASq@UWq@i@YYOUGOQkAOyAI_@_@yAEc@Ao@AgCEmA@_@Du@Ca@c@_DdBq@~DwARO^c@rCqEXa@WnAi@x@_@vA@Ws@gAwBcAqBcCEHwPiEIFmLyGsMMWAOHSLUASy@kBcAaBu@cAYe@O_@_BfAI@w@c@yAw@q@SEkAsAWQ@wBnAqBxAMs@IW_Aj@aAv@i@Qc@a@","comment":"","cost":0,"currency":"","destination":{"communityId":"","icon":"","location":[-70.7819,-34.3945],"longName":"Media luna cerrillos","placeId":"6654d4c8713b9a5184cfe1de","reference":"","shortName":"Media Luna Cerrillos"},"dropoutPlaces":[],"fee":0,"filed":false,"followerShards":[],"followers":[],"followersData":[],"_id":"","tripInstances":[],"new":true,"origin":{"communityId":"","icon":"","location":[-70.8537,-34.4111],"longName":"Hospital Rengo","placeId":"","reference":"","shortName":"Hospital Rengo"},"pending":[],"pendingsData":[],"pickupPlaces":[],"recurrent":true,"restrictions":[{"_id":"","restrictionType":"public"}],"seats":4,"sectionCost":true,"startDate":"2025-08-04T17:44:13.666-04:00","studentFee":false,"timezone":"America/Santiago","tripDates":[{"day":"monday","_id":"","time":"1970-01-01T18:38:00.000-03:00"}],"userId":""}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}    

        # --- Trip Id ---
    ${tripId}=  Set Variable    ${json}[_id]
    Set Global Variable    ${tripId}

        # --- Origin ---
    Should Be Equal As Strings    ${json}[origin][longName]    Hospital Rengo
    ...    msg=❌ Origin longName mismatch. Expected 'Hospital Rengo' but got '${json}[origin][longName]'.

    Should Be Equal As Strings    ${json}[origin][shortName]   Hospital Rengo
    ...    msg=❌ Origin shortName mismatch. Expected 'Hospital Rengo' but got '${json}[origin][shortName]'.

    Length Should Be    ${json}[origin][location]    2
    ...    msg=❌ Origin location must be [lon, lat] with 2 elements.

    Should Be Equal As Strings    ${json}[origin][placeId]    ${None}
    ...    msg=❌ Origin placeId should be null for this case.

    # --- Destination ---
    Should Be Equal As Strings    ${json}[destination][longName]    Media luna cerrillos
    ...    msg=❌ Destination longName mismatch. Expected 'Media luna cerrillos' but got '${json}[destination][longName]'.

    Should Be Equal As Strings    ${json}[destination][shortName]   Media Luna Cerrillos
    ...    msg=❌ Destination shortName mismatch. Expected 'Media Luna Cerrillos' but got '${json}[destination][shortName]'.

    Length Should Be    ${json}[destination][location]    2
    ...    msg=❌ Destination location must be [lon, lat] with 2 elements.

    Should Be Equal As Strings    ${json}[destination][placeId]    6654d4c8713b9a5184cfe1de
    ...    msg=❌ Destination placeId missing or incorrect.

    # --- Owner / Communities ---
    Should Be Equal As Strings    ${json}[owner][id]    66d8cf4f4a7101503b01f84a
    ...    msg=❌ Owner id mismatch.

    Should Be Equal As Strings    ${json}[owner][name]  Barbara Lisboa
    ...    msg=❌ Owner name mismatch.

    Should Contain    ${json}[owner][communities]    6654ae4eba54fe502d4e4187
    ...    msg=❌ Owner community 6654ae4eba54fe502d4e4187 not present.

    # --- Trip config flags ---
    Should Be True    ${json}[suggestions][enabled]
    ...    msg=❌ Suggestions must be enabled.

    Should Be True    ${json}[allowsSectionCost]
    ...    msg=❌ allowsSectionCost must be True.

    Should Be True    ${json}[recurrent]
    ...    msg=❌ Trip must be recurrent.

    # --- Seats / Cost / Currency / TZ ---
    Should Be Equal As Integers    ${json}[seats]    4
    ...    msg=❌ Seats should be 4 but got ${json}[seats].

    Should Be Equal As Integers    ${json}[cost]     0
    ...    msg=❌ Cost should be 0 (free), got ${json}[cost].

    Should Be Equal As Integers    ${json}[originalCost]    700
    ...    msg=❌ originalCost should be 700 but got ${json}[originalCost].

    Should Be Equal As Strings     ${json}[currency]    clp
    ...    msg=❌ Currency must be 'clp' but got '${json}[currency]'.

    Should Be Equal As Strings     ${json}[timezone]    America/Santiago
    ...    msg=❌ Timezone must be 'America/Santiago' but got '${json}[timezone]'.

    # --- Distance / Direction / Geometry ---
    Should Be True    ${json}[distance] > 0
    ...    msg=❌ Distance must be positive, got ${json}[distance].


    Should Not Be Empty    ${json}[codedRoute]
    ...    msg=❌ codedRoute must not be empty (expected an encoded polyline).

    # --- Arrays that should be empty ---
    Length Should Be    ${json}[followers]     0
    ...    msg=❌ followers should be empty for a new trip.

    Length Should Be    ${json}[pending]       0
    ...    msg=❌ pending should be empty for a new trip.

    Length Should Be    ${json}[pickupPlaces]  0
    ...    msg=❌ pickupPlaces should be empty.

    # --- Category ---
    Should Be Equal As Strings     ${json}[category]    5dab2269d79e785955386e2d
    ...    msg=❌ Category mismatch (expected 5dab2269d79e785955386e2d).

    # --- Restrictions (public) ---
    Length Should Be    ${json}[restrictions]    1
    ...    msg=❌ Expected exactly one restriction.

    Should Be Equal As Strings    ${json}[restrictions][0][restrictionType]    public
    ...    msg=❌ restrictionType must be 'public', got '${json}[restrictions][0][restrictionType]'.

    # --- Trip dates (weekly recurrence) ---
    Length Should Be    ${json}[tripDates]    1
    ...    msg=❌ Expected one tripDates entry.

    Should Be Equal As Strings    ${json}[tripDates][0][day]    monday
    ...    msg=❌ tripDates[0].day must be 'monday', got '${json}[tripDates][0][day]'.

    Should End With    ${json}[tripDates][0][time]    18:38:00.000Z
    ...    msg=❌ tripDates[0].time must end with '18:38:00.000Z', got '${json}[tripDates][0][time]'.

    # --- IDs present ---
    Should Not Be Empty    ${json}[_id]
    ...    msg=❌ Trip _id is missing.

    # --- Super/Community lists at root ---
    Should Contain    ${json}[communities]        6654ae4eba54fe502d4e4187
    ...    msg=❌ Root communities missing expected id 6654ae4eba54fe502d4e4187.

    Should Contain    ${json}[superCommunities]   653fd68233d83952fafcd4be
    ...    msg=❌ Root superCommunities missing expected id 653fd68233d83952fafcd4be.


Get route just created(Driver)
    [Documentation]    Se verifica el descuento del pase luego de la validación offline, no deberían quedar usos

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/tripinstances/for_trip/${tripId}
    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer ${accessTokenCarpool1}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}
    Should Be Equal As Numbers    ${response.status_code}    200
##Buscar ruta como usuario 1(solicita )https://stage.allrideapp.com/api/v1/search/coordinates?country=cl&origin_lat=-34.4111&origin_lon=-70.8537&destination_lat=-34.3945&destination_lon=-70.7819&origin_name=Hospital%20Rengo&destination_name=Media%20Luna%20Cerrillos&origin_place_id=6654d4acba54fe502d4e6b6a&destination_place_id=6654d4c8713b9a5184cfe1de
##Aporte por salida /api/v1/trips/sectionCost
##Seguir el viaje como usuario 2 /api/v1/trips/follow/6757525faa9f4e162d0c105e {"pickupPointLat":"0","pickupPointLon":"0"}
## Eliminar ruta creada por mi DELETE