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
    Skip
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

Create Shape Alto-Apu Colectivo
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/cp/shapes
    ...    data={"name":"Trazado colectivo alto-apu","points":[{"loc":[-70.54608,-33.39124],"lat":-33.39124,"lon":-70.54608,"sequence":0},{"loc":[-70.54690000000001,-33.391510000000004],"lat":-33.391510000000004,"lon":-70.54690000000001,"sequence":1},{"loc":[-70.54685,-33.39168],"lat":-33.39168,"lon":-70.54685,"sequence":2},{"loc":[-70.54689,-33.39181],"lat":-33.39181,"lon":-70.54689,"sequence":3},{"loc":[-70.54689,-33.39184],"lat":-33.39184,"lon":-70.54689,"sequence":4},{"loc":[-70.54693,-33.39188],"lat":-33.39188,"lon":-70.54693,"sequence":5},{"loc":[-70.54698,-33.3919],"lat":-33.3919,"lon":-70.54698,"sequence":6},{"loc":[-70.54719,-33.39193],"lat":-33.39193,"lon":-70.54719,"sequence":7},{"loc":[-70.54761,-33.3911],"lat":-33.3911,"lon":-70.54761,"sequence":8},{"loc":[-70.54768,-33.390840000000004],"lat":-33.390840000000004,"lon":-70.54768,"sequence":9},{"loc":[-70.54784000000001,-33.390390000000004],"lat":-33.390390000000004,"lon":-70.54784000000001,"sequence":10},{"loc":[-70.54805,-33.389990000000004],"lat":-33.389990000000004,"lon":-70.54805,"sequence":11},{"loc":[-70.54815,-33.38976],"lat":-33.38976,"lon":-70.54815,"sequence":12},{"loc":[-70.54824,-33.389570000000006],"lat":-33.389570000000006,"lon":-70.54824,"sequence":13},{"loc":[-70.54827,-33.389500000000005],"lat":-33.389500000000005,"lon":-70.54827,"sequence":14},{"loc":[-70.54875000000001,-33.38969],"lat":-33.38969,"lon":-70.54875000000001,"sequence":15},{"loc":[-70.54948,-33.389970000000005],"lat":-33.389970000000005,"lon":-70.54948,"sequence":16},{"loc":[-70.54958,-33.390040000000006],"lat":-33.390040000000006,"lon":-70.54958,"sequence":17},{"loc":[-70.54992,-33.3902],"lat":-33.3902,"lon":-70.54992,"sequence":18},{"loc":[-70.55023,-33.39032],"lat":-33.39032,"lon":-70.55023,"sequence":19},{"loc":[-70.55036000000001,-33.390420000000006],"lat":-33.390420000000006,"lon":-70.55036000000001,"sequence":20},{"loc":[-70.55036000000001,-33.390420000000006],"lat":-33.390420000000006,"lon":-70.55036000000001,"sequence":21},{"loc":[-70.55098000000001,-33.390660000000004],"lat":-33.390660000000004,"lon":-70.55098000000001,"sequence":22},{"loc":[-70.55206000000001,-33.391090000000005],"lat":-33.391090000000005,"lon":-70.55206000000001,"sequence":23},{"loc":[-70.55353000000001,-33.39166],"lat":-33.39166,"lon":-70.55353000000001,"sequence":24},{"loc":[-70.55523000000001,-33.392250000000004],"lat":-33.392250000000004,"lon":-70.55523000000001,"sequence":25},{"loc":[-70.55629,-33.39262],"lat":-33.39262,"lon":-70.55629,"sequence":26},{"loc":[-70.55736,-33.39296],"lat":-33.39296,"lon":-70.55736,"sequence":27},{"loc":[-70.55907,-33.393550000000005],"lat":-33.393550000000005,"lon":-70.55907,"sequence":28},{"loc":[-70.56134,-33.39435],"lat":-33.39435,"lon":-70.56134,"sequence":29},{"loc":[-70.56222000000001,-33.39464],"lat":-33.39464,"lon":-70.56222000000001,"sequence":30},{"loc":[-70.56398,-33.39528],"lat":-33.39528,"lon":-70.56398,"sequence":31},{"loc":[-70.56617,-33.39603],"lat":-33.39603,"lon":-70.56617,"sequence":32},{"loc":[-70.56617,-33.39603],"lat":-33.39603,"lon":-70.56617,"sequence":33},{"loc":[-70.56651000000001,-33.396080000000005],"lat":-33.396080000000005,"lon":-70.56651000000001,"sequence":34},{"loc":[-70.56689,-33.3962],"lat":-33.3962,"lon":-70.56689,"sequence":35},{"loc":[-70.5673,-33.39631],"lat":-33.39631,"lon":-70.5673,"sequence":36},{"loc":[-70.5673,-33.39631],"lat":-33.39631,"lon":-70.5673,"sequence":37},{"loc":[-70.56886,-33.396840000000005],"lat":-33.396840000000005,"lon":-70.56886,"sequence":38},{"loc":[-70.56916000000001,-33.39697],"lat":-33.39697,"lon":-70.56916000000001,"sequence":39},{"loc":[-70.56969000000001,-33.39716],"lat":-33.39716,"lon":-70.56969000000001,"sequence":40},{"loc":[-70.56996000000001,-33.397270000000006],"lat":-33.397270000000006,"lon":-70.56996000000001,"sequence":41},{"loc":[-70.5706,-33.39745],"lat":-33.39745,"lon":-70.5706,"sequence":42},{"loc":[-70.57125,-33.3977],"lat":-33.3977,"lon":-70.57125,"sequence":43},{"loc":[-70.57161,-33.397830000000006],"lat":-33.397830000000006,"lon":-70.57161,"sequence":44},{"loc":[-70.57173,-33.39781],"lat":-33.39781,"lon":-70.57173,"sequence":45},{"loc":[-70.57183,-33.39777],"lat":-33.39777,"lon":-70.57183,"sequence":46},{"loc":[-70.5719,-33.39772],"lat":-33.39772,"lon":-70.5719,"sequence":47},{"loc":[-70.57194000000001,-33.39764],"lat":-33.39764,"lon":-70.57194000000001,"sequence":48},{"loc":[-70.57194000000001,-33.39752],"lat":-33.39752,"lon":-70.57194000000001,"sequence":49},{"loc":[-70.57193000000001,-33.39746],"lat":-33.39746,"lon":-70.57193000000001,"sequence":50},{"loc":[-70.5719,-33.397360000000006],"lat":-33.397360000000006,"lon":-70.5719,"sequence":51},{"loc":[-70.57187,-33.397310000000004],"lat":-33.397310000000004,"lon":-70.57187,"sequence":52},{"loc":[-70.57182,-33.39728],"lat":-33.39728,"lon":-70.57182,"sequence":53},{"loc":[-70.57173,-33.397270000000006],"lat":-33.397270000000006,"lon":-70.57173,"sequence":54},{"loc":[-70.57153000000001,-33.397330000000004],"lat":-33.397330000000004,"lon":-70.57153000000001,"sequence":55},{"loc":[-70.57153000000001,-33.397330000000004],"lat":-33.397330000000004,"lon":-70.57153000000001,"sequence":56},{"loc":[-70.57133,-33.39791],"lat":-33.39791,"lon":-70.57133,"sequence":57},{"loc":[-70.57106,-33.398500000000006],"lat":-33.398500000000006,"lon":-70.57106,"sequence":58},{"loc":[-70.57043,-33.40035],"lat":-33.40035,"lon":-70.57043,"sequence":59},{"loc":[-70.57035,-33.40054],"lat":-33.40054,"lon":-70.57035,"sequence":60},{"loc":[-70.56972,-33.402370000000005],"lat":-33.402370000000005,"lon":-70.56972,"sequence":61},{"loc":[-70.56966,-33.40252],"lat":-33.40252,"lon":-70.56966,"sequence":62},{"loc":[-70.56952000000001,-33.40289],"lat":-33.40289,"lon":-70.56952000000001,"sequence":63},{"loc":[-70.56891,-33.404610000000005],"lat":-33.404610000000005,"lon":-70.56891,"sequence":64},{"loc":[-70.56868,-33.405210000000004],"lat":-33.405210000000004,"lon":-70.56868,"sequence":65},{"loc":[-70.56824,-33.406420000000004],"lat":-33.406420000000004,"lon":-70.56824,"sequence":66},{"loc":[-70.56824,-33.406420000000004],"lat":-33.406420000000004,"lon":-70.56824,"sequence":67},{"loc":[-70.56827000000001,-33.40659],"lat":-33.40659,"lon":-70.56827000000001,"sequence":68},{"loc":[-70.56823,-33.40675],"lat":-33.40675,"lon":-70.56823,"sequence":69},{"loc":[-70.56763000000001,-33.40807],"lat":-33.40807,"lon":-70.56763000000001,"sequence":70},{"loc":[-70.56735,-33.40872],"lat":-33.40872,"lon":-70.56735,"sequence":71},{"loc":[-70.56721,-33.409040000000005],"lat":-33.409040000000005,"lon":-70.56721,"sequence":72},{"loc":[-70.56699,-33.409670000000006],"lat":-33.409670000000006,"lon":-70.56699,"sequence":73},{"loc":[-70.56682,-33.410270000000004],"lat":-33.410270000000004,"lon":-70.56682,"sequence":74},{"loc":[-70.56682,-33.410270000000004],"lat":-33.410270000000004,"lon":-70.56682,"sequence":75},{"loc":[-70.56714000000001,-33.410340000000005],"lat":-33.410340000000005,"lon":-70.56714000000001,"sequence":76},{"loc":[-70.56744,-33.410410000000006],"lat":-33.410410000000006,"lon":-70.56744,"sequence":77},{"loc":[-70.56749,-33.4104],"lat":-33.4104,"lon":-70.56749,"sequence":78}],"avoid":{"ferries":false,"highways":false,"tolls":false},"markers":[{"lat":-33.391321740916055,"lng":-70.54604565002441,"draggable":true,"label":"A"},{"lat":-33.40996476311936,"lng":-70.56767357338819,"draggable":true,"label":"B"}],"communities":[],"superCommunities":[],"ownerIds":[],"skipDirections":false,"communityId":"666b08f0d574cd44de5885e1"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    ${cpShapeId}=   Set Variable    ${response.json()}[_id]
    Set Global Variable    ${cpShapeId}


Delete Shape
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=/api/v1/admin/cp/shapes/${cpShapeId}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}


