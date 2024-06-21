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
    [Documentation]     Prueba UAI Ruta Completa H (Son 4 vueltas)
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Set Location    -33.45008109378445     -70.66638938599046
    Sleep    30s
    ## Activate Application    com.allride.buses
Paso 0
    Set Location    -33.493571    -70.512244
    Sleep    30s

Paso 1
    Set Location    -33.493447    -70.512372
    Sleep    10s

Paso 2
    Set Location    -33.493447    -70.512372
    Sleep    10s

Paso 3
    Set Location    -33.493135    -70.512663
    Sleep    10s

Paso 4
    Set Location    -33.493135    -70.512663
    Sleep    10s

Paso 5
    Set Location    -33.489121    -70.517118
    Sleep    10s

Paso 6
    Set Location    -33.489075    -70.518537
    Sleep    10s

Paso 7
    Set Location    -33.488393    -70.519154
    Sleep    10s

Paso 8
    Set Location    -33.488393    -70.519154
    Sleep    10s

Paso 9
    Set Location    -33.486376    -70.518628
    Sleep    10s

Paso 10
    Set Location    -33.48637    -70.518733
    Sleep    10s

Paso 11
    Set Location    -33.48637    -70.518733
    Sleep    10s

Paso 12
    Set Location    -33.489013    -70.516372
    Sleep    10s

Paso 13
    Set Location    -33.491105    -70.513632
    Sleep    10s

Paso 14
    Set Location    -33.491717    -70.513363
    Sleep    10s

Paso 15
    Set Location    -33.492308    -70.513507
    Sleep    10s

Paso 16
    Set Location    -33.492308    -70.513507
    Sleep    10s

Paso 17
    Set Location    -33.49328    -70.512536
    Sleep    10s

Paso 18
    Set Location    -33.49328    -70.512536
    Sleep    10s

Paso 19
    Set Location    -33.49392    -70.511748
    Sleep    10s

Paso 20
    Set Location    -33.49387    -70.511857
    Sleep    10s

Paso 21
    Set Location    -33.493667    -70.51214
    Sleep    10s

Paso 22
    Set Location    -33.493667    -70.51214
    Sleep    10s

Paso 23
    Set Location    -33.493614    -70.512193
    Sleep    10s

Paso 24
    Set Location    -33.493614    -70.512193
    Sleep    10s

Paso 25
    Set Location    -33.493611    -70.512231
    Sleep    10s

Paso 26
    Set Location    -33.493529    -70.51236
    Sleep    10s

Paso 27
    Set Location    -33.493034    -70.512781
    Sleep    10s

Paso 28
    Set Location    -33.49205    -70.513569
    Sleep    10s

Paso 29
    Set Location    -33.490985    -70.513656
    Sleep    10s

Paso 30
    Set Location    -33.490632    -70.514521
    Sleep    10s

Paso 31
    Set Location    -33.490566    -70.514607
    Sleep    10s

Paso 32
    Set Location    -33.490566    -70.514607
    Sleep    10s

Paso 33
    Set Location    -33.489058    -70.516186
    Sleep    10s

Paso 34
    Set Location    -33.488992    -70.516617
    Sleep    10s

Paso 35
    Set Location    -33.489034    -70.518585
    Sleep    10s

Paso 36
    Set Location    -33.489034    -70.518585
    Sleep    10s

Paso 37
    Set Location    -33.488071    -70.519276
    Sleep    10s

Paso 38
    Set Location    -33.486539    -70.518608
    Sleep    10s

Paso 39
    Set Location    -33.486363    -70.518622
    Sleep    10s

Paso 40
    Set Location    -33.486355    -70.518629
    Sleep    10s

Paso 41
    Set Location    -33.486355    -70.518629
    Sleep    10s

Paso 42
    Set Location    -33.486337    -70.518688
    Sleep    10s

Paso 43
    Set Location    -33.489106    -70.518642
    Sleep    10s

Paso 44
    Set Location    -33.489084    -70.518199
    Sleep    10s

Paso 45
    Set Location    -33.489084    -70.518199
    Sleep    10s

Paso 46
    Set Location    -33.489161    -70.516187
    Sleep    10s

Paso 47
    Set Location    -33.489832    -70.516121
    Sleep    10s

Paso 48
    Set Location    -33.490421    -70.515467
    Sleep    10s

Paso 49
    Set Location    -33.490738    -70.514596
    Sleep    10s

Paso 50
    Set Location    -33.490707    -70.514509
    Sleep    10s

Paso 51
    Set Location    -33.490811    -70.513819
    Sleep    10s

Paso 52
    Set Location    -33.491016    -70.513653
    Sleep    10s

Paso 53
    Set Location    -33.491695    -70.513374
    Sleep    10s

Paso 54
    Set Location    -33.492503    -70.513261
    Sleep    10s

Paso 55
    Set Location    -33.492503    -70.513261
    Sleep    10s

Paso 56
    Set Location    -33.493784    -70.511988
    Sleep    10s

Paso 57
    Set Location    -33.493913    -70.511784
    Sleep    10s

Paso 58
    Set Location    -33.493834    -70.511909
    Sleep    10s

Paso 59
    Set Location    -33.493834    -70.511909
    Sleep    10s

Paso 60
    Set Location    -33.493589    -70.51223
    Sleep    10s

Paso 61
    Set Location    -33.493589    -70.51223
    Sleep    10s

Paso 62
    Set Location    -33.493673    -70.512379
    Sleep    10s

Paso 63
    Set Location    -33.493673    -70.512379
    Sleep    10s

Paso 64
    Set Location    -33.493516    -70.512528
    Sleep    10s

Paso 65
    Set Location    -33.49211    -70.513629
    Sleep    10s

Paso 66
    Set Location    -33.491496    -70.513444
    Sleep    10s

Paso 67
    Set Location    -33.490821    -70.513904
    Sleep    10s

Paso 68
    Set Location    -33.490606    -70.514666
    Sleep    10s

Paso 69
    Set Location    -33.490606    -70.514666
    Sleep    10s

Paso 70
    Set Location    -33.489806    -70.516067
    Sleep    10s

Paso 71
    Set Location    -33.48909    -70.516229
    Sleep    10s

Paso 72
    Set Location    -33.489083    -70.516978
    Sleep    10s

Paso 73
    Set Location    -33.489232    -70.517836
    Sleep    10s

Paso 74
    Set Location    -33.488866    -70.518796
    Sleep    10s

Paso 75
    Set Location    -33.488866    -70.518796
    Sleep    10s

Paso 76
    Set Location    -33.48748    -70.519071
    Sleep    10s

Paso 77
    Set Location    -33.486461    -70.518648
    Sleep    10s

Paso 78
    Set Location    -33.486461    -70.518648
    Sleep    10s

Paso 79
    Set Location    -33.486394    -70.518657
    Sleep    10s

Paso 80
    Set Location    -33.486394    -70.518657
    Sleep    10s

Paso 81
    Set Location    -33.486728    -70.51898
    Sleep    10s

Paso 82
    Set Location    -33.486728    -70.51898
    Sleep    10s

Paso 83
    Set Location    -33.486851    -70.519051
    Sleep    10s

Paso 84
    Set Location    -33.486851    -70.519051
    Sleep    10s

Paso 85
    Set Location    -33.487746    -70.519423
    Sleep    10s

Paso 86
    Set Location    -33.487746    -70.519423
    Sleep    10s

Paso 87
    Set Location    -33.489162    -70.518544
    Sleep    10s

Paso 88
    Set Location    -33.489162    -70.518544
    Sleep    10s

Paso 89
    Set Location    -33.489162    -70.518544
    Sleep    10s

Paso 90
    Set Location    -33.489824    -70.516135
    Sleep    10s

Paso 91
    Set Location    -33.489824    -70.516135
    Sleep    10s

Paso 92
    Set Location    -33.490132    -70.516126
    Sleep    10s

Paso 93
    Set Location    -33.490132    -70.516126
    Sleep    10s

Paso 94
    Set Location    -33.490781    -70.514628
    Sleep    10s

Paso 95
    Set Location    -33.490781    -70.514628
    Sleep    10s

Paso 96
    Set Location    -33.490713    -70.514279
    Sleep    10s

Paso 97
    Set Location    -33.490713    -70.514279
    Sleep    10s

Paso 98
    Set Location    -33.491065    -70.51367
    Sleep    10s

Paso 99
    Set Location    -33.491065    -70.51367
    Sleep    10s

Paso 100
    Set Location    -33.491684    -70.513372
    Sleep    10s

Paso 101
    Set Location    -33.491684    -70.513372
    Sleep    10s

Paso 102
    Set Location    -33.492391    -70.513488
    Sleep    10s

Paso 103
    Set Location    -33.492391    -70.513488
    Sleep    10s

Paso 104
    Set Location    -33.492799    -70.51297
    Sleep    10s

Paso 105
    Set Location    -33.492799    -70.51297
    Sleep    10s

Paso 106
    Set Location    -33.493972    -70.511714
    Sleep    10s

Paso 107
    Set Location    -33.493972    -70.511714
    Sleep    10s

Paso 108
    Set Location    -33.493953    -70.511836
    Sleep    10s

Paso 109
    Set Location    -33.493953    -70.511836
    Sleep    10s

Paso 110
    Set Location    -33.493809    -70.512009
    Sleep    10s

Paso 111
    Set Location    -33.493809    -70.512009
    Sleep    10s

Paso 112
    Set Location    -33.493629    -70.512232
    Sleep    10s

Paso 113
    Set Location    -33.493629    -70.512232
    Sleep    10s

Paso 114
    Set Location    -33.493572    -70.512297
    Sleep    10s

Paso 115
    Set Location    -33.493572    -70.512297
    Sleep    10s

Paso 116
    Set Location    -33.49216    -70.513582
    Sleep    10s

Paso 117
    Set Location    -33.49216    -70.513582
    Sleep    10s

Paso 118
    Set Location    -33.491634    -70.513362
    Sleep    10s

Paso 119
    Set Location    -33.491634    -70.513362
    Sleep    10s

Paso 120
    Set Location    -33.490858    -70.513828
    Sleep    10s

Paso 121
    Set Location    -33.490858    -70.513828
    Sleep    10s

Paso 122
    Set Location    -33.490681    -70.514528
    Sleep    10s

Paso 123
    Set Location    -33.490681    -70.514528
    Sleep    10s

Paso 124
    Set Location    -33.490611    -70.514614
    Sleep    10s

Paso 125
    Set Location    -33.490611    -70.514614
    Sleep    10s

Paso 126
    Set Location    -33.487163    -70.5189
    Sleep    10s

Paso 127
    Set Location    -33.487163    -70.5189
    Sleep    10s

Paso 128
    Set Location    -33.486931    -70.518781
    Sleep    10s

Paso 129
    Set Location    -33.486931    -70.518781
    Sleep    10s

Paso 130
    Set Location    -33.486506    -70.518661
    Sleep    10s

Paso 131
    Set Location    -33.486506    -70.518661
    Sleep    10s

Paso 132
    Set Location    -33.486445    -70.518656
    Sleep    10s

Paso 133
    Set Location    -33.486445    -70.518656
    Sleep    10s

Paso 134
    Set Location    -33.486648    -70.518889
    Sleep    10s

Paso 135
    Set Location    -33.486648    -70.518889
    Sleep    10s

Paso 136
    Set Location    -33.488542    -70.519109
    Sleep    10s

Paso 137
    Set Location    -33.488542    -70.519109
    Sleep    10s

Paso 138
    Set Location    -33.488952    -70.518762
    Sleep    10s

Paso 139
    Set Location    -33.488952    -70.518762
    Sleep    10s

Paso 140
    Set Location    -33.489155    -70.51854
    Sleep    10s

Paso 141
    Set Location    -33.489155    -70.51854
    Sleep    10s

Paso 142
    Set Location    -33.489149    -70.518105
    Sleep    10s

Paso 143
    Set Location    -33.489149    -70.518105
    Sleep    10s

Paso 144
    Set Location    -33.489248    -70.517575
    Sleep    10s

Paso 145
    Set Location    -33.489248    -70.517575
    Sleep    10s

Paso 146
    Set Location    -33.489027    -70.516669
    Sleep    10s

Paso 147
    Set Location    -33.489027    -70.516669
    Sleep    10s

Paso 148
    Set Location    -33.489887    -70.51615
    Sleep    10s

Paso 149
    Set Location    -33.489887    -70.51615
    Sleep    10s
