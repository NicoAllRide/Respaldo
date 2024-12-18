*** Settings ***
Library     AppiumLibrary
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     RPA.JSON


*** Variables ***
${STAGE_URL}            https://stage.allrideapp.com
${TESTING_URL}          https://testing.allrideapp.com
${endPoint}             /api/v1/admin/pb/routes?community=653fd601f90509541a748683
${driverId}             6582e724938e4e7b3bcf9f0a
${driverCode}           753
${vehicleId}            6553b81315e27f4db2b45935
${vehicleCapacity}      3
${vehicleCode}          1111
${addStopOrder}         /api/v1/admin/pb/stop-time?community=${idComunidad}
${seatReservation}      /api/v1/pb/user/booking
${idNico}               65e8e076337a90a35ba6e8dd
${idKratos}             65e092afca7842b1032f12e2
${idPedro}              654a5148bf3e9410d0bcd39a
${idNaruto}             653ff69df90509541a74988b
${tokenAdmin}           Bearer cb91fc010de72bf97bce8da804b7b1ed896bf0bf12e54034d570937eea068ed2e988a32cfd47af4ccb36bfe97a7d7166b39c72a1a792cb0b8d059b470c9d51cc
${tokenNico}            Bearer 60c0099c85d42b55bb405bd579d1c64f1629b1e879f290e43c235ef6bbfb8cd35da8055b20fefee31e3a11cb6207b9d91f7039a92eb266f587f11479d9f153f2
${tokenPedroPascal}     Bearer 2eacdb42a68ffa12b3d9901816b6b6049b1a65c9232c2112a64c5935002683b35bbf10c046ef9670f529241849999f66c4645956ecb1b0ae2a1de5c3209f9f4b
${tokenKratos}          Bearer fda5651771446906c9a511a066e26b4ef28873fa97ce094f47a2402b4a9a6f652a0032e1a7d3607515d2a873f2bb1eb73033e06c8d1d78e28b725a0537807d6f
${tokenNaruto}          Bearer fc7d6941c41225c2756ac83a2c0898dcae5c0ef2c0c9f5a7779d51fd3753dca60212278ac0f6fa0bf3ff4c77f482c6524eb2c5b8918b4dc4a3d81c7cba010bef
${idComunidad}          653fd601f90509541a748683
${idSuperCommunity}     653fd68233d83952fafcd4be
${shapeId}              658c42cff6f903bbee969242
${idAdmin}              653fd89733d83952fafcd6ca
${assignQty}            2
${cardIdPedro}          ABCDE159753


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
    Set Global Variable    ${end_date_tomorrow2}
    ${expiration_date_qr}=    Set Variable    ${fecha_manana}T14:10:37.968Z
    Set Global Variable    ${expiration_date_qr}

Round Full Online
    [Documentation]    Prueba UAI Ruta Completa H (Son 4 vueltas)
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}

    ## Activate Application    com.allride.buses

Paso 0
  Set Location    -34.41107     -70.85381000000001
  Sleep    10s
Paso 1
  Set Location    -34.408530000000006     -70.85308
  Sleep    5s
Paso 2
  Set Location    -34.40699     -70.852
  Sleep    5s
Paso 3
  Set Location    -34.40496     -70.84995
  Sleep    5s
Paso 4
  Set Location    -34.40296     -70.84740000000001
  Sleep    5s
Paso 5
  Set Location    -34.402800000000006     -70.84736000000001
  Sleep    5s
Paso 6
  Set Location    -34.40267     -70.84552000000001
  Sleep    5s
Paso 7
  Set Location    -34.40229     -70.84376
  Sleep    5s
Paso 8
  Set Location    -34.40229     -70.84241
  Sleep    5s
Paso 9
  Set Location    -34.40344     -70.8354
  Sleep    5s
Paso 10
  Set Location    -34.40379     -70.83406000000001
  Sleep    5s
Paso 11
  Set Location    -34.40545     -70.82964000000001
  Sleep    5s
Paso 12
  Set Location    -34.405660000000005     -70.82864000000001
  Sleep    5s
Paso 13
  Set Location    -34.40598     -70.82654000000001
  Sleep    5s
Paso 14
  Set Location    -34.406130000000005     -70.82332000000001
  Sleep    5s
Paso 15
  Set Location    -34.40782     -70.81975
  Sleep    5s
Paso 16
  Set Location    -34.409060000000004     -70.81747
  Sleep    5s
Paso 17
  Set Location    -34.40968     -70.81502
  Sleep    5s
Paso 18
  Set Location    -34.40997     -70.81436000000001
  Sleep    5s
Paso 19
  Set Location    -34.41068     -70.81312000000001
  Sleep    5s
Paso 20
  Set Location    -34.41037     -70.8121
  Sleep    5s
Paso 21
  Set Location    -34.40916     -70.80898
  Sleep    5s
Paso 22
  Set Location    -34.40769     -70.80719
  Sleep    5s
Paso 23
  Set Location    -34.406670000000005     -70.80617000000001
  Sleep    5s
Paso 24
  Set Location    -34.405620000000006     -70.80497000000001
  Sleep    5s
Paso 25
  Set Location    -34.40527     -70.80415
  Sleep    5s
Paso 26
  Set Location    -34.40466     -70.8035
  Sleep    5s
Paso 27
  Set Location    -34.404250000000005     -70.80188000000001
  Sleep    5s
Paso 28
  Set Location    -34.40424     -70.80014
  Sleep    5s
Paso 29
  Set Location    -34.40404     -70.79917
  Sleep    5s
Paso 30
  Set Location    -34.40551     -70.79848000000001
  Sleep    5s
Paso 31
  Set Location    -34.40664     -70.79700000000001
  Sleep    5s
Paso 32
  Set Location    -34.407920000000004     -70.7962
  Sleep    5s
Paso 33
  Set Location    -34.404030000000006     -70.78939000000001
  Sleep    5s
Paso 34
  Set Location    -34.40109     -70.78446000000001
  Sleep    5s
Paso 35
  Set Location    -34.40119     -70.78407
  Sleep    5s
Paso 36
  Set Location    -34.40008     -70.78235000000001
  Sleep    5s
Paso 37
  Set Location    -34.399550000000005     -70.78272000000001
  Sleep    5s
Paso 38
  Set Location    -34.39882     -70.78226000000001
  Sleep    5s
Paso 39
  Set Location    -34.397040000000004     -70.78166
  Sleep    5s
Paso 40
  Set Location    -34.39687     -70.78171
  Sleep    5s
Paso 41
  Set Location    -34.39578     -70.78252
  Sleep    5s
Paso 42
  Set Location    -34.395430000000005     -70.78160000000001
  Sleep    5s
Paso 43
  Set Location    -34.395250000000004     -70.78141000000001
  Sleep    5s
Paso 44
  Set Location    -34.3949     -70.78123000000001
  Sleep    5s

Paso 44
  Set Location    -34.3949     -70.78123000000001
  Sleep    5s
Paso 43
  Set Location    -34.395250000000004     -70.78141000000001
  Sleep    5s
Paso 42
  Set Location    -34.395430000000005     -70.78160000000001
  Sleep    5s
Paso 41
  Set Location    -34.39578     -70.78252
  Sleep    5s
Paso 40
  Set Location    -34.39687     -70.78171
  Sleep    5s
Paso 39
  Set Location    -34.397040000000004     -70.78166
  Sleep    5s
Paso 38
  Set Location    -34.39882     -70.78226000000001
  Sleep    5s
Paso 37
  Set Location    -34.399550000000005     -70.78272000000001
  Sleep    5s
Paso 36
  Set Location    -34.40008     -70.78235000000001
  Sleep    5s
Paso 35
  Set Location    -34.40119     -70.78407
  Sleep    5s
Paso 34
  Set Location    -34.40109     -70.78446000000001
  Sleep    5s
Paso 33
  Set Location    -34.404030000000006     -70.78939000000001
  Sleep    5s
Paso 32
  Set Location    -34.407920000000004     -70.7962
  Sleep    5s
Paso 31
  Set Location    -34.40664     -70.79700000000001
  Sleep    5s
Paso 30
  Set Location    -34.40551     -70.79848000000001
  Sleep    5s
Paso 29
  Set Location    -34.40404     -70.79917
  Sleep    5s
Paso 28
  Set Location    -34.40424     -70.80014
  Sleep    5s
Paso 27
  Set Location    -34.404250000000005     -70.80188000000001
  Sleep    5s
Paso 26
  Set Location    -34.40466     -70.8035
  Sleep    5s
Paso 25
  Set Location    -34.40527     -70.80415
  Sleep    5s
Paso 24
  Set Location    -34.405620000000006     -70.80497000000001
  Sleep    5s
Paso 23
  Set Location    -34.406670000000005     -70.80617000000001
  Sleep    5s
Paso 22
  Set Location    -34.40769     -70.80719
  Sleep    5s
Paso 21
  Set Location    -34.40916     -70.80898
  Sleep    5s
Paso 20
  Set Location    -34.41037     -70.8121
  Sleep    5s
Paso 19
  Set Location    -34.41068     -70.81312000000001
  Sleep    5s
Paso 18
  Set Location    -34.40997     -70.81436000000001
  Sleep    5s
Paso 17
  Set Location    -34.40968     -70.81502
  Sleep    5s
Paso 16
  Set Location    -34.409060000000004     -70.81747
  Sleep    5s
Paso 15
  Set Location    -34.40782     -70.81975
  Sleep    5s
Paso 14
  Set Location    -34.406130000000005     -70.82332000000001
  Sleep    5s
Paso 13
  Set Location    -34.40598     -70.82654000000001
  Sleep    5s
Paso 12
  Set Location    -34.405660000000005     -70.82864000000001
  Sleep    5s
Paso 11
  Set Location    -34.40545     -70.82964000000001
  Sleep    5s
Paso 10
  Set Location    -34.40379     -70.83406000000001
  Sleep    5s
Paso 9
  Set Location    -34.40344     -70.8354
  Sleep    5s
Paso 8
  Set Location    -34.40229     -70.84241
  Sleep    5s
Paso 7
  Set Location    -34.40229     -70.84376
  Sleep    5s
Paso 6
  Set Location    -34.40267     -70.84552000000001
  Sleep    5s
Paso 5
  Set Location    -34.402800000000006     -70.84736000000001
  Sleep    5s
Paso 4
  Set Location    -34.40296     -70.84740000000001
  Sleep    5s
Paso 3
  Set Location    -34.40496     -70.84995
  Sleep    5s
Paso 2
  Set Location    -34.40699     -70.852
  Sleep    5s
Paso 1
  Set Location    -34.408530000000006     -70.85308
  Sleep    5s
Paso 0
  Set Location    -34.41107     -70.85381000000001
  Sleep    5s

Paso 0
  Set Location    -34.41107     -70.85381000000001
  Sleep    5s
Paso 1
  Set Location    -34.408530000000006     -70.85308
  Sleep    5s
Paso 2
  Set Location    -34.40699     -70.852
  Sleep    5s
Paso 3
  Set Location    -34.40496     -70.84995
  Sleep    5s
Paso 4
  Set Location    -34.40296     -70.84740000000001
  Sleep    5s
Paso 5
  Set Location    -34.402800000000006     -70.84736000000001
  Sleep    5s
Paso 6
  Set Location    -34.40267     -70.84552000000001
  Sleep    5s
Paso 7
  Set Location    -34.40229     -70.84376
  Sleep    5s
Paso 8
  Set Location    -34.40229     -70.84241
  Sleep    5s
Paso 9
  Set Location    -34.40344     -70.8354
  Sleep    5s
Paso 10
  Set Location    -34.40379     -70.83406000000001
  Sleep    5s
Paso 11
  Set Location    -34.40545     -70.82964000000001
  Sleep    5s
Paso 12
  Set Location    -34.405660000000005     -70.82864000000001
  Sleep    5s
Paso 13
  Set Location    -34.40598     -70.82654000000001
  Sleep    5s
Paso 14
  Set Location    -34.406130000000005     -70.82332000000001
  Sleep    5s
Paso 15
  Set Location    -34.40782     -70.81975
  Sleep    5s
Paso 16
  Set Location    -34.409060000000004     -70.81747
  Sleep    5s
Paso 17
  Set Location    -34.40968     -70.81502
  Sleep    5s
Paso 18
  Set Location    -34.40997     -70.81436000000001
  Sleep    5s
Paso 19
  Set Location    -34.41068     -70.81312000000001
  Sleep    5s
Paso 20
  Set Location    -34.41037     -70.8121
  Sleep    5s
Paso 21
  Set Location    -34.40916     -70.80898
  Sleep    5s
Paso 22
  Set Location    -34.40769     -70.80719
  Sleep    5s
Paso 23
  Set Location    -34.406670000000005     -70.80617000000001
  Sleep    5s
Paso 24
  Set Location    -34.405620000000006     -70.80497000000001
  Sleep    5s
Paso 25
  Set Location    -34.40527     -70.80415
  Sleep    5s
Paso 26
  Set Location    -34.40466     -70.8035
  Sleep    5s
Paso 27
  Set Location    -34.404250000000005     -70.80188000000001
  Sleep    5s
Paso 28
  Set Location    -34.40424     -70.80014
  Sleep    5s
Paso 29
  Set Location    -34.40404     -70.79917
  Sleep    5s
Paso 30
  Set Location    -34.40551     -70.79848000000001
  Sleep    5s
Paso 31
  Set Location    -34.40664     -70.79700000000001
  Sleep    5s
Paso 32
  Set Location    -34.407920000000004     -70.7962
  Sleep    5s
Paso 33
  Set Location    -34.404030000000006     -70.78939000000001
  Sleep    5s
Paso 34
  Set Location    -34.40109     -70.78446000000001
  Sleep    5s
Paso 35
  Set Location    -34.40119     -70.78407
  Sleep    5s
Paso 36
  Set Location    -34.40008     -70.78235000000001
  Sleep    5s
Paso 37
  Set Location    -34.399550000000005     -70.78272000000001
  Sleep    5s
Paso 38
  Set Location    -34.39882     -70.78226000000001
  Sleep    5s
Paso 39
  Set Location    -34.397040000000004     -70.78166
  Sleep    5s
Paso 40
  Set Location    -34.39687     -70.78171
  Sleep    5s
Paso 41
  Set Location    -34.39578     -70.78252
  Sleep    5s
Paso 42
  Set Location    -34.395430000000005     -70.78160000000001
  Sleep    5s
Paso 43
  Set Location    -34.395250000000004     -70.78141000000001
  Sleep    5s
Paso 44
  Set Location    -34.3949     -70.78123000000001
  Sleep    5s

Paso 44
  Set Location    -34.3949     -70.78123000000001
  Sleep    5s
Paso 43
  Set Location    -34.395250000000004     -70.78141000000001
  Sleep    5s
Paso 42
  Set Location    -34.395430000000005     -70.78160000000001
  Sleep    5s
Paso 41
  Set Location    -34.39578     -70.78252
  Sleep    5s
Paso 40
  Set Location    -34.39687     -70.78171
  Sleep    5s
Paso 39
  Set Location    -34.397040000000004     -70.78166
  Sleep    5s
Paso 38
  Set Location    -34.39882     -70.78226000000001
  Sleep    5s
Paso 37
  Set Location    -34.399550000000005     -70.78272000000001
  Sleep    5s
Paso 36
  Set Location    -34.40008     -70.78235000000001
  Sleep    5s
Paso 35
  Set Location    -34.40119     -70.78407
  Sleep    5s
Paso 34
  Set Location    -34.40109     -70.78446000000001
  Sleep    5s
Paso 33
  Set Location    -34.404030000000006     -70.78939000000001
  Sleep    5s
Paso 32
  Set Location    -34.407920000000004     -70.7962
  Sleep    5s
Paso 31
  Set Location    -34.40664     -70.79700000000001
  Sleep    5s
Paso 30
  Set Location    -34.40551     -70.79848000000001
  Sleep    5s
Paso 29
  Set Location    -34.40404     -70.79917
  Sleep    5s
Paso 28
  Set Location    -34.40424     -70.80014
  Sleep    5s
Paso 27
  Set Location    -34.404250000000005     -70.80188000000001
  Sleep    5s
Paso 26
  Set Location    -34.40466     -70.8035
  Sleep    5s
Paso 25
  Set Location    -34.40527     -70.80415
  Sleep    5s
Paso 24
  Set Location    -34.405620000000006     -70.80497000000001
  Sleep    5s
Paso 23
  Set Location    -34.406670000000005     -70.80617000000001
  Sleep    5s
Paso 22
  Set Location    -34.40769     -70.80719
  Sleep    5s
Paso 21
  Set Location    -34.40916     -70.80898
  Sleep    5s
Paso 20
  Set Location    -34.41037     -70.8121
  Sleep    5s
Paso 19
  Set Location    -34.41068     -70.81312000000001
  Sleep    5s
Paso 18
  Set Location    -34.40997     -70.81436000000001
  Sleep    5s
Paso 17
  Set Location    -34.40968     -70.81502
  Sleep    5s
Paso 16
  Set Location    -34.409060000000004     -70.81747
  Sleep    5s
Paso 15
  Set Location    -34.40782     -70.81975
  Sleep    5s
Paso 14
  Set Location    -34.406130000000005     -70.82332000000001
  Sleep    5s
Paso 13
  Set Location    -34.40598     -70.82654000000001
  Sleep    5s
Paso 12
  Set Location    -34.405660000000005     -70.82864000000001
  Sleep    5s
Paso 11
  Set Location    -34.40545     -70.82964000000001
  Sleep    5s
Paso 10
  Set Location    -34.40379     -70.83406000000001
  Sleep    5s
Paso 9
  Set Location    -34.40344     -70.8354
  Sleep    5s
Paso 8
  Set Location    -34.40229     -70.84241
  Sleep    5s
Paso 7
  Set Location    -34.40229     -70.84376
  Sleep    5s
Paso 6
  Set Location    -34.40267     -70.84552000000001
  Sleep    5s
Paso 5
  Set Location    -34.402800000000006     -70.84736000000001
  Sleep    5s
Paso 4
  Set Location    -34.40296     -70.84740000000001
  Sleep    5s
Paso 3
  Set Location    -34.40496     -70.84995
  Sleep    5s
Paso 2
  Set Location    -34.40699     -70.852
  Sleep    5s
Paso 1
  Set Location    -34.408530000000006     -70.85308
  Sleep    5s
Paso 0
  Set Location    -34.41107     -70.85381000000001
  Sleep    5s