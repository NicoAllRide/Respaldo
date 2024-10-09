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
    # Calcular la fecha que es exactamente 4 semanas después del día de hoy
    ${fecha_4weekslater}=    Add Time To Date    ${fecha_hoy}    4 week    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_4weekslater}

Round Full Online
    [Documentation]    Prueba ADO
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses


Paso 0
  Set Location    21.1644377     -86.8262678
  Sleep    3s
Paso 1
  Set Location    21.1644512     -86.8262731
  Sleep    0.5s
Paso 2
  Set Location    21.1644916     -86.8263817
  Sleep    0.5s
Paso 3
  Set Location    21.1644834     -86.8263279
  Sleep    0.5s
Paso 4
  Set Location    21.1644433     -86.8262767
  Sleep    0.5s
Paso 5
  Set Location    21.1644433     -86.8262767
  Sleep    0.5s
Paso 6
  Set Location    21.164355     -86.8262785
  Sleep    0.5s
Paso 7
  Set Location    21.164355     -86.8262785
  Sleep    0.5s
Paso 8
  Set Location    21.1642875     -86.8262581
  Sleep    0.5s
Paso 9
  Set Location    21.1642875     -86.8262581
  Sleep    0.5s
Paso 10
  Set Location    21.1642967     -86.8262483
  Sleep    0.5s
Paso 11
  Set Location    21.1642967     -86.8262483
  Sleep    0.5s
Paso 12
  Set Location    21.16433     -86.8262017
  Sleep    0.5s
Paso 13
  Set Location    21.16433     -86.8262017
  Sleep    0.5s
Paso 14
  Set Location    21.1643052     -86.8261803
  Sleep    0.5s
Paso 15
  Set Location    21.1643052     -86.8261803
  Sleep    0.5s
Paso 16
  Set Location    21.164305     -86.8261767
  Sleep    0.5s
Paso 17
  Set Location    21.164305     -86.8261767
  Sleep    0.5s
Paso 18
  Set Location    21.164305     -86.8261617
  Sleep    0.5s
Paso 19
  Set Location    21.164305     -86.8261617
  Sleep    0.5s
Paso 20
  Set Location    21.1642835     -86.8261532
  Sleep    0.5s
Paso 21
  Set Location    21.1642835     -86.8261532
  Sleep    0.5s
Paso 22
  Set Location    21.1642431     -86.8260872
  Sleep    0.5s
Paso 23
  Set Location    21.1642431     -86.8260872
  Sleep    0.5s
Paso 24
  Set Location    21.1639222     -86.8262038
  Sleep    0.5s
Paso 25
  Set Location    21.1639222     -86.8262038
  Sleep    0.5s
Paso 26
  Set Location    21.1629298     -86.8259042
  Sleep    0.5s
Paso 27
  Set Location    21.1629298     -86.8259042
  Sleep    0.5s
Paso 28
  Set Location    21.1618049     -86.8257519
  Sleep    0.5s
Paso 29
  Set Location    21.1618049     -86.8257519
  Sleep    0.5s
Paso 30
  Set Location    21.1608076     -86.8256754
  Sleep    0.5s
Paso 31
  Set Location    21.1608076     -86.8256754
  Sleep    0.5s
Paso 32
  Set Location    21.1599057     -86.8255961
  Sleep    0.5s
Paso 33
  Set Location    21.1599057     -86.8255961
  Sleep    0.5s
Paso 34
  Set Location    21.1593186     -86.8255556
  Sleep    0.5s
Paso 35
  Set Location    21.1593186     -86.8255556
  Sleep    0.5s
Paso 36
  Set Location    21.1589051     -86.8255199
  Sleep    0.5s
Paso 37
  Set Location    21.1589051     -86.8255199
  Sleep    0.5s
Paso 38
  Set Location    21.1588402     -86.8255122
  Sleep    0.5s
Paso 39
  Set Location    21.1588402     -86.8255122
  Sleep    0.5s
Paso 40
  Set Location    21.158501     -86.8254833
  Sleep    0.5s
Paso 41
  Set Location    21.158501     -86.8254833
  Sleep    0.5s
Paso 42
  Set Location    21.1581327     -86.8254653
  Sleep    0.5s
Paso 43
  Set Location    21.1581327     -86.8254653
  Sleep    0.5s
Paso 44
  Set Location    21.1580808     -86.8254566
  Sleep    0.5s
Paso 45
  Set Location    21.1580808     -86.8254566
  Sleep    0.5s
Paso 46
  Set Location    21.1574506     -86.8254811
  Sleep    0.5s
Paso 47
  Set Location    21.1574506     -86.8254811
  Sleep    0.5s
Paso 48
  Set Location    21.1560204     -86.8252995
  Sleep    0.5s
Paso 49
  Set Location    21.1560204     -86.8252995
  Sleep    0.5s
Paso 50
  Set Location    21.1541082     -86.8251608
  Sleep    0.5s
Paso 51
  Set Location    21.1541082     -86.8251608
  Sleep    0.5s
Paso 52
  Set Location    21.1521019     -86.8250084
  Sleep    0.5s
Paso 53
  Set Location    21.1521019     -86.8250084
  Sleep    0.5s
Paso 54
  Set Location    21.1508433     -86.8249213
  Sleep    0.5s
Paso 55
  Set Location    21.1508433     -86.8249213
  Sleep    0.5s
Paso 56
  Set Location    21.1507669     -86.8249147
  Sleep    0.5s
Paso 57
  Set Location    21.1507669     -86.8249147
  Sleep    0.5s
Paso 58
  Set Location    21.1497167     -86.8248941
  Sleep    0.5s
Paso 59
  Set Location    21.1497167     -86.8248941
  Sleep    0.5s
Paso 60
  Set Location    21.1483038     -86.8247535
  Sleep    0.5s
Paso 61
  Set Location    21.1483038     -86.8247535
  Sleep    0.5s
Paso 62
  Set Location    21.1475377     -86.8247934
  Sleep    0.5s
Paso 63
  Set Location    21.1475377     -86.8247934
  Sleep    0.5s
Paso 64
  Set Location    21.1467425     -86.8247665
  Sleep    0.5s
Paso 65
  Set Location    21.1467425     -86.8247665
  Sleep    0.5s
Paso 66
  Set Location    21.1451876     -86.8246673
  Sleep    0.5s
Paso 67
  Set Location    21.1451876     -86.8246673
  Sleep    0.5s
Paso 68
  Set Location    21.1446567     -86.8246683
  Sleep    0.5s
Paso 69
  Set Location    21.1446567     -86.8246683
  Sleep    0.5s
Paso 70
  Set Location    21.1446308     -86.8246928
  Sleep    0.5s
Paso 71
  Set Location    21.1446308     -86.8246928
  Sleep    0.5s
Paso 72
  Set Location    21.1438689     -86.8247578
  Sleep    0.5s
Paso 73
  Set Location    21.1438689     -86.8247578
  Sleep    0.5s
Paso 74
  Set Location    21.1438333     -86.8247333
  Sleep    0.5s
Paso 75
  Set Location    21.1438333     -86.8247333
  Sleep    0.5s
Paso 76
  Set Location    21.1437411     -86.8246801
  Sleep    0.5s
Paso 77
  Set Location    21.1437411     -86.8246801
  Sleep    0.5s
Paso 78
  Set Location    21.1425704     -86.8245108
  Sleep    0.5s
Paso 79
  Set Location    21.1425704     -86.8245108
  Sleep    0.5s
Paso 80
  Set Location    21.1407806     -86.8250307
  Sleep    0.5s
Paso 81
  Set Location    21.1407806     -86.8250307
  Sleep    0.5s
Paso 82
  Set Location    21.139429     -86.8258126
  Sleep    0.5s
Paso 83
  Set Location    21.139429     -86.8258126
  Sleep    0.5s
Paso 84
  Set Location    21.1377183     -86.8264984
  Sleep    0.5s
Paso 85
  Set Location    21.1377183     -86.8264984
  Sleep    0.5s
Paso 86
  Set Location    21.1357473     -86.8274505
  Sleep    0.5s
Paso 87
  Set Location    21.1357473     -86.8274505
  Sleep    0.5s
Paso 88
  Set Location    21.1334569     -86.828545
  Sleep    0.5s
Paso 89
  Set Location    21.1334569     -86.828545
  Sleep    0.5s
Paso 90
  Set Location    21.1313247     -86.829561
  Sleep    0.5s
Paso 91
  Set Location    21.1313247     -86.829561
  Sleep    0.5s
Paso 92
  Set Location    21.1291579     -86.8306071
  Sleep    0.5s
Paso 93
  Set Location    21.1291579     -86.8306071
  Sleep    0.5s
Paso 94
  Set Location    21.1270252     -86.8316847
  Sleep    0.5s
Paso 95
  Set Location    21.1270252     -86.8316847
  Sleep    0.5s
Paso 96
  Set Location    21.1247019     -86.832815
  Sleep    0.5s
Paso 97
  Set Location    21.1247019     -86.832815
  Sleep    0.5s
Paso 98
  Set Location    21.1225129     -86.8338896
  Sleep    0.5s
Paso 99
  Set Location    21.1225129     -86.8338896
  Sleep    0.5s
Paso 100
  Set Location    21.1204502     -86.8348981
  Sleep    0.5s
Paso 101
  Set Location    21.1204502     -86.8348981
  Sleep    0.5s
Paso 102
  Set Location    21.1182516     -86.8359728
  Sleep    0.5s
Paso 103
  Set Location    21.1182516     -86.8359728
  Sleep    0.5s
Paso 104
  Set Location    21.1159654     -86.837085
  Sleep    0.5s
Paso 105
  Set Location    21.1159654     -86.837085
  Sleep    0.5s
Paso 106
  Set Location    21.1136501     -86.838218
  Sleep    0.5s
Paso 107
  Set Location    21.1136501     -86.838218
  Sleep    0.5s
Paso 108
  Set Location    21.1113246     -86.8390448
  Sleep    0.5s
Paso 109
  Set Location    21.1113246     -86.8390448
  Sleep    0.5s
Paso 110
  Set Location    21.1088636     -86.8394162
  Sleep    0.5s
Paso 111
  Set Location    21.1088636     -86.8394162
  Sleep    0.5s
Paso 112
  Set Location    21.1063363     -86.8398111
  Sleep    0.5s
Paso 113
  Set Location    21.1063363     -86.8398111
  Sleep    0.5s
Paso 114
  Set Location    21.1040684     -86.8401762
  Sleep    0.5s
Paso 115
  Set Location    21.1040684     -86.8401762
  Sleep    0.5s
Paso 116
  Set Location    21.1019541     -86.8405182
  Sleep    0.5s
Paso 117
  Set Location    21.1019541     -86.8405182
  Sleep    0.5s
Paso 118
  Set Location    21.0996447     -86.8408678
  Sleep    0.5s
Paso 119
  Set Location    21.0996447     -86.8408678
  Sleep    0.5s
Paso 120
  Set Location    21.0991799     -86.8409319
  Sleep    0.5s
Paso 121
  Set Location    21.0991799     -86.8409319
  Sleep    0.5s
Paso 122
  Set Location    21.0978703     -86.8411316
  Sleep    0.5s
Paso 123
  Set Location    21.0978703     -86.8411316
  Sleep    0.5s
Paso 124
  Set Location    21.0957035     -86.8414765
  Sleep    0.5s
Paso 125
  Set Location    21.0957035     -86.8414765
  Sleep    0.5s
Paso 126
  Set Location    21.0936935     -86.8417826
  Sleep    0.5s
Paso 127
  Set Location    21.0936935     -86.8417826
  Sleep    0.5s
Paso 128
  Set Location    21.0913734     -86.8420884
  Sleep    0.5s
Paso 129
  Set Location    21.0913734     -86.8420884
  Sleep    0.5s
Paso 130
  Set Location    21.0888994     -86.8424364
  Sleep    0.5s
Paso 131
  Set Location    21.0888994     -86.8424364
  Sleep    0.5s
Paso 132
  Set Location    21.0864192     -86.842821
  Sleep    0.5s
Paso 133
  Set Location    21.0864192     -86.842821
  Sleep    0.5s
Paso 134
  Set Location    21.0841587     -86.8432849
  Sleep    0.5s
Paso 135
  Set Location    21.0841587     -86.8432849
  Sleep    0.5s
Paso 136
  Set Location    21.0816183     -86.843686
  Sleep    0.5s
Paso 137
  Set Location    21.0816183     -86.843686
  Sleep    0.5s
Paso 138
  Set Location    21.0790817     -86.8440802
  Sleep    0.5s
Paso 139
  Set Location    21.0790817     -86.8440802
  Sleep    0.5s
Paso 140
  Set Location    21.0766355     -86.8444758
  Sleep    0.5s
Paso 141
  Set Location    21.0766355     -86.8444758
  Sleep    0.5s
Paso 142
  Set Location    21.0742003     -86.8448516
  Sleep    0.5s
Paso 143
  Set Location    21.0742003     -86.8448516
  Sleep    0.5s
Paso 144
  Set Location    21.0717363     -86.8452279
  Sleep    0.5s
Paso 145
  Set Location    21.0717363     -86.8452279
  Sleep    0.5s
Paso 146
  Set Location    21.0691172     -86.8456003
  Sleep    0.5s
Paso 147
  Set Location    21.0691172     -86.8456003
  Sleep    0.5s
Paso 148
  Set Location    21.0663616     -86.8460364
  Sleep    0.5s
Paso 149
  Set Location    21.0663616     -86.8460364
  Sleep    0.5s
Paso 150
  Set Location    21.0636054     -86.8464714
  Sleep    0.5s
Paso 151
  Set Location    21.0636054     -86.8464714
  Sleep    0.5s
Paso 152
  Set Location    21.0608787     -86.8468915
  Sleep    0.5s
Paso 153
  Set Location    21.0608787     -86.8468915
  Sleep    0.5s
Paso 154
  Set Location    21.0581519     -86.8473133
  Sleep    0.5s
Paso 155
  Set Location    21.0581519     -86.8473133
  Sleep    0.5s
Paso 156
  Set Location    21.0554339     -86.847743
  Sleep    0.5s
Paso 157
  Set Location    21.0554339     -86.847743
  Sleep    0.5s
Paso 158
  Set Location    21.05271     -86.848173
  Sleep    0.5s
Paso 159
  Set Location    21.05271     -86.848173
  Sleep    0.5s
Paso 160
  Set Location    21.0501248     -86.8485764
  Sleep    0.5s
Paso 161
  Set Location    21.0501248     -86.8485764
  Sleep    0.5s
Paso 162
  Set Location    21.0475501     -86.8489299
  Sleep    0.5s
Paso 163
  Set Location    21.0475501     -86.8489299
  Sleep    0.5s
Paso 164
  Set Location    21.0449633     -86.8493744
  Sleep    0.5s
Paso 165
  Set Location    21.0449633     -86.8493744
  Sleep    0.5s
Paso 166
  Set Location    21.0423919     -86.8497915
  Sleep    0.5s
Paso 167
  Set Location    21.0423919     -86.8497915
  Sleep    0.5s
Paso 168
  Set Location    21.0398117     -86.8502113
  Sleep    0.5s
Paso 169
  Set Location    21.0398117     -86.8502113
  Sleep    0.5s
Paso 170
  Set Location    21.037577     -86.8507174
  Sleep    0.5s
Paso 171
  Set Location    21.037577     -86.8507174
  Sleep    0.5s
Paso 172
  Set Location    21.0354282     -86.8516426
  Sleep    0.5s
Paso 173
  Set Location    21.0354282     -86.8516426
  Sleep    0.5s
Paso 174
  Set Location    21.0342345     -86.8537365
  Sleep    0.5s
Paso 175
  Set Location    21.0342345     -86.8537365
  Sleep    0.5s
Paso 176
  Set Location    21.0346012     -86.8556434
  Sleep    0.5s
Paso 177
  Set Location    21.0346012     -86.8556434
  Sleep    0.5s
Paso 178
  Set Location    21.035628     -86.8573921
  Sleep    0.5s
Paso 179
  Set Location    21.035628     -86.8573921
  Sleep    0.5s
Paso 180
  Set Location    21.0358909     -86.8577896
  Sleep    0.5s
Paso 181
  Set Location    21.0358909     -86.8577896
  Sleep    0.5s
Paso 182
  Set Location    21.0367614     -86.859083
  Sleep    0.5s
Paso 183
  Set Location    21.0367614     -86.859083
  Sleep    0.5s
Paso 184
  Set Location    21.0369247     -86.8593398
  Sleep    0.5s
Paso 185
  Set Location    21.0369247     -86.8593398
  Sleep    0.5s
Paso 186
  Set Location    21.0376712     -86.8606129
  Sleep    0.5s
Paso 187
  Set Location    21.0376712     -86.8606129
  Sleep    0.5s
Paso 188
  Set Location    21.0388831     -86.8625638
  Sleep    0.5s
Paso 189
  Set Location    21.0388831     -86.8625638
  Sleep    0.5s
Paso 190
  Set Location    21.0391583     -86.8629934
  Sleep    0.5s
Paso 191
  Set Location    21.0391583     -86.8629934
  Sleep    0.5s
Paso 192
  Set Location    21.0406318     -86.8654017
  Sleep    0.5s
Paso 193
  Set Location    21.0406318     -86.8654017
  Sleep    0.5s
Paso 194
  Set Location    21.0421927     -86.8678517
  Sleep    0.5s
Paso 195
  Set Location    21.0421927     -86.8678517
  Sleep    0.5s
Paso 196
  Set Location    21.0437477     -86.8703065
  Sleep    0.5s
Paso 197
  Set Location    21.0437477     -86.8703065
  Sleep    0.5s
Paso 198
  Set Location    21.0452065     -86.8725864
  Sleep    0.5s
Paso 199
  Set Location    21.0452065     -86.8725864
  Sleep    0.5s
Paso 200
  Set Location    21.0464962     -86.8747648
  Sleep    0.5s
Paso 201
  Set Location    21.0464962     -86.8747648
  Sleep    0.5s
Paso 202
  Set Location    21.0457449     -86.8766865
  Sleep    0.5s
Paso 203
  Set Location    21.0457449     -86.8766865
  Sleep    0.5s
Paso 204
  Set Location    21.0464549     -86.8781372
  Sleep    0.5s
Paso 205
  Set Location    21.0464549     -86.8781372
  Sleep    0.5s
Paso 206
  Set Location    21.0469731     -86.8789702
  Sleep    0.5s
Paso 207
  Set Location    21.0469731     -86.8789702
  Sleep    0.5s
Paso 208
  Set Location    21.0471742     -86.8794033
  Sleep    0.5s
Paso 209
  Set Location    21.0471742     -86.8794033
  Sleep    0.5s
Paso 210
  Set Location    21.0465828     -86.8799135
  Sleep    0.5s
Paso 211
  Set Location    21.0465828     -86.8799135
  Sleep    0.5s
Paso 212
  Set Location    21.046575     -86.8799217
  Sleep    0.5s
Paso 213
  Set Location    21.046575     -86.8799217
  Sleep    0.5s
Paso 214
  Set Location    21.0464784     -86.880038
  Sleep    0.5s
Paso 215
  Set Location    21.0464784     -86.880038
  Sleep    0.5s
Paso 216
  Set Location    21.0459374     -86.8804133
  Sleep    0.5s
Paso 217
  Set Location    21.0459374     -86.8804133
  Sleep    0.5s
Paso 218
  Set Location    21.0452434     -86.8809339
  Sleep    0.5s
Paso 219
  Set Location    21.0452434     -86.8809339
  Sleep    0.5s
Paso 220
  Set Location    21.0452544     -86.8802757
  Sleep    0.5s
Paso 221
  Set Location    21.0452544     -86.8802757
  Sleep    0.5s
Paso 222
  Set Location    21.0452733     -86.8802717
  Sleep    0.5s
Paso 223
  Set Location    21.0452733     -86.8802717
  Sleep    0.5s
Paso 224
  Set Location    21.0453712     -86.8802188
  Sleep    0.5s
Paso 225
  Set Location    21.0453712     -86.8802188
  Sleep    0.5s
Paso 226
  Set Location    21.0453857     -86.8794339
  Sleep    0.5s
Paso 227
  Set Location    21.0453857     -86.8794339
  Sleep    0.5s
Paso 228
  Set Location    21.0444127     -86.8779453
  Sleep    0.5s
Paso 229
  Set Location    21.0444127     -86.8779453
  Sleep    0.5s
Paso 230
  Set Location    21.0435317     -86.8779553
  Sleep    0.5s
Paso 231
  Set Location    21.0435317     -86.8779553
  Sleep    0.5s
Paso 232
  Set Location    21.042725     -86.8767647
  Sleep    0.5s
Paso 233
  Set Location    21.042725     -86.8767647
  Sleep    0.5s
Paso 234
  Set Location    21.0423567     -86.875783
  Sleep    0.5s
Paso 235
  Set Location    21.0423567     -86.875783
  Sleep    0.5s
Paso 236
  Set Location    21.0428919     -86.8751996
  Sleep    0.5s
Paso 237
  Set Location    21.0428919     -86.8751996
  Sleep    0.5s
Paso 238
  Set Location    21.042292     -86.8742084
  Sleep    0.5s
Paso 239
  Set Location    21.042292     -86.8742084
  Sleep    0.5s
Paso 240
  Set Location    21.0418803     -86.8737577
  Sleep    0.5s
Paso 241
  Set Location    21.0418803     -86.8737577
  Sleep    0.5s
Paso 242
  Set Location    21.0412286     -86.8741676
  Sleep    0.5s
Paso 243
  Set Location    21.0412286     -86.8741676
  Sleep    0.5s
Paso 244
  Set Location    21.0409065     -86.8737957
  Sleep    0.5s
Paso 245
  Set Location    21.0409065     -86.8737957
  Sleep    0.5s
Paso 246
  Set Location    21.0405384     -86.8732511
  Sleep    0.5s
Paso 247
  Set Location    21.0405384     -86.8732511
  Sleep    0.5s
Paso 248
  Set Location    21.0402547     -86.8728142
  Sleep    0.5s
Paso 249
  Set Location    21.0402547     -86.8728142
  Sleep    0.5s
Paso 250
  Set Location    21.0399515     -86.8721701
  Sleep    0.5s
Paso 251
  Set Location    21.0399515     -86.8721701
  Sleep    0.5s
Paso 252
  Set Location    21.0400483     -86.8720267
  Sleep    0.5s
Paso 253
  Set Location    21.0400483     -86.8720267
  Sleep    0.5s
Paso 254
  Set Location    21.0400807     -86.8720014
  Sleep    0.5s
Paso 255
  Set Location    21.0400807     -86.8720014
  Sleep    0.5s
Paso 256
  Set Location    21.0404066     -86.8714305
  Sleep    0.5s
Paso 257
  Set Location    21.0404066     -86.8714305
  Sleep    0.5s
Paso 258
  Set Location    21.0398953     -86.8705826
  Sleep    0.5s
Paso 259
  Set Location    21.0398953     -86.8705826
  Sleep    0.5s
Paso 260
  Set Location    21.0388961     -86.869946
  Sleep    0.5s
Paso 261
  Set Location    21.0388961     -86.869946
  Sleep    0.5s
Paso 262
  Set Location    21.0382893     -86.8692206
  Sleep    0.5s
Paso 263
  Set Location    21.0382893     -86.8692206
  Sleep    0.5s
Paso 264
  Set Location    21.0382917     -86.8692233
  Sleep    0.5s
Paso 265
  Set Location    21.0382917     -86.8692233
  Sleep    0.5s
Paso 266
  Set Location    21.03818     -86.8689902
  Sleep    0.5s
Paso 267
  Set Location    21.03818     -86.8689902
  Sleep    0.5s
Paso 268
  Set Location    21.0384043     -86.8684254
  Sleep    0.5s
Paso 269
  Set Location    21.0384043     -86.8684254
  Sleep    0.5s
Paso 270
  Set Location    21.0390919     -86.8693931
  Sleep    0.5s
Paso 271
  Set Location    21.0390919     -86.8693931
  Sleep    0.5s
Paso 272
  Set Location    21.0390097     -86.8701015
  Sleep    0.5s
Paso 273
  Set Location    21.0390097     -86.8701015
  Sleep    0.5s
Paso 274
  Set Location    21.0382336     -86.8706342
  Sleep    0.5s
Paso 275
  Set Location    21.0382336     -86.8706342
  Sleep    0.5s
Paso 276
  Set Location    21.0382983     -86.8713579
  Sleep    0.5s
Paso 277
  Set Location    21.0382983     -86.8713579
  Sleep    0.5s
Paso 278
  Set Location    21.0388074     -86.8721727
  Sleep    0.5s
Paso 279
  Set Location    21.0388074     -86.8721727
  Sleep    0.5s
Paso 280
  Set Location    21.0391667     -86.872647
  Sleep    0.5s
Paso 281
  Set Location    21.0391667     -86.872647
  Sleep    0.5s
Paso 282
  Set Location    21.0399683     -86.8720567
  Sleep    0.5s
Paso 283
  Set Location    21.0399683     -86.8720567
  Sleep    0.5s
Paso 284
  Set Location    21.0402458     -86.8719054
  Sleep    0.5s
Paso 285
  Set Location    21.0402458     -86.8719054
  Sleep    0.5s
Paso 286
  Set Location    21.0401629     -86.8709659
  Sleep    0.5s
Paso 287
  Set Location    21.0401629     -86.8709659
  Sleep    0.5s
Paso 288
  Set Location    21.0396646     -86.8696492
  Sleep    0.5s
Paso 289
  Set Location    21.0396646     -86.8696492
  Sleep    0.5s
Paso 290
  Set Location    21.0406937     -86.868889
  Sleep    0.5s
Paso 291
  Set Location    21.0406937     -86.868889
  Sleep    0.5s
Paso 292
  Set Location    21.0418697     -86.8677881
  Sleep    0.5s
Paso 293
  Set Location    21.0418697     -86.8677881
  Sleep    0.5s
Paso 294
  Set Location    21.0410192     -86.8661473
  Sleep    0.5s
Paso 295
  Set Location    21.0410192     -86.8661473
  Sleep    0.5s
Paso 296
  Set Location    21.0399138     -86.8643914
  Sleep    0.5s
Paso 297
  Set Location    21.0399138     -86.8643914
  Sleep    0.5s
Paso 298
  Set Location    21.0388642     -86.8626792
  Sleep    0.5s
Paso 299
  Set Location    21.0388642     -86.8626792
  Sleep    0.5s
Paso 300
  Set Location    21.0377134     -86.8608092
  Sleep    0.5s
Paso 301
  Set Location    21.0377134     -86.8608092
  Sleep    0.5s
Paso 302
  Set Location    21.0365786     -86.8589925
  Sleep    0.5s
Paso 303
  Set Location    21.0365786     -86.8589925
  Sleep    0.5s
Paso 304
  Set Location    21.0353688     -86.8570616
  Sleep    0.5s
Paso 305
  Set Location    21.0353688     -86.8570616
  Sleep    0.5s
Paso 306
  Set Location    21.03419     -86.8551848
  Sleep    0.5s
Paso 307
  Set Location    21.03419     -86.8551848
  Sleep    0.5s
Paso 308
  Set Location    21.0334367     -86.8533169
  Sleep    0.5s
Paso 309
  Set Location    21.0334367     -86.8533169
  Sleep    0.5s
Paso 310
  Set Location    21.0331714     -86.8515696
  Sleep    0.5s
Paso 311
  Set Location    21.0331714     -86.8515696
  Sleep    0.5s
Paso 312
  Set Location    21.0321906     -86.8511723
  Sleep    0.5s
Paso 313
  Set Location    21.0321906     -86.8511723
  Sleep    0.5s
Paso 314
  Set Location    21.0330283     -86.8518485
  Sleep    0.5s
Paso 315
  Set Location    21.0330283     -86.8518485
  Sleep    0.5s
Paso 316
  Set Location    21.0345512     -86.851554
  Sleep    0.5s
Paso 317
  Set Location    21.0345512     -86.851554
  Sleep    0.5s
Paso 318
  Set Location    21.0365353     -86.8508572
  Sleep    0.5s
Paso 319
  Set Location    21.0365353     -86.8508572
  Sleep    0.5s
Paso 320
  Set Location    21.0385425     -86.8502565
  Sleep    0.5s
Paso 321
  Set Location    21.0385425     -86.8502565
  Sleep    0.5s
Paso 322
  Set Location    21.0407601     -86.8499152
  Sleep    0.5s
Paso 323
  Set Location    21.0407601     -86.8499152
  Sleep    0.5s
Paso 324
  Set Location    21.0430568     -86.8495672
  Sleep    0.5s
Paso 325
  Set Location    21.0430568     -86.8495672
  Sleep    0.5s
Paso 326
  Set Location    21.0453246     -86.8492136
  Sleep    0.5s
Paso 327
  Set Location    21.0453246     -86.8492136
  Sleep    0.5s
Paso 328
  Set Location    21.0475467     -86.8488542
  Sleep    0.5s
Paso 329
  Set Location    21.0475467     -86.8488542
  Sleep    0.5s
Paso 330
  Set Location    21.0498906     -86.8485021
  Sleep    0.5s
Paso 331
  Set Location    21.0498906     -86.8485021
  Sleep    0.5s
Paso 332
  Set Location    21.0522994     -86.8481383
  Sleep    0.5s
Paso 333
  Set Location    21.0522994     -86.8481383
  Sleep    0.5s
Paso 334
  Set Location    21.0548232     -86.8477372
  Sleep    0.5s
Paso 335
  Set Location    21.0548232     -86.8477372
  Sleep    0.5s
Paso 336
  Set Location    21.0573464     -86.8473405
  Sleep    0.5s
Paso 337
  Set Location    21.0573464     -86.8473405
  Sleep    0.5s
Paso 338
  Set Location    21.0598169     -86.8469586
  Sleep    0.5s
Paso 339
  Set Location    21.0598169     -86.8469586
  Sleep    0.5s
Paso 340
  Set Location    21.0623587     -86.8465336
  Sleep    0.5s
Paso 341
  Set Location    21.0623587     -86.8465336
  Sleep    0.5s
Paso 342
  Set Location    21.0648981     -86.8461539
  Sleep    0.5s
Paso 343
  Set Location    21.0648981     -86.8461539
  Sleep    0.5s
Paso 344
  Set Location    21.0674437     -86.8457682
  Sleep    0.5s
Paso 345
  Set Location    21.0674437     -86.8457682
  Sleep    0.5s
Paso 346
  Set Location    21.0700365     -86.8453947
  Sleep    0.5s
Paso 347
  Set Location    21.0700365     -86.8453947
  Sleep    0.5s
Paso 348
  Set Location    21.0725938     -86.8450035
  Sleep    0.5s
Paso 349
  Set Location    21.0725938     -86.8450035
  Sleep    0.5s
Paso 350
  Set Location    21.0751749     -86.8446149
  Sleep    0.5s
Paso 351
  Set Location    21.0751749     -86.8446149
  Sleep    0.5s
Paso 352
  Set Location    21.0776651     -86.8441959
  Sleep    0.5s
Paso 353
  Set Location    21.0776651     -86.8441959
  Sleep    0.5s
Paso 354
  Set Location    21.0786807     -86.8440409
  Sleep    0.5s
Paso 355
  Set Location    21.0786807     -86.8440409
  Sleep    0.5s
Paso 356
  Set Location    21.0812066     -86.8436485
  Sleep    0.5s
Paso 357
  Set Location    21.0812066     -86.8436485
  Sleep    0.5s
Paso 358
  Set Location    21.0836846     -86.8432574
  Sleep    0.5s
Paso 359
  Set Location    21.0836846     -86.8432574
  Sleep    0.5s
Paso 360
  Set Location    21.0859305     -86.8427687
  Sleep    0.5s
Paso 361
  Set Location    21.0859305     -86.8427687
  Sleep    0.5s
Paso 362
  Set Location    21.0876076     -86.8424001
  Sleep    0.5s
Paso 363
  Set Location    21.0876076     -86.8424001
  Sleep    0.5s
Paso 364
  Set Location    21.0877497     -86.842332
  Sleep    0.5s
Paso 365
  Set Location    21.0877497     -86.842332
  Sleep    0.5s
Paso 366
  Set Location    21.0885329     -86.8423153
  Sleep    0.5s
Paso 367
  Set Location    21.0885329     -86.8423153
  Sleep    0.5s
Paso 368
  Set Location    21.0887768     -86.8423032
  Sleep    0.5s
Paso 369
  Set Location    21.0887768     -86.8423032
  Sleep    0.5s
Paso 370
  Set Location    21.0898297     -86.8421371
  Sleep    0.5s
Paso 371
  Set Location    21.0898297     -86.8421371
  Sleep    0.5s
Paso 372
  Set Location    21.0915697     -86.8419324
  Sleep    0.5s
Paso 373
  Set Location    21.0915697     -86.8419324
  Sleep    0.5s
Paso 374
  Set Location    21.0938062     -86.8416389
  Sleep    0.5s
Paso 375
  Set Location    21.0938062     -86.8416389
  Sleep    0.5s
Paso 376
  Set Location    21.0962133     -86.8412814
  Sleep    0.5s
Paso 377
  Set Location    21.0962133     -86.8412814
  Sleep    0.5s
Paso 378
  Set Location    21.0985776     -86.8409162
  Sleep    0.5s
Paso 379
  Set Location    21.0985776     -86.8409162
  Sleep    0.5s
Paso 380
  Set Location    21.1004187     -86.8406082
  Sleep    0.5s
Paso 381
  Set Location    21.1004187     -86.8406082
  Sleep    0.5s
Paso 382
  Set Location    21.1013026     -86.8404808
  Sleep    0.5s
Paso 383
  Set Location    21.1013026     -86.8404808
  Sleep    0.5s
Paso 384
  Set Location    21.1026901     -86.8402852
  Sleep    0.5s
Paso 385
  Set Location    21.1026901     -86.8402852
  Sleep    0.5s
Paso 386
  Set Location    21.1054968     -86.8398633
  Sleep    0.5s
Paso 387
  Set Location    21.1054968     -86.8398633
  Sleep    0.5s
Paso 388
  Set Location    21.1079671     -86.8394597
  Sleep    0.5s
Paso 389
  Set Location    21.1079671     -86.8394597
  Sleep    0.5s
Paso 390
  Set Location    21.1102827     -86.8391007
  Sleep    0.5s
Paso 391
  Set Location    21.1102827     -86.8391007
  Sleep    0.5s
Paso 392
  Set Location    21.112661     -86.8386194
  Sleep    0.5s
Paso 393
  Set Location    21.112661     -86.8386194
  Sleep    0.5s
Paso 394
  Set Location    21.1149381     -86.8375155
  Sleep    0.5s
Paso 395
  Set Location    21.1149381     -86.8375155
  Sleep    0.5s
Paso 396
  Set Location    21.1172752     -86.8363638
  Sleep    0.5s
Paso 397
  Set Location    21.1172752     -86.8363638
  Sleep    0.5s
Paso 398
  Set Location    21.1197072     -86.8351622
  Sleep    0.5s
Paso 399
  Set Location    21.1197072     -86.8351622
  Sleep    0.5s
Paso 400
  Set Location    21.1221314     -86.8339801
  Sleep    0.5s
Paso 401
  Set Location    21.1221314     -86.8339801
  Sleep    0.5s
Paso 402
  Set Location    21.1244331     -86.8328732
  Sleep    0.5s
Paso 403
  Set Location    21.1244331     -86.8328732
  Sleep    0.5s
Paso 404
  Set Location    21.1261918     -86.8320216
  Sleep    0.5s
Paso 405
  Set Location    21.1261918     -86.8320216
  Sleep    0.5s
Paso 406
  Set Location    21.1284904     -86.8309059
  Sleep    0.5s
Paso 407
  Set Location    21.1284904     -86.8309059
  Sleep    0.5s
Paso 408
  Set Location    21.1308989     -86.8297518
  Sleep    0.5s
Paso 409
  Set Location    21.1308989     -86.8297518
  Sleep    0.5s
Paso 410
  Set Location    21.1330279     -86.8286684
  Sleep    0.5s
Paso 411
  Set Location    21.1330279     -86.8286684
  Sleep    0.5s
Paso 412
  Set Location    21.1352949     -86.8275725
  Sleep    0.5s
Paso 413
  Set Location    21.1352949     -86.8275725
  Sleep    0.5s
Paso 414
  Set Location    21.1373314     -86.8265864
  Sleep    0.5s
Paso 415
  Set Location    21.1373314     -86.8265864
  Sleep    0.5s
Paso 416
  Set Location    21.1386871     -86.82597
  Sleep    0.5s
Paso 417
  Set Location    21.1386871     -86.82597
  Sleep    0.5s
Paso 418
  Set Location    21.1397122     -86.8253415
  Sleep    0.5s
Paso 419
  Set Location    21.1397122     -86.8253415
  Sleep    0.5s
Paso 420
  Set Location    21.1415601     -86.824546
  Sleep    0.5s
Paso 421
  Set Location    21.1415601     -86.824546
  Sleep    0.5s
Paso 422
  Set Location    21.1430386     -86.8242317
  Sleep    0.5s
Paso 423
  Set Location    21.1430386     -86.8242317
  Sleep    0.5s
Paso 424
  Set Location    21.143337     -86.8242201
  Sleep    0.5s
Paso 425
  Set Location    21.143337     -86.8242201
  Sleep    0.5s
Paso 426
  Set Location    21.1445043     -86.8243017
  Sleep    0.5s
Paso 427
  Set Location    21.1445043     -86.8243017
  Sleep    0.5s
Paso 428
  Set Location    21.1459594     -86.8244668
  Sleep    0.5s
Paso 429
  Set Location    21.1459594     -86.8244668
  Sleep    0.5s
Paso 430
  Set Location    21.1466068     -86.8244867
  Sleep    0.5s
Paso 431
  Set Location    21.1466068     -86.8244867
  Sleep    0.5s
Paso 432
  Set Location    21.1466067     -86.8244867
  Sleep    0.5s
Paso 433
  Set Location    21.1466067     -86.8244867
  Sleep    0.5s
Paso 434
  Set Location    21.147418     -86.8245903
  Sleep    0.5s
Paso 435
  Set Location    21.147418     -86.8245903
  Sleep    0.5s
Paso 436
  Set Location    21.1492024     -86.8246249
  Sleep    0.5s
Paso 437
  Set Location    21.1492024     -86.8246249
  Sleep    0.5s
Paso 438
  Set Location    21.1510578     -86.8248795
  Sleep    0.5s
Paso 439
  Set Location    21.1510578     -86.8248795
  Sleep    0.5s
Paso 440
  Set Location    21.1530376     -86.8250202
  Sleep    0.5s
Paso 441
  Set Location    21.1530376     -86.8250202
  Sleep    0.5s
Paso 442
  Set Location    21.1549521     -86.8251622
  Sleep    0.5s
Paso 443
  Set Location    21.1549521     -86.8251622
  Sleep    0.5s
Paso 444
  Set Location    21.1562544     -86.8252633
  Sleep    0.5s
Paso 445
  Set Location    21.1562544     -86.8252633
  Sleep    0.5s
Paso 446
  Set Location    21.1563217     -86.8252683
  Sleep    0.5s
Paso 447
  Set Location    21.1563217     -86.8252683
  Sleep    0.5s
Paso 448
  Set Location    21.157011     -86.8251278
  Sleep    0.5s
Paso 449
  Set Location    21.157011     -86.8251278
  Sleep    0.5s
Paso 450
  Set Location    21.1580819     -86.8254086
  Sleep    0.5s
Paso 451
  Set Location    21.1580819     -86.8254086
  Sleep    0.5s
Paso 452
  Set Location    21.1585319     -86.8254586
  Sleep    0.5s
Paso 453
  Set Location    21.1585319     -86.8254586
  Sleep    0.5s
Paso 454
  Set Location    21.1596186     -86.8255455
  Sleep    0.5s
Paso 455
  Set Location    21.1596186     -86.8255455
  Sleep    0.5s
Paso 456
  Set Location    21.1606682     -86.8256031
  Sleep    0.5s
Paso 457
  Set Location    21.1606682     -86.8256031
  Sleep    0.5s
Paso 458
  Set Location    21.1617897     -86.8256966
  Sleep    0.5s
Paso 459
  Set Location    21.1617897     -86.8256966
  Sleep    0.5s
Paso 460
  Set Location    21.1627464     -86.8257356
  Sleep    0.5s
Paso 461
  Set Location    21.1627464     -86.8257356
  Sleep    0.5s
Paso 462
  Set Location    21.1627467     -86.825735
  Sleep    0.5s
Paso 463
  Set Location    21.1627467     -86.825735
  Sleep    0.5s
Paso 464
  Set Location    21.1628717     -86.82573
  Sleep    0.5s
Paso 465
  Set Location    21.1628717     -86.82573
  Sleep    0.5s
Paso 466
  Set Location    21.1633076     -86.8254312
  Sleep    0.5s
Paso 467
  Set Location    21.1633076     -86.8254312
  Sleep    0.5s
Paso 468
  Set Location    21.1641993     -86.8258129
  Sleep    0.5s
Paso 469
  Set Location    21.1641993     -86.8258129
  Sleep    0.5s
Paso 470
  Set Location    21.1639625     -86.8266724
  Sleep    0.5s
Paso 471
  Set Location    21.1639625     -86.8266724
  Sleep    0.5s
Paso 472
  Set Location    21.1643641     -86.8263636
  Sleep    0.5s
Paso 473
  Set Location    21.1643641     -86.8263636
  Sleep    0.5s
Paso 474
  Set Location    21.164365     -86.826365
  Sleep    0.5s
Paso 475
  Set Location    21.164365     -86.826365
  Sleep    0.5s
Paso 476
  Set Location    21.1643017     -86.8262567
  Sleep    0.5s
Paso 477
  Set Location    21.1643017     -86.8262567
  Sleep    0.5s
Paso 478
  Set Location    21.1641685     -86.8262106
  Sleep    0.5s
Paso 479
  Set Location    21.1641685     -86.8262106
  Sleep    0.5s
Paso 480
  Set Location    21.1641317     -86.8262133
  Sleep    0.5s
Paso 481
  Set Location    21.1641317     -86.8262133
  Sleep    0.5s
Paso 482
  Set Location    21.1644067     -86.826225
  Sleep    0.5s
Paso 483
  Set Location    21.1644067     -86.826225
  Sleep    0.5s
Paso 484
  Set Location    21.1644963     -86.8262563
  Sleep    0.5s
Paso 485
  Set Location    21.1644963     -86.8262563
  Sleep    0.5s
Paso 486
  Set Location    21.1644967     -86.8262567
  Sleep    0.5s
Paso 487
  Set Location    21.1644967     -86.8262567
  Sleep    0.5s
Paso 488
  Set Location    21.1644352     -86.8263204
  Sleep    0.5s
Paso 489
  Set Location    21.1644352     -86.8263204
  Sleep    0.5s
Paso 490
  Set Location    21.1644233     -86.8263733
  Sleep    0.5s
Paso 491
  Set Location    21.1644233     -86.8263733
  Sleep    0.5s
Paso 492
  Set Location    21.1643383     -86.826295
  Sleep    0.5s
Paso 493
  Set Location    21.1643383     -86.826295
  Sleep    0.5s
Paso 494
  Set Location    21.1644091     -86.8262693
  Sleep    0.5s
Paso 495
  Set Location    21.1644091     -86.8262693
  Sleep    0.5s
Paso 496
  Set Location    21.1642696     -86.8261204
  Sleep    0.5s
Paso 497
  Set Location    21.1642696     -86.8261204
  Sleep    0.5s
Paso 498
  Set Location    21.1637519     -86.8262005
  Sleep    0.5s
Paso 499
  Set Location    21.1637519     -86.8262005
  Sleep    0.5s
Paso 500
  Set Location    21.1626852     -86.8257821
  Sleep    0.5s
Paso 501
  Set Location    21.1626852     -86.8257821
  Sleep    0.5s
Paso 502
  Set Location    21.1617629     -86.8257097
  Sleep    0.5s
Paso 503
  Set Location    21.1617629     -86.8257097
  Sleep    0.5s
Paso 504
  Set Location    21.161541     -86.8256946
  Sleep    0.5s
Paso 505
  Set Location    21.161541     -86.8256946
  Sleep    0.5s
Paso 506
  Set Location    21.1613816     -86.8256797
  Sleep    0.5s
Paso 507
  Set Location    21.1613816     -86.8256797
  Sleep    0.5s
Paso 508
  Set Location    21.1604513     -86.8256144
  Sleep    0.5s
Paso 509
  Set Location    21.1604513     -86.8256144
  Sleep    0.5s
Paso 510
  Set Location    21.159679     -86.8255521
  Sleep    0.5s
Paso 511
  Set Location    21.159679     -86.8255521
  Sleep    0.5s
Paso 512
  Set Location    21.1587158     -86.8254849
  Sleep    0.5s
Paso 513
  Set Location    21.1587158     -86.8254849
  Sleep    0.5s
Paso 514
  Set Location    21.1584917     -86.8254683
  Sleep    0.5s
Paso 515
  Set Location    21.1584917     -86.8254683
  Sleep    0.5s
Paso 516
  Set Location    21.158216     -86.8254527
  Sleep    0.5s
Paso 517
  Set Location    21.158216     -86.8254527
  Sleep    0.5s
Paso 518
  Set Location    21.1574967     -86.8254584
  Sleep    0.5s
Paso 519
  Set Location    21.1574967     -86.8254584
  Sleep    0.5s
Paso 520
  Set Location    21.1574933     -86.8254617
  Sleep    0.5s
Paso 521
  Set Location    21.1574933     -86.8254617
  Sleep    0.5s
Paso 522
  Set Location    21.1566087     -86.8254076
  Sleep    0.5s
Paso 523
  Set Location    21.1566087     -86.8254076
  Sleep    0.5s
Paso 524
  Set Location    21.155339     -86.8252282
  Sleep    0.5s
Paso 525
  Set Location    21.155339     -86.8252282
  Sleep    0.5s
Paso 526
  Set Location    21.1533282     -86.8250964
  Sleep    0.5s
Paso 527
  Set Location    21.1533282     -86.8250964
  Sleep    0.5s
Paso 528
  Set Location    21.1515985     -86.8249564
  Sleep    0.5s
Paso 529
  Set Location    21.1515985     -86.8249564
  Sleep    0.5s
Paso 530
  Set Location    21.1507736     -86.8249249
  Sleep    0.5s
Paso 531
  Set Location    21.1507736     -86.8249249
  Sleep    0.5s
Paso 532
  Set Location    21.1500155     -86.8249183
  Sleep    0.5s
Paso 533
  Set Location    21.1500155     -86.8249183
  Sleep    0.5s
Paso 534
  Set Location    21.1483151     -86.8247412
  Sleep    0.5s
Paso 535
  Set Location    21.1483151     -86.8247412
  Sleep    0.5s
Paso 536
  Set Location    21.1475699     -86.8247886
  Sleep    0.5s
Paso 537
  Set Location    21.1475699     -86.8247886
  Sleep    0.5s
Paso 538
  Set Location    21.14757     -86.8247883
  Sleep    0.5s
Paso 539
  Set Location    21.14757     -86.8247883
  Sleep    0.5s
Paso 540
  Set Location    21.1468428     -86.8247529
  Sleep    0.5s
Paso 541
  Set Location    21.1468428     -86.8247529
  Sleep    0.5s
Paso 542
  Set Location    21.1455504     -86.8246695
  Sleep    0.5s
Paso 543
  Set Location    21.1455504     -86.8246695
  Sleep    0.5s
Paso 544
  Set Location    21.1447781     -86.8246626
  Sleep    0.5s
Paso 545
  Set Location    21.1447781     -86.8246626
  Sleep    0.5s
Paso 546
  Set Location    21.1444522     -86.8246837
  Sleep    0.5s
Paso 547
  Set Location    21.1444522     -86.8246837
  Sleep    0.5s
Paso 548
  Set Location    21.1438392     -86.8247353
  Sleep    0.5s
Paso 549
  Set Location    21.1438392     -86.8247353
  Sleep    0.5s
Paso 550
  Set Location    21.1438017     -86.8247133
  Sleep    0.5s
Paso 551
  Set Location    21.1438017     -86.8247133
  Sleep    0.5s
Paso 552
  Set Location    21.1426923     -86.8244815
  Sleep    0.5s
Paso 553
  Set Location    21.1426923     -86.8244815
  Sleep    0.5s
Paso 554
  Set Location    21.1423519     -86.8245142
  Sleep    0.5s
Paso 555
  Set Location    21.1423519     -86.8245142
  Sleep    0.5s
Paso 556
  Set Location    21.140842     -86.8250503
  Sleep    0.5s
Paso 557
  Set Location    21.140842     -86.8250503
  Sleep    0.5s
Paso 558
  Set Location    21.1388347     -86.825924
  Sleep    0.5s
Paso 559
  Set Location    21.1388347     -86.825924
  Sleep    0.5s
Paso 560
  Set Location    21.1364439     -86.8270794
  Sleep    0.5s
Paso 561
  Set Location    21.1364439     -86.8270794
  Sleep    0.5s
Paso 562
  Set Location    21.1338962     -86.8283158
  Sleep    0.5s
Paso 563
  Set Location    21.1338962     -86.8283158
  Sleep    0.5s
Paso 564
  Set Location    21.1313188     -86.8295527
  Sleep    0.5s
Paso 565
  Set Location    21.1313188     -86.8295527
  Sleep    0.5s
Paso 566
  Set Location    21.1287828     -86.8307955
  Sleep    0.5s
Paso 567
  Set Location    21.1287828     -86.8307955
  Sleep    0.5s
Paso 568
  Set Location    21.1264355     -86.8319718
  Sleep    0.5s
Paso 569
  Set Location    21.1264355     -86.8319718
  Sleep    0.5s
Paso 570
  Set Location    21.1241965     -86.8330549
  Sleep    0.5s
Paso 571
  Set Location    21.1241965     -86.8330549
  Sleep    0.5s
Paso 572
  Set Location    21.1226163     -86.8338254
  Sleep    0.5s
Paso 573
  Set Location    21.1226163     -86.8338254
  Sleep    0.5s
Paso 574
  Set Location    21.1221339     -86.8340727
  Sleep    0.5s
Paso 575
  Set Location    21.1221339     -86.8340727
  Sleep    0.5s
Paso 576
  Set Location    21.1209556     -86.8346449
  Sleep    0.5s
Paso 577
  Set Location    21.1209556     -86.8346449
  Sleep    0.5s
Paso 578
  Set Location    21.1190781     -86.8355595
  Sleep    0.5s
Paso 579
  Set Location    21.1190781     -86.8355595
  Sleep    0.5s
Paso 580
  Set Location    21.1168299     -86.8366532
  Sleep    0.5s
Paso 581
  Set Location    21.1168299     -86.8366532
  Sleep    0.5s
Paso 582
  Set Location    21.1146453     -86.8377327
  Sleep    0.5s
Paso 583
  Set Location    21.1146453     -86.8377327
  Sleep    0.5s
Paso 584
  Set Location    21.1122852     -86.83881
  Sleep    0.5s
Paso 585
  Set Location    21.1122852     -86.83881
  Sleep    0.5s
Paso 586
  Set Location    21.1097344     -86.839248
  Sleep    0.5s
Paso 587
  Set Location    21.1097344     -86.839248
  Sleep    0.5s
Paso 588
  Set Location    21.1071483     -86.8396482
  Sleep    0.5s
Paso 589
  Set Location    21.1071483     -86.8396482
  Sleep    0.5s
Paso 590
  Set Location    21.1046231     -86.8400533
  Sleep    0.5s
Paso 591
  Set Location    21.1046231     -86.8400533
  Sleep    0.5s
Paso 592
  Set Location    21.1025987     -86.840412
  Sleep    0.5s
Paso 593
  Set Location    21.1025987     -86.840412
  Sleep    0.5s
Paso 594
  Set Location    21.1021334     -86.84048
  Sleep    0.5s
Paso 595
  Set Location    21.1021334     -86.84048
  Sleep    0.5s
Paso 596
  Set Location    21.1015824     -86.8405464
  Sleep    0.5s
Paso 597
  Set Location    21.1015824     -86.8405464
  Sleep    0.5s
Paso 598
  Set Location    21.0999725     -86.8408006
  Sleep    0.5s
Paso 599
  Set Location    21.0999725     -86.8408006
  Sleep    0.5s
Paso 600
  Set Location    21.0977951     -86.8411272
  Sleep    0.5s
Paso 601
  Set Location    21.0977951     -86.8411272
  Sleep    0.5s
Paso 602
  Set Location    21.0954583     -86.8414969
  Sleep    0.5s
Paso 603
  Set Location    21.0954583     -86.8414969
  Sleep    0.5s
Paso 604
  Set Location    21.0945307     -86.8416491
  Sleep    0.5s
Paso 605
  Set Location    21.0945307     -86.8416491
  Sleep    0.5s
Paso 606
  Set Location    21.0901352     -86.8422575
  Sleep    0.5s
Paso 607
  Set Location    21.0901352     -86.8422575
  Sleep    0.5s
Paso 608
  Set Location    21.0877294     -86.8426166
  Sleep    0.5s
Paso 609
  Set Location    21.0877294     -86.8426166
  Sleep    0.5s
Paso 610
  Set Location    21.0853301     -86.8430469
  Sleep    0.5s
Paso 611
  Set Location    21.0853301     -86.8430469
  Sleep    0.5s
Paso 612
  Set Location    21.0827358     -86.8435046
  Sleep    0.5s
Paso 613
  Set Location    21.0827358     -86.8435046
  Sleep    0.5s
Paso 614
  Set Location    21.080145     -86.8438959
  Sleep    0.5s
Paso 615
  Set Location    21.080145     -86.8438959
  Sleep    0.5s
Paso 616
  Set Location    21.0776003     -86.8442765
  Sleep    0.5s
Paso 617
  Set Location    21.0776003     -86.8442765
  Sleep    0.5s
Paso 618
  Set Location    21.0750777     -86.8446862
  Sleep    0.5s
Paso 619
  Set Location    21.0750777     -86.8446862
  Sleep    0.5s
Paso 620
  Set Location    21.0730165     -86.8450077
  Sleep    0.5s
Paso 621
  Set Location    21.0730165     -86.8450077
  Sleep    0.5s
Paso 622
  Set Location    21.0703524     -86.8454143
  Sleep    0.5s
Paso 623
  Set Location    21.0703524     -86.8454143
  Sleep    0.5s
Paso 624
  Set Location    21.0682069     -86.8457534
  Sleep    0.5s
Paso 625
  Set Location    21.0682069     -86.8457534
  Sleep    0.5s
Paso 626
  Set Location    21.0650157     -86.8462496
  Sleep    0.5s
Paso 627
  Set Location    21.0650157     -86.8462496
  Sleep    0.5s
Paso 628
  Set Location    21.0622803     -86.8466848
  Sleep    0.5s
Paso 629
  Set Location    21.0622803     -86.8466848
  Sleep    0.5s
Paso 630
  Set Location    21.0596159     -86.8470916
  Sleep    0.5s
Paso 631
  Set Location    21.0596159     -86.8470916
  Sleep    0.5s
Paso 632
  Set Location    21.0569134     -86.8475079
  Sleep    0.5s
Paso 633
  Set Location    21.0569134     -86.8475079
  Sleep    0.5s
Paso 634
  Set Location    21.0542236     -86.8479333
  Sleep    0.5s
Paso 635
  Set Location    21.0542236     -86.8479333
  Sleep    0.5s
Paso 636
  Set Location    21.0517482     -86.8483263
  Sleep    0.5s
Paso 637
  Set Location    21.0517482     -86.8483263
  Sleep    0.5s
Paso 638
  Set Location    21.0492735     -86.8487077
  Sleep    0.5s
Paso 639
  Set Location    21.0492735     -86.8487077
  Sleep    0.5s
Paso 640
  Set Location    21.0467547     -86.8490829
  Sleep    0.5s
Paso 641
  Set Location    21.0467547     -86.8490829
  Sleep    0.5s
Paso 642
  Set Location    21.0443297     -86.8494733
  Sleep    0.5s
Paso 643
  Set Location    21.0443297     -86.8494733
  Sleep    0.5s
Paso 644
  Set Location    21.0419132     -86.8498479
  Sleep    0.5s
Paso 645
  Set Location    21.0419132     -86.8498479
  Sleep    0.5s
Paso 646
  Set Location    21.0394749     -86.8502469
  Sleep    0.5s
Paso 647
  Set Location    21.0394749     -86.8502469
  Sleep    0.5s
Paso 648
  Set Location    21.0372631     -86.8507978
  Sleep    0.5s
Paso 649
  Set Location    21.0372631     -86.8507978
  Sleep    0.5s
Paso 650
  Set Location    21.0352344     -86.8517705
  Sleep    0.5s
Paso 651
  Set Location    21.0352344     -86.8517705
  Sleep    0.5s
Paso 652
  Set Location    21.0342496     -86.8538274
  Sleep    0.5s
Paso 653
  Set Location    21.0342496     -86.8538274
  Sleep    0.5s
Paso 654
  Set Location    21.0348157     -86.8559776
  Sleep    0.5s
Paso 655
  Set Location    21.0348157     -86.8559776
  Sleep    0.5s
Paso 656
  Set Location    21.0361034     -86.857992
  Sleep    0.5s
Paso 657
  Set Location    21.0361034     -86.857992
  Sleep    0.5s
Paso 658
  Set Location    21.037423     -86.8600972
  Sleep    0.5s
Paso 659
  Set Location    21.037423     -86.8600972
  Sleep    0.5s
Paso 660
  Set Location    21.0387479     -86.8622771
  Sleep    0.5s
Paso 661
  Set Location    21.0387479     -86.8622771
  Sleep    0.5s
Paso 662
  Set Location    21.040042     -86.8643417
  Sleep    0.5s
Paso 663
  Set Location    21.040042     -86.8643417
  Sleep    0.5s
Paso 664
  Set Location    21.0413596     -86.8664814
  Sleep    0.5s
Paso 665
  Set Location    21.0413596     -86.8664814
  Sleep    0.5s
Paso 666
  Set Location    21.0427346     -86.868696
  Sleep    0.5s
Paso 667
  Set Location    21.0427346     -86.868696
  Sleep    0.5s
Paso 668
  Set Location    21.043842     -86.870465
  Sleep    0.5s
Paso 669
  Set Location    21.043842     -86.870465
  Sleep    0.5s
Paso 670
  Set Location    21.0460165     -86.8739049
  Sleep    0.5s
Paso 671
  Set Location    21.0460165     -86.8739049
  Sleep    0.5s
Paso 672
  Set Location    21.0463796     -86.8759547
  Sleep    0.5s
Paso 673
  Set Location    21.0463796     -86.8759547
  Sleep    0.5s
Paso 674
  Set Location    21.045912     -86.8803976
  Sleep    0.5s
Paso 675
  Set Location    21.045912     -86.8803976
  Sleep    0.5s
Paso 676
  Set Location    21.045912     -86.8803976
  Sleep    0.5s
Paso 677
  Set Location    21.0449275     -86.8808581
  Sleep    0.5s
Paso 678
  Set Location    21.0449275     -86.8808581
  Sleep    0.5s
Paso 679
  Set Location    21.0454164     -86.8801778
  Sleep    0.5s
Paso 680
  Set Location    21.0454164     -86.8801778
  Sleep    0.5s
Paso 681
  Set Location    21.045415     -86.8801817
  Sleep    0.5s
Paso 682
  Set Location    21.045415     -86.8801817
  Sleep    0.5s
Paso 683
  Set Location    21.0456031     -86.8800903
  Sleep    0.5s
Paso 684
  Set Location    21.0456031     -86.8800903
  Sleep    0.5s
Paso 685
  Set Location    21.0451321     -86.879024
  Sleep    0.5s
Paso 686
  Set Location    21.0451321     -86.879024
  Sleep    0.5s
Paso 687
  Set Location    21.0443879     -86.8775199
  Sleep    0.5s
Paso 688
  Set Location    21.0443879     -86.8775199
  Sleep    0.5s
Paso 689
  Set Location    21.0457716     -86.8763104
  Sleep    0.5s
Paso 690
  Set Location    21.0457716     -86.8763104
  Sleep    0.5s
Paso 691
  Set Location    21.0462996     -86.8745911
  Sleep    0.5s
Paso 692
  Set Location    21.0462996     -86.8745911
  Sleep    0.5s
Paso 693
  Set Location    21.0452301     -86.8728483
  Sleep    0.5s
Paso 694
  Set Location    21.0452301     -86.8728483
  Sleep    0.5s
Paso 695
  Set Location    21.0445511     -86.872004
  Sleep    0.5s
Paso 696
  Set Location    21.0445511     -86.872004
  Sleep    0.5s
Paso 697
  Set Location    21.0440451     -86.8721813
  Sleep    0.5s
Paso 698
  Set Location    21.0440451     -86.8721813
  Sleep    0.5s
Paso 699
  Set Location    21.0437952     -86.8723773
  Sleep    0.5s
Paso 700
  Set Location    21.0437952     -86.8723773
  Sleep    0.5s
Paso 701
  Set Location    21.0423798     -86.8733514
  Sleep    0.5s
Paso 702
  Set Location    21.0423798     -86.8733514
  Sleep    0.5s
Paso 703
  Set Location    21.0418615     -86.8737449
  Sleep    0.5s
Paso 704
  Set Location    21.0418615     -86.8737449
  Sleep    0.5s
Paso 705
  Set Location    21.0416917     -86.8738517
  Sleep    0.5s
Paso 706
  Set Location    21.0416917     -86.8738517
  Sleep    0.5s
Paso 707
  Set Location    21.0414063     -86.8741941
  Sleep    0.5s
Paso 708
  Set Location    21.0414063     -86.8741941
  Sleep    0.5s
Paso 709
  Set Location    21.0409063     -86.8748185
  Sleep    0.5s
Paso 710
  Set Location    21.0409063     -86.8748185
  Sleep    0.5s
Paso 711
  Set Location    21.0404315     -86.8739859
  Sleep    0.5s
Paso 712
  Set Location    21.0404315     -86.8739859
  Sleep    0.5s
Paso 713
  Set Location    21.0402182     -86.8731077
  Sleep    0.5s
Paso 714
  Set Location    21.0402182     -86.8731077
  Sleep    0.5s
Paso 715
  Set Location    21.0399953     -86.8723561
  Sleep    0.5s
Paso 716
  Set Location    21.0399953     -86.8723561
  Sleep    0.5s
Paso 717
  Set Location    21.0397117     -86.872315
  Sleep    0.5s
Paso 718
  Set Location    21.0397117     -86.872315
  Sleep    0.5s
Paso 719
  Set Location    21.0394617     -86.8724944
  Sleep    0.5s
Paso 720
  Set Location    21.0394617     -86.8724944
  Sleep    0.5s
Paso 721
  Set Location    21.0392203     -86.8727156
  Sleep    0.5s
Paso 722
  Set Location    21.0392203     -86.8727156
  Sleep    0.5s
Paso 723
  Set Location    21.0394143     -86.8724715
  Sleep    0.5s
Paso 724
  Set Location    21.0394143     -86.8724715
  Sleep    0.5s
Paso 725
  Set Location    21.039415     -86.8724717
  Sleep    0.5s
Paso 726
  Set Location    21.039415     -86.8724717
  Sleep    0.5s
Paso 727
  Set Location    21.0394647     -86.8724449
  Sleep    0.5s
Paso 728
  Set Location    21.0394647     -86.8724449
  Sleep    0.5s
Paso 729
  Set Location    21.0394733     -86.8724417
  Sleep    0.5s
Paso 730
  Set Location    21.0394733     -86.8724417
  Sleep    0.5s
Paso 731
  Set Location    21.0394983     -86.8723498
  Sleep    0.5s
Paso 732
  Set Location    21.0394983     -86.8723498
  Sleep    0.5s
Paso 733
  Set Location    21.0394983     -86.87235
  Sleep    0.5s
Paso 734
  Set Location    21.0394983     -86.87235
  Sleep    0.5s
Paso 735
  Set Location    21.03944     -86.8722767
  Sleep    0.5s
Paso 736
  Set Location    21.03944     -86.8722767
  Sleep    0.5s
Paso 737
  Set Location    21.03945     -86.8723033
  Sleep    0.5s
Paso 738
  Set Location    21.03945     -86.8723033
  Sleep    0.5s
Paso 739
  Set Location    21.0395417     -86.872255
  Sleep    0.5s
Paso 740
  Set Location    21.0395417     -86.872255
  Sleep    0.5s
Paso 741
  Set Location    21.03963     -86.8722417
  Sleep    0.5s
Paso 742
  Set Location    21.03963     -86.8722417
  Sleep    0.5s
Paso 743
  Set Location    21.0398025     -86.8722146
  Sleep    0.5s
Paso 744
  Set Location    21.0398025     -86.8722146
  Sleep    0.5s
Paso 745
  Set Location    21.0398267     -86.8721667
  Sleep    0.5s
Paso 746
  Set Location    21.0398267     -86.8721667
  Sleep    0.5s
Paso 747
  Set Location    21.0398383     -86.8720633
  Sleep    0.5s
Paso 748
  Set Location    21.0398383     -86.8720633
  Sleep    0.5s
Paso 749
  Set Location    21.0398667     -86.8720117
  Sleep    0.5s
Paso 750
  Set Location    21.0398667     -86.8720117
  Sleep    0.5s
Paso 751
  Set Location    21.039955     -86.8719833
  Sleep    0.5s
Paso 752
  Set Location    21.039955     -86.8719833
  Sleep    0.5s
Paso 753
  Set Location    21.0402799     -86.8717474
  Sleep    0.5s
Paso 754
  Set Location    21.0402799     -86.8717474
  Sleep    0.5s
Paso 755
  Set Location    21.0399569     -86.8704555
  Sleep    0.5s
Paso 756
  Set Location    21.0399569     -86.8704555
  Sleep    0.5s
Paso 757
  Set Location    21.0402203     -86.8691606
  Sleep    0.5s
Paso 758
  Set Location    21.0402203     -86.8691606
  Sleep    0.5s
Paso 759
  Set Location    21.0412367     -86.8684044
  Sleep    0.5s
Paso 760
  Set Location    21.0412367     -86.8684044
  Sleep    0.5s
Paso 761
  Set Location    21.0416273     -86.8670094
  Sleep    0.5s
Paso 762
  Set Location    21.0416273     -86.8670094
  Sleep    0.5s
Paso 763
  Set Location    21.0404148     -86.8651075
  Sleep    0.5s
Paso 764
  Set Location    21.0404148     -86.8651075
  Sleep    0.5s
Paso 765
  Set Location    21.0391441     -86.863023
  Sleep    0.5s
Paso 766
  Set Location    21.0391441     -86.863023
  Sleep    0.5s
Paso 767
  Set Location    21.037822     -86.8609675
  Sleep    0.5s
Paso 768
  Set Location    21.037822     -86.8609675
  Sleep    0.5s
Paso 769
  Set Location    21.0371408     -86.8599338
  Sleep    0.5s
Paso 770
  Set Location    21.0371408     -86.8599338
  Sleep    0.5s
Paso 771
  Set Location    21.0363339     -86.8586456
  Sleep    0.5s
Paso 772
  Set Location    21.0363339     -86.8586456
  Sleep    0.5s
Paso 773
  Set Location    21.035187     -86.8568552
  Sleep    0.5s
Paso 774
  Set Location    21.035187     -86.8568552
  Sleep    0.5s
Paso 775
  Set Location    21.0339382     -86.8547642
  Sleep    0.5s
Paso 776
  Set Location    21.0339382     -86.8547642
  Sleep    0.5s
Paso 777
  Set Location    21.0334128     -86.8530792
  Sleep    0.5s
Paso 778
  Set Location    21.0334128     -86.8530792
  Sleep    0.5s
Paso 779
  Set Location    21.0332907     -86.8523732
  Sleep    0.5s
Paso 780
  Set Location    21.0332907     -86.8523732
  Sleep    0.5s
Paso 781
  Set Location    21.0332186     -86.851785
  Sleep    0.5s
Paso 782
  Set Location    21.0332186     -86.851785
  Sleep    0.5s
Paso 783
  Set Location    21.0331011     -86.8511249
  Sleep    0.5s
Paso 784
  Set Location    21.0331011     -86.8511249
  Sleep    0.5s
Paso 785
  Set Location    21.0327614     -86.8508505
  Sleep    0.5s
Paso 786
  Set Location    21.0327614     -86.8508505
  Sleep    0.5s
Paso 787
  Set Location    21.0322348     -86.8510746
  Sleep    0.5s
Paso 788
  Set Location    21.0322348     -86.8510746
  Sleep    0.5s
Paso 789
  Set Location    21.0325509     -86.8518366
  Sleep    0.5s
Paso 790
  Set Location    21.0325509     -86.8518366
  Sleep    0.5s
Paso 791
  Set Location    21.0341241     -86.8516321
  Sleep    0.5s
Paso 792
  Set Location    21.0341241     -86.8516321
  Sleep    0.5s
Paso 793
  Set Location    21.036383     -86.850897
  Sleep    0.5s
Paso 794
  Set Location    21.036383     -86.850897
  Sleep    0.5s
Paso 795
  Set Location    21.0389149     -86.8501806
  Sleep    0.5s
Paso 796
  Set Location    21.0389149     -86.8501806
  Sleep    0.5s
Paso 797
  Set Location    21.0417103     -86.8497602
  Sleep    0.5s
Paso 798
  Set Location    21.0417103     -86.8497602
  Sleep    0.5s
Paso 799
  Set Location    21.0446306     -86.8493246
  Sleep    0.5s
Paso 800
  Set Location    21.0446306     -86.8493246
  Sleep    0.5s
Paso 801
  Set Location    21.0475644     -86.8488483
  Sleep    0.5s
Paso 802
  Set Location    21.0475644     -86.8488483
  Sleep    0.5s
Paso 803
  Set Location    21.0505842     -86.8484121
  Sleep    0.5s
Paso 804
  Set Location    21.0505842     -86.8484121
  Sleep    0.5s
Paso 805
  Set Location    21.0535212     -86.8479524
  Sleep    0.5s
Paso 806
  Set Location    21.0535212     -86.8479524
  Sleep    0.5s
Paso 807
  Set Location    21.0564226     -86.8474951
  Sleep    0.5s
Paso 808
  Set Location    21.0564226     -86.8474951
  Sleep    0.5s
Paso 809
  Set Location    21.0593045     -86.8470453
  Sleep    0.5s
Paso 810
  Set Location    21.0593045     -86.8470453
  Sleep    0.5s
Paso 811
  Set Location    21.0622001     -86.8466022
  Sleep    0.5s
Paso 812
  Set Location    21.0622001     -86.8466022
  Sleep    0.5s
Paso 813
  Set Location    21.0651487     -86.8461176
  Sleep    0.5s
Paso 814
  Set Location    21.0651487     -86.8461176
  Sleep    0.5s
Paso 815
  Set Location    21.0680684     -86.8456282
  Sleep    0.5s
Paso 816
  Set Location    21.0680684     -86.8456282
  Sleep    0.5s
Paso 817
  Set Location    21.0709346     -86.8451567
  Sleep    0.5s
Paso 818
  Set Location    21.0709346     -86.8451567
  Sleep    0.5s
Paso 819
  Set Location    21.0738086     -86.8447482
  Sleep    0.5s
Paso 820
  Set Location    21.0738086     -86.8447482
  Sleep    0.5s
Paso 821
  Set Location    21.076579     -86.8443616
  Sleep    0.5s
Paso 822
  Set Location    21.076579     -86.8443616
  Sleep    0.5s
Paso 823
  Set Location    21.0794658     -86.8438891
  Sleep    0.5s
Paso 824
  Set Location    21.0794658     -86.8438891
  Sleep    0.5s
Paso 825
  Set Location    21.0823919     -86.8434121
  Sleep    0.5s
Paso 826
  Set Location    21.0823919     -86.8434121
  Sleep    0.5s
Paso 827
  Set Location    21.0829809     -86.8433165
  Sleep    0.5s
Paso 828
  Set Location    21.0829809     -86.8433165
  Sleep    0.5s
Paso 829
  Set Location    21.0857198     -86.8427671
  Sleep    0.5s
Paso 830
  Set Location    21.0857198     -86.8427671
  Sleep    0.5s
Paso 831
  Set Location    21.087662     -86.8422965
  Sleep    0.5s
Paso 832
  Set Location    21.087662     -86.8422965
  Sleep    0.5s
Paso 833
  Set Location    21.0877383     -86.84225
  Sleep    0.5s
Paso 834
  Set Location    21.0877383     -86.84225
  Sleep    0.5s
Paso 835
  Set Location    21.0886332     -86.8422475
  Sleep    0.5s
Paso 836
  Set Location    21.0886332     -86.8422475
  Sleep    0.5s
Paso 837
  Set Location    21.0906118     -86.8419792
  Sleep    0.5s
Paso 838
  Set Location    21.0906118     -86.8419792
  Sleep    0.5s
Paso 839
  Set Location    21.0927663     -86.8417638
  Sleep    0.5s
Paso 840
  Set Location    21.0927663     -86.8417638
  Sleep    0.5s
Paso 841
  Set Location    21.0950667     -86.8414153
  Sleep    0.5s
Paso 842
  Set Location    21.0950667     -86.8414153
  Sleep    0.5s
Paso 843
  Set Location    21.0972278     -86.8410835
  Sleep    0.5s
Paso 844
  Set Location    21.0972278     -86.8410835
  Sleep    0.5s
Paso 845
  Set Location    21.0993677     -86.8407433
  Sleep    0.5s
Paso 846
  Set Location    21.0993677     -86.8407433
  Sleep    0.5s
Paso 847
  Set Location    21.1011178     -86.8404673
  Sleep    0.5s
Paso 848
  Set Location    21.1011178     -86.8404673
  Sleep    0.5s
Paso 849
  Set Location    21.1034777     -86.8401011
  Sleep    0.5s
Paso 850
  Set Location    21.1034777     -86.8401011
  Sleep    0.5s
Paso 851
  Set Location    21.1062288     -86.8396739
  Sleep    0.5s
Paso 852
  Set Location    21.1062288     -86.8396739
  Sleep    0.5s
Paso 853
  Set Location    21.1089504     -86.8392518
  Sleep    0.5s
Paso 854
  Set Location    21.1089504     -86.8392518
  Sleep    0.5s
Paso 855
  Set Location    21.1116329     -86.8388327
  Sleep    0.5s
Paso 856
  Set Location    21.1116329     -86.8388327
  Sleep    0.5s
Paso 857
  Set Location    21.1140782     -86.8378801
  Sleep    0.5s
Paso 858
  Set Location    21.1140782     -86.8378801
  Sleep    0.5s
Paso 859
  Set Location    21.116703     -86.8365987
  Sleep    0.5s
Paso 860
  Set Location    21.116703     -86.8365987
  Sleep    0.5s
Paso 861
  Set Location    21.1193399     -86.8353295
  Sleep    0.5s
Paso 862
  Set Location    21.1193399     -86.8353295
  Sleep    0.5s
Paso 863
  Set Location    21.1219782     -86.834069
  Sleep    0.5s
Paso 864
  Set Location    21.1219782     -86.834069
  Sleep    0.5s
Paso 865
  Set Location    21.1246482     -86.832762
  Sleep    0.5s
Paso 866
  Set Location    21.1246482     -86.832762
  Sleep    0.5s
Paso 867
  Set Location    21.1257214     -86.8322352
  Sleep    0.5s
Paso 868
  Set Location    21.1257214     -86.8322352
  Sleep    0.5s
Paso 869
  Set Location    21.1284485     -86.8309071
  Sleep    0.5s
Paso 870
  Set Location    21.1284485     -86.8309071
  Sleep    0.5s
Paso 871
  Set Location    21.131184     -86.8295394
  Sleep    0.5s
Paso 872
  Set Location    21.131184     -86.8295394
  Sleep    0.5s
Paso 873
  Set Location    21.1337987     -86.8282771
  Sleep    0.5s
Paso 874
  Set Location    21.1337987     -86.8282771
  Sleep    0.5s
Paso 875
  Set Location    21.1364485     -86.826977
  Sleep    0.5s
Paso 876
  Set Location    21.1364485     -86.826977
  Sleep    0.5s
Paso 877
  Set Location    21.1386082     -86.8258701
  Sleep    0.5s
Paso 878
  Set Location    21.1386082     -86.8258701
  Sleep    0.5s
Paso 879
  Set Location    21.1388417     -86.8256967
  Sleep    0.5s
Paso 880
  Set Location    21.1388417     -86.8256967
  Sleep    0.5s
Paso 881
  Set Location    21.1395528     -86.8252444
  Sleep    0.5s
Paso 882
  Set Location    21.1395528     -86.8252444
  Sleep    0.5s
Paso 883
  Set Location    21.1413398     -86.8245431
  Sleep    0.5s
Paso 884
  Set Location    21.1413398     -86.8245431
  Sleep    0.5s
Paso 885
  Set Location    21.1436407     -86.8242368
  Sleep    0.5s
Paso 886
  Set Location    21.1436407     -86.8242368
  Sleep    0.5s
Paso 887
  Set Location    21.145495     -86.8243955
  Sleep    0.5s
Paso 888
  Set Location    21.145495     -86.8243955
  Sleep    0.5s
Paso 889
  Set Location    21.1465615     -86.8244505
  Sleep    0.5s
Paso 890
  Set Location    21.1465615     -86.8244505
  Sleep    0.5s
Paso 891
  Set Location    21.1465633     -86.8244567
  Sleep    0.5s
Paso 892
  Set Location    21.1465633     -86.8244567
  Sleep    0.5s
Paso 893
  Set Location    21.1466686     -86.8245104
  Sleep    0.5s
Paso 894
  Set Location    21.1466686     -86.8245104
  Sleep    0.5s
Paso 895
  Set Location    21.1479565     -86.8245791
  Sleep    0.5s
Paso 896
  Set Location    21.1479565     -86.8245791
  Sleep    0.5s
Paso 897
  Set Location    21.14875     -86.8246083
  Sleep    0.5s
Paso 898
  Set Location    21.14875     -86.8246083
  Sleep    0.5s
Paso 899
  Set Location    21.1495984     -86.8246274
  Sleep    0.5s
Paso 900
  Set Location    21.1495984     -86.8246274
  Sleep    0.5s
Paso 901
  Set Location    21.1514283     -86.8248738
  Sleep    0.5s
Paso 902
  Set Location    21.1514283     -86.8248738
  Sleep    0.5s
Paso 903
  Set Location    21.1535365     -86.8250287
  Sleep    0.5s
Paso 904
  Set Location    21.1535365     -86.8250287
  Sleep    0.5s
Paso 905
  Set Location    21.1554375     -86.8251602
  Sleep    0.5s
Paso 906
  Set Location    21.1554375     -86.8251602
  Sleep    0.5s
Paso 907
  Set Location    21.155835     -86.8251933
  Sleep    0.5s
Paso 908
  Set Location    21.155835     -86.8251933
  Sleep    0.5s
Paso 909
  Set Location    21.1559479     -86.8252098
  Sleep    0.5s
Paso 910
  Set Location    21.1559479     -86.8252098
  Sleep    0.5s
Paso 911
  Set Location    21.1568334     -86.8250806
  Sleep    0.5s
Paso 912
  Set Location    21.1568334     -86.8250806
  Sleep    0.5s
Paso 913
  Set Location    21.1572011     -86.8251642
  Sleep    0.5s
Paso 914
  Set Location    21.1572011     -86.8251642
  Sleep    0.5s
Paso 915
  Set Location    21.1578362     -86.8253501
  Sleep    0.5s
Paso 916
  Set Location    21.1578362     -86.8253501
  Sleep    0.5s
Paso 917
  Set Location    21.1584309     -86.8254059
  Sleep    0.5s
Paso 918
  Set Location    21.1584309     -86.8254059
  Sleep    0.5s
Paso 919
  Set Location    21.1596795     -86.8255102
  Sleep    0.5s
Paso 920
  Set Location    21.1596795     -86.8255102
  Sleep    0.5s
Paso 921
  Set Location    21.1607993     -86.8255858
  Sleep    0.5s
Paso 922
  Set Location    21.1607993     -86.8255858
  Sleep    0.5s
Paso 923
  Set Location    21.1612332     -86.8256217
  Sleep    0.5s
Paso 924
  Set Location    21.1612332     -86.8256217
  Sleep    0.5s
Paso 925
  Set Location    21.1617873     -86.8256603
  Sleep    0.5s
Paso 926
  Set Location    21.1617873     -86.8256603
  Sleep    0.5s
Paso 927
  Set Location    21.1629756     -86.8256837
  Sleep    0.5s
Paso 928
  Set Location    21.1629756     -86.8256837
  Sleep    0.5s
Paso 929
  Set Location    21.1637011     -86.8253222
  Sleep    0.5s
Paso 930
  Set Location    21.1637011     -86.8253222
  Sleep    0.5s
Paso 931
  Set Location    21.1640069     -86.8260966
  Sleep    0.5s
Paso 932
  Set Location    21.1640069     -86.8260966
  Sleep    0.5s
Paso 933
  Set Location    21.1638807     -86.8265634
  Sleep    0.5s
Paso 934
  Set Location    21.1638807     -86.8265634
  Sleep    0.5s
Paso 935
  Set Location    21.1641218     -86.8264098
  Sleep    0.5s
Paso 936
  Set Location    21.1641218     -86.8264098
  Sleep    0.5s
Paso 937
  Set Location    21.1643516     -86.8262665
  Sleep    0.5s
Paso 938
  Set Location    21.1643516     -86.8262665
  Sleep    0.5s
Paso 939
  Set Location    21.1643433     -86.8262667
  Sleep    0.5s
Paso 940
  Set Location    21.1643433     -86.8262667
  Sleep    0.5s
Paso 941
  Set Location    21.1642994     -86.8261952
  Sleep    0.5s
Paso 942
  Set Location    21.1642994     -86.8261952
  Sleep    0.5s
Paso 943
  Set Location    21.1643     -86.8261717
  Sleep    0.5s
Paso 944
  Set Location    21.1643     -86.8261717
  Sleep    0.5s
Paso 945
  Set Location    21.1642067     -86.8261733
  Sleep    0.5s
Paso 946
  Set Location    21.1642067     -86.8261733
  Sleep    0.5s
Paso 947
  Set Location    21.16431     -86.8261967
  Sleep    0.5s
Paso 948
  Set Location    21.16431     -86.8261967
  Sleep    0.5s
Paso 949
  Set Location    21.1642333     -86.82629
  Sleep    0.5s
Paso 950
  Set Location    21.1642333     -86.82629
  Sleep    0.5s
Paso 951
  Set Location    21.1643333     -86.8263283
  Sleep    0.5s
Paso 952
  Set Location    21.1643333     -86.8263283
  Sleep    0.5s
Paso 953
  Set Location    21.1643383     -86.826225
  Sleep    0.5s
Paso 954
  Set Location    21.1643383     -86.826225
  Sleep    0.5s
Paso 955
  Set Location    21.1642577     -86.8262376
  Sleep    0.5s
Paso 956
  Set Location    21.1642577     -86.8262376
  Sleep    0.5s
Paso 957
  Set Location    21.1642465     -86.8261463
  Sleep    0.5s
Paso 958
  Set Location    21.1642465     -86.8261463
  Sleep    0.5s
Paso 959
  Set Location    21.164179     -86.8261136
  Sleep    0.5s
Paso 960
  Set Location    21.164179     -86.8261136
  Sleep    0.5s
Paso 961
  Set Location    21.163874     -86.8261964
  Sleep    0.5s
Paso 962
  Set Location    21.163874     -86.8261964
  Sleep    0.5s
Paso 963
  Set Location    21.1628474     -86.8258413
  Sleep    0.5s
Paso 964
  Set Location    21.1628474     -86.8258413
  Sleep    0.5s
Paso 965
  Set Location    21.1617881     -86.8257415
  Sleep    0.5s
Paso 966
  Set Location    21.1617881     -86.8257415
  Sleep    0.5s
Paso 967
  Set Location    21.1607639     -86.8256616
  Sleep    0.5s
Paso 968
  Set Location    21.1607639     -86.8256616
  Sleep    0.5s
Paso 969
  Set Location    21.1599686     -86.8256035
  Sleep    0.5s
Paso 970
  Set Location    21.1599686     -86.8256035
  Sleep    0.5s
Paso 971
  Set Location    21.1596658     -86.8255832
  Sleep    0.5s
Paso 972
  Set Location    21.1596658     -86.8255832
  Sleep    0.5s
Paso 973
  Set Location    21.1584924     -86.8254936
  Sleep    0.5s
Paso 974
  Set Location    21.1584924     -86.8254936
  Sleep    0.5s
Paso 975
  Set Location    21.1581133     -86.8254567
  Sleep    0.5s
Paso 976
  Set Location    21.1581133     -86.8254567
  Sleep    0.5s
Paso 977
  Set Location    21.1572771     -86.8255182
  Sleep    0.5s
Paso 978
  Set Location    21.1572771     -86.8255182
  Sleep    0.5s
Paso 979
  Set Location    21.1560596     -86.8253003
  Sleep    0.5s
Paso 980
  Set Location    21.1560596     -86.8253003
  Sleep    0.5s
Paso 981
  Set Location    21.1542239     -86.8251546
  Sleep    0.5s
Paso 982
  Set Location    21.1542239     -86.8251546
  Sleep    0.5s
Paso 983
  Set Location    21.1521267     -86.824997
  Sleep    0.5s
Paso 984
  Set Location    21.1521267     -86.824997
  Sleep    0.5s
Paso 985
  Set Location    21.1513916     -86.8249447
  Sleep    0.5s
Paso 986
  Set Location    21.1513916     -86.8249447
  Sleep    0.5s
Paso 987
  Set Location    21.1477016     -86.8246648
  Sleep    0.5s
Paso 988
  Set Location    21.1477016     -86.8246648
  Sleep    0.5s
Paso 989
  Set Location    21.1458838     -86.8245197
  Sleep    0.5s
Paso 990
  Set Location    21.1458838     -86.8245197
  Sleep    0.5s
Paso 991
  Set Location    21.1439469     -86.8244425
  Sleep    0.5s
Paso 992
  Set Location    21.1439469     -86.8244425
  Sleep    0.5s
Paso 993
  Set Location    21.14369     -86.8244367
  Sleep    0.5s
Paso 994
  Set Location    21.14369     -86.8244367
  Sleep    0.5s
Paso 995
  Set Location    21.1431524     -86.8243949
  Sleep    0.5s
Paso 996
  Set Location    21.1431524     -86.8243949
  Sleep    0.5s
Paso 997
  Set Location    21.1413337     -86.8246427
  Sleep    0.5s
Paso 998
  Set Location    21.1413337     -86.8246427
  Sleep    0.5s
Paso 999
  Set Location    21.1400743     -86.8252814
  Sleep    0.5s
Paso 1000
  Set Location    21.1400743     -86.8252814
  Sleep    0.5s
Paso 1001
  Set Location    21.1389302     -86.8258871
  Sleep    0.5s
Paso 1002
  Set Location    21.1389302     -86.8258871
  Sleep    0.5s
Paso 1003
  Set Location    21.1369596     -86.8267638
  Sleep    0.5s
Paso 1004
  Set Location    21.1369596     -86.8267638
  Sleep    0.5s
Paso 1005
  Set Location    21.1345819     -86.8279151
  Sleep    0.5s
Paso 1006
  Set Location    21.1345819     -86.8279151
  Sleep    0.5s
Paso 1007
  Set Location    21.1320282     -86.8291413
  Sleep    0.5s
Paso 1008
  Set Location    21.1320282     -86.8291413
  Sleep    0.5s
Paso 1009
  Set Location    21.1294393     -86.8304615
  Sleep    0.5s
Paso 1010
  Set Location    21.1294393     -86.8304615
  Sleep    0.5s
Paso 1011
  Set Location    21.1270731     -86.8316203
  Sleep    0.5s
Paso 1012
  Set Location    21.1270731     -86.8316203
  Sleep    0.5s
Paso 1013
  Set Location    21.1246095     -86.8328086
  Sleep    0.5s
Paso 1014
  Set Location    21.1246095     -86.8328086
  Sleep    0.5s
Paso 1015
  Set Location    21.1226584     -86.8337468
  Sleep    0.5s
Paso 1016
  Set Location    21.1226584     -86.8337468
  Sleep    0.5s
Paso 1017
  Set Location    21.1221309     -86.8339929
  Sleep    0.5s
Paso 1018
  Set Location    21.1221309     -86.8339929
  Sleep    0.5s
Paso 1019
  Set Location    21.1208083     -86.8346272
  Sleep    0.5s
Paso 1020
  Set Location    21.1208083     -86.8346272
  Sleep    0.5s
Paso 1021
  Set Location    21.118909     -86.8355759
  Sleep    0.5s
Paso 1022
  Set Location    21.118909     -86.8355759
  Sleep    0.5s
Paso 1023
  Set Location    21.1167775     -86.8366149
  Sleep    0.5s
Paso 1024
  Set Location    21.1167775     -86.8366149
  Sleep    0.5s
Paso 1025
  Set Location    21.11499     -86.8374762
  Sleep    0.5s
Paso 1026
  Set Location    21.11499     -86.8374762
  Sleep    0.5s
Paso 1027
  Set Location    21.1128916     -86.8385148
  Sleep    0.5s
Paso 1028
  Set Location    21.1128916     -86.8385148
  Sleep    0.5s
Paso 1029
  Set Location    21.1124219     -86.8387032
  Sleep    0.5s
Paso 1030
  Set Location    21.1124219     -86.8387032
  Sleep    0.5s
Paso 1031
  Set Location    21.1104433     -86.8391058
  Sleep    0.5s
Paso 1032
  Set Location    21.1104433     -86.8391058
  Sleep    0.5s
Paso 1033
  Set Location    21.1079376     -86.8395031
  Sleep    0.5s
Paso 1034
  Set Location    21.1079376     -86.8395031
  Sleep    0.5s
Paso 1035
  Set Location    21.1053749     -86.8399381
  Sleep    0.5s
Paso 1036
  Set Location    21.1053749     -86.8399381
  Sleep    0.5s
Paso 1037
  Set Location    21.1028899     -86.8403232
  Sleep    0.5s
Paso 1038
  Set Location    21.1028899     -86.8403232
  Sleep    0.5s
Paso 1039
  Set Location    21.1002714     -86.84074
  Sleep    0.5s
Paso 1040
  Set Location    21.1002714     -86.84074
  Sleep    0.5s
Paso 1041
  Set Location    21.0975831     -86.8411592
  Sleep    0.5s
Paso 1042
  Set Location    21.0975831     -86.8411592
  Sleep    0.5s
Paso 1043
  Set Location    21.0951622     -86.8415345
  Sleep    0.5s
Paso 1044
  Set Location    21.0951622     -86.8415345
  Sleep    0.5s
Paso 1045
  Set Location    21.0927636     -86.841938
  Sleep    0.5s
Paso 1046
  Set Location    21.0927636     -86.841938
  Sleep    0.5s
Paso 1047
  Set Location    21.0908021     -86.842233
  Sleep    0.5s
Paso 1048
  Set Location    21.0908021     -86.842233
  Sleep    0.5s
Paso 1049
  Set Location    21.0887163     -86.8425604
  Sleep    0.5s
Paso 1050
  Set Location    21.0887163     -86.8425604
  Sleep    0.5s
Paso 1051
  Set Location    21.0873602     -86.84278
  Sleep    0.5s
Paso 1052
  Set Location    21.0873602     -86.84278
  Sleep    0.5s
Paso 1053
  Set Location    21.0859034     -86.8429877
  Sleep    0.5s
Paso 1054
  Set Location    21.0859034     -86.8429877
  Sleep    0.5s
Paso 1055
  Set Location    21.0839657     -86.8432878
  Sleep    0.5s
Paso 1056
  Set Location    21.0839657     -86.8432878
  Sleep    0.5s
Paso 1057
  Set Location    21.0815081     -86.8436901
  Sleep    0.5s
Paso 1058
  Set Location    21.0815081     -86.8436901
  Sleep    0.5s
Paso 1059
  Set Location    21.078924     -86.8440829
  Sleep    0.5s
Paso 1060
  Set Location    21.078924     -86.8440829
  Sleep    0.5s
Paso 1061
  Set Location    21.0762954     -86.8444716
  Sleep    0.5s
Paso 1062
  Set Location    21.0762954     -86.8444716
  Sleep    0.5s
Paso 1063
  Set Location    21.0736431     -86.844895
  Sleep    0.5s
Paso 1064
  Set Location    21.0736431     -86.844895
  Sleep    0.5s
Paso 1065
  Set Location    21.0709935     -86.845323
  Sleep    0.5s
Paso 1066
  Set Location    21.0709935     -86.845323
  Sleep    0.5s
Paso 1067
  Set Location    21.0683631     -86.8457263
  Sleep    0.5s
Paso 1068
  Set Location    21.0683631     -86.8457263
  Sleep    0.5s
Paso 1069
  Set Location    21.0657437     -86.8461679
  Sleep    0.5s
Paso 1070
  Set Location    21.0657437     -86.8461679
  Sleep    0.5s
Paso 1071
  Set Location    21.0631699     -86.8465566
  Sleep    0.5s
Paso 1072
  Set Location    21.0631699     -86.8465566
  Sleep    0.5s
Paso 1073
  Set Location    21.0606083     -86.8469616
  Sleep    0.5s
Paso 1074
  Set Location    21.0606083     -86.8469616
  Sleep    0.5s
Paso 1075
  Set Location    21.0580967     -86.8473372
  Sleep    0.5s
Paso 1076
  Set Location    21.0580967     -86.8473372
  Sleep    0.5s
Paso 1077
  Set Location    21.0554737     -86.8477397
  Sleep    0.5s
Paso 1078
  Set Location    21.0554737     -86.8477397
  Sleep    0.5s
Paso 1079
  Set Location    21.0527646     -86.8481783
  Sleep    0.5s
Paso 1080
  Set Location    21.0527646     -86.8481783
  Sleep    0.5s
Paso 1081
  Set Location    21.050108     -86.8485902
  Sleep    0.5s
Paso 1082
  Set Location    21.050108     -86.8485902
  Sleep    0.5s
Paso 1083
  Set Location    21.0475016     -86.8489461
  Sleep    0.5s
Paso 1084
  Set Location    21.0475016     -86.8489461
  Sleep    0.5s
Paso 1085
  Set Location    21.0449754     -86.8493862
  Sleep    0.5s
Paso 1086
  Set Location    21.0449754     -86.8493862
  Sleep    0.5s
Paso 1087
  Set Location    21.0424532     -86.849766
  Sleep    0.5s
Paso 1088
  Set Location    21.0424532     -86.849766
  Sleep    0.5s
Paso 1089
  Set Location    21.0398605     -86.8501624
  Sleep    0.5s
Paso 1090
  Set Location    21.0398605     -86.8501624
  Sleep    0.5s
Paso 1091
  Set Location    21.0375047     -86.8506863
  Sleep    0.5s
Paso 1092
  Set Location    21.0375047     -86.8506863
  Sleep    0.5s
Paso 1093
  Set Location    21.0352813     -86.8516344
  Sleep    0.5s
Paso 1094
  Set Location    21.0352813     -86.8516344
  Sleep    0.5s
Paso 1095
  Set Location    21.0342004     -86.8540495
  Sleep    0.5s
Paso 1096
  Set Location    21.0342004     -86.8540495
  Sleep    0.5s
Paso 1097
  Set Location    21.035124     -86.8565435
  Sleep    0.5s
Paso 1098
  Set Location    21.035124     -86.8565435
  Sleep    0.5s
Paso 1099
  Set Location    21.036645     -86.8589181
  Sleep    0.5s
Paso 1100
  Set Location    21.036645     -86.8589181
  Sleep    0.5s
Paso 1101
  Set Location    21.0381562     -86.8614071
  Sleep    0.5s
Paso 1102
  Set Location    21.0381562     -86.8614071
  Sleep    0.5s
Paso 1103
  Set Location    21.0397084     -86.8638356
  Sleep    0.5s
Paso 1104
  Set Location    21.0397084     -86.8638356
  Sleep    0.5s
Paso 1105
  Set Location    21.0410978     -86.8660999
  Sleep    0.5s
Paso 1106
  Set Location    21.0410978     -86.8660999
  Sleep    0.5s
Paso 1107
  Set Location    21.0424993     -86.8682939
  Sleep    0.5s
Paso 1108
  Set Location    21.0424993     -86.8682939
  Sleep    0.5s
Paso 1109
  Set Location    21.0438688     -86.8704814
  Sleep    0.5s
Paso 1110
  Set Location    21.0438688     -86.8704814
  Sleep    0.5s
Paso 1111
  Set Location    21.0452978     -86.8727031
  Sleep    0.5s
Paso 1112
  Set Location    21.0452978     -86.8727031
  Sleep    0.5s
Paso 1113
  Set Location    21.0465414     -86.8748824
  Sleep    0.5s
Paso 1114
  Set Location    21.0465414     -86.8748824
  Sleep    0.5s
Paso 1115
  Set Location    21.0457292     -86.8766879
  Sleep    0.5s
Paso 1116
  Set Location    21.0457292     -86.8766879
  Sleep    0.5s
Paso 1117
  Set Location    21.0464968     -86.8781774
  Sleep    0.5s
Paso 1118
  Set Location    21.0464968     -86.8781774
  Sleep    0.5s
Paso 1119
  Set Location    21.0469835     -86.8789298
  Sleep    0.5s
Paso 1120
  Set Location    21.0469835     -86.8789298
  Sleep    0.5s
Paso 1121
  Set Location    21.0471368     -86.8794401
  Sleep    0.5s
Paso 1122
  Set Location    21.0471368     -86.8794401
  Sleep    0.5s
Paso 1123
  Set Location    21.0465902     -86.8797952
  Sleep    0.5s
Paso 1124
  Set Location    21.0465902     -86.8797952
  Sleep    0.5s
Paso 1125
  Set Location    21.046381     -86.8800078
  Sleep    0.5s
Paso 1126
  Set Location    21.046381     -86.8800078
  Sleep    0.5s
Paso 1127
  Set Location    21.0456674     -86.8805218
  Sleep    0.5s
Paso 1128
  Set Location    21.0456674     -86.8805218
  Sleep    0.5s
Paso 1129
  Set Location    21.044803     -86.8806862
  Sleep    0.5s
Paso 1130
  Set Location    21.044803     -86.8806862
  Sleep    0.5s
Paso 1131
  Set Location    21.04529     -86.880195
  Sleep    0.5s
Paso 1132
  Set Location    21.04529     -86.880195
  Sleep    0.5s
Paso 1133
  Set Location    21.0453476     -86.8801725
  Sleep    0.5s
Paso 1134
  Set Location    21.0453476     -86.8801725
  Sleep    0.5s
Paso 1135
  Set Location    21.045389     -86.8794194
  Sleep    0.5s
Paso 1136
  Set Location    21.045389     -86.8794194
  Sleep    0.5s
Paso 1137
  Set Location    21.0444874     -86.8780226
  Sleep    0.5s
Paso 1138
  Set Location    21.0444874     -86.8780226
  Sleep    0.5s
Paso 1139
  Set Location    21.0436236     -86.877838
  Sleep    0.5s
Paso 1140
  Set Location    21.0436236     -86.877838
  Sleep    0.5s
Paso 1141
  Set Location    21.0430811     -86.8774368
  Sleep    0.5s
Paso 1142
  Set Location    21.0430811     -86.8774368
  Sleep    0.5s
Paso 1143
  Set Location    21.0423682     -86.8757106
  Sleep    0.5s
Paso 1144
  Set Location    21.0423682     -86.8757106
  Sleep    0.5s
Paso 1145
  Set Location    21.0428213     -86.8750021
  Sleep    0.5s
Paso 1146
  Set Location    21.0428213     -86.8750021
  Sleep    0.5s
Paso 1147
  Set Location    21.0425695     -86.8746234
  Sleep    0.5s
Paso 1148
  Set Location    21.0425695     -86.8746234
  Sleep    0.5s
Paso 1149
  Set Location    21.0419199     -86.873725
  Sleep    0.5s
Paso 1150
  Set Location    21.0419199     -86.873725
  Sleep    0.5s
Paso 1151
  Set Location    21.0413934     -86.8739905
  Sleep    0.5s
Paso 1152
  Set Location    21.0413934     -86.8739905
  Sleep    0.5s
Paso 1153
  Set Location    21.0408846     -86.873792
  Sleep    0.5s
Paso 1154
  Set Location    21.0408846     -86.873792
  Sleep    0.5s
Paso 1155
  Set Location    21.0406235     -86.8733565
  Sleep    0.5s
Paso 1156
  Set Location    21.0406235     -86.8733565
  Sleep    0.5s
Paso 1157
  Set Location    21.0404541     -86.8731214
  Sleep    0.5s
Paso 1158
  Set Location    21.0404541     -86.8731214
  Sleep    0.5s
Paso 1159
  Set Location    21.040262     -86.8727833
  Sleep    0.5s
Paso 1160
  Set Location    21.040262     -86.8727833
  Sleep    0.5s
Paso 1161
  Set Location    21.0399309     -86.8720598
  Sleep    0.5s
Paso 1162
  Set Location    21.0399309     -86.8720598
  Sleep    0.5s
Paso 1163
  Set Location    21.039955     -86.8720617
  Sleep    0.5s
Paso 1164
  Set Location    21.039955     -86.8720617
  Sleep    0.5s
Paso 1165
  Set Location    21.0403167     -86.8717812
  Sleep    0.5s
Paso 1166
  Set Location    21.0403167     -86.8717812
  Sleep    0.5s
Paso 1167
  Set Location    21.0399726     -86.870565
  Sleep    0.5s
Paso 1168
  Set Location    21.0399726     -86.870565
  Sleep    0.5s
Paso 1169
  Set Location    21.0399274     -86.8693986
  Sleep    0.5s
Paso 1170
  Set Location    21.0399274     -86.8693986
  Sleep    0.5s
Paso 1171
  Set Location    21.0405418     -86.8689551
  Sleep    0.5s
Paso 1172
  Set Location    21.0405418     -86.8689551
  Sleep    0.5s
Paso 1173
  Set Location    21.0409062     -86.8686805
  Sleep    0.5s
Paso 1174
  Set Location    21.0409062     -86.8686805
  Sleep    0.5s
Paso 1175
  Set Location    21.0418673     -86.8676536
  Sleep    0.5s
Paso 1176
  Set Location    21.0418673     -86.8676536
  Sleep    0.5s
Paso 1177
  Set Location    21.0417617     -86.8673145
  Sleep    0.5s
Paso 1178
  Set Location    21.0417617     -86.8673145
  Sleep    0.5s
Paso 1179
  Set Location    21.0391932     -86.8631723
  Sleep    0.5s
Paso 1180
  Set Location    21.0391932     -86.8631723
  Sleep    0.5s
Paso 1181
  Set Location    21.0378369     -86.8610294
  Sleep    0.5s
Paso 1182
  Set Location    21.0378369     -86.8610294
  Sleep    0.5s
Paso 1183
  Set Location    21.0362988     -86.8585582
  Sleep    0.5s
Paso 1184
  Set Location    21.0362988     -86.8585582
  Sleep    0.5s
Paso 1185
  Set Location    21.0347159     -86.8560365
  Sleep    0.5s
Paso 1186
  Set Location    21.0347159     -86.8560365
  Sleep    0.5s
Paso 1187
  Set Location    21.0334676     -86.8534141
  Sleep    0.5s
Paso 1188
  Set Location    21.0334676     -86.8534141
  Sleep    0.5s
Paso 1189
  Set Location    21.0332435     -86.8519803
  Sleep    0.5s
Paso 1190
  Set Location    21.0332435     -86.8519803
  Sleep    0.5s
Paso 1191
  Set Location    21.033104     -86.8511372
  Sleep    0.5s
Paso 1192
  Set Location    21.033104     -86.8511372
  Sleep    0.5s
Paso 1193
  Set Location    21.0325682     -86.8508347
  Sleep    0.5s
Paso 1194
  Set Location    21.0325682     -86.8508347
  Sleep    0.5s
Paso 1195
  Set Location    21.0321578     -86.8512227
  Sleep    0.5s
Paso 1196
  Set Location    21.0321578     -86.8512227
  Sleep    0.5s
Paso 1197
  Set Location    21.0326588     -86.8519025
  Sleep    0.5s
Paso 1198
  Set Location    21.0326588     -86.8519025
  Sleep    0.5s
Paso 1199
  Set Location    21.0345766     -86.8515628
  Sleep    0.5s
Paso 1200
  Set Location    21.0345766     -86.8515628
  Sleep    0.5s
Paso 1201
  Set Location    21.037032     -86.8506984
  Sleep    0.5s
Paso 1202
  Set Location    21.037032     -86.8506984
  Sleep    0.5s
Paso 1203
  Set Location    21.039578     -86.8501289
  Sleep    0.5s
Paso 1204
  Set Location    21.039578     -86.8501289
  Sleep    0.5s
Paso 1205
  Set Location    21.0423662     -86.849726
  Sleep    0.5s
Paso 1206
  Set Location    21.0423662     -86.849726
  Sleep    0.5s
Paso 1207
  Set Location    21.0454034     -86.8492456
  Sleep    0.5s
Paso 1208
  Set Location    21.0454034     -86.8492456
  Sleep    0.5s
Paso 1209
  Set Location    21.048367     -86.8487852
  Sleep    0.5s
Paso 1210
  Set Location    21.048367     -86.8487852
  Sleep    0.5s
Paso 1211
  Set Location    21.0488803     -86.8487175
  Sleep    0.5s
Paso 1212
  Set Location    21.0488803     -86.8487175
  Sleep    0.5s
Paso 1213
  Set Location    21.0516029     -86.8482803
  Sleep    0.5s
Paso 1214
  Set Location    21.0516029     -86.8482803
  Sleep    0.5s
Paso 1215
  Set Location    21.0545013     -86.8478218
  Sleep    0.5s
Paso 1216
  Set Location    21.0545013     -86.8478218
  Sleep    0.5s
Paso 1217
  Set Location    21.0575347     -86.8473585
  Sleep    0.5s
Paso 1218
  Set Location    21.0575347     -86.8473585
  Sleep    0.5s
Paso 1219
  Set Location    21.0606613     -86.8468707
  Sleep    0.5s
Paso 1220
  Set Location    21.0606613     -86.8468707
  Sleep    0.5s
Paso 1221
  Set Location    21.063593     -86.8464202
  Sleep    0.5s
Paso 1222
  Set Location    21.063593     -86.8464202
  Sleep    0.5s
Paso 1223
  Set Location    21.0663975     -86.8459871
  Sleep    0.5s
Paso 1224
  Set Location    21.0663975     -86.8459871
  Sleep    0.5s
Paso 1225
  Set Location    21.0690579     -86.8455783
  Sleep    0.5s
Paso 1226
  Set Location    21.0690579     -86.8455783
  Sleep    0.5s
Paso 1227
  Set Location    21.0717565     -86.8451352
  Sleep    0.5s
Paso 1228
  Set Location    21.0717565     -86.8451352
  Sleep    0.5s
Paso 1229
  Set Location    21.0743615     -86.8447468
  Sleep    0.5s
Paso 1230
  Set Location    21.0743615     -86.8447468
  Sleep    0.5s
Paso 1231
  Set Location    21.0770698     -86.844319
  Sleep    0.5s
Paso 1232
  Set Location    21.0770698     -86.844319
  Sleep    0.5s
Paso 1233
  Set Location    21.0799326     -86.843843
  Sleep    0.5s
Paso 1234
  Set Location    21.0799326     -86.843843
  Sleep    0.5s
Paso 1235
  Set Location    21.0827598     -86.8434098
  Sleep    0.5s
Paso 1236
  Set Location    21.0827598     -86.8434098
  Sleep    0.5s
Paso 1237
  Set Location    21.0856222     -86.8429056
  Sleep    0.5s
Paso 1238
  Set Location    21.0856222     -86.8429056
  Sleep    0.5s
Paso 1239
  Set Location    21.0884501     -86.8424736
  Sleep    0.5s
Paso 1240
  Set Location    21.0884501     -86.8424736
  Sleep    0.5s
Paso 1241
  Set Location    21.0908525     -86.8421121
  Sleep    0.5s
Paso 1242
  Set Location    21.0908525     -86.8421121
  Sleep    0.5s
Paso 1243
  Set Location    21.0936506     -86.8417019
  Sleep    0.5s
Paso 1244
  Set Location    21.0936506     -86.8417019
  Sleep    0.5s
Paso 1245
  Set Location    21.0964251     -86.8412588
  Sleep    0.5s
Paso 1246
  Set Location    21.0964251     -86.8412588
  Sleep    0.5s
Paso 1247
  Set Location    21.0989235     -86.8408753
  Sleep    0.5s
Paso 1248
  Set Location    21.0989235     -86.8408753
  Sleep    0.5s
Paso 1249
  Set Location    21.1001084     -86.8406731
  Sleep    0.5s
Paso 1250
  Set Location    21.1001084     -86.8406731
  Sleep    0.5s
Paso 1251
  Set Location    21.1006638     -86.8405787
  Sleep    0.5s
Paso 1252
  Set Location    21.1006638     -86.8405787
  Sleep    0.5s
Paso 1253
  Set Location    21.1024238     -86.840302
  Sleep    0.5s
Paso 1254
  Set Location    21.1024238     -86.840302
  Sleep    0.5s
Paso 1255
  Set Location    21.1048097     -86.8399205
  Sleep    0.5s
Paso 1256
  Set Location    21.1048097     -86.8399205
  Sleep    0.5s
Paso 1257
  Set Location    21.1074367     -86.8395347
  Sleep    0.5s
Paso 1258
  Set Location    21.1074367     -86.8395347
  Sleep    0.5s
Paso 1259
  Set Location    21.1102265     -86.8391067
  Sleep    0.5s
Paso 1260
  Set Location    21.1102265     -86.8391067
  Sleep    0.5s
Paso 1261
  Set Location    21.1130025     -86.838464
  Sleep    0.5s
Paso 1262
  Set Location    21.1130025     -86.838464
  Sleep    0.5s
Paso 1263
  Set Location    21.1156335     -86.837202
  Sleep    0.5s
Paso 1264
  Set Location    21.1156335     -86.837202
  Sleep    0.5s
Paso 1265
  Set Location    21.1183001     -86.8358851
  Sleep    0.5s
Paso 1266
  Set Location    21.1183001     -86.8358851
  Sleep    0.5s
Paso 1267
  Set Location    21.1208357     -86.834624
  Sleep    0.5s
Paso 1268
  Set Location    21.1208357     -86.834624
  Sleep    0.5s
Paso 1269
  Set Location    21.1234148     -86.8333601
  Sleep    0.5s
Paso 1270
  Set Location    21.1234148     -86.8333601
  Sleep    0.5s
Paso 1271
  Set Location    21.1260854     -86.8320415
  Sleep    0.5s
Paso 1272
  Set Location    21.1260854     -86.8320415
  Sleep    0.5s
Paso 1273
  Set Location    21.1286453     -86.8307727
  Sleep    0.5s
Paso 1274
  Set Location    21.1286453     -86.8307727
  Sleep    0.5s
Paso 1275
  Set Location    21.1311298     -86.8295967
  Sleep    0.5s
Paso 1276
  Set Location    21.1311298     -86.8295967
  Sleep    0.5s
Paso 1277
  Set Location    21.1332449     -86.8285519
  Sleep    0.5s
Paso 1278
  Set Location    21.1332449     -86.8285519
  Sleep    0.5s
Paso 1279
  Set Location    21.1355482     -86.8274268
  Sleep    0.5s
Paso 1280
  Set Location    21.1355482     -86.8274268
  Sleep    0.5s
Paso 1281
  Set Location    21.1376013     -86.826421
  Sleep    0.5s
Paso 1282
  Set Location    21.1376013     -86.826421
  Sleep    0.5s
Paso 1283
  Set Location    21.1383675     -86.8260435
  Sleep    0.5s
Paso 1284
  Set Location    21.1383675     -86.8260435
  Sleep    0.5s
Paso 1285
  Set Location    21.1396729     -86.8252985
  Sleep    0.5s
Paso 1286
  Set Location    21.1396729     -86.8252985
  Sleep    0.5s
Paso 1287
  Set Location    21.1414339     -86.8245322
  Sleep    0.5s
Paso 1288
  Set Location    21.1414339     -86.8245322
  Sleep    0.5s
Paso 1289
  Set Location    21.1429528     -86.8242133
  Sleep    0.5s
Paso 1290
  Set Location    21.1429528     -86.8242133
  Sleep    0.5s
Paso 1291
  Set Location    21.1434743     -86.8242299
  Sleep    0.5s
Paso 1292
  Set Location    21.1434743     -86.8242299
  Sleep    0.5s
Paso 1293
  Set Location    21.1448312     -86.8243219
  Sleep    0.5s
Paso 1294
  Set Location    21.1448312     -86.8243219
  Sleep    0.5s
Paso 1295
  Set Location    21.1461253     -86.8244854
  Sleep    0.5s
Paso 1296
  Set Location    21.1461253     -86.8244854
  Sleep    0.5s
Paso 1297
  Set Location    21.1463017     -86.8244983
  Sleep    0.5s
Paso 1298
  Set Location    21.1463017     -86.8244983
  Sleep    0.5s
Paso 1299
  Set Location    21.1464688     -86.8245115
  Sleep    0.5s
Paso 1300
  Set Location    21.1464688     -86.8245115
  Sleep    0.5s
Paso 1301
  Set Location    21.1476115     -86.8245851
  Sleep    0.5s
Paso 1302
  Set Location    21.1476115     -86.8245851
  Sleep    0.5s
Paso 1303
  Set Location    21.1488577     -86.8246369
  Sleep    0.5s
Paso 1304
  Set Location    21.1488577     -86.8246369
  Sleep    0.5s
Paso 1305
  Set Location    21.1488983     -86.824635
  Sleep    0.5s
Paso 1306
  Set Location    21.1488983     -86.824635
  Sleep    0.5s
Paso 1307
  Set Location    21.1489942     -86.8246333
  Sleep    0.5s
Paso 1308
  Set Location    21.1489942     -86.8246333
  Sleep    0.5s
Paso 1309
  Set Location    21.1500125     -86.8246822
  Sleep    0.5s
Paso 1310
  Set Location    21.1500125     -86.8246822
  Sleep    0.5s
Paso 1311
  Set Location    21.1517165     -86.8248867
  Sleep    0.5s
Paso 1312
  Set Location    21.1517165     -86.8248867
  Sleep    0.5s
Paso 1313
  Set Location    21.1538857     -86.8250484
  Sleep    0.5s
Paso 1314
  Set Location    21.1538857     -86.8250484
  Sleep    0.5s
Paso 1315
  Set Location    21.1556994     -86.8252001
  Sleep    0.5s
Paso 1316
  Set Location    21.1556994     -86.8252001
  Sleep    0.5s
Paso 1317
  Set Location    21.1559167     -86.8252167
  Sleep    0.5s
Paso 1318
  Set Location    21.1559167     -86.8252167
  Sleep    0.5s
Paso 1319
  Set Location    21.1565683     -86.8251508
  Sleep    0.5s
Paso 1320
  Set Location    21.1565683     -86.8251508
  Sleep    0.5s
Paso 1321
  Set Location    21.1571796     -86.8251489
  Sleep    0.5s
Paso 1322
  Set Location    21.1571796     -86.8251489
  Sleep    0.5s
Paso 1323
  Set Location    21.1576329     -86.825302
  Sleep    0.5s
Paso 1324
  Set Location    21.1576329     -86.825302
  Sleep    0.5s
Paso 1325
  Set Location    21.15779     -86.8253383
  Sleep    0.5s
Paso 1326
  Set Location    21.15779     -86.8253383
  Sleep    0.5s
Paso 1327
  Set Location    21.1579565     -86.8253516
  Sleep    0.5s
Paso 1328
  Set Location    21.1579565     -86.8253516
  Sleep    0.5s
Paso 1329
  Set Location    21.1582091     -86.8254081
  Sleep    0.5s
Paso 1330
  Set Location    21.1582091     -86.8254081
  Sleep    0.5s
Paso 1331
  Set Location    21.1583651     -86.8254305
  Sleep    0.5s
Paso 1332
  Set Location    21.1583651     -86.8254305
  Sleep    0.5s
Paso 1333
  Set Location    21.1593886     -86.8254852
  Sleep    0.5s
Paso 1334
  Set Location    21.1593886     -86.8254852
  Sleep    0.5s
Paso 1335
  Set Location    21.1601443     -86.8255585
  Sleep    0.5s
Paso 1336
  Set Location    21.1601443     -86.8255585
  Sleep    0.5s
Paso 1337
  Set Location    21.1612793     -86.8256671
  Sleep    0.5s
Paso 1338
  Set Location    21.1612793     -86.8256671
  Sleep    0.5s
Paso 1339
  Set Location    21.1619511     -86.8257069
  Sleep    0.5s
Paso 1340
  Set Location    21.1619511     -86.8257069
  Sleep    0.5s
Paso 1341
  Set Location    21.1629182     -86.825764
  Sleep    0.5s
Paso 1342
  Set Location    21.1629182     -86.825764
  Sleep    0.5s
Paso 1343
  Set Location    21.1632234     -86.8254837
  Sleep    0.5s
Paso 1344
  Set Location    21.1632234     -86.8254837
  Sleep    0.5s
Paso 1345
  Set Location    21.1642069     -86.8257704
  Sleep    0.5s
Paso 1346
  Set Location    21.1642069     -86.8257704
  Sleep    0.5s
Paso 1347
  Set Location    21.1639371     -86.8266614
  Sleep    0.5s
Paso 1348
  Set Location    21.1639371     -86.8266614
  Sleep    0.5s
Paso 1349
  Set Location    21.1640183     -86.82663
  Sleep    0.5s
Paso 1350
  Set Location    21.1640183     -86.82663
  Sleep    0.5s
Paso 1351
  Set Location    21.164221     -86.826297
  Sleep    0.5s
Paso 1352
  Set Location    21.164221     -86.826297
  Sleep    0.5s
Paso 1353
  Set Location    21.1642217     -86.8262967
  Sleep    0.5s
Paso 1354
  Set Location    21.1642217     -86.8262967
  Sleep    0.5s
Paso 1355
  Set Location    21.1644186     -86.826255
  Sleep    0.5s
Paso 1356
  Set Location    21.1644186     -86.826255
  Sleep    0.5s
Paso 1357
  Set Location    21.1644118     -86.8261193
  Sleep    0.5s
Paso 1358
  Set Location    21.1644118     -86.8261193
  Sleep    0.5s
Paso 1359
  Set Location    21.1644117     -86.8261183
  Sleep    0.5s
Paso 1360
  Set Location    21.1644117     -86.8261183
  Sleep    0.5s
Paso 1361
  Set Location    21.1644267     -86.8262367
  Sleep    0.5s
Paso 1362
  Set Location    21.1644267     -86.8262367
  Sleep    0.5s
Paso 1363
  Set Location    21.1644591     -86.8263126
  Sleep    0.5s
Paso 1364
  Set Location    21.1644591     -86.8263126
  Sleep    0.5s
Paso 1365
  Set Location    21.1644817     -86.82635
  Sleep    0.5s
Paso 1366
  Set Location    21.1644817     -86.82635
  Sleep    0.5s
Paso 1367
  Set Location    21.1644917     -86.826475
  Sleep    0.5s
Paso 1368
  Set Location    21.1644917     -86.826475
  Sleep    0.5s
Paso 1369
  Set Location    21.1644804     -86.8263894
  Sleep    0.5s
Paso 1370
  Set Location    21.1644804     -86.8263894
  Sleep    0.5s
Paso 1371
  Set Location    21.16448     -86.82637
  Sleep    0.5s
Paso 1372
  Set Location    21.16448     -86.82637
  Sleep    0.5s
Paso 1373
  Set Location    21.164314     -86.8262099
  Sleep    0.5s
Paso 1374
  Set Location    21.164314     -86.8262099
  Sleep    0.5s
Paso 1375
  Set Location    21.1641367     -86.8261517
  Sleep    0.5s
Paso 1376
  Set Location    21.1641367     -86.8261517
  Sleep    0.5s
Paso 1377
  Set Location    21.1636806     -86.8262462
  Sleep    0.5s
Paso 1378
  Set Location    21.1636806     -86.8262462
  Sleep    0.5s
Paso 1379
  Set Location    21.1625366     -86.825829
  Sleep    0.5s
Paso 1380
  Set Location    21.1625366     -86.825829
  Sleep    0.5s
Paso 1381
  Set Location    21.1613606     -86.8257329
  Sleep    0.5s
Paso 1382
  Set Location    21.1613606     -86.8257329
  Sleep    0.5s
Paso 1383
  Set Location    21.1602268     -86.8256583
  Sleep    0.5s
Paso 1384
  Set Location    21.1602268     -86.8256583
  Sleep    0.5s
Paso 1385
  Set Location    21.1594707     -86.8255914
  Sleep    0.5s
Paso 1386
  Set Location    21.1594707     -86.8255914
  Sleep    0.5s
Paso 1387
  Set Location    21.1587512     -86.8255374
  Sleep    0.5s
Paso 1388
  Set Location    21.1587512     -86.8255374
  Sleep    0.5s
Paso 1389
  Set Location    21.1585832     -86.8255357
  Sleep    0.5s
Paso 1390
  Set Location    21.1585832     -86.8255357
  Sleep    0.5s
Paso 1391
  Set Location    21.1580665     -86.8254997
  Sleep    0.5s
Paso 1392
  Set Location    21.1580665     -86.8254997
  Sleep    0.5s
Paso 1393
  Set Location    21.1580467     -86.8255017
  Sleep    0.5s
Paso 1394
  Set Location    21.1580467     -86.8255017
  Sleep    0.5s
Paso 1395
  Set Location    21.1574375     -86.8255082
  Sleep    0.5s
Paso 1396
  Set Location    21.1574375     -86.8255082
  Sleep    0.5s
Paso 1397
  Set Location    21.1561582     -86.8253314
  Sleep    0.5s
Paso 1398
  Set Location    21.1561582     -86.8253314
  Sleep    0.5s
Paso 1399
  Set Location    21.1542001     -86.8251849
  Sleep    0.5s
Paso 1400
  Set Location    21.1542001     -86.8251849
  Sleep    0.5s
Paso 1401
  Set Location    21.1519913     -86.8250099
  Sleep    0.5s
Paso 1402
  Set Location    21.1519913     -86.8250099
  Sleep    0.5s
Paso 1403
  Set Location    21.1505388     -86.8249361
  Sleep    0.5s
Paso 1404
  Set Location    21.1505388     -86.8249361
  Sleep    0.5s
Paso 1405
  Set Location    21.1490301     -86.8248121
  Sleep    0.5s
Paso 1406
  Set Location    21.1490301     -86.8248121
  Sleep    0.5s
Paso 1407
  Set Location    21.1471936     -86.824635
  Sleep    0.5s
Paso 1408
  Set Location    21.1471936     -86.824635
  Sleep    0.5s
Paso 1409
  Set Location    21.1452799     -86.8245341
  Sleep    0.5s
Paso 1410
  Set Location    21.1452799     -86.8245341
  Sleep    0.5s
Paso 1411
  Set Location    21.1445617     -86.8245067
  Sleep    0.5s
Paso 1412
  Set Location    21.1445617     -86.8245067
  Sleep    0.5s
Paso 1413
  Set Location    21.144528     -86.8244801
  Sleep    0.5s
Paso 1414
  Set Location    21.144528     -86.8244801
  Sleep    0.5s
Paso 1415
  Set Location    21.143688     -86.8244497
  Sleep    0.5s
Paso 1416
  Set Location    21.143688     -86.8244497
  Sleep    0.5s
Paso 1417
  Set Location    21.1419588     -86.8244693
  Sleep    0.5s
Paso 1418
  Set Location    21.1419588     -86.8244693
  Sleep    0.5s
Paso 1419
  Set Location    21.139932     -86.8254142
  Sleep    0.5s
Paso 1420
  Set Location    21.139932     -86.8254142
  Sleep    0.5s
Paso 1421
  Set Location    21.1382068     -86.8262213
  Sleep    0.5s
Paso 1422
  Set Location    21.1382068     -86.8262213
  Sleep    0.5s
Paso 1423
  Set Location    21.1362089     -86.827218
  Sleep    0.5s
Paso 1424
  Set Location    21.1362089     -86.827218
  Sleep    0.5s
Paso 1425
  Set Location    21.1337873     -86.8283864
  Sleep    0.5s
Paso 1426
  Set Location    21.1337873     -86.8283864
  Sleep    0.5s
Paso 1427
  Set Location    21.1313574     -86.8295523
  Sleep    0.5s
Paso 1428
  Set Location    21.1313574     -86.8295523
  Sleep    0.5s
Paso 1429
  Set Location    21.1288909     -86.8307645
  Sleep    0.5s
Paso 1430
  Set Location    21.1288909     -86.8307645
  Sleep    0.5s
Paso 1431
  Set Location    21.1264484     -86.8319802
  Sleep    0.5s
Paso 1432
  Set Location    21.1264484     -86.8319802
  Sleep    0.5s
Paso 1433
  Set Location    21.1238281     -86.8332569
  Sleep    0.5s
Paso 1434
  Set Location    21.1238281     -86.8332569
  Sleep    0.5s
Paso 1435
  Set Location    21.1212369     -86.8345369
  Sleep    0.5s
Paso 1436
  Set Location    21.1212369     -86.8345369
  Sleep    0.5s
Paso 1437
  Set Location    21.11857     -86.8358362
  Sleep    0.5s
Paso 1438
  Set Location    21.11857     -86.8358362
  Sleep    0.5s
Paso 1439
  Set Location    21.1158684     -86.8371432
  Sleep    0.5s
Paso 1440
  Set Location    21.1158684     -86.8371432
  Sleep    0.5s
Paso 1441
  Set Location    21.1131687     -86.8384666
  Sleep    0.5s
Paso 1442
  Set Location    21.1131687     -86.8384666
  Sleep    0.5s
Paso 1443
  Set Location    21.1103563     -86.8391842
  Sleep    0.5s
Paso 1444
  Set Location    21.1103563     -86.8391842
  Sleep    0.5s
Paso 1445
  Set Location    21.1076166     -86.8396245
  Sleep    0.5s
Paso 1446
  Set Location    21.1076166     -86.8396245
  Sleep    0.5s
Paso 1447
  Set Location    21.1051764     -86.8400301
  Sleep    0.5s
Paso 1448
  Set Location    21.1051764     -86.8400301
  Sleep    0.5s
Paso 1449
  Set Location    21.1033928     -86.8403321
  Sleep    0.5s
Paso 1450
  Set Location    21.1033928     -86.8403321
  Sleep    0.5s
Paso 1451
  Set Location    21.1031733     -86.8403633
  Sleep    0.5s
Paso 1452
  Set Location    21.1031733     -86.8403633
  Sleep    0.5s
Paso 1453
  Set Location    21.1020438     -86.8405183
  Sleep    0.5s
Paso 1454
  Set Location    21.1020438     -86.8405183
  Sleep    0.5s
Paso 1455
  Set Location    21.0999452     -86.8408517
  Sleep    0.5s
Paso 1456
  Set Location    21.0999452     -86.8408517
  Sleep    0.5s
Paso 1457
  Set Location    21.0976519     -86.8411993
  Sleep    0.5s
Paso 1458
  Set Location    21.0976519     -86.8411993
  Sleep    0.5s
Paso 1459
  Set Location    21.0955187     -86.8415233
  Sleep    0.5s
Paso 1460
  Set Location    21.0955187     -86.8415233
  Sleep    0.5s
Paso 1461
  Set Location    21.0932049     -86.8418981
  Sleep    0.5s
Paso 1462
  Set Location    21.0932049     -86.8418981
  Sleep    0.5s
Paso 1463
  Set Location    21.0910317     -86.8422368
  Sleep    0.5s
Paso 1464
  Set Location    21.0910317     -86.8422368
  Sleep    0.5s
Paso 1465
  Set Location    21.0888869     -86.8425667
  Sleep    0.5s
Paso 1466
  Set Location    21.0888869     -86.8425667
  Sleep    0.5s
Paso 1467
  Set Location    21.087822     -86.8427596
  Sleep    0.5s
Paso 1468
  Set Location    21.087822     -86.8427596
  Sleep    0.5s
Paso 1469
  Set Location    21.0865461     -86.8429568
  Sleep    0.5s
Paso 1470
  Set Location    21.0865461     -86.8429568
  Sleep    0.5s
Paso 1471
  Set Location    21.086269     -86.842997
  Sleep    0.5s
Paso 1472
  Set Location    21.086269     -86.842997
  Sleep    0.5s
Paso 1473
  Set Location    21.0857315     -86.8430735
  Sleep    0.5s
Paso 1474
  Set Location    21.0857315     -86.8430735
  Sleep    0.5s
Paso 1475
  Set Location    21.0856337     -86.8430697
  Sleep    0.5s
Paso 1476
  Set Location    21.0856337     -86.8430697
  Sleep    0.5s
Paso 1477
  Set Location    21.0853984     -86.8431083
  Sleep    0.5s
Paso 1478
  Set Location    21.0853984     -86.8431083
  Sleep    0.5s
Paso 1479
  Set Location    21.0852367     -86.8431148
  Sleep    0.5s
Paso 1480
  Set Location    21.0852367     -86.8431148
  Sleep    0.5s
Paso 1481
  Set Location    21.0850915     -86.8431422
  Sleep    0.5s
Paso 1482
  Set Location    21.0850915     -86.8431422
  Sleep    0.5s
Paso 1483
  Set Location    21.0848202     -86.8431915
  Sleep    0.5s
Paso 1484
  Set Location    21.0848202     -86.8431915
  Sleep    0.5s
Paso 1485
  Set Location    21.0844186     -86.8432693
  Sleep    0.5s
Paso 1486
  Set Location    21.0844186     -86.8432693
  Sleep    0.5s
Paso 1487
  Set Location    21.0839216     -86.8433984
  Sleep    0.5s
Paso 1488
  Set Location    21.0839216     -86.8433984
  Sleep    0.5s
Paso 1489
  Set Location    21.0835384     -86.8434382
  Sleep    0.5s
Paso 1490
  Set Location    21.0835384     -86.8434382
  Sleep    0.5s
Paso 1491
  Set Location    21.0832836     -86.8434884
  Sleep    0.5s
Paso 1492
  Set Location    21.0832836     -86.8434884
  Sleep    0.5s
Paso 1493
  Set Location    21.0831621     -86.8434911
  Sleep    0.5s
Paso 1494
  Set Location    21.0831621     -86.8434911
  Sleep    0.5s
Paso 1495
  Set Location    21.0827399     -86.8435649
  Sleep    0.5s
Paso 1496
  Set Location    21.0827399     -86.8435649
  Sleep    0.5s
Paso 1497
  Set Location    21.0825267     -86.8436167
  Sleep    0.5s
Paso 1498
  Set Location    21.0825267     -86.8436167
  Sleep    0.5s
Paso 1499
  Set Location    21.0821648     -86.8436619
  Sleep    0.5s
Paso 1500
  Set Location    21.0821648     -86.8436619
  Sleep    0.5s
Paso 1501
  Set Location    21.0820185     -86.8436581
  Sleep    0.5s
Paso 1502
  Set Location    21.0820185     -86.8436581
  Sleep    0.5s
Paso 1503
  Set Location    21.081915     -86.8436733
  Sleep    0.5s
Paso 1504
  Set Location    21.081915     -86.8436733
  Sleep    0.5s
Paso 1505
  Set Location    21.0817424     -86.84369
  Sleep    0.5s
Paso 1506
  Set Location    21.0817424     -86.84369
  Sleep    0.5s
Paso 1507
  Set Location    21.0814433     -86.843735
  Sleep    0.5s
Paso 1508
  Set Location    21.0814433     -86.843735
  Sleep    0.5s
Paso 1509
  Set Location    21.0811218     -86.8437736
  Sleep    0.5s
Paso 1510
  Set Location    21.0811218     -86.8437736
  Sleep    0.5s
Paso 1511
  Set Location    21.0808556     -86.8438201
  Sleep    0.5s
Paso 1512
  Set Location    21.0808556     -86.8438201
  Sleep    0.5s
Paso 1513
  Set Location    21.080695     -86.84385
  Sleep    0.5s
Paso 1514
  Set Location    21.080695     -86.84385
  Sleep    0.5s
Paso 1515
  Set Location    21.080562     -86.8438629
  Sleep    0.5s
Paso 1516
  Set Location    21.080562     -86.8438629
  Sleep    0.5s
Paso 1517
  Set Location    21.0802913     -86.8439359
  Sleep    0.5s
Paso 1518
  Set Location    21.0802913     -86.8439359
  Sleep    0.5s
Paso 1519
  Set Location    21.0799768     -86.8439967
  Sleep    0.5s
Paso 1520
  Set Location    21.0799768     -86.8439967
  Sleep    0.5s
Paso 1521
  Set Location    21.0798651     -86.8440024
  Sleep    0.5s
Paso 1522
  Set Location    21.0798651     -86.8440024
  Sleep    0.5s
Paso 1523
  Set Location    21.0795899     -86.8440641
  Sleep    0.5s
Paso 1524
  Set Location    21.0795899     -86.8440641
  Sleep    0.5s
Paso 1525
  Set Location    21.0792984     -86.8441167
  Sleep    0.5s
Paso 1526
  Set Location    21.0792984     -86.8441167
  Sleep    0.5s
Paso 1527
  Set Location    21.0789776     -86.844153
  Sleep    0.5s
Paso 1528
  Set Location    21.0789776     -86.844153
  Sleep    0.5s
Paso 1529
  Set Location    21.0780574     -86.844292
  Sleep    0.5s
Paso 1530
  Set Location    21.0780574     -86.844292
  Sleep    0.5s
Paso 1531
  Set Location    21.0764003     -86.8445285
  Sleep    0.5s
Paso 1532
  Set Location    21.0764003     -86.8445285
  Sleep    0.5s
Paso 1533
  Set Location    21.0741718     -86.8448448
  Sleep    0.5s
Paso 1534
  Set Location    21.0741718     -86.8448448
  Sleep    0.5s
Paso 1535
  Set Location    21.0720153     -86.8451766
  Sleep    0.5s
Paso 1536
  Set Location    21.0720153     -86.8451766
  Sleep    0.5s
Paso 1537
  Set Location    21.0704163     -86.845418
  Sleep    0.5s
Paso 1538
  Set Location    21.0704163     -86.845418
  Sleep    0.5s
Paso 1539
  Set Location    21.0693537     -86.8455928
  Sleep    0.5s
Paso 1540
  Set Location    21.0693537     -86.8455928
  Sleep    0.5s
Paso 1541
  Set Location    21.069095     -86.8456253
  Sleep    0.5s
Paso 1542
  Set Location    21.069095     -86.8456253
  Sleep    0.5s
Paso 1543
  Set Location    21.0681653     -86.8457514
  Sleep    0.5s
Paso 1544
  Set Location    21.0681653     -86.8457514
  Sleep    0.5s
Paso 1545
  Set Location    21.0656335     -86.8461629
  Sleep    0.5s
Paso 1546
  Set Location    21.0656335     -86.8461629
  Sleep    0.5s
Paso 1547
  Set Location    21.0631697     -86.8465565
  Sleep    0.5s
Paso 1548
  Set Location    21.0631697     -86.8465565
  Sleep    0.5s
Paso 1549
  Set Location    21.0605451     -86.8469647
  Sleep    0.5s
Paso 1550
  Set Location    21.0605451     -86.8469647
  Sleep    0.5s
Paso 1551
  Set Location    21.0577998     -86.8473916
  Sleep    0.5s
Paso 1552
  Set Location    21.0577998     -86.8473916
  Sleep    0.5s
Paso 1553
  Set Location    21.0562919     -86.8476281
  Sleep    0.5s
Paso 1554
  Set Location    21.0562919     -86.8476281
  Sleep    0.5s
Paso 1555
  Set Location    21.0529366     -86.8481997
  Sleep    0.5s
Paso 1556
  Set Location    21.0529366     -86.8481997
  Sleep    0.5s
Paso 1557
  Set Location    21.0499965     -86.8486401
  Sleep    0.5s
Paso 1558
  Set Location    21.0499965     -86.8486401
  Sleep    0.5s
Paso 1559
  Set Location    21.0473929     -86.8490178
  Sleep    0.5s
Paso 1560
  Set Location    21.0473929     -86.8490178
  Sleep    0.5s
Paso 1561
  Set Location    21.0449964     -86.8494208
  Sleep    0.5s
Paso 1562
  Set Location    21.0449964     -86.8494208
  Sleep    0.5s
Paso 1563
  Set Location    21.0423915     -86.8498384
  Sleep    0.5s
Paso 1564
  Set Location    21.0423915     -86.8498384
  Sleep    0.5s
Paso 1565
  Set Location    21.0397071     -86.8502799
  Sleep    0.5s
Paso 1566
  Set Location    21.0397071     -86.8502799
  Sleep    0.5s
Paso 1567
  Set Location    21.0371124     -86.8508858
  Sleep    0.5s
Paso 1568
  Set Location    21.0371124     -86.8508858
  Sleep    0.5s
Paso 1569
  Set Location    21.0349843     -86.8520221
  Sleep    0.5s
Paso 1570
  Set Location    21.0349843     -86.8520221
  Sleep    0.5s
Paso 1571
  Set Location    21.0342053     -86.8545109
  Sleep    0.5s
Paso 1572
  Set Location    21.0342053     -86.8545109
  Sleep    0.5s
Paso 1573
  Set Location    21.0353296     -86.8570033
  Sleep    0.5s
Paso 1574
  Set Location    21.0353296     -86.8570033
  Sleep    0.5s
Paso 1575
  Set Location    21.0370532     -86.8596118
  Sleep    0.5s
Paso 1576
  Set Location    21.0370532     -86.8596118
  Sleep    0.5s
Paso 1577
  Set Location    21.0387013     -86.8623649
  Sleep    0.5s
Paso 1578
  Set Location    21.0387013     -86.8623649
  Sleep    0.5s
Paso 1579
  Set Location    21.0403705     -86.8650093
  Sleep    0.5s
Paso 1580
  Set Location    21.0403705     -86.8650093
  Sleep    0.5s
Paso 1581
  Set Location    21.0418886     -86.8674396
  Sleep    0.5s
Paso 1582
  Set Location    21.0418886     -86.8674396
  Sleep    0.5s
Paso 1583
  Set Location    21.0431019     -86.8693533
  Sleep    0.5s
Paso 1584
  Set Location    21.0431019     -86.8693533
  Sleep    0.5s
Paso 1585
  Set Location    21.0444849     -86.871551
  Sleep    0.5s
Paso 1586
  Set Location    21.0444849     -86.871551
  Sleep    0.5s
Paso 1587
  Set Location    21.0458736     -86.8737694
  Sleep    0.5s
Paso 1588
  Set Location    21.0458736     -86.8737694
  Sleep    0.5s
Paso 1589
  Set Location    21.0463733     -86.875885
  Sleep    0.5s
Paso 1590
  Set Location    21.0463733     -86.875885
  Sleep    0.5s
Paso 1591
  Set Location    21.0459761     -86.8774333
  Sleep    0.5s
Paso 1592
  Set Location    21.0459761     -86.8774333
  Sleep    0.5s
Paso 1593
  Set Location    21.0468098     -86.8787422
  Sleep    0.5s
Paso 1594
  Set Location    21.0468098     -86.8787422
  Sleep    0.5s
Paso 1595
  Set Location    21.0470528     -86.8791108
  Sleep    0.5s
Paso 1596
  Set Location    21.0470528     -86.8791108
  Sleep    0.5s
Paso 1597
  Set Location    21.0466477     -86.879878
  Sleep    0.5s
Paso 1598
  Set Location    21.0466477     -86.879878
  Sleep    0.5s
Paso 1599
  Set Location    21.0461606     -86.8802899
  Sleep    0.5s
Paso 1600
  Set Location    21.0461606     -86.8802899
  Sleep    0.5s
Paso 1601
  Set Location    21.0455886     -86.8806799
  Sleep    0.5s
Paso 1602
  Set Location    21.0455886     -86.8806799
  Sleep    0.5s
Paso 1603
  Set Location    21.0448322     -86.8806709
  Sleep    0.5s
Paso 1604
  Set Location    21.0448322     -86.8806709
  Sleep    0.5s
Paso 1605
  Set Location    21.0452983     -86.880235
  Sleep    0.5s
Paso 1606
  Set Location    21.0452983     -86.880235
  Sleep    0.5s
Paso 1607
  Set Location    21.0454059     -86.8802101
  Sleep    0.5s
Paso 1608
  Set Location    21.0454059     -86.8802101
  Sleep    0.5s
Paso 1609
  Set Location    21.0455476     -86.8797473
  Sleep    0.5s
Paso 1610
  Set Location    21.0455476     -86.8797473
  Sleep    0.5s
Paso 1611
  Set Location    21.0445268     -86.8781013
  Sleep    0.5s
Paso 1612
  Set Location    21.0445268     -86.8781013
  Sleep    0.5s
Paso 1613
  Set Location    21.0453133     -86.8766054
  Sleep    0.5s
Paso 1614
  Set Location    21.0453133     -86.8766054
  Sleep    0.5s
Paso 1615
  Set Location    21.0463203     -86.8746911
  Sleep    0.5s
Paso 1616
  Set Location    21.0463203     -86.8746911
  Sleep    0.5s
Paso 1617
  Set Location    21.0452007     -86.8728735
  Sleep    0.5s
Paso 1618
  Set Location    21.0452007     -86.8728735
  Sleep    0.5s
Paso 1619
  Set Location    21.0439546     -86.8722577
  Sleep    0.5s
Paso 1620
  Set Location    21.0439546     -86.8722577
  Sleep    0.5s
Paso 1621
  Set Location    21.0427013     -86.8731289
  Sleep    0.5s
Paso 1622
  Set Location    21.0427013     -86.8731289
  Sleep    0.5s
Paso 1623
  Set Location    21.0413405     -86.8740821
  Sleep    0.5s
Paso 1624
  Set Location    21.0413405     -86.8740821
  Sleep    0.5s
Paso 1625
  Set Location    21.0409081     -86.8738538
  Sleep    0.5s
Paso 1626
  Set Location    21.0409081     -86.8738538
  Sleep    0.5s
Paso 1627
  Set Location    21.0407183     -86.8735334
  Sleep    0.5s
Paso 1628
  Set Location    21.0407183     -86.8735334
  Sleep    0.5s
Paso 1629
  Set Location    21.0404269     -86.8730996
  Sleep    0.5s
Paso 1630
  Set Location    21.0404269     -86.8730996
  Sleep    0.5s
Paso 1631
  Set Location    21.040027     -86.8724813
  Sleep    0.5s
Paso 1632
  Set Location    21.040027     -86.8724813
  Sleep    0.5s
Paso 1633
  Set Location    21.0396867     -86.87232
  Sleep    0.5s
Paso 1634
  Set Location    21.0396867     -86.87232
  Sleep    0.5s
Paso 1635
  Set Location    21.0396265     -86.8723752
  Sleep    0.5s
Paso 1636
  Set Location    21.0396265     -86.8723752
  Sleep    0.5s
Paso 1637
  Set Location    21.0392294     -86.8727658
  Sleep    0.5s
Paso 1638
  Set Location    21.0392294     -86.8727658
  Sleep    0.5s
Paso 1639
  Set Location    21.0395377     -86.8723738
  Sleep    0.5s
Paso 1640
  Set Location    21.0395377     -86.8723738
  Sleep    0.5s
Paso 1641
  Set Location    21.0398117     -86.872175
  Sleep    0.5s
Paso 1642
  Set Location    21.0398117     -86.872175
  Sleep    0.5s
Paso 1643
  Set Location    21.0398919     -86.8721202
  Sleep    0.5s
Paso 1644
  Set Location    21.0398919     -86.8721202
  Sleep    0.5s
Paso 1645
  Set Location    21.0399517     -86.8720633
  Sleep    0.5s
Paso 1646
  Set Location    21.0399517     -86.8720633
  Sleep    0.5s
Paso 1647
  Set Location    21.0400388     -86.8720321
  Sleep    0.5s
Paso 1648
  Set Location    21.0400388     -86.8720321
  Sleep    0.5s
Paso 1649
  Set Location    21.0403995     -86.8714392
  Sleep    0.5s
Paso 1650
  Set Location    21.0403995     -86.8714392
  Sleep    0.5s
Paso 1651
  Set Location    21.0396468     -86.8699569
  Sleep    0.5s
Paso 1652
  Set Location    21.0396468     -86.8699569
  Sleep    0.5s
Paso 1653
  Set Location    21.0396804     -86.8696645
  Sleep    0.5s
Paso 1654
  Set Location    21.0396804     -86.8696645
  Sleep    0.5s
Paso 1655
  Set Location    21.0408804     -86.8687173
  Sleep    0.5s
Paso 1656
  Set Location    21.0408804     -86.8687173
  Sleep    0.5s
Paso 1657
  Set Location    21.0418154     -86.8675431
  Sleep    0.5s
Paso 1658
  Set Location    21.0418154     -86.8675431
  Sleep    0.5s
Paso 1659
  Set Location    21.0407457     -86.865785
  Sleep    0.5s
Paso 1660
  Set Location    21.0407457     -86.865785
  Sleep    0.5s
Paso 1661
  Set Location    21.0398135     -86.864263
  Sleep    0.5s
Paso 1662
  Set Location    21.0398135     -86.864263
  Sleep    0.5s
Paso 1663
  Set Location    21.0386016     -86.8623578
  Sleep    0.5s
Paso 1664
  Set Location    21.0386016     -86.8623578
  Sleep    0.5s
Paso 1665
  Set Location    21.0371956     -86.86011
  Sleep    0.5s
Paso 1666
  Set Location    21.0371956     -86.86011
  Sleep    0.5s
Paso 1667
  Set Location    21.0358132     -86.8578784
  Sleep    0.5s
Paso 1668
  Set Location    21.0358132     -86.8578784
  Sleep    0.5s
Paso 1669
  Set Location    21.0344385     -86.8556813
  Sleep    0.5s
Paso 1670
  Set Location    21.0344385     -86.8556813
  Sleep    0.5s
Paso 1671
  Set Location    21.0334751     -86.8535751
  Sleep    0.5s
Paso 1672
  Set Location    21.0334751     -86.8535751
  Sleep    0.5s
Paso 1673
  Set Location    21.033242     -86.852222
  Sleep    0.5s
Paso 1674
  Set Location    21.033242     -86.852222
  Sleep    0.5s
Paso 1675
  Set Location    21.0331734     -86.8517485
  Sleep    0.5s
Paso 1676
  Set Location    21.0331734     -86.8517485
  Sleep    0.5s
Paso 1677
  Set Location    21.032849     -86.8509393
  Sleep    0.5s
Paso 1678
  Set Location    21.032849     -86.8509393
  Sleep    0.5s
Paso 1679
  Set Location    21.032235     -86.8511108
  Sleep    0.5s
Paso 1680
  Set Location    21.032235     -86.8511108
  Sleep    0.5s
Paso 1681
  Set Location    21.0323289     -86.8518442
  Sleep    0.5s
Paso 1682
  Set Location    21.0323289     -86.8518442
  Sleep    0.5s
Paso 1683
  Set Location    21.0327336     -86.8519491
  Sleep    0.5s
Paso 1684
  Set Location    21.0327336     -86.8519491
  Sleep    0.5s
Paso 1685
  Set Location    21.0344511     -86.8516379
  Sleep    0.5s
Paso 1686
  Set Location    21.0344511     -86.8516379
  Sleep    0.5s
Paso 1687
  Set Location    21.036666     -86.850829
  Sleep    0.5s
Paso 1688
  Set Location    21.036666     -86.850829
  Sleep    0.5s
Paso 1689
  Set Location    21.0392635     -86.8501732
  Sleep    0.5s
Paso 1690
  Set Location    21.0392635     -86.8501732
  Sleep    0.5s
Paso 1691
  Set Location    21.0419263     -86.8497656
  Sleep    0.5s
Paso 1692
  Set Location    21.0419263     -86.8497656
  Sleep    0.5s
Paso 1693
  Set Location    21.0444841     -86.8493673
  Sleep    0.5s
Paso 1694
  Set Location    21.0444841     -86.8493673
  Sleep    0.5s
Paso 1695
  Set Location    21.0470301     -86.8489597
  Sleep    0.5s
Paso 1696
  Set Location    21.0470301     -86.8489597
  Sleep    0.5s
Paso 1697
  Set Location    21.0495647     -86.8485885
  Sleep    0.5s
Paso 1698
  Set Location    21.0495647     -86.8485885
  Sleep    0.5s
Paso 1699
  Set Location    21.0516565     -86.8482656
  Sleep    0.5s
Paso 1700
  Set Location    21.0516565     -86.8482656
  Sleep    0.5s
Paso 1701
  Set Location    21.0542581     -86.8478557
  Sleep    0.5s
Paso 1702
  Set Location    21.0542581     -86.8478557
  Sleep    0.5s
Paso 1703
  Set Location    21.0570697     -86.847422
  Sleep    0.5s
Paso 1704
  Set Location    21.0570697     -86.847422
  Sleep    0.5s
Paso 1705
  Set Location    21.0599136     -86.8469769
  Sleep    0.5s
Paso 1706
  Set Location    21.0599136     -86.8469769
  Sleep    0.5s
Paso 1707
  Set Location    21.0627062     -86.8465627
  Sleep    0.5s
Paso 1708
  Set Location    21.0627062     -86.8465627
  Sleep    0.5s
Paso 1709
  Set Location    21.0655728     -86.8461257
  Sleep    0.5s
Paso 1710
  Set Location    21.0655728     -86.8461257
  Sleep    0.5s
Paso 1711
  Set Location    21.0684632     -86.8456639
  Sleep    0.5s
Paso 1712
  Set Location    21.0684632     -86.8456639
  Sleep    0.5s
Paso 1713
  Set Location    21.0714445     -86.8451518
  Sleep    0.5s
Paso 1714
  Set Location    21.0714445     -86.8451518
  Sleep    0.5s
Paso 1715
  Set Location    21.0743718     -86.8447085
  Sleep    0.5s
Paso 1716
  Set Location    21.0743718     -86.8447085
  Sleep    0.5s
Paso 1717
  Set Location    21.0770258     -86.8442953
  Sleep    0.5s
Paso 1718
  Set Location    21.0770258     -86.8442953
  Sleep    0.5s
Paso 1719
  Set Location    21.0794553     -86.8439217
  Sleep    0.5s
Paso 1720
  Set Location    21.0794553     -86.8439217
  Sleep    0.5s
Paso 1721
  Set Location    21.08192     -86.8435389
  Sleep    0.5s
Paso 1722
  Set Location    21.08192     -86.8435389
  Sleep    0.5s
Paso 1723
  Set Location    21.084449     -86.8431101
  Sleep    0.5s
Paso 1724
  Set Location    21.084449     -86.8431101
  Sleep    0.5s
Paso 1725
  Set Location    21.086961     -86.8426805
  Sleep    0.5s
Paso 1726
  Set Location    21.086961     -86.8426805
  Sleep    0.5s
Paso 1727
  Set Location    21.0895871     -86.8422386
  Sleep    0.5s
Paso 1728
  Set Location    21.0895871     -86.8422386
  Sleep    0.5s
Paso 1729
  Set Location    21.0923381     -86.8419181
  Sleep    0.5s
Paso 1730
  Set Location    21.0923381     -86.8419181
  Sleep    0.5s
Paso 1731
  Set Location    21.0952701     -86.8414384
  Sleep    0.5s
Paso 1732
  Set Location    21.0952701     -86.8414384
  Sleep    0.5s
Paso 1733
  Set Location    21.0979767     -86.8410253
  Sleep    0.5s
Paso 1734
  Set Location    21.0979767     -86.8410253
  Sleep    0.5s
Paso 1735
  Set Location    21.1000937     -86.8406987
  Sleep    0.5s
Paso 1736
  Set Location    21.1000937     -86.8406987
  Sleep    0.5s
Paso 1737
  Set Location    21.1015965     -86.8404569
  Sleep    0.5s
Paso 1738
  Set Location    21.1015965     -86.8404569
  Sleep    0.5s
Paso 1739
  Set Location    21.1037626     -86.8401219
  Sleep    0.5s
Paso 1740
  Set Location    21.1037626     -86.8401219
  Sleep    0.5s
Paso 1741
  Set Location    21.106153     -86.839744
  Sleep    0.5s
Paso 1742
  Set Location    21.106153     -86.839744
  Sleep    0.5s
Paso 1743
  Set Location    21.1086215     -86.8393651
  Sleep    0.5s
Paso 1744
  Set Location    21.1086215     -86.8393651
  Sleep    0.5s
Paso 1745
  Set Location    21.1111131     -86.8389739
  Sleep    0.5s
Paso 1746
  Set Location    21.1111131     -86.8389739
  Sleep    0.5s
Paso 1747
  Set Location    21.1135416     -86.8381944
  Sleep    0.5s
Paso 1748
  Set Location    21.1135416     -86.8381944
  Sleep    0.5s
Paso 1749
  Set Location    21.1158212     -86.8371072
  Sleep    0.5s
Paso 1750
  Set Location    21.1158212     -86.8371072
  Sleep    0.5s
Paso 1751
  Set Location    21.1181818     -86.8359581
  Sleep    0.5s
Paso 1752
  Set Location    21.1181818     -86.8359581
  Sleep    0.5s
Paso 1753
  Set Location    21.1188301     -86.8356133
  Sleep    0.5s
Paso 1754
  Set Location    21.1188301     -86.8356133
  Sleep    0.5s
Paso 1755
  Set Location    21.1194644     -86.8353034
  Sleep    0.5s
Paso 1756
  Set Location    21.1194644     -86.8353034
  Sleep    0.5s
Paso 1757
  Set Location    21.1214877     -86.8343103
  Sleep    0.5s
Paso 1758
  Set Location    21.1214877     -86.8343103
  Sleep    0.5s
Paso 1759
  Set Location    21.1238913     -86.8331253
  Sleep    0.5s
Paso 1760
  Set Location    21.1238913     -86.8331253
  Sleep    0.5s
Paso 1761
  Set Location    21.1260794     -86.832097
  Sleep    0.5s
Paso 1762
  Set Location    21.1260794     -86.832097
  Sleep    0.5s
Paso 1763
  Set Location    21.1282851     -86.8310254
  Sleep    0.5s
Paso 1764
  Set Location    21.1282851     -86.8310254
  Sleep    0.5s
Paso 1765
  Set Location    21.1308398     -86.8298324
  Sleep    0.5s
Paso 1766
  Set Location    21.1308398     -86.8298324
  Sleep    0.5s
Paso 1767
  Set Location    21.1321504     -86.8291469
  Sleep    0.5s
Paso 1768
  Set Location    21.1321504     -86.8291469
  Sleep    0.5s
Paso 1769
  Set Location    21.1336135     -86.8284319
  Sleep    0.5s
Paso 1770
  Set Location    21.1336135     -86.8284319
  Sleep    0.5s
Paso 1771
  Set Location    21.1339966     -86.8282335
  Sleep    0.5s
Paso 1772
  Set Location    21.1339966     -86.8282335
  Sleep    0.5s
Paso 1773
  Set Location    21.1348744     -86.8277651
  Sleep    0.5s
Paso 1774
  Set Location    21.1348744     -86.8277651
  Sleep    0.5s
Paso 1775
  Set Location    21.1367149     -86.8268337
  Sleep    0.5s
Paso 1776
  Set Location    21.1367149     -86.8268337
  Sleep    0.5s
Paso 1777
  Set Location    21.1381257     -86.8261563
  Sleep    0.5s
Paso 1778
  Set Location    21.1381257     -86.8261563
  Sleep    0.5s
Paso 1779
  Set Location    21.1385622     -86.8259563
  Sleep    0.5s
Paso 1780
  Set Location    21.1385622     -86.8259563
  Sleep    0.5s
Paso 1781
  Set Location    21.139241     -86.8254567
  Sleep    0.5s
Paso 1782
  Set Location    21.139241     -86.8254567
  Sleep    0.5s
Paso 1783
  Set Location    21.1409849     -86.8247813
  Sleep    0.5s
Paso 1784
  Set Location    21.1409849     -86.8247813
  Sleep    0.5s
Paso 1785
  Set Location    21.1428622     -86.8242661
  Sleep    0.5s
Paso 1786
  Set Location    21.1428622     -86.8242661
  Sleep    0.5s
Paso 1787
  Set Location    21.1432704     -86.8242704
  Sleep    0.5s
Paso 1788
  Set Location    21.1432704     -86.8242704
  Sleep    0.5s
Paso 1789
  Set Location    21.1444696     -86.8243241
  Sleep    0.5s
Paso 1790
  Set Location    21.1444696     -86.8243241
  Sleep    0.5s
Paso 1791
  Set Location    21.1461657     -86.8244883
  Sleep    0.5s
Paso 1792
  Set Location    21.1461657     -86.8244883
  Sleep    0.5s
Paso 1793
  Set Location    21.1465233     -86.8244883
  Sleep    0.5s
Paso 1794
  Set Location    21.1465233     -86.8244883
  Sleep    0.5s
Paso 1795
  Set Location    21.1467655     -86.8245467
  Sleep    0.5s
Paso 1796
  Set Location    21.1467655     -86.8245467
  Sleep    0.5s
Paso 1797
  Set Location    21.1483096     -86.8246739
  Sleep    0.5s
Paso 1798
  Set Location    21.1483096     -86.8246739
  Sleep    0.5s
Paso 1799
  Set Location    21.1491817     -86.8246867
  Sleep    0.5s
Paso 1800
  Set Location    21.1491817     -86.8246867
  Sleep    0.5s
Paso 1801
  Set Location    21.1494717     -86.8247053
  Sleep    0.5s
Paso 1802
  Set Location    21.1494717     -86.8247053
  Sleep    0.5s
Paso 1803
  Set Location    21.1510936     -86.8249093
  Sleep    0.5s
Paso 1804
  Set Location    21.1510936     -86.8249093
  Sleep    0.5s
Paso 1805
  Set Location    21.1536263     -86.8250528
  Sleep    0.5s
Paso 1806
  Set Location    21.1536263     -86.8250528
  Sleep    0.5s
Paso 1807
  Set Location    21.1560669     -86.8252484
  Sleep    0.5s
Paso 1808
  Set Location    21.1560669     -86.8252484
  Sleep    0.5s
Paso 1809
  Set Location    21.1562567     -86.8252517
  Sleep    0.5s
Paso 1810
  Set Location    21.1562567     -86.8252517
  Sleep    0.5s
Paso 1811
  Set Location    21.1563499     -86.82525
  Sleep    0.5s
Paso 1812
  Set Location    21.1563499     -86.82525
  Sleep    0.5s
Paso 1813
  Set Location    21.157228     -86.8252096
  Sleep    0.5s
Paso 1814
  Set Location    21.157228     -86.8252096
  Sleep    0.5s
Paso 1815
  Set Location    21.1577725     -86.8253988
  Sleep    0.5s
Paso 1816
  Set Location    21.1577725     -86.8253988
  Sleep    0.5s
Paso 1817
  Set Location    21.1579542     -86.8254295
  Sleep    0.5s
Paso 1818
  Set Location    21.1579542     -86.8254295
  Sleep    0.5s
Paso 1819
  Set Location    21.1582875     -86.8254521
  Sleep    0.5s
Paso 1820
  Set Location    21.1582875     -86.8254521
  Sleep    0.5s
Paso 1821
  Set Location    21.1583875     -86.8254609
  Sleep    0.5s
Paso 1822
  Set Location    21.1583875     -86.8254609
  Sleep    0.5s
Paso 1823
  Set Location    21.1594234     -86.8255503
  Sleep    0.5s
Paso 1824
  Set Location    21.1594234     -86.8255503
  Sleep    0.5s
Paso 1825
  Set Location    21.1606613     -86.8256462
  Sleep    0.5s
Paso 1826
  Set Location    21.1606613     -86.8256462
  Sleep    0.5s
Paso 1827
  Set Location    21.1619137     -86.8257236
  Sleep    0.5s
Paso 1828
  Set Location    21.1619137     -86.8257236
  Sleep    0.5s
Paso 1829
  Set Location    21.162933     -86.8257446
  Sleep    0.5s
Paso 1830
  Set Location    21.162933     -86.8257446
  Sleep    0.5s
Paso 1831
  Set Location    21.163546     -86.8254062
  Sleep    0.5s
Paso 1832
  Set Location    21.163546     -86.8254062
  Sleep    0.5s
Paso 1833
  Set Location    21.1640679     -86.8261626
  Sleep    0.5s
Paso 1834
  Set Location    21.1640679     -86.8261626
  Sleep    0.5s
Paso 1835
  Set Location    21.1640784     -86.8265315
  Sleep    0.5s
Paso 1836
  Set Location    21.1640784     -86.8265315
  Sleep    0.5s
Paso 1837
  Set Location    21.1641599     -86.826375
  Sleep    0.5s
Paso 1838
  Set Location    21.1641599     -86.826375
  Sleep    0.5s
Paso 1839
  Set Location    21.1644518     -86.8262888
  Sleep    0.5s
Paso 1840
  Set Location    21.1644518     -86.8262888
  Sleep    0.5s
Paso 1841
  Set Location    21.1644517     -86.82629
  Sleep    0.5s
Paso 1842
  Set Location    21.1644517     -86.82629
  Sleep    0.5s
Paso 1843
  Set Location    21.1644283     -86.8261467
  Sleep    0.5s
Paso 1844
  Set Location    21.1644283     -86.8261467
  Sleep    0.5s
Paso 1845
  Set Location    21.1643571     -86.8261557
  Sleep    0.5s
Paso 1846
  Set Location    21.1643571     -86.8261557
  Sleep    0.5s
Paso 1847
  Set Location    21.1643517     -86.826135
  Sleep    0.5s
Paso 1848
  Set Location    21.1643517     -86.826135
  Sleep    0.5s
Paso 1849
  Set Location    21.1642969     -86.8261799
  Sleep    0.5s
Paso 1850
  Set Location    21.1642969     -86.8261799
  Sleep    0.5s
Paso 1851
  Set Location    21.1640936     -86.826147
  Sleep    0.5s
Paso 1852
  Set Location    21.1640936     -86.826147
  Sleep    0.5s
Paso 1853
  Set Location    21.1635002     -86.8262252
  Sleep    0.5s
Paso 1854
  Set Location    21.1635002     -86.8262252
  Sleep    0.5s
Paso 1855
  Set Location    21.1622152     -86.8258017
  Sleep    0.5s
Paso 1856
  Set Location    21.1622152     -86.8258017
  Sleep    0.5s
Paso 1857
  Set Location    21.1611774     -86.8256966
  Sleep    0.5s
Paso 1858
  Set Location    21.1611774     -86.8256966
  Sleep    0.5s
Paso 1859
  Set Location    21.1599868     -86.8256167
  Sleep    0.5s
Paso 1860
  Set Location    21.1599868     -86.8256167
  Sleep    0.5s
Paso 1861
  Set Location    21.1593479     -86.8255534
  Sleep    0.5s
Paso 1862
  Set Location    21.1593479     -86.8255534
  Sleep    0.5s
Paso 1863
  Set Location    21.15911     -86.8255367
  Sleep    0.5s
Paso 1864
  Set Location    21.15911     -86.8255367
  Sleep    0.5s
Paso 1865
  Set Location    21.1590047     -86.825535
  Sleep    0.5s
Paso 1866
  Set Location    21.1590047     -86.825535
  Sleep    0.5s
Paso 1867
  Set Location    21.1588887     -86.8255268
  Sleep    0.5s
Paso 1868
  Set Location    21.1588887     -86.8255268
  Sleep    0.5s
Paso 1869
  Set Location    21.1582935     -86.825487
  Sleep    0.5s
Paso 1870
  Set Location    21.1582935     -86.825487
  Sleep    0.5s
Paso 1871
  Set Location    21.15788     -86.8255
  Sleep    0.5s
Paso 1872
  Set Location    21.15788     -86.8255
  Sleep    0.5s
Paso 1873
  Set Location    21.1576332     -86.8255019
  Sleep    0.5s
Paso 1874
  Set Location    21.1576332     -86.8255019
  Sleep    0.5s
Paso 1875
  Set Location    21.1564172     -86.8254363
  Sleep    0.5s
Paso 1876
  Set Location    21.1564172     -86.8254363
  Sleep    0.5s
Paso 1877
  Set Location    21.1557599     -86.8253216
  Sleep    0.5s
Paso 1878
  Set Location    21.1557599     -86.8253216
  Sleep    0.5s
Paso 1879
  Set Location    21.1537467     -86.8251666
  Sleep    0.5s
Paso 1880
  Set Location    21.1537467     -86.8251666
  Sleep    0.5s
Paso 1881
  Set Location    21.1513766     -86.8249865
  Sleep    0.5s
Paso 1882
  Set Location    21.1513766     -86.8249865
  Sleep    0.5s
Paso 1883
  Set Location    21.15025     -86.8249667
  Sleep    0.5s
Paso 1884
  Set Location    21.15025     -86.8249667
  Sleep    0.5s
Paso 1885
  Set Location    21.1498476     -86.8249099
  Sleep    0.5s
Paso 1886
  Set Location    21.1498476     -86.8249099
  Sleep    0.5s
Paso 1887
  Set Location    21.1481401     -86.8247613
  Sleep    0.5s
Paso 1888
  Set Location    21.1481401     -86.8247613
  Sleep    0.5s
Paso 1889
  Set Location    21.1461174     -86.8245899
  Sleep    0.5s
Paso 1890
  Set Location    21.1461174     -86.8245899
  Sleep    0.5s
Paso 1891
  Set Location    21.1440272     -86.8244864
  Sleep    0.5s
Paso 1892
  Set Location    21.1440272     -86.8244864
  Sleep    0.5s
Paso 1893
  Set Location    21.142075     -86.8244578
  Sleep    0.5s
Paso 1894
  Set Location    21.142075     -86.8244578
  Sleep    0.5s
Paso 1895
  Set Location    21.1405299     -86.8250508
  Sleep    0.5s
Paso 1896
  Set Location    21.1405299     -86.8250508
  Sleep    0.5s
Paso 1897
  Set Location    21.1403233     -86.8251567
  Sleep    0.5s
Paso 1898
  Set Location    21.1403233     -86.8251567
  Sleep    0.5s
Paso 1899
  Set Location    21.1400348     -86.8253014
  Sleep    0.5s
Paso 1900
  Set Location    21.1400348     -86.8253014
  Sleep    0.5s
Paso 1901
  Set Location    21.1392598     -86.8258042
  Sleep    0.5s
Paso 1902
  Set Location    21.1392598     -86.8258042
  Sleep    0.5s
Paso 1903
  Set Location    21.1375736     -86.8265097
  Sleep    0.5s
Paso 1904
  Set Location    21.1375736     -86.8265097
  Sleep    0.5s
Paso 1905
  Set Location    21.1354567     -86.8275222
  Sleep    0.5s
Paso 1906
  Set Location    21.1354567     -86.8275222
  Sleep    0.5s
Paso 1907
  Set Location    21.1333811     -86.8285845
  Sleep    0.5s
Paso 1908
  Set Location    21.1333811     -86.8285845
  Sleep    0.5s
Paso 1909
  Set Location    21.1311002     -86.8296624
  Sleep    0.5s
Paso 1910
  Set Location    21.1311002     -86.8296624
  Sleep    0.5s
Paso 1911
  Set Location    21.1288471     -86.8307309
  Sleep    0.5s
Paso 1912
  Set Location    21.1288471     -86.8307309
  Sleep    0.5s
Paso 1913
  Set Location    21.1268099     -86.8317576
  Sleep    0.5s
Paso 1914
  Set Location    21.1268099     -86.8317576
  Sleep    0.5s
Paso 1915
  Set Location    21.1243714     -86.8329894
  Sleep    0.5s
Paso 1916
  Set Location    21.1243714     -86.8329894
  Sleep    0.5s
Paso 1917
  Set Location    21.1222671     -86.8340434
  Sleep    0.5s
Paso 1918
  Set Location    21.1222671     -86.8340434
  Sleep    0.5s
Paso 1919
  Set Location    21.1203156     -86.8349898
  Sleep    0.5s
Paso 1920
  Set Location    21.1203156     -86.8349898
  Sleep    0.5s
Paso 1921
  Set Location    21.1182652     -86.8359568
  Sleep    0.5s
Paso 1922
  Set Location    21.1182652     -86.8359568
  Sleep    0.5s
Paso 1923
  Set Location    21.1159688     -86.8370841
  Sleep    0.5s
Paso 1924
  Set Location    21.1159688     -86.8370841
  Sleep    0.5s
Paso 1925
  Set Location    21.1137908     -86.8381375
  Sleep    0.5s
Paso 1926
  Set Location    21.1137908     -86.8381375
  Sleep    0.5s
Paso 1927
  Set Location    21.1114221     -86.8390152
  Sleep    0.5s
Paso 1928
  Set Location    21.1114221     -86.8390152
  Sleep    0.5s
Paso 1929
  Set Location    21.108767     -86.8394382
  Sleep    0.5s
Paso 1930
  Set Location    21.108767     -86.8394382
  Sleep    0.5s
Paso 1931
  Set Location    21.1061359     -86.8398482
  Sleep    0.5s
Paso 1932
  Set Location    21.1061359     -86.8398482
  Sleep    0.5s
Paso 1933
  Set Location    21.104579     -86.8400816
  Sleep    0.5s
Paso 1934
  Set Location    21.104579     -86.8400816
  Sleep    0.5s
Paso 1935
  Set Location    21.1031506     -86.8403132
  Sleep    0.5s
Paso 1936
  Set Location    21.1031506     -86.8403132
  Sleep    0.5s
Paso 1937
  Set Location    21.1021813     -86.8404768
  Sleep    0.5s
Paso 1938
  Set Location    21.1021813     -86.8404768
  Sleep    0.5s
Paso 1939
  Set Location    21.10215     -86.8404817
  Sleep    0.5s
Paso 1940
  Set Location    21.10215     -86.8404817
  Sleep    0.5s
Paso 1941
  Set Location    21.1012468     -86.8406168
  Sleep    0.5s
Paso 1942
  Set Location    21.1012468     -86.8406168
  Sleep    0.5s
Paso 1943
  Set Location    21.0992287     -86.8409268
  Sleep    0.5s
Paso 1944
  Set Location    21.0992287     -86.8409268
  Sleep    0.5s
Paso 1945
  Set Location    21.0967     -86.8413115
  Sleep    0.5s
Paso 1946
  Set Location    21.0967     -86.8413115
  Sleep    0.5s
Paso 1947
  Set Location    21.0942521     -86.8417003
  Sleep    0.5s
Paso 1948
  Set Location    21.0942521     -86.8417003
  Sleep    0.5s
Paso 1949
  Set Location    21.0919916     -86.8420633
  Sleep    0.5s
Paso 1950
  Set Location    21.0919916     -86.8420633
  Sleep    0.5s
Paso 1951
  Set Location    21.0900962     -86.8423597
  Sleep    0.5s
Paso 1952
  Set Location    21.0900962     -86.8423597
  Sleep    0.5s
Paso 1953
  Set Location    21.0885552     -86.8426103
  Sleep    0.5s
Paso 1954
  Set Location    21.0885552     -86.8426103
  Sleep    0.5s
Paso 1955
  Set Location    21.0877354     -86.8427465
  Sleep    0.5s
Paso 1956
  Set Location    21.0877354     -86.8427465
  Sleep    0.5s
Paso 1957
  Set Location    21.0867451     -86.8429036
  Sleep    0.5s
Paso 1958
  Set Location    21.0867451     -86.8429036
  Sleep    0.5s
Paso 1959
  Set Location    21.0865356     -86.8429334
  Sleep    0.5s
Paso 1960
  Set Location    21.0865356     -86.8429334
  Sleep    0.5s
Paso 1961
  Set Location    21.085027     -86.8431359
  Sleep    0.5s
Paso 1962
  Set Location    21.085027     -86.8431359
  Sleep    0.5s
Paso 1963
  Set Location    21.0826736     -86.8435311
  Sleep    0.5s
Paso 1964
  Set Location    21.0826736     -86.8435311
  Sleep    0.5s
Paso 1965
  Set Location    21.080024     -86.843932
  Sleep    0.5s
Paso 1966
  Set Location    21.080024     -86.843932
  Sleep    0.5s
Paso 1967
  Set Location    21.0772902     -86.8443549
  Sleep    0.5s
Paso 1968
  Set Location    21.0772902     -86.8443549
  Sleep    0.5s
Paso 1969
  Set Location    21.0745255     -86.84479
  Sleep    0.5s
Paso 1970
  Set Location    21.0745255     -86.84479
  Sleep    0.5s
Paso 1971
  Set Location    21.0718357     -86.8452108
  Sleep    0.5s
Paso 1972
  Set Location    21.0718357     -86.8452108
  Sleep    0.5s
Paso 1973
  Set Location    21.0691316     -86.8456327
  Sleep    0.5s
Paso 1974
  Set Location    21.0691316     -86.8456327
  Sleep    0.5s
Paso 1975
  Set Location    21.0665872     -86.8460413
  Sleep    0.5s
Paso 1976
  Set Location    21.0665872     -86.8460413
  Sleep    0.5s
Paso 1977
  Set Location    21.063846     -86.84647
  Sleep    0.5s
Paso 1978
  Set Location    21.063846     -86.84647
  Sleep    0.5s
Paso 1979
  Set Location    21.0611817     -86.8468703
  Sleep    0.5s
Paso 1980
  Set Location    21.0611817     -86.8468703
  Sleep    0.5s
Paso 1981
  Set Location    21.0584651     -86.8472965
  Sleep    0.5s
Paso 1982
  Set Location    21.0584651     -86.8472965
  Sleep    0.5s
Paso 1983
  Set Location    21.0556521     -86.847735
  Sleep    0.5s
Paso 1984
  Set Location    21.0556521     -86.847735
  Sleep    0.5s
Paso 1985
  Set Location    21.0528577     -86.8481751
  Sleep    0.5s
Paso 1986
  Set Location    21.0528577     -86.8481751
  Sleep    0.5s
Paso 1987
  Set Location    21.050107     -86.8486028
  Sleep    0.5s
Paso 1988
  Set Location    21.050107     -86.8486028
  Sleep    0.5s
Paso 1989
  Set Location    21.0473481     -86.8489878
  Sleep    0.5s
Paso 1990
  Set Location    21.0473481     -86.8489878
  Sleep    0.5s
Paso 1991
  Set Location    21.0446407     -86.8494547
  Sleep    0.5s
Paso 1992
  Set Location    21.0446407     -86.8494547
  Sleep    0.5s
Paso 1993
  Set Location    21.0419894     -86.8498472
  Sleep    0.5s
Paso 1994
  Set Location    21.0419894     -86.8498472
  Sleep    0.5s
Paso 1995
  Set Location    21.0392729     -86.8502883
  Sleep    0.5s
Paso 1996
  Set Location    21.0392729     -86.8502883
  Sleep    0.5s
Paso 1997
  Set Location    21.0367926     -86.8510003
  Sleep    0.5s
Paso 1998
  Set Location    21.0367926     -86.8510003
  Sleep    0.5s
Paso 1999
  Set Location    21.034888     -86.8521357
  Sleep    0.5s
Paso 2000
  Set Location    21.034888     -86.8521357
  Sleep    0.5s
Paso 2001
  Set Location    21.0342089     -86.8545981
  Sleep    0.5s
Paso 2002
  Set Location    21.0342089     -86.8545981
  Sleep    0.5s
Paso 2003
  Set Location    21.0353413     -86.8569666
  Sleep    0.5s
Paso 2004
  Set Location    21.0353413     -86.8569666
  Sleep    0.5s
Paso 2005
  Set Location    21.0366344     -86.8589785
  Sleep    0.5s
Paso 2006
  Set Location    21.0366344     -86.8589785
  Sleep    0.5s
Paso 2007
  Set Location    21.0375363     -86.8604837
  Sleep    0.5s
Paso 2008
  Set Location    21.0375363     -86.8604837
  Sleep    0.5s
Paso 2009
  Set Location    21.0391667     -86.8630404
  Sleep    0.5s
Paso 2010
  Set Location    21.0391667     -86.8630404
  Sleep    0.5s
Paso 2011
  Set Location    21.0407836     -86.8656274
  Sleep    0.5s
Paso 2012
  Set Location    21.0407836     -86.8656274
  Sleep    0.5s
Paso 2013
  Set Location    21.042378     -86.8681901
  Sleep    0.5s
Paso 2014
  Set Location    21.042378     -86.8681901
  Sleep    0.5s
Paso 2015
  Set Location    21.0438918     -86.8706704
  Sleep    0.5s
Paso 2016
  Set Location    21.0438918     -86.8706704
  Sleep    0.5s
Paso 2017
  Set Location    21.045091     -86.8725486
  Sleep    0.5s
Paso 2018
  Set Location    21.045091     -86.8725486
  Sleep    0.5s
Paso 2019
  Set Location    21.0463836     -86.8746747
  Sleep    0.5s
Paso 2020
  Set Location    21.0463836     -86.8746747
  Sleep    0.5s
Paso 2021
  Set Location    21.0457789     -86.876484
  Sleep    0.5s
Paso 2022
  Set Location    21.0457789     -86.876484
  Sleep    0.5s
Paso 2023
  Set Location    21.0462913     -86.8779501
  Sleep    0.5s
Paso 2024
  Set Location    21.0462913     -86.8779501
  Sleep    0.5s
Paso 2025
  Set Location    21.0468469     -86.8788304
  Sleep    0.5s
Paso 2026
  Set Location    21.0468469     -86.8788304
  Sleep    0.5s
Paso 2027
  Set Location    21.0469357     -86.8789854
  Sleep    0.5s
Paso 2028
  Set Location    21.0469357     -86.8789854
  Sleep    0.5s
Paso 2029
  Set Location    21.0471391     -86.8794391
  Sleep    0.5s
Paso 2030
  Set Location    21.0471391     -86.8794391
  Sleep    0.5s
Paso 2031
  Set Location    21.0464981     -86.8800129
  Sleep    0.5s
Paso 2032
  Set Location    21.0464981     -86.8800129
  Sleep    0.5s
Paso 2033
  Set Location    21.0458105     -86.8805263
  Sleep    0.5s
Paso 2034
  Set Location    21.0458105     -86.8805263
  Sleep    0.5s
Paso 2035
  Set Location    21.0448893     -86.8809062
  Sleep    0.5s
Paso 2036
  Set Location    21.0448893     -86.8809062
  Sleep    0.5s
Paso 2037
  Set Location    21.0448401     -86.8807806
  Sleep    0.5s
Paso 2038
  Set Location    21.0448401     -86.8807806
  Sleep    0.5s
Paso 2039
  Set Location    21.0452167     -86.8803717
  Sleep    0.5s
Paso 2040
  Set Location    21.0452167     -86.8803717
  Sleep    0.5s
Paso 2041
  Set Location    21.0455281     -86.8801608
  Sleep    0.5s
Paso 2042
  Set Location    21.0455281     -86.8801608
  Sleep    0.5s
Paso 2043
  Set Location    21.0450559     -86.8789373
  Sleep    0.5s
Paso 2044
  Set Location    21.0450559     -86.8789373
  Sleep    0.5s
Paso 2045
  Set Location    21.0443888     -86.8774856
  Sleep    0.5s
Paso 2046
  Set Location    21.0443888     -86.8774856
  Sleep    0.5s
Paso 2047
  Set Location    21.0463183     -86.8757266
  Sleep    0.5s
Paso 2048
  Set Location    21.0463183     -86.8757266
  Sleep    0.5s
Paso 2049
  Set Location    21.045857     -86.873929
  Sleep    0.5s
Paso 2050
  Set Location    21.045857     -86.873929
  Sleep    0.5s
Paso 2051
  Set Location    21.0454332     -86.8732814
  Sleep    0.5s
Paso 2052
  Set Location    21.0454332     -86.8732814
  Sleep    0.5s
Paso 2053
  Set Location    21.0448991     -86.87244
  Sleep    0.5s
Paso 2054
  Set Location    21.0448991     -86.87244
  Sleep    0.5s
Paso 2055
  Set Location    21.0424     -86.8733551
  Sleep    0.5s
Paso 2056
  Set Location    21.0424     -86.8733551
  Sleep    0.5s
Paso 2057
  Set Location    21.0412122     -86.874183
  Sleep    0.5s
Paso 2058
  Set Location    21.0412122     -86.874183
  Sleep    0.5s
Paso 2059
  Set Location    21.0408622     -86.8738131
  Sleep    0.5s
Paso 2060
  Set Location    21.0408622     -86.8738131
  Sleep    0.5s
Paso 2061
  Set Location    21.0405626     -86.8733132
  Sleep    0.5s
Paso 2062
  Set Location    21.0405626     -86.8733132
  Sleep    0.5s
Paso 2063
  Set Location    21.0402104     -86.8727725
  Sleep    0.5s
Paso 2064
  Set Location    21.0402104     -86.8727725
  Sleep    0.5s
Paso 2065
  Set Location    21.0397154     -86.8723457
  Sleep    0.5s
Paso 2066
  Set Location    21.0397154     -86.8723457
  Sleep    0.5s
Paso 2067
  Set Location    21.03971     -86.872355
  Sleep    0.5s
Paso 2068
  Set Location    21.03971     -86.872355
  Sleep    0.5s
Paso 2069
  Set Location    21.0393373     -86.8726723
  Sleep    0.5s
Paso 2070
  Set Location    21.0393373     -86.8726723
  Sleep    0.5s
Paso 2071
  Set Location    21.0394575     -86.872484
  Sleep    0.5s
Paso 2072
  Set Location    21.0394575     -86.872484
  Sleep    0.5s
Paso 2073
  Set Location    21.0397399     -86.8722735
  Sleep    0.5s
Paso 2074
  Set Location    21.0397399     -86.8722735
  Sleep    0.5s
Paso 2075
  Set Location    21.0397417     -86.8722733
  Sleep    0.5s
Paso 2076
  Set Location    21.0397417     -86.8722733
  Sleep    0.5s
Paso 2077
  Set Location    21.0398083     -86.87223
  Sleep    0.5s
Paso 2078
  Set Location    21.0398083     -86.87223
  Sleep    0.5s
Paso 2079
  Set Location    21.0398883     -86.8722067
  Sleep    0.5s
Paso 2080
  Set Location    21.0398883     -86.8722067
  Sleep    0.5s
Paso 2081
  Set Location    21.039964     -86.8720968
  Sleep    0.5s
Paso 2082
  Set Location    21.039964     -86.8720968
  Sleep    0.5s
Paso 2083
  Set Location    21.03999     -86.8720783
  Sleep    0.5s
Paso 2084
  Set Location    21.03999     -86.8720783
  Sleep    0.5s
Paso 2085
  Set Location    21.0404483     -86.8716151
  Sleep    0.5s
Paso 2086
  Set Location    21.0404483     -86.8716151
  Sleep    0.5s
Paso 2087
  Set Location    21.0397163     -86.8701801
  Sleep    0.5s
Paso 2088
  Set Location    21.0397163     -86.8701801
  Sleep    0.5s
Paso 2089
  Set Location    21.0405414     -86.869037
  Sleep    0.5s
Paso 2090
  Set Location    21.0405414     -86.869037
  Sleep    0.5s
Paso 2091
  Set Location    21.0412381     -86.8685475
  Sleep    0.5s
Paso 2092
  Set Location    21.0412381     -86.8685475
  Sleep    0.5s
Paso 2093
  Set Location    21.0417011     -86.8672123
  Sleep    0.5s
Paso 2094
  Set Location    21.0417011     -86.8672123
  Sleep    0.5s
Paso 2095
  Set Location    21.0404465     -86.8652307
  Sleep    0.5s
Paso 2096
  Set Location    21.0404465     -86.8652307
  Sleep    0.5s
Paso 2097
  Set Location    21.0391655     -86.8631764
  Sleep    0.5s
Paso 2098
  Set Location    21.0391655     -86.8631764
  Sleep    0.5s
Paso 2099
  Set Location    21.0378565     -86.8610723
  Sleep    0.5s
Paso 2100
  Set Location    21.0378565     -86.8610723
  Sleep    0.5s
Paso 2101
  Set Location    21.0370714     -86.8598143
  Sleep    0.5s
Paso 2102
  Set Location    21.0370714     -86.8598143
  Sleep    0.5s
Paso 2103
  Set Location    21.0365307     -86.8589643
  Sleep    0.5s
Paso 2104
  Set Location    21.0365307     -86.8589643
  Sleep    0.5s
Paso 2105
  Set Location    21.0354155     -86.8571833
  Sleep    0.5s
Paso 2106
  Set Location    21.0354155     -86.8571833
  Sleep    0.5s
Paso 2107
  Set Location    21.0339648     -86.8548703
  Sleep    0.5s
Paso 2108
  Set Location    21.0339648     -86.8548703
  Sleep    0.5s
Paso 2109
  Set Location    21.0333201     -86.8526093
  Sleep    0.5s
Paso 2110
  Set Location    21.0333201     -86.8526093
  Sleep    0.5s
Paso 2111
  Set Location    21.0331348     -86.8514212
  Sleep    0.5s
Paso 2112
  Set Location    21.0331348     -86.8514212
  Sleep    0.5s
Paso 2113
  Set Location    21.0327067     -86.8509361
  Sleep    0.5s
Paso 2114
  Set Location    21.0327067     -86.8509361
  Sleep    0.5s
Paso 2115
  Set Location    21.0321798     -86.8513691
  Sleep    0.5s
Paso 2116
  Set Location    21.0321798     -86.8513691
  Sleep    0.5s
Paso 2117
  Set Location    21.0325863     -86.8519713
  Sleep    0.5s
Paso 2118
  Set Location    21.0325863     -86.8519713
  Sleep    0.5s
Paso 2119
  Set Location    21.0341656     -86.8517307
  Sleep    0.5s
Paso 2120
  Set Location    21.0341656     -86.8517307
  Sleep    0.5s
Paso 2121
  Set Location    21.0364652     -86.8509631
  Sleep    0.5s
Paso 2122
  Set Location    21.0364652     -86.8509631
  Sleep    0.5s
Paso 2123
  Set Location    21.0390667     -86.8502872
  Sleep    0.5s
Paso 2124
  Set Location    21.0390667     -86.8502872
  Sleep    0.5s
Paso 2125
  Set Location    21.0416726     -86.8498651
  Sleep    0.5s
Paso 2126
  Set Location    21.0416726     -86.8498651
  Sleep    0.5s
Paso 2127
  Set Location    21.0450763     -86.8492787
  Sleep    0.5s
Paso 2128
  Set Location    21.0450763     -86.8492787
  Sleep    0.5s
Paso 2129
  Set Location    21.0478117     -86.8488484
  Sleep    0.5s
Paso 2130
  Set Location    21.0478117     -86.8488484
  Sleep    0.5s
Paso 2131
  Set Location    21.0504665     -86.8484632
  Sleep    0.5s
Paso 2132
  Set Location    21.0504665     -86.8484632
  Sleep    0.5s
Paso 2133
  Set Location    21.0531511     -86.8480416
  Sleep    0.5s
Paso 2134
  Set Location    21.0531511     -86.8480416
  Sleep    0.5s
Paso 2135
  Set Location    21.0553889     -86.847687
  Sleep    0.5s
Paso 2136
  Set Location    21.0553889     -86.847687
  Sleep    0.5s
Paso 2137
  Set Location    21.0599669     -86.8469453
  Sleep    0.5s
Paso 2138
  Set Location    21.0599669     -86.8469453
  Sleep    0.5s
Paso 2139
  Set Location    21.0629045     -86.8465425
  Sleep    0.5s
Paso 2140
  Set Location    21.0629045     -86.8465425
  Sleep    0.5s
Paso 2141
  Set Location    21.0658811     -86.8460955
  Sleep    0.5s
Paso 2142
  Set Location    21.0658811     -86.8460955
  Sleep    0.5s
Paso 2143
  Set Location    21.0689486     -86.8455836
  Sleep    0.5s
Paso 2144
  Set Location    21.0689486     -86.8455836
  Sleep    0.5s
Paso 2145
  Set Location    21.070148     -86.8453756
  Sleep    0.5s
Paso 2146
  Set Location    21.070148     -86.8453756
  Sleep    0.5s
Paso 2147
  Set Location    21.0737468     -86.8448235
  Sleep    0.5s
Paso 2148
  Set Location    21.0737468     -86.8448235
  Sleep    0.5s
Paso 2149
  Set Location    21.0766146     -86.8443635
  Sleep    0.5s
Paso 2150
  Set Location    21.0766146     -86.8443635
  Sleep    0.5s
Paso 2151
  Set Location    21.0793875     -86.8439316
  Sleep    0.5s
Paso 2152
  Set Location    21.0793875     -86.8439316
  Sleep    0.5s
Paso 2153
  Set Location    21.0820617     -86.8435115
  Sleep    0.5s
Paso 2154
  Set Location    21.0820617     -86.8435115
  Sleep    0.5s
Paso 2155
  Set Location    21.0861417     -86.8428027
  Sleep    0.5s
Paso 2156
  Set Location    21.0861417     -86.8428027
  Sleep    0.5s
Paso 2157
  Set Location    21.0876425     -86.8425603
  Sleep    0.5s
Paso 2158
  Set Location    21.0876425     -86.8425603
  Sleep    0.5s
Paso 2159
  Set Location    21.0883205     -86.842533
  Sleep    0.5s
Paso 2160
  Set Location    21.0883205     -86.842533
  Sleep    0.5s
Paso 2161
  Set Location    21.0893696     -86.8423335
  Sleep    0.5s
Paso 2162
  Set Location    21.0893696     -86.8423335
  Sleep    0.5s
Paso 2163
  Set Location    21.0902243     -86.842142
  Sleep    0.5s
Paso 2164
  Set Location    21.0902243     -86.842142
  Sleep    0.5s
Paso 2165
  Set Location    21.0909319     -86.8420368
  Sleep    0.5s
Paso 2166
  Set Location    21.0909319     -86.8420368
  Sleep    0.5s
Paso 2167
  Set Location    21.0914632     -86.841972
  Sleep    0.5s
Paso 2168
  Set Location    21.0914632     -86.841972
  Sleep    0.5s
Paso 2169
  Set Location    21.0923492     -86.84185
  Sleep    0.5s
Paso 2170
  Set Location    21.0923492     -86.84185
  Sleep    0.5s
Paso 2171
  Set Location    21.0932351     -86.8417335
  Sleep    0.5s
Paso 2172
  Set Location    21.0932351     -86.8417335
  Sleep    0.5s
Paso 2173
  Set Location    21.0940388     -86.8415905
  Sleep    0.5s
Paso 2174
  Set Location    21.0940388     -86.8415905
  Sleep    0.5s
Paso 2175
  Set Location    21.0950205     -86.8414483
  Sleep    0.5s
Paso 2176
  Set Location    21.0950205     -86.8414483
  Sleep    0.5s
Paso 2177
  Set Location    21.0965537     -86.8412002
  Sleep    0.5s
Paso 2178
  Set Location    21.0965537     -86.8412002
  Sleep    0.5s
Paso 2179
  Set Location    21.0978087     -86.8410134
  Sleep    0.5s
Paso 2180
  Set Location    21.0978087     -86.8410134
  Sleep    0.5s
Paso 2181
  Set Location    21.0988318     -86.8408548
  Sleep    0.5s
Paso 2182
  Set Location    21.0988318     -86.8408548
  Sleep    0.5s
Paso 2183
  Set Location    21.0993694     -86.8407701
  Sleep    0.5s
Paso 2184
  Set Location    21.0993694     -86.8407701
  Sleep    0.5s
Paso 2185
  Set Location    21.1008182     -86.8405385
  Sleep    0.5s
Paso 2186
  Set Location    21.1008182     -86.8405385
  Sleep    0.5s
Paso 2187
  Set Location    21.102757     -86.8402357
  Sleep    0.5s
Paso 2188
  Set Location    21.102757     -86.8402357
  Sleep    0.5s
Paso 2189
  Set Location    21.1046459     -86.8399386
  Sleep    0.5s
Paso 2190
  Set Location    21.1046459     -86.8399386
  Sleep    0.5s
Paso 2191
  Set Location    21.1066695     -86.8396298
  Sleep    0.5s
Paso 2192
  Set Location    21.1066695     -86.8396298
  Sleep    0.5s
Paso 2193
  Set Location    21.1082496     -86.8393903
  Sleep    0.5s
Paso 2194
  Set Location    21.1082496     -86.8393903
  Sleep    0.5s
Paso 2195
  Set Location    21.111597     -86.8389034
  Sleep    0.5s
Paso 2196
  Set Location    21.111597     -86.8389034
  Sleep    0.5s
Paso 2197
  Set Location    21.1139433     -86.8380004
  Sleep    0.5s
Paso 2198
  Set Location    21.1139433     -86.8380004
  Sleep    0.5s
Paso 2199
  Set Location    21.115609     -86.8371896
  Sleep    0.5s
Paso 2200
  Set Location    21.115609     -86.8371896
  Sleep    0.5s
Paso 2201
  Set Location    21.1162533     -86.836875
  Sleep    0.5s
Paso 2202
  Set Location    21.1162533     -86.836875
  Sleep    0.5s
Paso 2203
  Set Location    21.116578     -86.8367131
  Sleep    0.5s
Paso 2204
  Set Location    21.116578     -86.8367131
  Sleep    0.5s
Paso 2205
  Set Location    21.1170643     -86.8364802
  Sleep    0.5s
Paso 2206
  Set Location    21.1170643     -86.8364802
  Sleep    0.5s
Paso 2207
  Set Location    21.1181101     -86.8359579
  Sleep    0.5s
Paso 2208
  Set Location    21.1181101     -86.8359579
  Sleep    0.5s
Paso 2209
  Set Location    21.1189823     -86.8355302
  Sleep    0.5s
Paso 2210
  Set Location    21.1189823     -86.8355302
  Sleep    0.5s
Paso 2211
  Set Location    21.1192559     -86.8354068
  Sleep    0.5s
Paso 2212
  Set Location    21.1192559     -86.8354068
  Sleep    0.5s
Paso 2213
  Set Location    21.1204089     -86.8348311
  Sleep    0.5s
Paso 2214
  Set Location    21.1204089     -86.8348311
  Sleep    0.5s
Paso 2215
  Set Location    21.1223057     -86.8339047
  Sleep    0.5s
Paso 2216
  Set Location    21.1223057     -86.8339047
  Sleep    0.5s
Paso 2217
  Set Location    21.1246382     -86.8327702
  Sleep    0.5s
Paso 2218
  Set Location    21.1246382     -86.8327702
  Sleep    0.5s
Paso 2219
  Set Location    21.1269231     -86.8316554
  Sleep    0.5s
Paso 2220
  Set Location    21.1269231     -86.8316554
  Sleep    0.5s
Paso 2221
  Set Location    21.1291175     -86.8306036
  Sleep    0.5s
Paso 2222
  Set Location    21.1291175     -86.8306036
  Sleep    0.5s
Paso 2223
  Set Location    21.1300521     -86.8302147
  Sleep    0.5s
Paso 2224
  Set Location    21.1300521     -86.8302147
  Sleep    0.5s
Paso 2225
  Set Location    21.1300467     -86.83022
  Sleep    0.5s
Paso 2226
  Set Location    21.1300467     -86.83022
  Sleep    0.5s
Paso 2227
  Set Location    21.1304637     -86.8299999
  Sleep    0.5s
Paso 2228
  Set Location    21.1304637     -86.8299999
  Sleep    0.5s
Paso 2229
  Set Location    21.1314487     -86.8295016
  Sleep    0.5s
Paso 2230
  Set Location    21.1314487     -86.8295016
  Sleep    0.5s
Paso 2231
  Set Location    21.1321858     -86.829093
  Sleep    0.5s
Paso 2232
  Set Location    21.1321858     -86.829093
  Sleep    0.5s
Paso 2233
  Set Location    21.1322267     -86.8290667
  Sleep    0.5s
Paso 2234
  Set Location    21.1322267     -86.8290667
  Sleep    0.5s
Paso 2235
  Set Location    21.1325666     -86.8288837
  Sleep    0.5s
Paso 2236
  Set Location    21.1325666     -86.8288837
  Sleep    0.5s
Paso 2237
  Set Location    21.133782     -86.828288
  Sleep    0.5s
Paso 2238
  Set Location    21.133782     -86.828288
  Sleep    0.5s
Paso 2239
  Set Location    21.1341583     -86.828105
  Sleep    0.5s
Paso 2240
  Set Location    21.1341583     -86.828105
  Sleep    0.5s
Paso 2241
  Set Location    21.1348435     -86.8277783
  Sleep    0.5s
Paso 2242
  Set Location    21.1348435     -86.8277783
  Sleep    0.5s
Paso 2243
  Set Location    21.1354852     -86.8274598
  Sleep    0.5s
Paso 2244
  Set Location    21.1354852     -86.8274598
  Sleep    0.5s
Paso 2245
  Set Location    21.135922     -86.8272351
  Sleep    0.5s
Paso 2246
  Set Location    21.135922     -86.8272351
  Sleep    0.5s
Paso 2247
  Set Location    21.1360967     -86.8271433
  Sleep    0.5s
Paso 2248
  Set Location    21.1360967     -86.8271433
  Sleep    0.5s
Paso 2249
  Set Location    21.1366876     -86.8268802
  Sleep    0.5s
Paso 2250
  Set Location    21.1366876     -86.8268802
  Sleep    0.5s
Paso 2251
  Set Location    21.137915     -86.8262721
  Sleep    0.5s
Paso 2252
  Set Location    21.137915     -86.8262721
  Sleep    0.5s
Paso 2253
  Set Location    21.1385251     -86.82597
  Sleep    0.5s
Paso 2254
  Set Location    21.1385251     -86.82597
  Sleep    0.5s
Paso 2255
  Set Location    21.138525     -86.82597
  Sleep    0.5s
Paso 2256
  Set Location    21.138525     -86.82597
  Sleep    0.5s
Paso 2257
  Set Location    21.1388096     -86.8257837
  Sleep    0.5s
Paso 2258
  Set Location    21.1388096     -86.8257837
  Sleep    0.5s
Paso 2259
  Set Location    21.1401042     -86.8252062
  Sleep    0.5s
Paso 2260
  Set Location    21.1401042     -86.8252062
  Sleep    0.5s
Paso 2261
  Set Location    21.1420834     -86.8243711
  Sleep    0.5s
Paso 2262
  Set Location    21.1420834     -86.8243711
  Sleep    0.5s
Paso 2263
  Set Location    21.1432819     -86.8242786
  Sleep    0.5s
Paso 2264
  Set Location    21.1432819     -86.8242786
  Sleep    0.5s
Paso 2265
  Set Location    21.1437126     -86.8242938
  Sleep    0.5s
Paso 2266
  Set Location    21.1437126     -86.8242938
  Sleep    0.5s
Paso 2267
  Set Location    21.1452484     -86.8243935
  Sleep    0.5s
Paso 2268
  Set Location    21.1452484     -86.8243935
  Sleep    0.5s
Paso 2269
  Set Location    21.1465555     -86.8244828
  Sleep    0.5s
Paso 2270
  Set Location    21.1465555     -86.8244828
  Sleep    0.5s
Paso 2271
  Set Location    21.146565     -86.824485
  Sleep    0.5s
Paso 2272
  Set Location    21.146565     -86.824485
  Sleep    0.5s
Paso 2273
  Set Location    21.1465981     -86.8244899
  Sleep    0.5s
Paso 2274
  Set Location    21.1465981     -86.8244899
  Sleep    0.5s
Paso 2275
  Set Location    21.1477496     -86.8246052
  Sleep    0.5s
Paso 2276
  Set Location    21.1477496     -86.8246052
  Sleep    0.5s
Paso 2277
  Set Location    21.1492066     -86.8246536
  Sleep    0.5s
Paso 2278
  Set Location    21.1492066     -86.8246536
  Sleep    0.5s
Paso 2279
  Set Location    21.1491983     -86.8246583
  Sleep    0.5s
Paso 2280
  Set Location    21.1491983     -86.8246583
  Sleep    0.5s
Paso 2281
  Set Location    21.1497864     -86.8246909
  Sleep    0.5s
Paso 2282
  Set Location    21.1497864     -86.8246909
  Sleep    0.5s
Paso 2283
  Set Location    21.1514127     -86.8248887
  Sleep    0.5s
Paso 2284
  Set Location    21.1514127     -86.8248887
  Sleep    0.5s
Paso 2285
  Set Location    21.1533266     -86.8250235
  Sleep    0.5s
Paso 2286
  Set Location    21.1533266     -86.8250235
  Sleep    0.5s
Paso 2287
  Set Location    21.1550517     -86.825182
  Sleep    0.5s
Paso 2288
  Set Location    21.1550517     -86.825182
  Sleep    0.5s
Paso 2289
  Set Location    21.1559172     -86.8252495
  Sleep    0.5s
Paso 2290
  Set Location    21.1559172     -86.8252495
  Sleep    0.5s
Paso 2291
  Set Location    21.1567399     -86.8251362
  Sleep    0.5s
Paso 2292
  Set Location    21.1567399     -86.8251362
  Sleep    0.5s
Paso 2293
  Set Location    21.157286     -86.8252626
  Sleep    0.5s
Paso 2294
  Set Location    21.157286     -86.8252626
  Sleep    0.5s
Paso 2295
  Set Location    21.1578845     -86.8254056
  Sleep    0.5s
Paso 2296
  Set Location    21.1578845     -86.8254056
  Sleep    0.5s
Paso 2297
  Set Location    21.157895     -86.82541
  Sleep    0.5s
Paso 2298
  Set Location    21.157895     -86.82541
  Sleep    0.5s
Paso 2299
  Set Location    21.1581667     -86.8254383
  Sleep    0.5s
Paso 2300
  Set Location    21.1581667     -86.8254383
  Sleep    0.5s
Paso 2301
  Set Location    21.1582667     -86.8254467
  Sleep    0.5s
Paso 2302
  Set Location    21.1582667     -86.8254467
  Sleep    0.5s
Paso 2303
  Set Location    21.1583414     -86.8254425
  Sleep    0.5s
Paso 2304
  Set Location    21.1583414     -86.8254425
  Sleep    0.5s
Paso 2305
  Set Location    21.1592925     -86.8255202
  Sleep    0.5s
Paso 2306
  Set Location    21.1592925     -86.8255202
  Sleep    0.5s
Paso 2307
  Set Location    21.1598401     -86.8255717
  Sleep    0.5s
Paso 2308
  Set Location    21.1598401     -86.8255717
  Sleep    0.5s
Paso 2309
  Set Location    21.1603894     -86.8256089
  Sleep    0.5s
Paso 2310
  Set Location    21.1603894     -86.8256089
  Sleep    0.5s
Paso 2311
  Set Location    21.1613834     -86.825675
  Sleep    0.5s
Paso 2312
  Set Location    21.1613834     -86.825675
  Sleep    0.5s
Paso 2313
  Set Location    21.1625236     -86.8257338
  Sleep    0.5s
Paso 2314
  Set Location    21.1625236     -86.8257338
  Sleep    0.5s
Paso 2315
  Set Location    21.1630039     -86.8256955
  Sleep    0.5s
Paso 2316
  Set Location    21.1630039     -86.8256955
  Sleep    0.5s
Paso 2317
  Set Location    21.1637848     -86.8254137
  Sleep    0.5s
Paso 2318
  Set Location    21.1637848     -86.8254137
  Sleep    0.5s
Paso 2319
  Set Location    21.1641396     -86.8260029
  Sleep    0.5s
Paso 2320
  Set Location    21.1641396     -86.8260029
  Sleep    0.5s
Paso 2321
  Set Location    21.1638673     -86.8264129
  Sleep    0.5s
Paso 2322
  Set Location    21.1638673     -86.8264129
  Sleep    0.5s
Paso 2323
  Set Location    21.1641638     -86.8263665
  Sleep    0.5s
Paso 2324
  Set Location    21.1641638     -86.8263665
  Sleep    0.5s
Paso 2325
  Set Location    21.1643883     -86.826305
  Sleep    0.5s
Paso 2326
  Set Location    21.1643883     -86.826305
  Sleep    0.5s
Paso 2327
  Set Location    21.1642833     -86.8262967
  Sleep    0.5s
Paso 2328
  Set Location    21.1642833     -86.8262967
  Sleep    0.5s
Paso 2329
  Set Location    21.1641613     -86.8263214
  Sleep    0.5s
Paso 2330
  Set Location    21.1641613     -86.8263214
  Sleep    0.5s
Paso 2331
  Set Location    21.1641533     -86.8263017
  Sleep    0.5s
Paso 2332
  Set Location    21.1641533     -86.8263017
  Sleep    0.5s
Paso 2333
  Set Location    21.1642068     -86.8263395
  Sleep    0.5s
Paso 2334
  Set Location    21.1642068     -86.8263395
  Sleep    0.5s
Paso 2335
  Set Location    21.164395     -86.82625
  Sleep    0.5s
Paso 2336
  Set Location    21.164395     -86.82625
  Sleep    0.5s
Paso 2337
  Set Location    21.1644683     -86.826335
  Sleep    0.5s
Paso 2338
  Set Location    21.1644683     -86.826335
  Sleep    0.5s
Paso 2339
  Set Location    21.1643744     -86.8261641
  Sleep    0.5s
Paso 2340
  Set Location    21.1643744     -86.8261641
  Sleep    0.5s
Paso 2341
  Set Location    21.16435     -86.8261809
  Sleep    0.5s
Paso 2342
  Set Location    21.16435     -86.8261809
  Sleep    0.5s
Paso 2343
  Set Location    21.1591691     -86.8255816
  Sleep    0.5s
Paso 2344
  Set Location    21.1591691     -86.8255816
  Sleep    0.5s
Paso 2345
  Set Location    21.1591691     -86.8255816
  Sleep    0.5s
Paso 2346
  Set Location    21.1591691     -86.8255816
  Sleep    0.5s
Paso 2347
  Set Location    21.1591691     -86.8255816
  Sleep    0.5s
Paso 2348
  Set Location    21.1590237     -86.8255647
  Sleep    0.5s
Paso 2349
  Set Location    21.1590237     -86.8255647
  Sleep    0.5s
Paso 2350
  Set Location    21.1590237     -86.8255647
  Sleep    0.5s
Paso 2351
  Set Location    21.1590237     -86.8255647
  Sleep    0.5s
Paso 2352
  Set Location    21.1590237     -86.8255647
  Sleep    0.5s
Paso 2353
  Set Location    21.1588922     -86.8255634
  Sleep    0.5s
Paso 2354
  Set Location    21.1588922     -86.8255634
  Sleep    0.5s
Paso 2355
  Set Location    21.1588922     -86.8255634
  Sleep    0.5s
Paso 2356
  Set Location    21.1588922     -86.8255634
  Sleep    0.5s
Paso 2357
  Set Location    21.1588922     -86.8255634
  Sleep    0.5s
Paso 2358
  Set Location    21.1586523     -86.8255553
  Sleep    0.5s
Paso 2359
  Set Location    21.1586523     -86.8255553
  Sleep    0.5s
Paso 2360
  Set Location    21.1586523     -86.8255553
  Sleep    0.5s
Paso 2361
  Set Location    21.1586523     -86.8255553
  Sleep    0.5s
Paso 2362
  Set Location    21.1586523     -86.8255553
  Sleep    0.5s
Paso 2363
  Set Location    21.1582048     -86.8255137
  Sleep    0.5s
Paso 2364
  Set Location    21.1582048     -86.8255137
  Sleep    0.5s
Paso 2365
  Set Location    21.1582048     -86.8255137
  Sleep    0.5s
Paso 2366
  Set Location    21.1582048     -86.8255137
  Sleep    0.5s
Paso 2367
  Set Location    21.1582048     -86.8255137
  Sleep    0.5s
Paso 2368
  Set Location    21.158085     -86.82551
  Sleep    0.5s
Paso 2369
  Set Location    21.158085     -86.82551
  Sleep    0.5s
Paso 2370
  Set Location    21.157847     -86.8254962
  Sleep    0.5s
Paso 2371
  Set Location    21.157847     -86.8254962
  Sleep    0.5s
Paso 2372
  Set Location    21.1566234     -86.8255601
  Sleep    0.5s
Paso 2373
  Set Location    21.1566234     -86.8255601
  Sleep    0.5s
Paso 2374
  Set Location    21.154938     -86.8252416
  Sleep    0.5s
Paso 2375
  Set Location    21.154938     -86.8252416
  Sleep    0.5s
Paso 2376
  Set Location    21.1530078     -86.8250986
  Sleep    0.5s
Paso 2377
  Set Location    21.1530078     -86.8250986
  Sleep    0.5s
Paso 2378
  Set Location    21.1509535     -86.8249277
  Sleep    0.5s
Paso 2379
  Set Location    21.1509535     -86.8249277
  Sleep    0.5s
Paso 2380
  Set Location    21.1490097     -86.8248358
  Sleep    0.5s
Paso 2381
  Set Location    21.1490097     -86.8248358
  Sleep    0.5s
Paso 2382
  Set Location    21.1470495     -86.8246422
  Sleep    0.5s
Paso 2383
  Set Location    21.1470495     -86.8246422
  Sleep    0.5s
Paso 2384
  Set Location    21.1453142     -86.824534
  Sleep    0.5s
Paso 2385
  Set Location    21.1453142     -86.824534
  Sleep    0.5s
Paso 2386
  Set Location    21.1439274     -86.8244768
  Sleep    0.5s
Paso 2387
  Set Location    21.1439274     -86.8244768
  Sleep    0.5s
Paso 2388
  Set Location    21.14383     -86.824475
  Sleep    0.5s
Paso 2389
  Set Location    21.14383     -86.824475
  Sleep    0.5s
Paso 2390
  Set Location    21.1430356     -86.8243981
  Sleep    0.5s
Paso 2391
  Set Location    21.1430356     -86.8243981
  Sleep    0.5s
Paso 2392
  Set Location    21.1410713     -86.824835
  Sleep    0.5s
Paso 2393
  Set Location    21.1410713     -86.824835
  Sleep    0.5s
Paso 2394
  Set Location    21.1399112     -86.8254559
  Sleep    0.5s
Paso 2395
  Set Location    21.1399112     -86.8254559
  Sleep    0.5s
Paso 2396
  Set Location    21.1398667     -86.8254867
  Sleep    0.5s
Paso 2397
  Set Location    21.1398667     -86.8254867
  Sleep    0.5s
Paso 2398
  Set Location    21.139797     -86.8255613
  Sleep    0.5s
Paso 2399
  Set Location    21.139797     -86.8255613
  Sleep    0.5s
Paso 2400
  Set Location    21.1386735     -86.826021
  Sleep    0.5s
Paso 2401
  Set Location    21.1386735     -86.826021
  Sleep    0.5s
Paso 2402
  Set Location    21.1367147     -86.8269608
  Sleep    0.5s
Paso 2403
  Set Location    21.1367147     -86.8269608
  Sleep    0.5s
Paso 2404
  Set Location    21.1343388     -86.8281177
  Sleep    0.5s
Paso 2405
  Set Location    21.1343388     -86.8281177
  Sleep    0.5s
Paso 2406
  Set Location    21.1319104     -86.8292897
  Sleep    0.5s
Paso 2407
  Set Location    21.1319104     -86.8292897
  Sleep    0.5s
Paso 2408
  Set Location    21.129519     -86.8304648
  Sleep    0.5s
Paso 2409
  Set Location    21.129519     -86.8304648
  Sleep    0.5s
Paso 2410
  Set Location    21.1272314     -86.831603
  Sleep    0.5s
Paso 2411
  Set Location    21.1272314     -86.831603
  Sleep    0.5s
Paso 2412
  Set Location    21.124686     -86.8328678
  Sleep    0.5s
Paso 2413
  Set Location    21.124686     -86.8328678
  Sleep    0.5s
Paso 2414
  Set Location    21.1219238     -86.8342579
  Sleep    0.5s
Paso 2415
  Set Location    21.1219238     -86.8342579
  Sleep    0.5s
Paso 2416
  Set Location    21.1194224     -86.8354635
  Sleep    0.5s
Paso 2417
  Set Location    21.1194224     -86.8354635
  Sleep    0.5s
Paso 2418
  Set Location    21.1168784     -86.8366917
  Sleep    0.5s
Paso 2419
  Set Location    21.1168784     -86.8366917
  Sleep    0.5s
Paso 2420
  Set Location    21.114233     -86.8379511
  Sleep    0.5s
Paso 2421
  Set Location    21.114233     -86.8379511
  Sleep    0.5s
Paso 2422
  Set Location    21.1114122     -86.839028
  Sleep    0.5s
Paso 2423
  Set Location    21.1114122     -86.839028
  Sleep    0.5s
Paso 2424
  Set Location    21.1084899     -86.8394942
  Sleep    0.5s
Paso 2425
  Set Location    21.1084899     -86.8394942
  Sleep    0.5s
Paso 2426
  Set Location    21.10551     -86.8400035
  Sleep    0.5s
Paso 2427
  Set Location    21.10551     -86.8400035
  Sleep    0.5s
Paso 2428
  Set Location    21.1025405     -86.8404781
  Sleep    0.5s
Paso 2429
  Set Location    21.1025405     -86.8404781
  Sleep    0.5s
Paso 2430
  Set Location    21.099652     -86.8409213
  Sleep    0.5s
Paso 2431
  Set Location    21.099652     -86.8409213
  Sleep    0.5s
Paso 2432
  Set Location    21.0967847     -86.8413294
  Sleep    0.5s
Paso 2433
  Set Location    21.0967847     -86.8413294
  Sleep    0.5s
Paso 2434
  Set Location    21.0938679     -86.8417949
  Sleep    0.5s
Paso 2435
  Set Location    21.0938679     -86.8417949
  Sleep    0.5s
Paso 2436
  Set Location    21.0909319     -86.8421991
  Sleep    0.5s
Paso 2437
  Set Location    21.0909319     -86.8421991
  Sleep    0.5s
Paso 2438
  Set Location    21.087949     -86.8426413
  Sleep    0.5s
Paso 2439
  Set Location    21.087949     -86.8426413
  Sleep    0.5s
Paso 2440
  Set Location    21.085639     -86.8430023
  Sleep    0.5s
Paso 2441
  Set Location    21.085639     -86.8430023
  Sleep    0.5s
Paso 2442
  Set Location    21.0827124     -86.8435513
  Sleep    0.5s
Paso 2443
  Set Location    21.0827124     -86.8435513
  Sleep    0.5s
Paso 2444
  Set Location    21.0797417     -86.8440081
  Sleep    0.5s
Paso 2445
  Set Location    21.0797417     -86.8440081
  Sleep    0.5s
Paso 2446
  Set Location    21.0767145     -86.8444867
  Sleep    0.5s
Paso 2447
  Set Location    21.0767145     -86.8444867
  Sleep    0.5s
Paso 2448
  Set Location    21.0736835     -86.8449579
  Sleep    0.5s
Paso 2449
  Set Location    21.0736835     -86.8449579
  Sleep    0.5s
Paso 2450
  Set Location    21.0706588     -86.8454445
  Sleep    0.5s
Paso 2451
  Set Location    21.0706588     -86.8454445
  Sleep    0.5s
Paso 2452
  Set Location    21.0676149     -86.845912
  Sleep    0.5s
Paso 2453
  Set Location    21.0676149     -86.845912
  Sleep    0.5s
Paso 2454
  Set Location    21.0646814     -86.8463399
  Sleep    0.5s
Paso 2455
  Set Location    21.0646814     -86.8463399
  Sleep    0.5s
Paso 2456
  Set Location    21.0616514     -86.8467932
  Sleep    0.5s
Paso 2457
  Set Location    21.0616514     -86.8467932
  Sleep    0.5s
Paso 2458
  Set Location    21.0586461     -86.8472883
  Sleep    0.5s
Paso 2459
  Set Location    21.0586461     -86.8472883
  Sleep    0.5s
Paso 2460
  Set Location    21.055609     -86.8477593
  Sleep    0.5s
Paso 2461
  Set Location    21.055609     -86.8477593
  Sleep    0.5s
Paso 2462
  Set Location    21.0525114     -86.8482468
  Sleep    0.5s
Paso 2463
  Set Location    21.0525114     -86.8482468
  Sleep    0.5s
Paso 2464
  Set Location    21.049483     -86.8487179
  Sleep    0.5s
Paso 2465
  Set Location    21.049483     -86.8487179
  Sleep    0.5s
Paso 2466
  Set Location    21.0465411     -86.8491733
  Sleep    0.5s
Paso 2467
  Set Location    21.0465411     -86.8491733
  Sleep    0.5s
Paso 2468
  Set Location    21.0436315     -86.8496115
  Sleep    0.5s
Paso 2469
  Set Location    21.0436315     -86.8496115
  Sleep    0.5s
Paso 2470
  Set Location    21.0407943     -86.8500557
  Sleep    0.5s
Paso 2471
  Set Location    21.0407943     -86.8500557
  Sleep    0.5s
Paso 2472
  Set Location    21.0378968     -86.8506256
  Sleep    0.5s
Paso 2473
  Set Location    21.0378968     -86.8506256
  Sleep    0.5s
Paso 2474
  Set Location    21.035287     -86.8517585
  Sleep    0.5s
Paso 2475
  Set Location    21.035287     -86.8517585
  Sleep    0.5s
Paso 2476
  Set Location    21.0342279     -86.8540726
  Sleep    0.5s
Paso 2477
  Set Location    21.0342279     -86.8540726
  Sleep    0.5s
Paso 2478
  Set Location    21.0348905     -86.8561585
  Sleep    0.5s
Paso 2479
  Set Location    21.0348905     -86.8561585
  Sleep    0.5s
Paso 2480
  Set Location    21.0363496     -86.8584756
  Sleep    0.5s
Paso 2481
  Set Location    21.0363496     -86.8584756
  Sleep    0.5s
Paso 2482
  Set Location    21.0379595     -86.8610808
  Sleep    0.5s
Paso 2483
  Set Location    21.0379595     -86.8610808
  Sleep    0.5s
Paso 2484
  Set Location    21.0396006     -86.8636611
  Sleep    0.5s
Paso 2485
  Set Location    21.0396006     -86.8636611
  Sleep    0.5s
Paso 2486
  Set Location    21.0412325     -86.8662832
  Sleep    0.5s
Paso 2487
  Set Location    21.0412325     -86.8662832
  Sleep    0.5s
Paso 2488
  Set Location    21.0428949     -86.8689424
  Sleep    0.5s
Paso 2489
  Set Location    21.0428949     -86.8689424
  Sleep    0.5s
Paso 2490
  Set Location    21.0444415     -86.8713953
  Sleep    0.5s
Paso 2491
  Set Location    21.0444415     -86.8713953
  Sleep    0.5s
Paso 2492
  Set Location    21.0460069     -86.8739144
  Sleep    0.5s
Paso 2493
  Set Location    21.0460069     -86.8739144
  Sleep    0.5s
Paso 2494
  Set Location    21.0460629     -86.8762589
  Sleep    0.5s
Paso 2495
  Set Location    21.0460629     -86.8762589
  Sleep    0.5s
Paso 2496
  Set Location    21.0462979     -86.8779055
  Sleep    0.5s
Paso 2497
  Set Location    21.0462979     -86.8779055
  Sleep    0.5s
Paso 2498
  Set Location    21.0469825     -86.8790084
  Sleep    0.5s
Paso 2499
  Set Location    21.0469825     -86.8790084
  Sleep    0.5s
Paso 2500
  Set Location    21.0471133     -86.8795663
  Sleep    0.5s
Paso 2501
  Set Location    21.0471133     -86.8795663
  Sleep    0.5s
Paso 2502
  Set Location    21.04649     -86.8800282
  Sleep    0.5s
Paso 2503
  Set Location    21.04649     -86.8800282
  Sleep    0.5s
Paso 2504
  Set Location    21.0460423     -86.8803454
  Sleep    0.5s
Paso 2505
  Set Location    21.0460423     -86.8803454
  Sleep    0.5s
Paso 2506
  Set Location    21.04557     -86.8801183
  Sleep    0.5s
Paso 2507
  Set Location    21.04557     -86.8801183
  Sleep    0.5s
Paso 2508
  Set Location    21.04557     -86.8801183
  Sleep    0.5s
Paso 2509
  Set Location    21.04557     -86.8801183
  Sleep    0.5s
Paso 2510
  Set Location    21.04557     -86.8801183
  Sleep    0.5s
Paso 2511
  Set Location    21.04557     -86.8801183
  Sleep    0.5s
Paso 2512
  Set Location    21.0452788     -86.8792601
  Sleep    0.5s
Paso 2513
  Set Location    21.0452788     -86.8792601
  Sleep    0.5s
Paso 2514
  Set Location    21.0452788     -86.8792601
  Sleep    0.5s
Paso 2515
  Set Location    21.0452788     -86.8792601
  Sleep    0.5s
Paso 2516
  Set Location    21.0452788     -86.8792601
  Sleep    0.5s
Paso 2517
  Set Location    21.0452788     -86.8792601
  Sleep    0.5s
Paso 2518
  Set Location    21.0443713     -86.8775582
  Sleep    0.5s
Paso 2519
  Set Location    21.0443713     -86.8775582
  Sleep    0.5s
Paso 2520
  Set Location    21.0443713     -86.8775582
  Sleep    0.5s
Paso 2521
  Set Location    21.0443713     -86.8775582
  Sleep    0.5s
Paso 2522
  Set Location    21.0443713     -86.8775582
  Sleep    0.5s
Paso 2523
  Set Location    21.0443713     -86.8775582
  Sleep    0.5s
Paso 2524
  Set Location    21.0458454     -86.8762702
  Sleep    0.5s
Paso 2525
  Set Location    21.0458454     -86.8762702
  Sleep    0.5s
Paso 2526
  Set Location    21.0460645     -86.8742119
  Sleep    0.5s
Paso 2527
  Set Location    21.0460645     -86.8742119
  Sleep    0.5s
Paso 2528
  Set Location    21.0457737     -86.8737594
  Sleep    0.5s
Paso 2529
  Set Location    21.0457737     -86.8737594
  Sleep    0.5s
Paso 2530
  Set Location    21.0422299     -86.8734984
  Sleep    0.5s
Paso 2531
  Set Location    21.0422299     -86.8734984
  Sleep    0.5s
Paso 2532
  Set Location    21.0410047     -86.8740808
  Sleep    0.5s
Paso 2533
  Set Location    21.0410047     -86.8740808
  Sleep    0.5s
Paso 2534
  Set Location    21.0406717     -86.8734349
  Sleep    0.5s
Paso 2535
  Set Location    21.0406717     -86.8734349
  Sleep    0.5s
Paso 2536
  Set Location    21.040337     -86.87289
  Sleep    0.5s
Paso 2537
  Set Location    21.040337     -86.87289
  Sleep    0.5s
Paso 2538
  Set Location    21.0399248     -86.872317
  Sleep    0.5s
Paso 2539
  Set Location    21.0399248     -86.872317
  Sleep    0.5s
Paso 2540
  Set Location    21.0399117     -86.872155
  Sleep    0.5s
Paso 2541
  Set Location    21.0399117     -86.872155
  Sleep    0.5s
Paso 2542
  Set Location    21.0399707     -86.8720915
  Sleep    0.5s
Paso 2543
  Set Location    21.0399707     -86.8720915
  Sleep    0.5s
Paso 2544
  Set Location    21.03997     -86.87209
  Sleep    0.5s
Paso 2545
  Set Location    21.03997     -86.87209
  Sleep    0.5s
Paso 2546
  Set Location    21.0404716     -86.8716394
  Sleep    0.5s
Paso 2547
  Set Location    21.0404716     -86.8716394
  Sleep    0.5s
Paso 2548
  Set Location    21.0399308     -86.8705208
  Sleep    0.5s
Paso 2549
  Set Location    21.0399308     -86.8705208
  Sleep    0.5s
Paso 2550
  Set Location    21.0400783     -86.8693557
  Sleep    0.5s
Paso 2551
  Set Location    21.0400783     -86.8693557
  Sleep    0.5s
Paso 2552
  Set Location    21.041393     -86.8684382
  Sleep    0.5s
Paso 2553
  Set Location    21.041393     -86.8684382
  Sleep    0.5s
Paso 2554
  Set Location    21.0415991     -86.8670091
  Sleep    0.5s
Paso 2555
  Set Location    21.0415991     -86.8670091
  Sleep    0.5s
Paso 2556
  Set Location    21.0404223     -86.865112
  Sleep    0.5s
Paso 2557
  Set Location    21.0404223     -86.865112
  Sleep    0.5s
Paso 2558
  Set Location    21.0390969     -86.863008
  Sleep    0.5s
Paso 2559
  Set Location    21.0390969     -86.863008
  Sleep    0.5s
Paso 2560
  Set Location    21.0378012     -86.8609275
  Sleep    0.5s
Paso 2561
  Set Location    21.0378012     -86.8609275
  Sleep    0.5s
Paso 2562
  Set Location    21.0367612     -86.859272
  Sleep    0.5s
Paso 2563
  Set Location    21.0367612     -86.859272
  Sleep    0.5s
Paso 2564
  Set Location    21.0356222     -86.8574487
  Sleep    0.5s
Paso 2565
  Set Location    21.0356222     -86.8574487
  Sleep    0.5s
Paso 2566
  Set Location    21.0342351     -86.8552328
  Sleep    0.5s
Paso 2567
  Set Location    21.0342351     -86.8552328
  Sleep    0.5s
Paso 2568
  Set Location    21.0333619     -86.852796
  Sleep    0.5s
Paso 2569
  Set Location    21.0333619     -86.852796
  Sleep    0.5s
Paso 2570
  Set Location    21.0328569     -86.8509258
  Sleep    0.5s
Paso 2571
  Set Location    21.0328569     -86.8509258
  Sleep    0.5s
Paso 2572
  Set Location    21.0326283     -86.8519332
  Sleep    0.5s
Paso 2573
  Set Location    21.0326283     -86.8519332
  Sleep    0.5s
Paso 2574
  Set Location    21.0345718     -86.8515685
  Sleep    0.5s
Paso 2575
  Set Location    21.0345718     -86.8515685
  Sleep    0.5s
Paso 2576
  Set Location    21.0369716     -86.8507284
  Sleep    0.5s
Paso 2577
  Set Location    21.0369716     -86.8507284
  Sleep    0.5s
Paso 2578
  Set Location    21.0396031     -86.8501153
  Sleep    0.5s
Paso 2579
  Set Location    21.0396031     -86.8501153
  Sleep    0.5s
Paso 2580
  Set Location    21.0422847     -86.8496884
  Sleep    0.5s
Paso 2581
  Set Location    21.0422847     -86.8496884
  Sleep    0.5s
Paso 2582
  Set Location    21.0449948     -86.8492807
  Sleep    0.5s
Paso 2583
  Set Location    21.0449948     -86.8492807
  Sleep    0.5s
Paso 2584
  Set Location    21.047722     -86.8488298
  Sleep    0.5s
Paso 2585
  Set Location    21.047722     -86.8488298
  Sleep    0.5s
Paso 2586
  Set Location    21.0504997     -86.8484286
  Sleep    0.5s
Paso 2587
  Set Location    21.0504997     -86.8484286
  Sleep    0.5s
Paso 2588
  Set Location    21.0532632     -86.8479884
  Sleep    0.5s
Paso 2589
  Set Location    21.0532632     -86.8479884
  Sleep    0.5s
Paso 2590
  Set Location    21.0560215     -86.8475603
  Sleep    0.5s
Paso 2591
  Set Location    21.0560215     -86.8475603
  Sleep    0.5s
Paso 2592
  Set Location    21.0586599     -86.8471772
  Sleep    0.5s
Paso 2593
  Set Location    21.0586599     -86.8471772
  Sleep    0.5s
Paso 2594
  Set Location    21.0614599     -86.8467434
  Sleep    0.5s
Paso 2595
  Set Location    21.0614599     -86.8467434
  Sleep    0.5s
Paso 2596
  Set Location    21.0642173     -86.8463204
  Sleep    0.5s
Paso 2597
  Set Location    21.0642173     -86.8463204
  Sleep    0.5s
Paso 2598
  Set Location    21.0669184     -86.8458993
  Sleep    0.5s
Paso 2599
  Set Location    21.0669184     -86.8458993
  Sleep    0.5s
Paso 2600
  Set Location    21.0696146     -86.8454775
  Sleep    0.5s
Paso 2601
  Set Location    21.0696146     -86.8454775
  Sleep    0.5s
Paso 2602
  Set Location    21.0722818     -86.8450634
  Sleep    0.5s
Paso 2603
  Set Location    21.0722818     -86.8450634
  Sleep    0.5s
Paso 2604
  Set Location    21.0748965     -86.844657
  Sleep    0.5s
Paso 2605
  Set Location    21.0748965     -86.844657
  Sleep    0.5s
Paso 2606
  Set Location    21.0775214     -86.8442486
  Sleep    0.5s
Paso 2607
  Set Location    21.0775214     -86.8442486
  Sleep    0.5s
Paso 2608
  Set Location    21.0802399     -86.8438233
  Sleep    0.5s
Paso 2609
  Set Location    21.0802399     -86.8438233
  Sleep    0.5s
Paso 2610
  Set Location    21.0829134     -86.8433972
  Sleep    0.5s
Paso 2611
  Set Location    21.0829134     -86.8433972
  Sleep    0.5s
Paso 2612
  Set Location    21.0856414     -86.8429069
  Sleep    0.5s
Paso 2613
  Set Location    21.0856414     -86.8429069
  Sleep    0.5s
Paso 2614
  Set Location    21.0882957     -86.8424934
  Sleep    0.5s
Paso 2615
  Set Location    21.0882957     -86.8424934
  Sleep    0.5s
Paso 2616
  Set Location    21.0907217     -86.84213
  Sleep    0.5s
Paso 2617
  Set Location    21.0907217     -86.84213
  Sleep    0.5s
Paso 2618
  Set Location    21.0930584     -86.8417485
  Sleep    0.5s
Paso 2619
  Set Location    21.0930584     -86.8417485
  Sleep    0.5s
Paso 2620
  Set Location    21.0948657     -86.8414599
  Sleep    0.5s
Paso 2621
  Set Location    21.0948657     -86.8414599
  Sleep    0.5s
Paso 2622
  Set Location    21.0955138     -86.8413655
  Sleep    0.5s
Paso 2623
  Set Location    21.0955138     -86.8413655
  Sleep    0.5s
Paso 2624
  Set Location    21.0969429     -86.8411322
  Sleep    0.5s
Paso 2625
  Set Location    21.0969429     -86.8411322
  Sleep    0.5s
Paso 2626
  Set Location    21.0980745     -86.8409668
  Sleep    0.5s
Paso 2627
  Set Location    21.0980745     -86.8409668
  Sleep    0.5s
Paso 2628
  Set Location    21.0986825     -86.8408637
  Sleep    0.5s
Paso 2629
  Set Location    21.0986825     -86.8408637
  Sleep    0.5s
Paso 2630
  Set Location    21.0998905     -86.840688
  Sleep    0.5s
Paso 2631
  Set Location    21.0998905     -86.840688
  Sleep    0.5s
Paso 2632
  Set Location    21.1012058     -86.8403061
  Sleep    0.5s
Paso 2633
  Set Location    21.1012058     -86.8403061
  Sleep    0.5s
Paso 2634
  Set Location    21.1030254     -86.8401403
  Sleep    0.5s
Paso 2635
  Set Location    21.1030254     -86.8401403
  Sleep    0.5s
Paso 2636
  Set Location    21.1040236     -86.8400246
  Sleep    0.5s
Paso 2637
  Set Location    21.1040236     -86.8400246
  Sleep    0.5s
Paso 2638
  Set Location    21.104035     -86.8400283
  Sleep    0.5s
Paso 2639
  Set Location    21.104035     -86.8400283
  Sleep    0.5s
Paso 2640
  Set Location    21.1043985     -86.8399767
  Sleep    0.5s
Paso 2641
  Set Location    21.1043985     -86.8399767
  Sleep    0.5s
Paso 2642
  Set Location    21.1046596     -86.8399417
  Sleep    0.5s
Paso 2643
  Set Location    21.1046596     -86.8399417
  Sleep    0.5s
Paso 2644
  Set Location    21.1050031     -86.8398985
  Sleep    0.5s
Paso 2645
  Set Location    21.1050031     -86.8398985
  Sleep    0.5s
Paso 2646
  Set Location    21.1051217     -86.8398883
  Sleep    0.5s
Paso 2647
  Set Location    21.1051217     -86.8398883
  Sleep    0.5s
Paso 2648
  Set Location    21.1052747     -86.8398668
  Sleep    0.5s
Paso 2649
  Set Location    21.1052747     -86.8398668
  Sleep    0.5s
Paso 2650
  Set Location    21.1055798     -86.8398067
  Sleep    0.5s
Paso 2651
  Set Location    21.1055798     -86.8398067
  Sleep    0.5s
Paso 2652
  Set Location    21.1060129     -86.8397299
  Sleep    0.5s
Paso 2653
  Set Location    21.1060129     -86.8397299
  Sleep    0.5s
Paso 2654
  Set Location    21.10613     -86.839715
  Sleep    0.5s
Paso 2655
  Set Location    21.10613     -86.839715
  Sleep    0.5s
Paso 2656
  Set Location    21.1062515     -86.8397005
  Sleep    0.5s
Paso 2657
  Set Location    21.1062515     -86.8397005
  Sleep    0.5s
Paso 2658
  Set Location    21.1069154     -86.8395937
  Sleep    0.5s
Paso 2659
  Set Location    21.1069154     -86.8395937
  Sleep    0.5s
Paso 2660
  Set Location    21.1073593     -86.8395303
  Sleep    0.5s
Paso 2661
  Set Location    21.1073593     -86.8395303
  Sleep    0.5s
Paso 2662
  Set Location    21.107512     -86.839507
  Sleep    0.5s
Paso 2663
  Set Location    21.107512     -86.839507
  Sleep    0.5s
Paso 2664
  Set Location    21.1078578     -86.839447
  Sleep    0.5s
Paso 2665
  Set Location    21.1078578     -86.839447
  Sleep    0.5s
Paso 2666
  Set Location    21.1083325     -86.8393749
  Sleep    0.5s
Paso 2667
  Set Location    21.1083325     -86.8393749
  Sleep    0.5s
Paso 2668
  Set Location    21.1089445     -86.8392883
  Sleep    0.5s
Paso 2669
  Set Location    21.1089445     -86.8392883
  Sleep    0.5s
Paso 2670
  Set Location    21.1098984     -86.8391437
  Sleep    0.5s
Paso 2671
  Set Location    21.1098984     -86.8391437
  Sleep    0.5s
Paso 2672
  Set Location    21.110622     -86.83902
  Sleep    0.5s
Paso 2673
  Set Location    21.110622     -86.83902
  Sleep    0.5s
Paso 2674
  Set Location    21.1109296     -86.8389846
  Sleep    0.5s
Paso 2675
  Set Location    21.1109296     -86.8389846
  Sleep    0.5s
Paso 2676
  Set Location    21.1114368     -86.8389148
  Sleep    0.5s
Paso 2677
  Set Location    21.1114368     -86.8389148
  Sleep    0.5s
Paso 2678
  Set Location    21.1117029     -86.8388804
  Sleep    0.5s
Paso 2679
  Set Location    21.1117029     -86.8388804
  Sleep    0.5s
Paso 2680
  Set Location    21.112158     -86.8387689
  Sleep    0.5s
Paso 2681
  Set Location    21.112158     -86.8387689
  Sleep    0.5s
Paso 2682
  Set Location    21.1124543     -86.8386766
  Sleep    0.5s
Paso 2683
  Set Location    21.1124543     -86.8386766
  Sleep    0.5s
Paso 2684
  Set Location    21.1132422     -86.8383401
  Sleep    0.5s
Paso 2685
  Set Location    21.1132422     -86.8383401
  Sleep    0.5s
Paso 2686
  Set Location    21.1135542     -86.8381703
  Sleep    0.5s
Paso 2687
  Set Location    21.1135542     -86.8381703
  Sleep    0.5s
Paso 2688
  Set Location    21.1138079     -86.8380402
  Sleep    0.5s
Paso 2689
  Set Location    21.1138079     -86.8380402
  Sleep    0.5s
Paso 2690
  Set Location    21.114304     -86.8377929
  Sleep    0.5s
Paso 2691
  Set Location    21.114304     -86.8377929
  Sleep    0.5s
Paso 2692
  Set Location    21.1146698     -86.8376352
  Sleep    0.5s
Paso 2693
  Set Location    21.1146698     -86.8376352
  Sleep    0.5s
Paso 2694
  Set Location    21.1151563     -86.8374072
  Sleep    0.5s
Paso 2695
  Set Location    21.1151563     -86.8374072
  Sleep    0.5s
Paso 2696
  Set Location    21.1158064     -86.8370914
  Sleep    0.5s
Paso 2697
  Set Location    21.1158064     -86.8370914
  Sleep    0.5s
Paso 2698
  Set Location    21.117578     -86.8362384
  Sleep    0.5s
Paso 2699
  Set Location    21.117578     -86.8362384
  Sleep    0.5s
Paso 2700
  Set Location    21.117578     -86.8362384
  Sleep    0.5s
Paso 2701
  Set Location    21.117578     -86.8362384
  Sleep    0.5s
Paso 2702
  Set Location    21.117578     -86.8362384
  Sleep    0.5s
Paso 2703
  Set Location    21.117578     -86.8362384
  Sleep    0.5s
Paso 2704
  Set Location    21.117578     -86.8362384
  Sleep    0.5s
Paso 2705
  Set Location    21.1180848     -86.8359732
  Sleep    0.5s
Paso 2706
  Set Location    21.1180848     -86.8359732
  Sleep    0.5s
Paso 2707
  Set Location    21.1180848     -86.8359732
  Sleep    0.5s
Paso 2708
  Set Location    21.1180848     -86.8359732
  Sleep    0.5s
Paso 2709
  Set Location    21.1180848     -86.8359732
  Sleep    0.5s
Paso 2710
  Set Location    21.1180848     -86.8359732
  Sleep    0.5s
Paso 2711
  Set Location    21.1180848     -86.8359732
  Sleep    0.5s
Paso 2712
  Set Location    21.11826     -86.83591
  Sleep    0.5s
Paso 2713
  Set Location    21.11826     -86.83591
  Sleep    0.5s
Paso 2714
  Set Location    21.1184194     -86.8358607
  Sleep    0.5s
Paso 2715
  Set Location    21.1184194     -86.8358607
  Sleep    0.5s
Paso 2716
  Set Location    21.1189052     -86.8356184
  Sleep    0.5s
Paso 2717
  Set Location    21.1189052     -86.8356184
  Sleep    0.5s
Paso 2718
  Set Location    21.1190482     -86.8355383
  Sleep    0.5s
Paso 2719
  Set Location    21.1190482     -86.8355383
  Sleep    0.5s
Paso 2720
  Set Location    21.1193728     -86.83537
  Sleep    0.5s
Paso 2721
  Set Location    21.1193728     -86.83537
  Sleep    0.5s
Paso 2722
  Set Location    21.1196568     -86.8352399
  Sleep    0.5s
Paso 2723
  Set Location    21.1196568     -86.8352399
  Sleep    0.5s
Paso 2724
  Set Location    21.1199132     -86.8351305
  Sleep    0.5s
Paso 2725
  Set Location    21.1199132     -86.8351305
  Sleep    0.5s
Paso 2726
  Set Location    21.1200317     -86.8350617
  Sleep    0.5s
Paso 2727
  Set Location    21.1200317     -86.8350617
  Sleep    0.5s
Paso 2728
  Set Location    21.1202788     -86.8349434
  Sleep    0.5s
Paso 2729
  Set Location    21.1202788     -86.8349434
  Sleep    0.5s
Paso 2730
  Set Location    21.1205749     -86.8347854
  Sleep    0.5s
Paso 2731
  Set Location    21.1205749     -86.8347854
  Sleep    0.5s
Paso 2732
  Set Location    21.1214999     -86.8343421
  Sleep    0.5s
Paso 2733
  Set Location    21.1214999     -86.8343421
  Sleep    0.5s
Paso 2734
  Set Location    21.1229618     -86.8336572
  Sleep    0.5s
Paso 2735
  Set Location    21.1229618     -86.8336572
  Sleep    0.5s
Paso 2736
  Set Location    21.1249868     -86.8326639
  Sleep    0.5s
Paso 2737
  Set Location    21.1249868     -86.8326639
  Sleep    0.5s
Paso 2738
  Set Location    21.1270284     -86.8316254
  Sleep    0.5s
Paso 2739
  Set Location    21.1270284     -86.8316254
  Sleep    0.5s
Paso 2740
  Set Location    21.1291369     -86.8306018
  Sleep    0.5s
Paso 2741
  Set Location    21.1291369     -86.8306018
  Sleep    0.5s
Paso 2742
  Set Location    21.1313832     -86.829529
  Sleep    0.5s
Paso 2743
  Set Location    21.1313832     -86.829529
  Sleep    0.5s
Paso 2744
  Set Location    21.1332967     -86.8285619
  Sleep    0.5s
Paso 2745
  Set Location    21.1332967     -86.8285619
  Sleep    0.5s
Paso 2746
  Set Location    21.1352571     -86.8276068
  Sleep    0.5s
Paso 2747
  Set Location    21.1352571     -86.8276068
  Sleep    0.5s
Paso 2748
  Set Location    21.1370087     -86.8267621
  Sleep    0.5s
Paso 2749
  Set Location    21.1370087     -86.8267621
  Sleep    0.5s
Paso 2750
  Set Location    21.1382085     -86.8262031
  Sleep    0.5s
Paso 2751
  Set Location    21.1382085     -86.8262031
  Sleep    0.5s
Paso 2752
  Set Location    21.1389412     -86.8257709
  Sleep    0.5s
Paso 2753
  Set Location    21.1389412     -86.8257709
  Sleep    0.5s
Paso 2754
  Set Location    21.1407381     -86.8249525
  Sleep    0.5s
Paso 2755
  Set Location    21.1407381     -86.8249525
  Sleep    0.5s
Paso 2756
  Set Location    21.1429034     -86.8242728
  Sleep    0.5s
Paso 2757
  Set Location    21.1429034     -86.8242728
  Sleep    0.5s
Paso 2758
  Set Location    21.143255     -86.82428
  Sleep    0.5s
Paso 2759
  Set Location    21.143255     -86.82428
  Sleep    0.5s
Paso 2760
  Set Location    21.1436498     -86.8243031
  Sleep    0.5s
Paso 2761
  Set Location    21.1436498     -86.8243031
  Sleep    0.5s
Paso 2762
  Set Location    21.1450163     -86.8243724
  Sleep    0.5s
Paso 2763
  Set Location    21.1450163     -86.8243724
  Sleep    0.5s
Paso 2764
  Set Location    21.145386     -86.824412
  Sleep    0.5s
Paso 2765
  Set Location    21.145386     -86.824412
  Sleep    0.5s
Paso 2766
  Set Location    21.146534     -86.82453
  Sleep    0.5s
Paso 2767
  Set Location    21.146534     -86.82453
  Sleep    0.5s
Paso 2768
  Set Location    21.1465333     -86.82453
  Sleep    0.5s
Paso 2769
  Set Location    21.1465333     -86.82453
  Sleep    0.5s
Paso 2770
  Set Location    21.1466035     -86.8245037
  Sleep    0.5s
Paso 2771
  Set Location    21.1466035     -86.8245037
  Sleep    0.5s
Paso 2772
  Set Location    21.1476826     -86.8246038
  Sleep    0.5s
Paso 2773
  Set Location    21.1476826     -86.8246038
  Sleep    0.5s
Paso 2774
  Set Location    21.1491925     -86.8246167
  Sleep    0.5s
Paso 2775
  Set Location    21.1491925     -86.8246167
  Sleep    0.5s
Paso 2776
  Set Location    21.14919     -86.824615
  Sleep    0.5s
Paso 2777
  Set Location    21.14919     -86.824615
  Sleep    0.5s
Paso 2778
  Set Location    21.1503127     -86.8247363
  Sleep    0.5s
Paso 2779
  Set Location    21.1503127     -86.8247363
  Sleep    0.5s
Paso 2780
  Set Location    21.1514714     -86.8248803
  Sleep    0.5s
Paso 2781
  Set Location    21.1514714     -86.8248803
  Sleep    0.5s
Paso 2782
  Set Location    21.1541427     -86.8250715
  Sleep    0.5s
Paso 2783
  Set Location    21.1541427     -86.8250715
  Sleep    0.5s
Paso 2784
  Set Location    21.1559419     -86.825207
  Sleep    0.5s
Paso 2785
  Set Location    21.1559419     -86.825207
  Sleep    0.5s
Paso 2786
  Set Location    21.1564628     -86.825154
  Sleep    0.5s
Paso 2787
  Set Location    21.1564628     -86.825154
  Sleep    0.5s
Paso 2788
  Set Location    21.1573291     -86.8252298
  Sleep    0.5s
Paso 2789
  Set Location    21.1573291     -86.8252298
  Sleep    0.5s
Paso 2790
  Set Location    21.1581423     -86.8253779
  Sleep    0.5s
Paso 2791
  Set Location    21.1581423     -86.8253779
  Sleep    0.5s
Paso 2792
  Set Location    21.1590414     -86.8254484
  Sleep    0.5s
Paso 2793
  Set Location    21.1590414     -86.8254484
  Sleep    0.5s
Paso 2794
  Set Location    21.1598805     -86.8255053
  Sleep    0.5s
Paso 2795
  Set Location    21.1598805     -86.8255053
  Sleep    0.5s
Paso 2796
  Set Location    21.1610322     -86.8255783
  Sleep    0.5s
Paso 2797
  Set Location    21.1610322     -86.8255783
  Sleep    0.5s
Paso 2798
  Set Location    21.1615456     -86.8256303
  Sleep    0.5s
Paso 2799
  Set Location    21.1615456     -86.8256303
  Sleep    0.5s
Paso 2800
  Set Location    21.1628991     -86.8256962
  Sleep    0.5s
Paso 2801
  Set Location    21.1628991     -86.8256962
  Sleep    0.5s
Paso 2802
  Set Location    21.1637167     -86.8253861
  Sleep    0.5s
Paso 2803
  Set Location    21.1637167     -86.8253861
  Sleep    0.5s
Paso 2804
  Set Location    21.1641663     -86.8259893
  Sleep    0.5s
Paso 2805
  Set Location    21.1641663     -86.8259893
  Sleep    0.5s
Paso 2806
  Set Location    21.1638548     -86.8264694
  Sleep    0.5s
Paso 2807
  Set Location    21.1638548     -86.8264694
  Sleep    0.5s
Paso 2808
  Set Location    21.1638867     -86.8266133
  Sleep    0.5s
Paso 2809
  Set Location    21.1638867     -86.8266133
  Sleep    0.5s
Paso 2810
  Set Location    21.1640296     -86.8266311
  Sleep    0.5s
Paso 2811
  Set Location    21.1640296     -86.8266311
  Sleep    0.5s
Paso 2812
  Set Location    21.16403     -86.8266283
  Sleep    0.5s
Paso 2813
  Set Location    21.16403     -86.8266283
  Sleep    0.5s
Paso 2814
  Set Location    21.1642002     -86.8263316
  Sleep    0.5s
Paso 2815
  Set Location    21.1642002     -86.8263316
  Sleep    0.5s
Paso 2816
  Set Location    21.1642133     -86.8263133
  Sleep    0.5s
Paso 2817
  Set Location    21.1642133     -86.8263133
  Sleep    0.5s
Paso 2818
  Set Location    21.1644167     -86.82623
  Sleep    0.5s
Paso 2819
  Set Location    21.1644167     -86.82623
  Sleep    0.5s
Paso 2820
  Set Location    21.1644883     -86.8263533
  Sleep    0.5s
Paso 2821
  Set Location    21.1644883     -86.8263533
  Sleep    0.5s
Paso 2822
  Set Location    21.1643431     -86.826218
  Sleep    0.5s
Paso 2823
  Set Location    21.1643431     -86.826218
  Sleep    0.5s
Paso 2824
  Set Location    21.1643117     -86.826165
  Sleep    0.5s
Paso 2825
  Set Location    21.1643117     -86.826165
  Sleep    0.5s
Paso 2826
  Set Location    21.1641854     -86.8261365
  Sleep    0.5s
Paso 2827
  Set Location    21.1641854     -86.8261365
  Sleep    0.5s
Paso 2828
  Set Location    21.1636995     -86.8262338
  Sleep    0.5s
Paso 2829
  Set Location    21.1636995     -86.8262338
  Sleep    0.5s
Paso 2830
  Set Location    21.1625242     -86.8258084
  Sleep    0.5s
Paso 2831
  Set Location    21.1625242     -86.8258084
  Sleep    0.5s
Paso 2832
  Set Location    21.1615854     -86.8257184
  Sleep    0.5s
Paso 2833
  Set Location    21.1615854     -86.8257184
  Sleep    0.5s
Paso 2834
  Set Location    21.1604699     -86.8256279
  Sleep    0.5s
Paso 2835
  Set Location    21.1604699     -86.8256279
  Sleep    0.5s
Paso 2836
  Set Location    21.1597408     -86.8255751
  Sleep    0.5s
Paso 2837
  Set Location    21.1597408     -86.8255751
  Sleep    0.5s
Paso 2838
  Set Location    21.1592377     -86.8255383
  Sleep    0.5s
Paso 2839
  Set Location    21.1592377     -86.8255383
  Sleep    0.5s
Paso 2840
  Set Location    21.158427     -86.8254813
  Sleep    0.5s
Paso 2841
  Set Location    21.158427     -86.8254813
  Sleep    0.5s
Paso 2842
  Set Location    21.1579046     -86.8254399
  Sleep    0.5s
Paso 2843
  Set Location    21.1579046     -86.8254399
  Sleep    0.5s
Paso 2844
  Set Location    21.1578883     -86.8254367
  Sleep    0.5s
Paso 2845
  Set Location    21.1578883     -86.8254367
  Sleep    0.5s
Paso 2846
  Set Location    21.1573826     -86.8254665
  Sleep    0.5s
Paso 2847
  Set Location    21.1573826     -86.8254665
  Sleep    0.5s
Paso 2848
  Set Location    21.1565971     -86.8254425
  Sleep    0.5s
Paso 2849
  Set Location    21.1565971     -86.8254425
  Sleep    0.5s
Paso 2850
  Set Location    21.1554259     -86.8252419
  Sleep    0.5s
Paso 2851
  Set Location    21.1554259     -86.8252419
  Sleep    0.5s
Paso 2852
  Set Location    21.1534169     -86.8250767
  Sleep    0.5s
Paso 2853
  Set Location    21.1534169     -86.8250767
  Sleep    0.5s
Paso 2854
  Set Location    21.1514641     -86.8249258
  Sleep    0.5s
Paso 2855
  Set Location    21.1514641     -86.8249258
  Sleep    0.5s
Paso 2856
  Set Location    21.150429     -86.8249128
  Sleep    0.5s
Paso 2857
  Set Location    21.150429     -86.8249128
  Sleep    0.5s
Paso 2858
  Set Location    21.1487257     -86.8247559
  Sleep    0.5s
Paso 2859
  Set Location    21.1487257     -86.8247559
  Sleep    0.5s
Paso 2860
  Set Location    21.1467445     -86.8246275
  Sleep    0.5s
Paso 2861
  Set Location    21.1467445     -86.8246275
  Sleep    0.5s
Paso 2862
  Set Location    21.144738     -86.8245349
  Sleep    0.5s
Paso 2863
  Set Location    21.144738     -86.8245349
  Sleep    0.5s
Paso 2864
  Set Location    21.1445517     -86.8245367
  Sleep    0.5s
Paso 2865
  Set Location    21.1445517     -86.8245367
  Sleep    0.5s
Paso 2866
  Set Location    21.1444104     -86.8245113
  Sleep    0.5s
Paso 2867
  Set Location    21.1444104     -86.8245113
  Sleep    0.5s
Paso 2868
  Set Location    21.1429956     -86.8243606
  Sleep    0.5s
Paso 2869
  Set Location    21.1429956     -86.8243606
  Sleep    0.5s
Paso 2870
  Set Location    21.140805     -86.8249294
  Sleep    0.5s
Paso 2871
  Set Location    21.140805     -86.8249294
  Sleep    0.5s
Paso 2872
  Set Location    21.1340754     -86.8282362
  Sleep    0.5s
Paso 2873
  Set Location    21.1340754     -86.8282362
  Sleep    0.5s
Paso 2874
  Set Location    21.1319052     -86.829269
  Sleep    0.5s
Paso 2875
  Set Location    21.1319052     -86.829269
  Sleep    0.5s
Paso 2876
  Set Location    21.1297017     -86.8303439
  Sleep    0.5s
Paso 2877
  Set Location    21.1297017     -86.8303439
  Sleep    0.5s
Paso 2878
  Set Location    21.1276071     -86.8313894
  Sleep    0.5s
Paso 2879
  Set Location    21.1276071     -86.8313894
  Sleep    0.5s
Paso 2880
  Set Location    21.1257164     -86.8323115
  Sleep    0.5s
Paso 2881
  Set Location    21.1257164     -86.8323115
  Sleep    0.5s
Paso 2882
  Set Location    21.1238191     -86.8332402
  Sleep    0.5s
Paso 2883
  Set Location    21.1238191     -86.8332402
  Sleep    0.5s
Paso 2884
  Set Location    21.121763     -86.8342533
  Sleep    0.5s
Paso 2885
  Set Location    21.121763     -86.8342533
  Sleep    0.5s
Paso 2886
  Set Location    21.1195736     -86.8353231
  Sleep    0.5s
Paso 2887
  Set Location    21.1195736     -86.8353231
  Sleep    0.5s
Paso 2888
  Set Location    21.1171254     -86.8365329
  Sleep    0.5s
Paso 2889
  Set Location    21.1171254     -86.8365329
  Sleep    0.5s
Paso 2890
  Set Location    21.1146601     -86.8377263
  Sleep    0.5s
Paso 2891
  Set Location    21.1146601     -86.8377263
  Sleep    0.5s
Paso 2892
  Set Location    21.1121675     -86.8388387
  Sleep    0.5s
Paso 2893
  Set Location    21.1121675     -86.8388387
  Sleep    0.5s
Paso 2894
  Set Location    21.1095851     -86.8392876
  Sleep    0.5s
Paso 2895
  Set Location    21.1095851     -86.8392876
  Sleep    0.5s
Paso 2896
  Set Location    21.1069719     -86.8396827
  Sleep    0.5s
Paso 2897
  Set Location    21.1069719     -86.8396827
  Sleep    0.5s
Paso 2898
  Set Location    21.1044399     -86.8401082
  Sleep    0.5s
Paso 2899
  Set Location    21.1044399     -86.8401082
  Sleep    0.5s
Paso 2900
  Set Location    21.1025728     -86.8404102
  Sleep    0.5s
Paso 2901
  Set Location    21.1025728     -86.8404102
  Sleep    0.5s
Paso 2902
  Set Location    21.1011438     -86.8406299
  Sleep    0.5s
Paso 2903
  Set Location    21.1011438     -86.8406299
  Sleep    0.5s
Paso 2904
  Set Location    21.0991021     -86.8409399
  Sleep    0.5s
Paso 2905
  Set Location    21.0991021     -86.8409399
  Sleep    0.5s
Paso 2906
  Set Location    21.0967793     -86.8412951
  Sleep    0.5s
Paso 2907
  Set Location    21.0967793     -86.8412951
  Sleep    0.5s
Paso 2908
  Set Location    21.0947682     -86.8416197
  Sleep    0.5s
Paso 2909
  Set Location    21.0947682     -86.8416197
  Sleep    0.5s
Paso 2910
  Set Location    21.0925469     -86.8419482
  Sleep    0.5s
Paso 2911
  Set Location    21.0925469     -86.8419482
  Sleep    0.5s
Paso 2912
  Set Location    21.0899955     -86.8422912
  Sleep    0.5s
Paso 2913
  Set Location    21.0899955     -86.8422912
  Sleep    0.5s
Paso 2914
  Set Location    21.0874184     -86.8426904
  Sleep    0.5s
Paso 2915
  Set Location    21.0874184     -86.8426904
  Sleep    0.5s
Paso 2916
  Set Location    21.0854573     -86.8430127
  Sleep    0.5s
Paso 2917
  Set Location    21.0854573     -86.8430127
  Sleep    0.5s
Paso 2918
  Set Location    21.0835031     -86.8433747
  Sleep    0.5s
Paso 2919
  Set Location    21.0835031     -86.8433747
  Sleep    0.5s
Paso 2920
  Set Location    21.0808854     -86.8437844
  Sleep    0.5s
Paso 2921
  Set Location    21.0808854     -86.8437844
  Sleep    0.5s
Paso 2922
  Set Location    21.0782688     -86.844208
  Sleep    0.5s
Paso 2923
  Set Location    21.0782688     -86.844208
  Sleep    0.5s
Paso 2924
  Set Location    21.0756266     -86.8446167
  Sleep    0.5s
Paso 2925
  Set Location    21.0756266     -86.8446167
  Sleep    0.5s
Paso 2926
  Set Location    21.0729937     -86.8450149
  Sleep    0.5s
Paso 2927
  Set Location    21.0729937     -86.8450149
  Sleep    0.5s
Paso 2928
  Set Location    21.0703334     -86.8454515
  Sleep    0.5s
Paso 2929
  Set Location    21.0703334     -86.8454515
  Sleep    0.5s
Paso 2930
  Set Location    21.067602     -86.8458762
  Sleep    0.5s
Paso 2931
  Set Location    21.067602     -86.8458762
  Sleep    0.5s
Paso 2932
  Set Location    21.064842     -86.8463031
  Sleep    0.5s
Paso 2933
  Set Location    21.064842     -86.8463031
  Sleep    0.5s
Paso 2934
  Set Location    21.0621332     -86.8467313
  Sleep    0.5s
Paso 2935
  Set Location    21.0621332     -86.8467313
  Sleep    0.5s
Paso 2936
  Set Location    21.0599507     -86.8470631
  Sleep    0.5s
Paso 2937
  Set Location    21.0599507     -86.8470631
  Sleep    0.5s
Paso 2938
  Set Location    21.0566267     -86.847581
  Sleep    0.5s
Paso 2939
  Set Location    21.0566267     -86.847581
  Sleep    0.5s
Paso 2940
  Set Location    21.0539235     -86.8480062
  Sleep    0.5s
Paso 2941
  Set Location    21.0539235     -86.8480062
  Sleep    0.5s
Paso 2942
  Set Location    21.0511822     -86.8484453
  Sleep    0.5s
Paso 2943
  Set Location    21.0511822     -86.8484453
  Sleep    0.5s
Paso 2944
  Set Location    21.0484992     -86.8488528
  Sleep    0.5s
Paso 2945
  Set Location    21.0484992     -86.8488528
  Sleep    0.5s
Paso 2946
  Set Location    21.0459048     -86.8492768
  Sleep    0.5s
Paso 2947
  Set Location    21.0459048     -86.8492768
  Sleep    0.5s
Paso 2948
  Set Location    21.0433434     -86.8496699
  Sleep    0.5s
Paso 2949
  Set Location    21.0433434     -86.8496699
  Sleep    0.5s
Paso 2950
  Set Location    21.0408386     -86.85007
  Sleep    0.5s
Paso 2951
  Set Location    21.0408386     -86.85007
  Sleep    0.5s
Paso 2952
  Set Location    21.0386298     -86.8504463
  Sleep    0.5s
Paso 2953
  Set Location    21.0386298     -86.8504463
  Sleep    0.5s
Paso 2954
  Set Location    21.036754     -86.8509896
  Sleep    0.5s
Paso 2955
  Set Location    21.036754     -86.8509896
  Sleep    0.5s
Paso 2956
  Set Location    21.0348323     -86.8521838
  Sleep    0.5s
Paso 2957
  Set Location    21.0348323     -86.8521838
  Sleep    0.5s
Paso 2958
  Set Location    21.0342456     -86.8546684
  Sleep    0.5s
Paso 2959
  Set Location    21.0342456     -86.8546684
  Sleep    0.5s
Paso 2960
  Set Location    21.0353566     -86.8569385
  Sleep    0.5s
Paso 2961
  Set Location    21.0353566     -86.8569385
  Sleep    0.5s
Paso 2962
  Set Location    21.0368297     -86.8591751
  Sleep    0.5s
Paso 2963
  Set Location    21.0368297     -86.8591751
  Sleep    0.5s
Paso 2964
  Set Location    21.0382362     -86.8614787
  Sleep    0.5s
Paso 2965
  Set Location    21.0382362     -86.8614787
  Sleep    0.5s
Paso 2966
  Set Location    21.0396994     -86.8638358
  Sleep    0.5s
Paso 2967
  Set Location    21.0396994     -86.8638358
  Sleep    0.5s
Paso 2968
  Set Location    21.0411409     -86.8661453
  Sleep    0.5s
Paso 2969
  Set Location    21.0411409     -86.8661453
  Sleep    0.5s
Paso 2970
  Set Location    21.0425672     -86.8684121
  Sleep    0.5s
Paso 2971
  Set Location    21.0425672     -86.8684121
  Sleep    0.5s
Paso 2972
  Set Location    21.0439161     -86.8705643
  Sleep    0.5s
Paso 2973
  Set Location    21.0439161     -86.8705643
  Sleep    0.5s
Paso 2974
  Set Location    21.0452745     -86.8727486
  Sleep    0.5s
Paso 2975
  Set Location    21.0452745     -86.8727486
  Sleep    0.5s
Paso 2976
  Set Location    21.0464909     -86.8748016
  Sleep    0.5s
Paso 2977
  Set Location    21.0464909     -86.8748016
  Sleep    0.5s
Paso 2978
  Set Location    21.0457699     -86.8765704
  Sleep    0.5s
Paso 2979
  Set Location    21.0457699     -86.8765704
  Sleep    0.5s
Paso 2980
  Set Location    21.0463299     -86.8779904
  Sleep    0.5s
Paso 2981
  Set Location    21.0463299     -86.8779904
  Sleep    0.5s
Paso 2982
  Set Location    21.0469594     -86.8789782
  Sleep    0.5s
Paso 2983
  Set Location    21.0469594     -86.8789782
  Sleep    0.5s
Paso 2984
  Set Location    21.0471397     -86.8794252
  Sleep    0.5s
Paso 2985
  Set Location    21.0471397     -86.8794252
  Sleep    0.5s
Paso 2986
  Set Location    21.0466456     -86.8798464
  Sleep    0.5s
Paso 2987
  Set Location    21.0466456     -86.8798464
  Sleep    0.5s
Paso 2988
  Set Location    21.0465135     -86.8799618
  Sleep    0.5s
Paso 2989
  Set Location    21.0465135     -86.8799618
  Sleep    0.5s
Paso 2990
  Set Location    21.0463253     -86.8801212
  Sleep    0.5s
Paso 2991
  Set Location    21.0463253     -86.8801212
  Sleep    0.5s
Paso 2992
  Set Location    21.045802     -86.8804729
  Sleep    0.5s
Paso 2993
  Set Location    21.045802     -86.8804729
  Sleep    0.5s
Paso 2994
  Set Location    21.0452635     -86.8808698
  Sleep    0.5s
Paso 2995
  Set Location    21.0452635     -86.8808698
  Sleep    0.5s
Paso 2996
  Set Location    21.0450016     -86.8804961
  Sleep    0.5s
Paso 2997
  Set Location    21.0450016     -86.8804961
  Sleep    0.5s
Paso 2998
  Set Location    21.0452633     -86.880275
  Sleep    0.5s
Paso 2999
  Set Location    21.0452633     -86.880275
  Sleep    0.5s
Paso 3000
  Set Location    21.0454373     -86.8801869
  Sleep    0.5s
Paso 3001
  Set Location    21.0454373     -86.8801869
  Sleep    0.5s
Paso 3002
  Set Location    21.0450974     -86.8790473
  Sleep    0.5s
Paso 3003
  Set Location    21.0450974     -86.8790473
  Sleep    0.5s
Paso 3004
  Set Location    21.0443978     -86.8774319
  Sleep    0.5s
Paso 3005
  Set Location    21.0443978     -86.8774319
  Sleep    0.5s
Paso 3006
  Set Location    21.0459367     -86.8761686
  Sleep    0.5s
Paso 3007
  Set Location    21.0459367     -86.8761686
  Sleep    0.5s
Paso 3008
  Set Location    21.0460904     -86.8742862
  Sleep    0.5s
Paso 3009
  Set Location    21.0460904     -86.8742862
  Sleep    0.5s
Paso 3010
  Set Location    21.044859     -86.872377
  Sleep    0.5s
Paso 3011
  Set Location    21.044859     -86.872377
  Sleep    0.5s
Paso 3012
  Set Location    21.0433186     -86.8726847
  Sleep    0.5s
Paso 3013
  Set Location    21.0433186     -86.8726847
  Sleep    0.5s
Paso 3014
  Set Location    21.0417349     -86.8738109
  Sleep    0.5s
Paso 3015
  Set Location    21.0417349     -86.8738109
  Sleep    0.5s
Paso 3016
  Set Location    21.0410857     -86.874137
  Sleep    0.5s
Paso 3017
  Set Location    21.0410857     -86.874137
  Sleep    0.5s
Paso 3018
  Set Location    21.0408936     -86.8738035
  Sleep    0.5s
Paso 3019
  Set Location    21.0408936     -86.8738035
  Sleep    0.5s
Paso 3020
  Set Location    21.0405349     -86.8732314
  Sleep    0.5s
Paso 3021
  Set Location    21.0405349     -86.8732314
  Sleep    0.5s
Paso 3022
  Set Location    21.0402666     -86.8728214
  Sleep    0.5s
Paso 3023
  Set Location    21.0402666     -86.8728214
  Sleep    0.5s
Paso 3024
  Set Location    21.039674     -86.8723359
  Sleep    0.5s
Paso 3025
  Set Location    21.039674     -86.8723359
  Sleep    0.5s
Paso 3026
  Set Location    21.03968     -86.8723417
  Sleep    0.5s
Paso 3027
  Set Location    21.03968     -86.8723417
  Sleep    0.5s
Paso 3028
  Set Location    21.0392674     -86.8727103
  Sleep    0.5s
Paso 3029
  Set Location    21.0392674     -86.8727103
  Sleep    0.5s
Paso 3030
  Set Location    21.0395601     -86.8724099
  Sleep    0.5s
Paso 3031
  Set Location    21.0395601     -86.8724099
  Sleep    0.5s
Paso 3032
  Set Location    21.03983     -86.8721967
  Sleep    0.5s
Paso 3033
  Set Location    21.03983     -86.8721967
  Sleep    0.5s
Paso 3034
  Set Location    21.0399523     -86.8720749
  Sleep    0.5s
Paso 3035
  Set Location    21.0399523     -86.8720749
  Sleep    0.5s
Paso 3036
  Set Location    21.0399517     -86.872075
  Sleep    0.5s
Paso 3037
  Set Location    21.0399517     -86.872075
  Sleep    0.5s
Paso 3038
  Set Location    21.0403222     -86.871841
  Sleep    0.5s
Paso 3039
  Set Location    21.0403222     -86.871841
  Sleep    0.5s
Paso 3040
  Set Location    21.040092     -86.8708773
  Sleep    0.5s
Paso 3041
  Set Location    21.040092     -86.8708773
  Sleep    0.5s
Paso 3042
  Set Location    21.0397242     -86.8695914
  Sleep    0.5s
Paso 3043
  Set Location    21.0397242     -86.8695914
  Sleep    0.5s
Paso 3044
  Set Location    21.041056     -86.8685672
  Sleep    0.5s
Paso 3045
  Set Location    21.041056     -86.8685672
  Sleep    0.5s
Paso 3046
  Set Location    21.0417023     -86.8672978
  Sleep    0.5s
Paso 3047
  Set Location    21.0417023     -86.8672978
  Sleep    0.5s
Paso 3048
  Set Location    21.0405618     -86.8654988
  Sleep    0.5s
Paso 3049
  Set Location    21.0405618     -86.8654988
  Sleep    0.5s
Paso 3050
  Set Location    21.0391692     -86.8632761
  Sleep    0.5s
Paso 3051
  Set Location    21.0391692     -86.8632761
  Sleep    0.5s
Paso 3052
  Set Location    21.0377664     -86.8609931
  Sleep    0.5s
Paso 3053
  Set Location    21.0377664     -86.8609931
  Sleep    0.5s
Paso 3054
  Set Location    21.0364017     -86.8587949
  Sleep    0.5s
Paso 3055
  Set Location    21.0364017     -86.8587949
  Sleep    0.5s
Paso 3056
  Set Location    21.0349859     -86.8565183
  Sleep    0.5s
Paso 3057
  Set Location    21.0349859     -86.8565183
  Sleep    0.5s
Paso 3058
  Set Location    21.033646     -86.854199
  Sleep    0.5s
Paso 3059
  Set Location    21.033646     -86.854199
  Sleep    0.5s
Paso 3060
  Set Location    21.0331921     -86.8519372
  Sleep    0.5s
Paso 3061
  Set Location    21.0331921     -86.8519372
  Sleep    0.5s
Paso 3062
  Set Location    21.0323998     -86.850951
  Sleep    0.5s
Paso 3063
  Set Location    21.0323998     -86.850951
  Sleep    0.5s
Paso 3064
  Set Location    21.0327252     -86.851918
  Sleep    0.5s
Paso 3065
  Set Location    21.0327252     -86.851918
  Sleep    0.5s
Paso 3066
  Set Location    21.0343623     -86.8516144
  Sleep    0.5s
Paso 3067
  Set Location    21.0343623     -86.8516144
  Sleep    0.5s
Paso 3068
  Set Location    21.0365248     -86.8508782
  Sleep    0.5s
Paso 3069
  Set Location    21.0365248     -86.8508782
  Sleep    0.5s
Paso 3070
  Set Location    21.0387349     -86.8502382
  Sleep    0.5s
Paso 3071
  Set Location    21.0387349     -86.8502382
  Sleep    0.5s
Paso 3072
  Set Location    21.0410824     -86.8498668
  Sleep    0.5s
Paso 3073
  Set Location    21.0410824     -86.8498668
  Sleep    0.5s
Paso 3074
  Set Location    21.04357     -86.8494923
  Sleep    0.5s
Paso 3075
  Set Location    21.04357     -86.8494923
  Sleep    0.5s
Paso 3076
  Set Location    21.0450884     -86.8492484
  Sleep    0.5s
Paso 3077
  Set Location    21.0450884     -86.8492484
  Sleep    0.5s
Paso 3078
  Set Location    21.048098     -86.8487653
  Sleep    0.5s
Paso 3079
  Set Location    21.048098     -86.8487653
  Sleep    0.5s
Paso 3080
  Set Location    21.0506239     -86.8483752
  Sleep    0.5s
Paso 3081
  Set Location    21.0506239     -86.8483752
  Sleep    0.5s
Paso 3082
  Set Location    21.0530446     -86.8479848
  Sleep    0.5s
Paso 3083
  Set Location    21.0530446     -86.8479848
  Sleep    0.5s
Paso 3084
  Set Location    21.0556751     -86.8475673
  Sleep    0.5s
Paso 3085
  Set Location    21.0556751     -86.8475673
  Sleep    0.5s
Paso 3086
  Set Location    21.0583562     -86.8471536
  Sleep    0.5s
Paso 3087
  Set Location    21.0583562     -86.8471536
  Sleep    0.5s
Paso 3088
  Set Location    21.0609995     -86.8467655
  Sleep    0.5s
Paso 3089
  Set Location    21.0609995     -86.8467655
  Sleep    0.5s
Paso 3090
  Set Location    21.063727     -86.8463404
  Sleep    0.5s
Paso 3091
  Set Location    21.063727     -86.8463404
  Sleep    0.5s
Paso 3092
  Set Location    21.06646     -86.8459037
  Sleep    0.5s
Paso 3093
  Set Location    21.06646     -86.8459037
  Sleep    0.5s
Paso 3094
  Set Location    21.0691266     -86.8454937
  Sleep    0.5s
Paso 3095
  Set Location    21.0691266     -86.8454937
  Sleep    0.5s
Paso 3096
  Set Location    21.0717269     -86.8450818
  Sleep    0.5s
Paso 3097
  Set Location    21.0717269     -86.8450818
  Sleep    0.5s
Paso 3098
  Set Location    21.0744077     -86.8446791
  Sleep    0.5s
Paso 3099
  Set Location    21.0744077     -86.8446791
  Sleep    0.5s
Paso 3100
  Set Location    21.0770983     -86.8442536
  Sleep    0.5s
Paso 3101
  Set Location    21.0770983     -86.8442536
  Sleep    0.5s
Paso 3102
  Set Location    21.0796966     -86.8438553
  Sleep    0.5s
Paso 3103
  Set Location    21.0796966     -86.8438553
  Sleep    0.5s
Paso 3104
  Set Location    21.0822932     -86.8434471
  Sleep    0.5s
Paso 3105
  Set Location    21.0822932     -86.8434471
  Sleep    0.5s
Paso 3106
  Set Location    21.084793     -86.8430087
  Sleep    0.5s
Paso 3107
  Set Location    21.084793     -86.8430087
  Sleep    0.5s
Paso 3108
  Set Location    21.0873527     -86.8425737
  Sleep    0.5s
Paso 3109
  Set Location    21.0873527     -86.8425737
  Sleep    0.5s
Paso 3110
  Set Location    21.0898387     -86.8422188
  Sleep    0.5s
Paso 3111
  Set Location    21.0898387     -86.8422188
  Sleep    0.5s
Paso 3112
  Set Location    21.0907943     -86.8420857
  Sleep    0.5s
Paso 3113
  Set Location    21.0907943     -86.8420857
  Sleep    0.5s
Paso 3114
  Set Location    21.0933811     -86.8417052
  Sleep    0.5s
Paso 3115
  Set Location    21.0933811     -86.8417052
  Sleep    0.5s
Paso 3116
  Set Location    21.0959713     -86.841295
  Sleep    0.5s
Paso 3117
  Set Location    21.0959713     -86.841295
  Sleep    0.5s
Paso 3118
  Set Location    21.09858     -86.8409004
  Sleep    0.5s
Paso 3119
  Set Location    21.09858     -86.8409004
  Sleep    0.5s
Paso 3120
  Set Location    21.1011133     -86.8404886
  Sleep    0.5s
Paso 3121
  Set Location    21.1011133     -86.8404886
  Sleep    0.5s
Paso 3122
  Set Location    21.1036898     -86.8400844
  Sleep    0.5s
Paso 3123
  Set Location    21.1036898     -86.8400844
  Sleep    0.5s
Paso 3124
  Set Location    21.1063347     -86.8396889
  Sleep    0.5s
Paso 3125
  Set Location    21.1063347     -86.8396889
  Sleep    0.5s
Paso 3126
  Set Location    21.109015     -86.8392588
  Sleep    0.5s
Paso 3127
  Set Location    21.109015     -86.8392588
  Sleep    0.5s
Paso 3128
  Set Location    21.1116563     -86.838836
  Sleep    0.5s
Paso 3129
  Set Location    21.1116563     -86.838836
  Sleep    0.5s
Paso 3130
  Set Location    21.1141514     -86.8378541
  Sleep    0.5s
Paso 3131
  Set Location    21.1141514     -86.8378541
  Sleep    0.5s
Paso 3132
  Set Location    21.1164264     -86.8367534
  Sleep    0.5s
Paso 3133
  Set Location    21.1164264     -86.8367534
  Sleep    0.5s
Paso 3134
  Set Location    21.1187627     -86.835652
  Sleep    0.5s
Paso 3135
  Set Location    21.1187627     -86.835652
  Sleep    0.5s
Paso 3136
  Set Location    21.1210743     -86.8344905
  Sleep    0.5s
Paso 3137
  Set Location    21.1210743     -86.8344905
  Sleep    0.5s
Paso 3138
  Set Location    21.1234713     -86.8333117
  Sleep    0.5s
Paso 3139
  Set Location    21.1234713     -86.8333117
  Sleep    0.5s
Paso 3140
  Set Location    21.1258615     -86.8321401
  Sleep    0.5s
Paso 3141
  Set Location    21.1258615     -86.8321401
  Sleep    0.5s
Paso 3142
  Set Location    21.1281821     -86.8310128
  Sleep    0.5s
Paso 3143
  Set Location    21.1281821     -86.8310128
  Sleep    0.5s
Paso 3144
  Set Location    21.1304411     -86.8299183
  Sleep    0.5s
Paso 3145
  Set Location    21.1304411     -86.8299183
  Sleep    0.5s
Paso 3146
  Set Location    21.1324664     -86.8289173
  Sleep    0.5s
Paso 3147
  Set Location    21.1324664     -86.8289173
  Sleep    0.5s
Paso 3148
  Set Location    21.1345594     -86.827854
  Sleep    0.5s
Paso 3149
  Set Location    21.1345594     -86.827854
  Sleep    0.5s
Paso 3150
  Set Location    21.1367103     -86.8268034
  Sleep    0.5s
Paso 3151
  Set Location    21.1367103     -86.8268034
  Sleep    0.5s
Paso 3152
  Set Location    21.138754     -86.8257713
  Sleep    0.5s
Paso 3153
  Set Location    21.138754     -86.8257713
  Sleep    0.5s
Paso 3154
  Set Location    21.140531     -86.8249487
  Sleep    0.5s
Paso 3155
  Set Location    21.140531     -86.8249487
  Sleep    0.5s
Paso 3156
  Set Location    21.1422783     -86.8242361
  Sleep    0.5s
Paso 3157
  Set Location    21.1422783     -86.8242361
  Sleep    0.5s
Paso 3158
  Set Location    21.1426174     -86.8241965
  Sleep    0.5s
Paso 3159
  Set Location    21.1426174     -86.8241965
  Sleep    0.5s
Paso 3160
  Set Location    21.1445777     -86.8242803
  Sleep    0.5s
Paso 3161
  Set Location    21.1445777     -86.8242803
  Sleep    0.5s
Paso 3162
  Set Location    21.1462488     -86.8244705
  Sleep    0.5s
Paso 3163
  Set Location    21.1462488     -86.8244705
  Sleep    0.5s
Paso 3164
  Set Location    21.1464467     -86.82445
  Sleep    0.5s
Paso 3165
  Set Location    21.1464467     -86.82445
  Sleep    0.5s
Paso 3166
  Set Location    21.1465257     -86.8244908
  Sleep    0.5s
Paso 3167
  Set Location    21.1465257     -86.8244908
  Sleep    0.5s
Paso 3168
  Set Location    21.1475973     -86.8245853
  Sleep    0.5s
Paso 3169
  Set Location    21.1475973     -86.8245853
  Sleep    0.5s
Paso 3170
  Set Location    21.1491328     -86.8246084
  Sleep    0.5s
Paso 3171
  Set Location    21.1491328     -86.8246084
  Sleep    0.5s
Paso 3172
  Set Location    21.1492016     -86.8246067
  Sleep    0.5s
Paso 3173
  Set Location    21.1492016     -86.8246067
  Sleep    0.5s
Paso 3174
  Set Location    21.1503345     -86.8247133
  Sleep    0.5s
Paso 3175
  Set Location    21.1503345     -86.8247133
  Sleep    0.5s
Paso 3176
  Set Location    21.1521877     -86.8249119
  Sleep    0.5s
Paso 3177
  Set Location    21.1521877     -86.8249119
  Sleep    0.5s
Paso 3178
  Set Location    21.1541852     -86.8250585
  Sleep    0.5s
Paso 3179
  Set Location    21.1541852     -86.8250585
  Sleep    0.5s
Paso 3180
  Set Location    21.1557404     -86.8251815
  Sleep    0.5s
Paso 3181
  Set Location    21.1557404     -86.8251815
  Sleep    0.5s
Paso 3182
  Set Location    21.1564022     -86.8251946
  Sleep    0.5s
Paso 3183
  Set Location    21.1564022     -86.8251946
  Sleep    0.5s
Paso 3184
  Set Location    21.1572316     -86.8252012
  Sleep    0.5s
Paso 3185
  Set Location    21.1572316     -86.8252012
  Sleep    0.5s
Paso 3186
  Set Location    21.1582682     -86.8254051
  Sleep    0.5s
Paso 3187
  Set Location    21.1582682     -86.8254051
  Sleep    0.5s
Paso 3188
  Set Location    21.1593463     -86.8254861
  Sleep    0.5s
Paso 3189
  Set Location    21.1593463     -86.8254861
  Sleep    0.5s
Paso 3190
  Set Location    21.1599206     -86.8255203
  Sleep    0.5s
Paso 3191
  Set Location    21.1599206     -86.8255203
  Sleep    0.5s
Paso 3192
  Set Location    21.1610969     -86.8256081
  Sleep    0.5s
Paso 3193
  Set Location    21.1610969     -86.8256081
  Sleep    0.5s
Paso 3194
  Set Location    21.1615252     -86.8256576
  Sleep    0.5s
Paso 3195
  Set Location    21.1615252     -86.8256576
  Sleep    0.5s
Paso 3196
  Set Location    21.1626335     -86.8257385
  Sleep    0.5s
Paso 3197
  Set Location    21.1626335     -86.8257385
  Sleep    0.5s
Paso 3198
  Set Location    21.1631584     -86.8255302
  Sleep    0.5s
Paso 3199
  Set Location    21.1631584     -86.8255302
  Sleep    0.5s
Paso 3200
  Set Location    21.1641062     -86.8255638
  Sleep    0.5s
Paso 3201
  Set Location    21.1641062     -86.8255638
  Sleep    0.5s
Paso 3202
  Set Location    21.1639874     -86.8261345
  Sleep    0.5s
Paso 3203
  Set Location    21.1639874     -86.8261345
  Sleep    0.5s
Paso 3204
  Set Location    21.1639963     -86.8265981
  Sleep    0.5s
Paso 3205
  Set Location    21.1639963     -86.8265981
  Sleep    0.5s
Paso 3206
  Set Location    21.1644484     -86.8262316
  Sleep    0.5s
Paso 3207
  Set Location    21.1644484     -86.8262316
  Sleep    0.5s
Paso 3208
  Set Location    21.1644417     -86.8262283
  Sleep    0.5s
Paso 3209
  Set Location    21.1644417     -86.8262283
  Sleep    0.5s
Paso 3210
  Set Location    21.1643367     -86.8262217
  Sleep    0.5s
Paso 3211
  Set Location    21.1643367     -86.8262217
  Sleep    0.5s
Paso 3212
  Set Location    21.1643084     -86.8261191
  Sleep    0.5s
Paso 3213
  Set Location    21.1643084     -86.8261191
  Sleep    0.5s
Paso 3214
  Set Location    21.1639607     -86.8261405
  Sleep    0.5s
Paso 3215
  Set Location    21.1639607     -86.8261405
  Sleep    0.5s
Paso 3216
  Set Location    21.1628488     -86.8258074
  Sleep    0.5s
Paso 3217
  Set Location    21.1628488     -86.8258074
  Sleep    0.5s
Paso 3218
  Set Location    21.1616454     -86.8256847
  Sleep    0.5s
Paso 3219
  Set Location    21.1616454     -86.8256847
  Sleep    0.5s
Paso 3220
  Set Location    21.1607318     -86.8256165
  Sleep    0.5s
Paso 3221
  Set Location    21.1607318     -86.8256165
  Sleep    0.5s
Paso 3222
  Set Location    21.1596549     -86.8255402
  Sleep    0.5s
Paso 3223
  Set Location    21.1596549     -86.8255402
  Sleep    0.5s
Paso 3224
  Set Location    21.1583452     -86.8254936
  Sleep    0.5s
Paso 3225
  Set Location    21.1583452     -86.8254936
  Sleep    0.5s
Paso 3226
  Set Location    21.1572595     -86.8255315
  Sleep    0.5s
Paso 3227
  Set Location    21.1572595     -86.8255315
  Sleep    0.5s
Paso 3228
  Set Location    21.1558983     -86.825274
  Sleep    0.5s
Paso 3229
  Set Location    21.1558983     -86.825274
  Sleep    0.5s
Paso 3230
  Set Location    21.1540473     -86.8251287
  Sleep    0.5s
Paso 3231
  Set Location    21.1540473     -86.8251287
  Sleep    0.5s
Paso 3232
  Set Location    21.1520469     -86.824981
  Sleep    0.5s
Paso 3233
  Set Location    21.1520469     -86.824981
  Sleep    0.5s
Paso 3234
  Set Location    21.1502935     -86.8248999
  Sleep    0.5s
Paso 3235
  Set Location    21.1502935     -86.8248999
  Sleep    0.5s
Paso 3236
  Set Location    21.1502517     -86.824905
  Sleep    0.5s
Paso 3237
  Set Location    21.1502517     -86.824905
  Sleep    0.5s
Paso 3238
  Set Location    21.1495511     -86.8248486
  Sleep    0.5s
Paso 3239
  Set Location    21.1495511     -86.8248486
  Sleep    0.5s
Paso 3240
  Set Location    21.1479053     -86.8246598
  Sleep    0.5s
Paso 3241
  Set Location    21.1479053     -86.8246598
  Sleep    0.5s
Paso 3242
  Set Location    21.1458738     -86.8244973
  Sleep    0.5s
Paso 3243
  Set Location    21.1458738     -86.8244973
  Sleep    0.5s
Paso 3244
  Set Location    21.1436761     -86.8244307
  Sleep    0.5s
Paso 3245
  Set Location    21.1436761     -86.8244307
  Sleep    0.5s
Paso 3246
  Set Location    21.1414116     -86.8246502
  Sleep    0.5s
Paso 3247
  Set Location    21.1414116     -86.8246502
  Sleep    0.5s
Paso 3248
  Set Location    21.1395281     -86.8257148
  Sleep    0.5s
Paso 3249
  Set Location    21.1395281     -86.8257148
  Sleep    0.5s
Paso 3250
  Set Location    21.1375516     -86.8265331
  Sleep    0.5s
Paso 3251
  Set Location    21.1375516     -86.8265331
  Sleep    0.5s
Paso 3252
  Set Location    21.1353794     -86.8275887
  Sleep    0.5s
Paso 3253
  Set Location    21.1353794     -86.8275887
  Sleep    0.5s
Paso 3254
  Set Location    21.1332297     -86.82863
  Sleep    0.5s
Paso 3255
  Set Location    21.1332297     -86.82863
  Sleep    0.5s
Paso 3256
  Set Location    21.1310499     -86.8296993
  Sleep    0.5s
Paso 3257
  Set Location    21.1310499     -86.8296993
  Sleep    0.5s
Paso 3258
  Set Location    21.1305982     -86.829915
  Sleep    0.5s
Paso 3259
  Set Location    21.1305982     -86.829915
  Sleep    0.5s
Paso 3260
  Set Location    21.1283625     -86.8310061
  Sleep    0.5s
Paso 3261
  Set Location    21.1283625     -86.8310061
  Sleep    0.5s
Paso 3262
  Set Location    21.127942     -86.8312299
  Sleep    0.5s
Paso 3263
  Set Location    21.127942     -86.8312299
  Sleep    0.5s
Paso 3264
  Set Location    21.1257331     -86.8323028
  Sleep    0.5s
Paso 3265
  Set Location    21.1257331     -86.8323028
  Sleep    0.5s
Paso 3266
  Set Location    21.1235503     -86.8333565
  Sleep    0.5s
Paso 3267
  Set Location    21.1235503     -86.8333565
  Sleep    0.5s
Paso 3268
  Set Location    21.1213501     -86.8344445
  Sleep    0.5s
Paso 3269
  Set Location    21.1213501     -86.8344445
  Sleep    0.5s
Paso 3270
  Set Location    21.1191029     -86.8355478
  Sleep    0.5s
Paso 3271
  Set Location    21.1191029     -86.8355478
  Sleep    0.5s
Paso 3272
  Set Location    21.1167551     -86.836708
  Sleep    0.5s
Paso 3273
  Set Location    21.1167551     -86.836708
  Sleep    0.5s
Paso 3274
  Set Location    21.1143698     -86.8378636
  Sleep    0.5s
Paso 3275
  Set Location    21.1143698     -86.8378636
  Sleep    0.5s
Paso 3276
  Set Location    21.1119307     -86.8389052
  Sleep    0.5s
Paso 3277
  Set Location    21.1119307     -86.8389052
  Sleep    0.5s
Paso 3278
  Set Location    21.1092969     -86.8393782
  Sleep    0.5s
Paso 3279
  Set Location    21.1092969     -86.8393782
  Sleep    0.5s
Paso 3280
  Set Location    21.106708     -86.8397895
  Sleep    0.5s
Paso 3281
  Set Location    21.106708     -86.8397895
  Sleep    0.5s
Paso 3282
  Set Location    21.1045131     -86.8401299
  Sleep    0.5s
Paso 3283
  Set Location    21.1045131     -86.8401299
  Sleep    0.5s
Paso 3284
  Set Location    21.1028516     -86.8403979
  Sleep    0.5s
Paso 3285
  Set Location    21.1028516     -86.8403979
  Sleep    0.5s
Paso 3286
  Set Location    21.1016137     -86.8406032
  Sleep    0.5s
Paso 3287
  Set Location    21.1016137     -86.8406032
  Sleep    0.5s
Paso 3288
  Set Location    21.0998201     -86.8408681
  Sleep    0.5s
Paso 3289
  Set Location    21.0998201     -86.8408681
  Sleep    0.5s
Paso 3290
  Set Location    21.0974522     -86.8412114
  Sleep    0.5s
Paso 3291
  Set Location    21.0974522     -86.8412114
  Sleep    0.5s
Paso 3292
  Set Location    21.0951048     -86.8415861
  Sleep    0.5s
Paso 3293
  Set Location    21.0951048     -86.8415861
  Sleep    0.5s
Paso 3294
  Set Location    21.0926067     -86.8419814
  Sleep    0.5s
Paso 3295
  Set Location    21.0926067     -86.8419814
  Sleep    0.5s
Paso 3296
  Set Location    21.0901258     -86.8422876
  Sleep    0.5s
Paso 3297
  Set Location    21.0901258     -86.8422876
  Sleep    0.5s
Paso 3298
  Set Location    21.0875422     -86.8426998
  Sleep    0.5s
Paso 3299
  Set Location    21.0875422     -86.8426998
  Sleep    0.5s
Paso 3300
  Set Location    21.0849985     -86.843118
  Sleep    0.5s
Paso 3301
  Set Location    21.0849985     -86.843118
  Sleep    0.5s
Paso 3302
  Set Location    21.0823432     -86.8435911
  Sleep    0.5s
Paso 3303
  Set Location    21.0823432     -86.8435911
  Sleep    0.5s
Paso 3304
  Set Location    21.079797     -86.8439862
  Sleep    0.5s
Paso 3305
  Set Location    21.079797     -86.8439862
  Sleep    0.5s
Paso 3306
  Set Location    21.077177     -86.8443947
  Sleep    0.5s
Paso 3307
  Set Location    21.077177     -86.8443947
  Sleep    0.5s
Paso 3308
  Set Location    21.0697688     -86.8455526
  Sleep    0.5s
Paso 3309
  Set Location    21.0697688     -86.8455526
  Sleep    0.5s
Paso 3310
  Set Location    21.0697688     -86.8455526
  Sleep    0.5s
Paso 3311
  Set Location    21.0697688     -86.8455526
  Sleep    0.5s
Paso 3312
  Set Location    21.0697688     -86.8455526
  Sleep    0.5s
Paso 3313
  Set Location    21.0697688     -86.8455526
  Sleep    0.5s
Paso 3314
  Set Location    21.0697688     -86.8455526
  Sleep    0.5s
Paso 3315
  Set Location    21.0697688     -86.8455526
  Sleep    0.5s
Paso 3316
  Set Location    21.0672028     -86.8459635
  Sleep    0.5s
Paso 3317
  Set Location    21.0672028     -86.8459635
  Sleep    0.5s
Paso 3318
  Set Location    21.0647107     -86.8463515
  Sleep    0.5s
Paso 3319
  Set Location    21.0647107     -86.8463515
  Sleep    0.5s
Paso 3320
  Set Location    21.0621249     -86.8467601
  Sleep    0.5s
Paso 3321
  Set Location    21.0621249     -86.8467601
  Sleep    0.5s
Paso 3322
  Set Location    21.0595853     -86.8471467
  Sleep    0.5s
Paso 3323
  Set Location    21.0595853     -86.8471467
  Sleep    0.5s
Paso 3324
  Set Location    21.0569482     -86.8475543
  Sleep    0.5s
Paso 3325
  Set Location    21.0569482     -86.8475543
  Sleep    0.5s
Paso 3326
  Set Location    21.0543218     -86.8479632
  Sleep    0.5s
Paso 3327
  Set Location    21.0543218     -86.8479632
  Sleep    0.5s
Paso 3328
  Set Location    21.051797     -86.8483531
  Sleep    0.5s
Paso 3329
  Set Location    21.051797     -86.8483531
  Sleep    0.5s
Paso 3330
  Set Location    21.0492916     -86.84873
  Sleep    0.5s
Paso 3331
  Set Location    21.0492916     -86.84873
  Sleep    0.5s
Paso 3332
  Set Location    21.0467782     -86.8491022
  Sleep    0.5s
Paso 3333
  Set Location    21.0467782     -86.8491022
  Sleep    0.5s
Paso 3334
  Set Location    21.0442932     -86.8495102
  Sleep    0.5s
Paso 3335
  Set Location    21.0442932     -86.8495102
  Sleep    0.5s
Paso 3336
  Set Location    21.0417282     -86.8499237
  Sleep    0.5s
Paso 3337
  Set Location    21.0417282     -86.8499237
  Sleep    0.5s
Paso 3338
  Set Location    21.0392405     -86.8503349
  Sleep    0.5s
Paso 3339
  Set Location    21.0392405     -86.8503349
  Sleep    0.5s
Paso 3340
  Set Location    21.0368343     -86.850975
  Sleep    0.5s
Paso 3341
  Set Location    21.0368343     -86.850975
  Sleep    0.5s
Paso 3342
  Set Location    21.0347973     -86.8522207
  Sleep    0.5s
Paso 3343
  Set Location    21.0347973     -86.8522207
  Sleep    0.5s
Paso 3344
  Set Location    21.0342499     -86.8547282
  Sleep    0.5s
Paso 3345
  Set Location    21.0342499     -86.8547282
  Sleep    0.5s
Paso 3346
  Set Location    21.0354396     -86.8570633
  Sleep    0.5s
Paso 3347
  Set Location    21.0354396     -86.8570633
  Sleep    0.5s
Paso 3348
  Set Location    21.0369173     -86.8592871
  Sleep    0.5s
Paso 3349
  Set Location    21.0369173     -86.8592871
  Sleep    0.5s
Paso 3350
  Set Location    21.0382571     -86.8614732
  Sleep    0.5s
Paso 3351
  Set Location    21.0382571     -86.8614732
  Sleep    0.5s
Paso 3352
  Set Location    21.0396284     -86.8636002
  Sleep    0.5s
Paso 3353
  Set Location    21.0396284     -86.8636002
  Sleep    0.5s
Paso 3354
  Set Location    21.0408425     -86.8656212
  Sleep    0.5s
Paso 3355
  Set Location    21.0408425     -86.8656212
  Sleep    0.5s
Paso 3356
  Set Location    21.0420891     -86.8676477
  Sleep    0.5s
Paso 3357
  Set Location    21.0420891     -86.8676477
  Sleep    0.5s
Paso 3358
  Set Location    21.0433449     -86.8696438
  Sleep    0.5s
Paso 3359
  Set Location    21.0433449     -86.8696438
  Sleep    0.5s
Paso 3360
  Set Location    21.0444797     -86.8714632
  Sleep    0.5s
Paso 3361
  Set Location    21.0444797     -86.8714632
  Sleep    0.5s
Paso 3362
  Set Location    21.0456538     -86.8733843
  Sleep    0.5s
Paso 3363
  Set Location    21.0456538     -86.8733843
  Sleep    0.5s
Paso 3364
  Set Location    21.0465732     -86.8752737
  Sleep    0.5s
Paso 3365
  Set Location    21.0465732     -86.8752737
  Sleep    0.5s
Paso 3366
  Set Location    21.0457151     -86.8769531
  Sleep    0.5s
Paso 3367
  Set Location    21.0457151     -86.8769531
  Sleep    0.5s
Paso 3368
  Set Location    21.0465114     -86.8782951
  Sleep    0.5s
Paso 3369
  Set Location    21.0465114     -86.8782951
  Sleep    0.5s
Paso 3370
  Set Location    21.0469902     -86.8790581
  Sleep    0.5s
Paso 3371
  Set Location    21.0469902     -86.8790581
  Sleep    0.5s
Paso 3372
  Set Location    21.0467621     -86.8797904
  Sleep    0.5s
Paso 3373
  Set Location    21.0467621     -86.8797904
  Sleep    0.5s
Paso 3374
  Set Location    21.0462806     -86.8801607
  Sleep    0.5s
Paso 3375
  Set Location    21.0462806     -86.8801607
  Sleep    0.5s
Paso 3376
  Set Location    21.0457539     -86.8805393
  Sleep    0.5s
Paso 3377
  Set Location    21.0457539     -86.8805393
  Sleep    0.5s
Paso 3378
  Set Location    21.0449333     -86.8804711
  Sleep    0.5s
Paso 3379
  Set Location    21.0449333     -86.8804711
  Sleep    0.5s
Paso 3380
  Set Location    21.045255     -86.880265
  Sleep    0.5s
Paso 3381
  Set Location    21.045255     -86.880265
  Sleep    0.5s
Paso 3382
  Set Location    21.0455697     -86.8800588
  Sleep    0.5s
Paso 3383
  Set Location    21.0455697     -86.8800588
  Sleep    0.5s
Paso 3384
  Set Location    21.044727     -86.8783682
  Sleep    0.5s
Paso 3385
  Set Location    21.044727     -86.8783682
  Sleep    0.5s
Paso 3386
  Set Location    21.045121     -86.8767405
  Sleep    0.5s
Paso 3387
  Set Location    21.045121     -86.8767405
  Sleep    0.5s
Paso 3388
  Set Location    21.0463844     -86.8748677
  Sleep    0.5s
Paso 3389
  Set Location    21.0463844     -86.8748677
  Sleep    0.5s
Paso 3390
  Set Location    21.0449696     -86.8724993
  Sleep    0.5s
Paso 3391
  Set Location    21.0449696     -86.8724993
  Sleep    0.5s
Paso 3392
  Set Location    21.0433942     -86.8726826
  Sleep    0.5s
Paso 3393
  Set Location    21.0433942     -86.8726826
  Sleep    0.5s
Paso 3394
  Set Location    21.0416409     -86.8738863
  Sleep    0.5s
Paso 3395
  Set Location    21.0416409     -86.8738863
  Sleep    0.5s
Paso 3396
  Set Location    21.0410816     -86.8741046
  Sleep    0.5s
Paso 3397
  Set Location    21.0410816     -86.8741046
  Sleep    0.5s
Paso 3398
  Set Location    21.0407445     -86.8735703
  Sleep    0.5s
Paso 3399
  Set Location    21.0407445     -86.8735703
  Sleep    0.5s
Paso 3400
  Set Location    21.0403992     -86.873039
  Sleep    0.5s
Paso 3401
  Set Location    21.0403992     -86.873039
  Sleep    0.5s
Paso 3402
  Set Location    21.0398149     -86.8722806
  Sleep    0.5s
Paso 3403
  Set Location    21.0398149     -86.8722806
  Sleep    0.5s
Paso 3404
  Set Location    21.039715     -86.8723267
  Sleep    0.5s
Paso 3405
  Set Location    21.039715     -86.8723267
  Sleep    0.5s
Paso 3406
  Set Location    21.0392629     -86.8727404
  Sleep    0.5s
Paso 3407
  Set Location    21.0392629     -86.8727404
  Sleep    0.5s
Paso 3408
  Set Location    21.0396454     -86.8723185
  Sleep    0.5s
Paso 3409
  Set Location    21.0396454     -86.8723185
  Sleep    0.5s
Paso 3410
  Set Location    21.0397533     -86.8722317
  Sleep    0.5s
Paso 3411
  Set Location    21.0397533     -86.8722317
  Sleep    0.5s
Paso 3412
  Set Location    21.0398267     -86.8721317
  Sleep    0.5s
Paso 3413
  Set Location    21.0398267     -86.8721317
  Sleep    0.5s
Paso 3414
  Set Location    21.0399583     -86.87202
  Sleep    0.5s
Paso 3415
  Set Location    21.0399583     -86.87202
  Sleep    0.5s
Paso 3416
  Set Location    21.0399923     -86.8721106
  Sleep    0.5s
Paso 3417
  Set Location    21.0399923     -86.8721106
  Sleep    0.5s
Paso 3418
  Set Location    21.0399967     -86.872115
  Sleep    0.5s
Paso 3419
  Set Location    21.0399967     -86.872115
  Sleep    0.5s
Paso 3420
  Set Location    21.0401006     -86.8720195
  Sleep    0.5s
Paso 3421
  Set Location    21.0401006     -86.8720195
  Sleep    0.5s
Paso 3422
  Set Location    21.0403292     -86.8712701
  Sleep    0.5s
Paso 3423
  Set Location    21.0403292     -86.8712701
  Sleep    0.5s
Paso 3424
  Set Location    21.0396403     -86.8699588
  Sleep    0.5s
Paso 3425
  Set Location    21.0396403     -86.8699588
  Sleep    0.5s
Paso 3426
  Set Location    21.0407445     -86.868832
  Sleep    0.5s
Paso 3427
  Set Location    21.0407445     -86.868832
  Sleep    0.5s
Paso 3428
  Set Location    21.0418636     -86.8675277
  Sleep    0.5s
Paso 3429
  Set Location    21.0418636     -86.8675277
  Sleep    0.5s
Paso 3430
  Set Location    21.0414822     -86.8668269
  Sleep    0.5s
Paso 3431
  Set Location    21.0414822     -86.8668269
  Sleep    0.5s
Paso 3432
  Set Location    21.0402152     -86.8647965
  Sleep    0.5s
Paso 3433
  Set Location    21.0402152     -86.8647965
  Sleep    0.5s
Paso 3434
  Set Location    21.0387469     -86.8624668
  Sleep    0.5s
Paso 3435
  Set Location    21.0387469     -86.8624668
  Sleep    0.5s
Paso 3436
  Set Location    21.0373549     -86.8602466
  Sleep    0.5s
Paso 3437
  Set Location    21.0373549     -86.8602466
  Sleep    0.5s
Paso 3438
  Set Location    21.0360582     -86.8581516
  Sleep    0.5s
Paso 3439
  Set Location    21.0360582     -86.8581516
  Sleep    0.5s
Paso 3440
  Set Location    21.0346385     -86.8558947
  Sleep    0.5s
Paso 3441
  Set Location    21.0346385     -86.8558947
  Sleep    0.5s
Paso 3442
  Set Location    21.0334812     -86.8535477
  Sleep    0.5s
Paso 3443
  Set Location    21.0334812     -86.8535477
  Sleep    0.5s
Paso 3444
  Set Location    21.0331437     -86.8515415
  Sleep    0.5s
Paso 3445
  Set Location    21.0331437     -86.8515415
  Sleep    0.5s
Paso 3446
  Set Location    21.0321977     -86.8511793
  Sleep    0.5s
Paso 3447
  Set Location    21.0321977     -86.8511793
  Sleep    0.5s
Paso 3448
  Set Location    21.0332529     -86.8518287
  Sleep    0.5s
Paso 3449
  Set Location    21.0332529     -86.8518287
  Sleep    0.5s
Paso 3450
  Set Location    21.0353792     -86.8512736
  Sleep    0.5s
Paso 3451
  Set Location    21.0353792     -86.8512736
  Sleep    0.5s
Paso 3452
  Set Location    21.0375927     -86.8504497
  Sleep    0.5s
Paso 3453
  Set Location    21.0375927     -86.8504497
  Sleep    0.5s
Paso 3454
  Set Location    21.03786     -86.8503717
  Sleep    0.5s
Paso 3455
  Set Location    21.03786     -86.8503717
  Sleep    0.5s
Paso 3456
  Set Location    21.0389446     -86.8501656
  Sleep    0.5s
Paso 3457
  Set Location    21.0389446     -86.8501656
  Sleep    0.5s
Paso 3458
  Set Location    21.0410763     -86.8498203
  Sleep    0.5s
Paso 3459
  Set Location    21.0410763     -86.8498203
  Sleep    0.5s
Paso 3460
  Set Location    21.0435622     -86.8494353
  Sleep    0.5s
Paso 3461
  Set Location    21.0435622     -86.8494353
  Sleep    0.5s
Paso 3462
  Set Location    21.0460896     -86.8490571
  Sleep    0.5s
Paso 3463
  Set Location    21.0460896     -86.8490571
  Sleep    0.5s
Paso 3464
  Set Location    21.048723     -86.8486855
  Sleep    0.5s
Paso 3465
  Set Location    21.048723     -86.8486855
  Sleep    0.5s
Paso 3466
  Set Location    21.0514533     -86.8482418
  Sleep    0.5s
Paso 3467
  Set Location    21.0514533     -86.8482418
  Sleep    0.5s
Paso 3468
  Set Location    21.0542231     -86.847812
  Sleep    0.5s
Paso 3469
  Set Location    21.0542231     -86.847812
  Sleep    0.5s
Paso 3470
  Set Location    21.0570232     -86.8473884
  Sleep    0.5s
Paso 3471
  Set Location    21.0570232     -86.8473884
  Sleep    0.5s
Paso 3472
  Set Location    21.0598576     -86.8469686
  Sleep    0.5s
Paso 3473
  Set Location    21.0598576     -86.8469686
  Sleep    0.5s
Paso 3474
  Set Location    21.0627215     -86.8465222
  Sleep    0.5s
Paso 3475
  Set Location    21.0627215     -86.8465222
  Sleep    0.5s
Paso 3476
  Set Location    21.0656135     -86.8460434
  Sleep    0.5s
Paso 3477
  Set Location    21.0656135     -86.8460434
  Sleep    0.5s
Paso 3478
  Set Location    21.0684654     -86.8456017
  Sleep    0.5s
Paso 3479
  Set Location    21.0684654     -86.8456017
  Sleep    0.5s
Paso 3480
  Set Location    21.0713372     -86.8451185
  Sleep    0.5s
Paso 3481
  Set Location    21.0713372     -86.8451185
  Sleep    0.5s
Paso 3482
  Set Location    21.0741366     -86.8447001
  Sleep    0.5s
Paso 3483
  Set Location    21.0741366     -86.8447001
  Sleep    0.5s
Paso 3484
  Set Location    21.0769349     -86.8442869
  Sleep    0.5s
Paso 3485
  Set Location    21.0769349     -86.8442869
  Sleep    0.5s
Paso 3486
  Set Location    21.0796272     -86.8438565
  Sleep    0.5s
Paso 3487
  Set Location    21.0796272     -86.8438565
  Sleep    0.5s
Paso 3488
  Set Location    21.0801299     -86.8437753
  Sleep    0.5s
Paso 3489
  Set Location    21.0801299     -86.8437753
  Sleep    0.5s
Paso 3490
  Set Location    21.0834237     -86.8432998
  Sleep    0.5s
Paso 3491
  Set Location    21.0834237     -86.8432998
  Sleep    0.5s
Paso 3492
  Set Location    21.0862416     -86.8427786
  Sleep    0.5s
Paso 3493
  Set Location    21.0862416     -86.8427786
  Sleep    0.5s
Paso 3494
  Set Location    21.0890843     -86.8423488
  Sleep    0.5s
Paso 3495
  Set Location    21.0890843     -86.8423488
  Sleep    0.5s
Paso 3496
  Set Location    21.09178     -86.8419821
  Sleep    0.5s
Paso 3497
  Set Location    21.09178     -86.8419821
  Sleep    0.5s
Paso 3498
  Set Location    21.0944816     -86.8415565
  Sleep    0.5s
Paso 3499
  Set Location    21.0944816     -86.8415565
  Sleep    0.5s
Paso 3500
  Set Location    21.0972977     -86.841114
  Sleep    0.5s
Paso 3501
  Set Location    21.0972977     -86.841114
  Sleep    0.5s
Paso 3502
  Set Location    21.1001804     -86.8406541
  Sleep    0.5s
Paso 3503
  Set Location    21.1001804     -86.8406541
  Sleep    0.5s
Paso 3504
  Set Location    21.1029413     -86.8402251
  Sleep    0.5s
Paso 3505
  Set Location    21.1029413     -86.8402251
  Sleep    0.5s
Paso 3506
  Set Location    21.1056227     -86.8398131
  Sleep    0.5s
Paso 3507
  Set Location    21.1056227     -86.8398131
  Sleep    0.5s
Paso 3508
  Set Location    21.108408     -86.839398
  Sleep    0.5s
Paso 3509
  Set Location    21.108408     -86.839398
  Sleep    0.5s
Paso 3510
  Set Location    21.1112182     -86.8389531
  Sleep    0.5s
Paso 3511
  Set Location    21.1112182     -86.8389531
  Sleep    0.5s
Paso 3512
  Set Location    21.1139383     -86.8379968
  Sleep    0.5s
Paso 3513
  Set Location    21.1139383     -86.8379968
  Sleep    0.5s
Paso 3514
  Set Location    21.1164782     -86.8367669
  Sleep    0.5s
Paso 3515
  Set Location    21.1164782     -86.8367669
  Sleep    0.5s
Paso 3516
  Set Location    21.1189182     -86.8355338
  Sleep    0.5s
Paso 3517
  Set Location    21.1189182     -86.8355338
  Sleep    0.5s
Paso 3518
  Set Location    21.1213318     -86.8343532
  Sleep    0.5s
Paso 3519
  Set Location    21.1213318     -86.8343532
  Sleep    0.5s
Paso 3520
  Set Location    21.1239302     -86.8330985
  Sleep    0.5s
Paso 3521
  Set Location    21.1239302     -86.8330985
  Sleep    0.5s
Paso 3522
  Set Location    21.126568     -86.8317903
  Sleep    0.5s
Paso 3523
  Set Location    21.126568     -86.8317903
  Sleep    0.5s
Paso 3524
  Set Location    21.1291787     -86.8305105
  Sleep    0.5s
Paso 3525
  Set Location    21.1291787     -86.8305105
  Sleep    0.5s
Paso 3526
  Set Location    21.1317148     -86.8293122
  Sleep    0.5s
Paso 3527
  Set Location    21.1317148     -86.8293122
  Sleep    0.5s
Paso 3528
  Set Location    21.1340934     -86.8281089
  Sleep    0.5s
Paso 3529
  Set Location    21.1340934     -86.8281089
  Sleep    0.5s
Paso 3530
  Set Location    21.1364785     -86.82693
  Sleep    0.5s
Paso 3531
  Set Location    21.1364785     -86.82693
  Sleep    0.5s
Paso 3532
  Set Location    21.1386391     -86.8258722
  Sleep    0.5s
Paso 3533
  Set Location    21.1386391     -86.8258722
  Sleep    0.5s
Paso 3534
  Set Location    21.140388     -86.8250159
  Sleep    0.5s
Paso 3535
  Set Location    21.140388     -86.8250159
  Sleep    0.5s
Paso 3536
  Set Location    21.14228     -86.8242517
  Sleep    0.5s
Paso 3537
  Set Location    21.14228     -86.8242517
  Sleep    0.5s
Paso 3538
  Set Location    21.1443512     -86.8242547
  Sleep    0.5s
Paso 3539
  Set Location    21.1443512     -86.8242547
  Sleep    0.5s
Paso 3540
  Set Location    21.1461406     -86.8244473
  Sleep    0.5s
Paso 3541
  Set Location    21.1461406     -86.8244473
  Sleep    0.5s
Paso 3542
  Set Location    21.1464667     -86.82445
  Sleep    0.5s
Paso 3543
  Set Location    21.1464667     -86.82445
  Sleep    0.5s
Paso 3544
  Set Location    21.1465726     -86.824471
  Sleep    0.5s
Paso 3545
  Set Location    21.1465726     -86.824471
  Sleep    0.5s
Paso 3546
  Set Location    21.147754     -86.8245676
  Sleep    0.5s
Paso 3547
  Set Location    21.147754     -86.8245676
  Sleep    0.5s
Paso 3548
  Set Location    21.1490532     -86.8246247
  Sleep    0.5s
Paso 3549
  Set Location    21.1490532     -86.8246247
  Sleep    0.5s
Paso 3550
  Set Location    21.14906     -86.824625
  Sleep    0.5s
Paso 3551
  Set Location    21.14906     -86.824625
  Sleep    0.5s
Paso 3552
  Set Location    21.1500748     -86.8246864
  Sleep    0.5s
Paso 3553
  Set Location    21.1500748     -86.8246864
  Sleep    0.5s
Paso 3554
  Set Location    21.1520346     -86.8248983
  Sleep    0.5s
Paso 3555
  Set Location    21.1520346     -86.8248983
  Sleep    0.5s
Paso 3556
  Set Location    21.1544469     -86.8250883
  Sleep    0.5s
Paso 3557
  Set Location    21.1544469     -86.8250883
  Sleep    0.5s
Paso 3558
  Set Location    21.1562584     -86.8252183
  Sleep    0.5s
Paso 3559
  Set Location    21.1562584     -86.8252183
  Sleep    0.5s
Paso 3560
  Set Location    21.1563183     -86.8252067
  Sleep    0.5s
Paso 3561
  Set Location    21.1563183     -86.8252067
  Sleep    0.5s
Paso 3562
  Set Location    21.156875     -86.8250356
  Sleep    0.5s
Paso 3563
  Set Location    21.156875     -86.8250356
  Sleep    0.5s
Paso 3564
  Set Location    21.1579662     -86.8253566
  Sleep    0.5s
Paso 3565
  Set Location    21.1579662     -86.8253566
  Sleep    0.5s
Paso 3566
  Set Location    21.1589526     -86.8254514
  Sleep    0.5s
Paso 3567
  Set Location    21.1589526     -86.8254514
  Sleep    0.5s
Paso 3568
  Set Location    21.1600922     -86.8255367
  Sleep    0.5s
Paso 3569
  Set Location    21.1600922     -86.8255367
  Sleep    0.5s
Paso 3570
  Set Location    21.1613666     -86.825625
  Sleep    0.5s
Paso 3571
  Set Location    21.1613666     -86.825625
  Sleep    0.5s
Paso 3572
  Set Location    21.162683     -86.8257285
  Sleep    0.5s
Paso 3573
  Set Location    21.162683     -86.8257285
  Sleep    0.5s
Paso 3574
  Set Location    21.1630065     -86.8256533
  Sleep    0.5s
Paso 3575
  Set Location    21.1630065     -86.8256533
  Sleep    0.5s
Paso 3576
  Set Location    21.1638925     -86.8254044
  Sleep    0.5s
Paso 3577
  Set Location    21.1638925     -86.8254044
  Sleep    0.5s
Paso 3578
  Set Location    21.1639846     -86.8262068
  Sleep    0.5s
Paso 3579
  Set Location    21.1639846     -86.8262068
  Sleep    0.5s
Paso 3580
  Set Location    21.1640183     -86.8266226
  Sleep    0.5s
Paso 3581
  Set Location    21.1640183     -86.8266226
  Sleep    0.5s
Paso 3582
  Set Location    21.1644274     -86.8262067
  Sleep    0.5s
Paso 3583
  Set Location    21.1644274     -86.8262067
  Sleep    0.5s
Paso 3584
  Set Location    21.1644533     -86.8261867
  Sleep    0.5s
Paso 3585
  Set Location    21.1644533     -86.8261867
  Sleep    0.5s
Paso 3586
  Set Location    21.1645217     -86.8261083
  Sleep    0.5s
Paso 3587
  Set Location    21.1645217     -86.8261083
  Sleep    0.5s
Paso 3588
  Set Location    21.16447     -86.826175
  Sleep    0.5s
Paso 3589
  Set Location    21.16447     -86.826175
  Sleep    0.5s
Paso 3590
  Set Location    21.1644912     -86.826326
  Sleep    0.5s
Paso 3591
  Set Location    21.1644912     -86.826326
  Sleep    0.5s
Paso 3592
  Set Location    21.164495     -86.826335
  Sleep    0.5s
Paso 3593
  Set Location    21.164495     -86.826335
  Sleep    0.5s
Paso 3594
  Set Location    21.16447     -86.8262017
  Sleep    0.5s
Paso 3595
  Set Location    21.16447     -86.8262017
  Sleep    0.5s
Paso 3596
  Set Location    21.1645094     -86.826126
  Sleep    0.5s
Paso 3597
  Set Location    21.1645094     -86.826126
  Sleep    0.5s
Paso 3598
  Set Location    21.1645183     -86.826105
  Sleep    0.5s
Paso 3599
  Set Location    21.1645183     -86.826105
  Sleep    0.5s
Paso 3600
  Set Location    21.1644985     -86.8260039
  Sleep    0.5s
Paso 3601
  Set Location    21.1644985     -86.8260039
  Sleep    0.5s
Paso 3602
  Set Location    21.1643915     -86.8261658
  Sleep    0.5s
Paso 3603
  Set Location    21.1643915     -86.8261658
  Sleep    0.5s
Paso 3604
  Set Location    21.1640528     -86.8261273
  Sleep    0.5s
Paso 3605
  Set Location    21.1640528     -86.8261273
  Sleep    0.5s
Paso 3606
  Set Location    21.1630122     -86.8258975
  Sleep    0.5s
Paso 3607
  Set Location    21.1630122     -86.8258975
  Sleep    0.5s
Paso 3608
  Set Location    21.1619161     -86.8257381
  Sleep    0.5s
Paso 3609
  Set Location    21.1619161     -86.8257381
  Sleep    0.5s
Paso 3610
  Set Location    21.1610053     -86.8256697
  Sleep    0.5s
Paso 3611
  Set Location    21.1610053     -86.8256697
  Sleep    0.5s
Paso 3612
  Set Location    21.1599195     -86.8255812
  Sleep    0.5s
Paso 3613
  Set Location    21.1599195     -86.8255812
  Sleep    0.5s
Paso 3614
  Set Location    21.1591238     -86.8255214
  Sleep    0.5s
Paso 3615
  Set Location    21.1591238     -86.8255214
  Sleep    0.5s
Paso 3616
  Set Location    21.1584417     -86.8254684
  Sleep    0.5s
Paso 3617
  Set Location    21.1584417     -86.8254684
  Sleep    0.5s
Paso 3618
  Set Location    21.1576685     -86.8254418
  Sleep    0.5s
Paso 3619
  Set Location    21.1576685     -86.8254418
  Sleep    0.5s
Paso 3620
  Set Location    21.1562866     -86.8253308
  Sleep    0.5s
Paso 3621
  Set Location    21.1562866     -86.8253308
  Sleep    0.5s
Paso 3622
  Set Location    21.1547221     -86.8252033
  Sleep    0.5s
Paso 3623
  Set Location    21.1547221     -86.8252033
  Sleep    0.5s
Paso 3624
  Set Location    21.1529817     -86.8250695
  Sleep    0.5s
Paso 3625
  Set Location    21.1529817     -86.8250695
  Sleep    0.5s
Paso 3626
  Set Location    21.1513676     -86.8249497
  Sleep    0.5s
Paso 3627
  Set Location    21.1513676     -86.8249497
  Sleep    0.5s
Paso 3628
  Set Location    21.1503176     -86.8249048
  Sleep    0.5s
Paso 3629
  Set Location    21.1503176     -86.8249048
  Sleep    0.5s
Paso 3630
  Set Location    21.1503033     -86.8249117
  Sleep    0.5s
Paso 3631
  Set Location    21.1503033     -86.8249117
  Sleep    0.5s
Paso 3632
  Set Location    21.1495088     -86.8248536
  Sleep    0.5s
Paso 3633
  Set Location    21.1495088     -86.8248536
  Sleep    0.5s
Paso 3634
  Set Location    21.1480389     -86.8246914
  Sleep    0.5s
Paso 3635
  Set Location    21.1480389     -86.8246914
  Sleep    0.5s
Paso 3636
  Set Location    21.1464772     -86.824579
  Sleep    0.5s
Paso 3637
  Set Location    21.1464772     -86.824579
  Sleep    0.5s
Paso 3638
  Set Location    21.1445329     -86.8245024
  Sleep    0.5s
Paso 3639
  Set Location    21.1445329     -86.8245024
  Sleep    0.5s
Paso 3640
  Set Location    21.142464     -86.8243547
  Sleep    0.5s
Paso 3641
  Set Location    21.142464     -86.8243547
  Sleep    0.5s
Paso 3642
  Set Location    21.1405427     -86.8250443
  Sleep    0.5s
Paso 3643
  Set Location    21.1405427     -86.8250443
  Sleep    0.5s
Paso 3644
  Set Location    21.1400083     -86.8253317
  Sleep    0.5s
Paso 3645
  Set Location    21.1400083     -86.8253317
  Sleep    0.5s
Paso 3646
  Set Location    21.1397579     -86.8255295
  Sleep    0.5s
Paso 3647
  Set Location    21.1397579     -86.8255295
  Sleep    0.5s
Paso 3648
  Set Location    21.1383104     -86.826133
  Sleep    0.5s
Paso 3649
  Set Location    21.1383104     -86.826133
  Sleep    0.5s
Paso 3650
  Set Location    21.1360777     -86.8272375
  Sleep    0.5s
Paso 3651
  Set Location    21.1360777     -86.8272375
  Sleep    0.5s
Paso 3652
  Set Location    21.1336445     -86.8284183
  Sleep    0.5s
Paso 3653
  Set Location    21.1336445     -86.8284183
  Sleep    0.5s
Paso 3654
  Set Location    21.131302     -86.8295527
  Sleep    0.5s
Paso 3655
  Set Location    21.131302     -86.8295527
  Sleep    0.5s
Paso 3656
  Set Location    21.1288667     -86.8307497
  Sleep    0.5s
Paso 3657
  Set Location    21.1288667     -86.8307497
  Sleep    0.5s
Paso 3658
  Set Location    21.1264301     -86.8319514
  Sleep    0.5s
Paso 3659
  Set Location    21.1264301     -86.8319514
  Sleep    0.5s
Paso 3660
  Set Location    21.123864     -86.8332006
  Sleep    0.5s
Paso 3661
  Set Location    21.123864     -86.8332006
  Sleep    0.5s
Paso 3662
  Set Location    21.1212802     -86.83447
  Sleep    0.5s
Paso 3663
  Set Location    21.1212802     -86.83447
  Sleep    0.5s
Paso 3664
  Set Location    21.1187928     -86.8356813
  Sleep    0.5s
Paso 3665
  Set Location    21.1187928     -86.8356813
  Sleep    0.5s
Paso 3666
  Set Location    21.1163055     -86.8369032
  Sleep    0.5s
Paso 3667
  Set Location    21.1163055     -86.8369032
  Sleep    0.5s
Paso 3668
  Set Location    21.1137534     -86.8381511
  Sleep    0.5s
Paso 3669
  Set Location    21.1137534     -86.8381511
  Sleep    0.5s
Paso 3670
  Set Location    21.1111002     -86.8390295
  Sleep    0.5s
Paso 3671
  Set Location    21.1111002     -86.8390295
  Sleep    0.5s
Paso 3672
  Set Location    21.1084268     -86.83945
  Sleep    0.5s
Paso 3673
  Set Location    21.1084268     -86.83945
  Sleep    0.5s
Paso 3674
  Set Location    21.1056733     -86.8399081
  Sleep    0.5s
Paso 3675
  Set Location    21.1056733     -86.8399081
  Sleep    0.5s
Paso 3676
  Set Location    21.1029947     -86.8403361
  Sleep    0.5s
Paso 3677
  Set Location    21.1029947     -86.8403361
  Sleep    0.5s
Paso 3678
  Set Location    21.1004182     -86.8407379
  Sleep    0.5s
Paso 3679
  Set Location    21.1004182     -86.8407379
  Sleep    0.5s
Paso 3680
  Set Location    21.0978134     -86.8411311
  Sleep    0.5s
Paso 3681
  Set Location    21.0978134     -86.8411311
  Sleep    0.5s
Paso 3682
  Set Location    21.0952465     -86.8415476
  Sleep    0.5s
Paso 3683
  Set Location    21.0952465     -86.8415476
  Sleep    0.5s
Paso 3684
  Set Location    21.0925404     -86.8419764
  Sleep    0.5s
Paso 3685
  Set Location    21.0925404     -86.8419764
  Sleep    0.5s
Paso 3686
  Set Location    21.0900014     -86.8422695
  Sleep    0.5s
Paso 3687
  Set Location    21.0900014     -86.8422695
  Sleep    0.5s
Paso 3688
  Set Location    21.0872684     -86.8426714
  Sleep    0.5s
Paso 3689
  Set Location    21.0872684     -86.8426714
  Sleep    0.5s
Paso 3690
  Set Location    21.0845692     -86.8431711
  Sleep    0.5s
Paso 3691
  Set Location    21.0845692     -86.8431711
  Sleep    0.5s
Paso 3692
  Set Location    21.0817981     -86.8436594
  Sleep    0.5s
Paso 3693
  Set Location    21.0817981     -86.8436594
  Sleep    0.5s
Paso 3694
  Set Location    21.078992     -86.844095
  Sleep    0.5s
Paso 3695
  Set Location    21.078992     -86.844095
  Sleep    0.5s
Paso 3696
  Set Location    21.0761618     -86.8445279
  Sleep    0.5s
Paso 3697
  Set Location    21.0761618     -86.8445279
  Sleep    0.5s
Paso 3698
  Set Location    21.0733292     -86.8449681
  Sleep    0.5s
Paso 3699
  Set Location    21.0733292     -86.8449681
  Sleep    0.5s
Paso 3700
  Set Location    21.0705479     -86.845401
  Sleep    0.5s
Paso 3701
  Set Location    21.0705479     -86.845401
  Sleep    0.5s
Paso 3702
  Set Location    21.0677849     -86.8458358
  Sleep    0.5s
Paso 3703
  Set Location    21.0677849     -86.8458358
  Sleep    0.5s
Paso 3704
  Set Location    21.0650358     -86.8462695
  Sleep    0.5s
Paso 3705
  Set Location    21.0650358     -86.8462695
  Sleep    0.5s
Paso 3706
  Set Location    21.0622774     -86.8467126
  Sleep    0.5s
Paso 3707
  Set Location    21.0622774     -86.8467126
  Sleep    0.5s
Paso 3708
  Set Location    21.0595331     -86.8471445
  Sleep    0.5s
Paso 3709
  Set Location    21.0595331     -86.8471445
  Sleep    0.5s
Paso 3710
  Set Location    21.0568182     -86.8475578
  Sleep    0.5s
Paso 3711
  Set Location    21.0568182     -86.8475578
  Sleep    0.5s
Paso 3712
  Set Location    21.0542302     -86.8479681
  Sleep    0.5s
Paso 3713
  Set Location    21.0542302     -86.8479681
  Sleep    0.5s
Paso 3714
  Set Location    21.0517384     -86.848353
  Sleep    0.5s
Paso 3715
  Set Location    21.0517384     -86.848353
  Sleep    0.5s
Paso 3716
  Set Location    21.0493417     -86.8487325
  Sleep    0.5s
Paso 3717
  Set Location    21.0493417     -86.8487325
  Sleep    0.5s
Paso 3718
  Set Location    21.0468574     -86.849084
  Sleep    0.5s
Paso 3719
  Set Location    21.0468574     -86.849084
  Sleep    0.5s
Paso 3720
  Set Location    21.0443149     -86.8495028
  Sleep    0.5s
Paso 3721
  Set Location    21.0443149     -86.8495028
  Sleep    0.5s
Paso 3722
  Set Location    21.0418396     -86.8499062
  Sleep    0.5s
Paso 3723
  Set Location    21.0418396     -86.8499062
  Sleep    0.5s
Paso 3724
  Set Location    21.0393206     -86.8503232
  Sleep    0.5s
Paso 3725
  Set Location    21.0393206     -86.8503232
  Sleep    0.5s
Paso 3726
  Set Location    21.0369481     -86.8509111
  Sleep    0.5s
Paso 3727
  Set Location    21.0369481     -86.8509111
  Sleep    0.5s
Paso 3728
  Set Location    21.0348963     -86.852102
  Sleep    0.5s
Paso 3729
  Set Location    21.0348963     -86.852102
  Sleep    0.5s
Paso 3730
  Set Location    21.0342501     -86.854665
  Sleep    0.5s
Paso 3731
  Set Location    21.0342501     -86.854665
  Sleep    0.5s
Paso 3732
  Set Location    21.0354581     -86.8570532
  Sleep    0.5s
Paso 3733
  Set Location    21.0354581     -86.8570532
  Sleep    0.5s
Paso 3734
  Set Location    21.0369759     -86.8593782
  Sleep    0.5s
Paso 3735
  Set Location    21.0369759     -86.8593782
  Sleep    0.5s
Paso 3736
  Set Location    21.0383934     -86.861737
  Sleep    0.5s
Paso 3737
  Set Location    21.0383934     -86.861737
  Sleep    0.5s
Paso 3738
  Set Location    21.0398096     -86.8640809
  Sleep    0.5s
Paso 3739
  Set Location    21.0398096     -86.8640809
  Sleep    0.5s
Paso 3740
  Set Location    21.0412276     -86.8662938
  Sleep    0.5s
Paso 3741
  Set Location    21.0412276     -86.8662938
  Sleep    0.5s
Paso 3742
  Set Location    21.0426239     -86.8685042
  Sleep    0.5s
Paso 3743
  Set Location    21.0426239     -86.8685042
  Sleep    0.5s
Paso 3744
  Set Location    21.0439127     -86.8706154
  Sleep    0.5s
Paso 3745
  Set Location    21.0439127     -86.8706154
  Sleep    0.5s
Paso 3746
  Set Location    21.0453082     -86.8727437
  Sleep    0.5s
Paso 3747
  Set Location    21.0453082     -86.8727437
  Sleep    0.5s
Paso 3748
  Set Location    21.0465232     -86.8747916
  Sleep    0.5s
Paso 3749
  Set Location    21.0465232     -86.8747916
  Sleep    0.5s
Paso 3750
  Set Location    21.0458067     -86.876496
  Sleep    0.5s
Paso 3751
  Set Location    21.0458067     -86.876496
  Sleep    0.5s
Paso 3752
  Set Location    21.0464563     -86.8781172
  Sleep    0.5s
Paso 3753
  Set Location    21.0464563     -86.8781172
  Sleep    0.5s
Paso 3754
  Set Location    21.0470135     -86.8790105
  Sleep    0.5s
Paso 3755
  Set Location    21.0470135     -86.8790105
  Sleep    0.5s
Paso 3756
  Set Location    21.0469749     -86.8796293
  Sleep    0.5s
Paso 3757
  Set Location    21.0469749     -86.8796293
  Sleep    0.5s
Paso 3758
  Set Location    21.0459794     -86.8803324
  Sleep    0.5s
Paso 3759
  Set Location    21.0459794     -86.8803324
  Sleep    0.5s
Paso 3760
  Set Location    21.0449507     -86.8809434
  Sleep    0.5s
Paso 3761
  Set Location    21.0449507     -86.8809434
  Sleep    0.5s
Paso 3762
  Set Location    21.0453336     -86.8802403
  Sleep    0.5s
Paso 3763
  Set Location    21.0453336     -86.8802403
  Sleep    0.5s
Paso 3764
  Set Location    21.0454517     -86.88018
  Sleep    0.5s
Paso 3765
  Set Location    21.0454517     -86.88018
  Sleep    0.5s
Paso 3766
  Set Location    21.045495     -86.8796228
  Sleep    0.5s
Paso 3767
  Set Location    21.045495     -86.8796228
  Sleep    0.5s
Paso 3768
  Set Location    21.0445531     -86.8780856
  Sleep    0.5s
Paso 3769
  Set Location    21.0445531     -86.8780856
  Sleep    0.5s
Paso 3770
  Set Location    21.0452291     -86.8766834
  Sleep    0.5s
Paso 3771
  Set Location    21.0452291     -86.8766834
  Sleep    0.5s
Paso 3772
  Set Location    21.0464712     -86.8751311
  Sleep    0.5s
Paso 3773
  Set Location    21.0464712     -86.8751311
  Sleep    0.5s
Paso 3774
  Set Location    21.0454632     -86.8732483
  Sleep    0.5s
Paso 3775
  Set Location    21.0454632     -86.8732483
  Sleep    0.5s
Paso 3776
  Set Location    21.0442655     -86.8720605
  Sleep    0.5s
Paso 3777
  Set Location    21.0442655     -86.8720605
  Sleep    0.5s
Paso 3778
  Set Location    21.0427341     -86.8731011
  Sleep    0.5s
Paso 3779
  Set Location    21.0427341     -86.8731011
  Sleep    0.5s
Paso 3780
  Set Location    21.0413092     -86.8741106
  Sleep    0.5s
Paso 3781
  Set Location    21.0413092     -86.8741106
  Sleep    0.5s
Paso 3782
  Set Location    21.040856     -86.8737414
  Sleep    0.5s
Paso 3783
  Set Location    21.040856     -86.8737414
  Sleep    0.5s
Paso 3784
  Set Location    21.0404816     -86.8731224
  Sleep    0.5s
Paso 3785
  Set Location    21.0404816     -86.8731224
  Sleep    0.5s
Paso 3786
  Set Location    21.0400484     -86.8724993
  Sleep    0.5s
Paso 3787
  Set Location    21.0400484     -86.8724993
  Sleep    0.5s
Paso 3788
  Set Location    21.0399162     -86.8721008
  Sleep    0.5s
Paso 3789
  Set Location    21.0399162     -86.8721008
  Sleep    0.5s
Paso 3790
  Set Location    21.0399183     -86.8720933
  Sleep    0.5s
Paso 3791
  Set Location    21.0399183     -86.8720933
  Sleep    0.5s
Paso 3792
  Set Location    21.039945     -86.8720383
  Sleep    0.5s
Paso 3793
  Set Location    21.039945     -86.8720383
  Sleep    0.5s
Paso 3794
  Set Location    21.0400344     -86.8720416
  Sleep    0.5s
Paso 3795
  Set Location    21.0400344     -86.8720416
  Sleep    0.5s
Paso 3796
  Set Location    21.0403695     -86.8713393
  Sleep    0.5s
Paso 3797
  Set Location    21.0403695     -86.8713393
  Sleep    0.5s
Paso 3798
  Set Location    21.0396443     -86.869942
  Sleep    0.5s
Paso 3799
  Set Location    21.0396443     -86.869942
  Sleep    0.5s
Paso 3800
  Set Location    21.0408051     -86.8688005
  Sleep    0.5s
Paso 3801
  Set Location    21.0408051     -86.8688005
  Sleep    0.5s
Paso 3802
  Set Location    21.0418913     -86.8675906
  Sleep    0.5s
Paso 3803
  Set Location    21.0418913     -86.8675906
  Sleep    0.5s
Paso 3804
  Set Location    21.0407969     -86.8657884
  Sleep    0.5s
Paso 3805
  Set Location    21.0407969     -86.8657884
  Sleep    0.5s
Paso 3806
  Set Location    21.0394275     -86.8636107
  Sleep    0.5s
Paso 3807
  Set Location    21.0394275     -86.8636107
  Sleep    0.5s
Paso 3808
  Set Location    21.0381795     -86.8615842
  Sleep    0.5s
Paso 3809
  Set Location    21.0381795     -86.8615842
  Sleep    0.5s
Paso 3810
  Set Location    21.0372189     -86.8600254
  Sleep    0.5s
Paso 3811
  Set Location    21.0372189     -86.8600254
  Sleep    0.5s
Paso 3812
  Set Location    21.0361322     -86.8582929
  Sleep    0.5s
Paso 3813
  Set Location    21.0361322     -86.8582929
  Sleep    0.5s
Paso 3814
  Set Location    21.0347872     -86.8561768
  Sleep    0.5s
Paso 3815
  Set Location    21.0347872     -86.8561768
  Sleep    0.5s
Paso 3816
  Set Location    21.0335774     -86.8539063
  Sleep    0.5s
Paso 3817
  Set Location    21.0335774     -86.8539063
  Sleep    0.5s
Paso 3818
  Set Location    21.0332155     -86.8518563
  Sleep    0.5s
Paso 3819
  Set Location    21.0332155     -86.8518563
  Sleep    0.5s
Paso 3820
  Set Location    21.0323684     -86.8510011
  Sleep    0.5s
Paso 3821
  Set Location    21.0323684     -86.8510011
  Sleep    0.5s
Paso 3822
  Set Location    21.0330929     -86.8518904
  Sleep    0.5s
Paso 3823
  Set Location    21.0330929     -86.8518904
  Sleep    0.5s
Paso 3824
  Set Location    21.0351512     -86.8514174
  Sleep    0.5s
Paso 3825
  Set Location    21.0351512     -86.8514174
  Sleep    0.5s
Paso 3826
  Set Location    21.0374659     -86.8505543
  Sleep    0.5s
Paso 3827
  Set Location    21.0374659     -86.8505543
  Sleep    0.5s
Paso 3828
  Set Location    21.0399295     -86.8500536
  Sleep    0.5s
Paso 3829
  Set Location    21.0399295     -86.8500536
  Sleep    0.5s
Paso 3830
  Set Location    21.0425191     -86.849657
  Sleep    0.5s
Paso 3831
  Set Location    21.0425191     -86.849657
  Sleep    0.5s
Paso 3832
  Set Location    21.0451997     -86.8492386
  Sleep    0.5s
Paso 3833
  Set Location    21.0451997     -86.8492386
  Sleep    0.5s
Paso 3834
  Set Location    21.0478683     -86.8488049
  Sleep    0.5s
Paso 3835
  Set Location    21.0478683     -86.8488049
  Sleep    0.5s
Paso 3836
  Set Location    21.0505449     -86.8484217
  Sleep    0.5s
Paso 3837
  Set Location    21.0505449     -86.8484217
  Sleep    0.5s
Paso 3838
  Set Location    21.0531825     -86.8480072
  Sleep    0.5s
Paso 3839
  Set Location    21.0531825     -86.8480072
  Sleep    0.5s
Paso 3840
  Set Location    21.0559457     -86.8475703
  Sleep    0.5s
Paso 3841
  Set Location    21.0559457     -86.8475703
  Sleep    0.5s
Paso 3842
  Set Location    21.0587552     -86.8471433
  Sleep    0.5s
Paso 3843
  Set Location    21.0587552     -86.8471433
  Sleep    0.5s
Paso 3844
  Set Location    21.061589     -86.8466955
  Sleep    0.5s
Paso 3845
  Set Location    21.061589     -86.8466955
  Sleep    0.5s
Paso 3846
  Set Location    21.0644063     -86.8462574
  Sleep    0.5s
Paso 3847
  Set Location    21.0644063     -86.8462574
  Sleep    0.5s
Paso 3848
  Set Location    21.0672464     -86.8458208
  Sleep    0.5s
Paso 3849
  Set Location    21.0672464     -86.8458208
  Sleep    0.5s
Paso 3850
  Set Location    21.0700435     -86.8453652
  Sleep    0.5s
Paso 3851
  Set Location    21.0700435     -86.8453652
  Sleep    0.5s
Paso 3852
  Set Location    21.0727849     -86.8449469
  Sleep    0.5s
Paso 3853
  Set Location    21.0727849     -86.8449469
  Sleep    0.5s
Paso 3854
  Set Location    21.0754797     -86.8445285
  Sleep    0.5s
Paso 3855
  Set Location    21.0754797     -86.8445285
  Sleep    0.5s
Paso 3856
  Set Location    21.078233     -86.8440951
  Sleep    0.5s
Paso 3857
  Set Location    21.078233     -86.8440951
  Sleep    0.5s
Paso 3858
  Set Location    21.0809884     -86.8436671
  Sleep    0.5s
Paso 3859
  Set Location    21.0809884     -86.8436671
  Sleep    0.5s
Paso 3860
  Set Location    21.0837118     -86.8432252
  Sleep    0.5s
Paso 3861
  Set Location    21.0837118     -86.8432252
  Sleep    0.5s
Paso 3862
  Set Location    21.0864046     -86.8427483
  Sleep    0.5s
Paso 3863
  Set Location    21.0864046     -86.8427483
  Sleep    0.5s
Paso 3864
  Set Location    21.0888547     -86.8423366
  Sleep    0.5s
Paso 3865
  Set Location    21.0888547     -86.8423366
  Sleep    0.5s
Paso 3866
  Set Location    21.0914498     -86.8420119
  Sleep    0.5s
Paso 3867
  Set Location    21.0914498     -86.8420119
  Sleep    0.5s
Paso 3868
  Set Location    21.0940973     -86.8416037
  Sleep    0.5s
Paso 3869
  Set Location    21.0940973     -86.8416037
  Sleep    0.5s
Paso 3870
  Set Location    21.0966599     -86.8411991
  Sleep    0.5s
Paso 3871
  Set Location    21.0966599     -86.8411991
  Sleep    0.5s
Paso 3872
  Set Location    21.0988419     -86.8408429
  Sleep    0.5s
Paso 3873
  Set Location    21.0988419     -86.8408429
  Sleep    0.5s
Paso 3874
  Set Location    21.1005254     -86.8405578
  Sleep    0.5s
Paso 3875
  Set Location    21.1005254     -86.8405578
  Sleep    0.5s
Paso 3876
  Set Location    21.1022369     -86.8402949
  Sleep    0.5s
Paso 3877
  Set Location    21.1022369     -86.8402949
  Sleep    0.5s
Paso 3878
  Set Location    21.1045396     -86.8399549
  Sleep    0.5s
Paso 3879
  Set Location    21.1045396     -86.8399549
  Sleep    0.5s
Paso 3880
  Set Location    21.1070276     -86.8395825
  Sleep    0.5s
Paso 3881
  Set Location    21.1070276     -86.8395825
  Sleep    0.5s
Paso 3882
  Set Location    21.1095868     -86.8391682
  Sleep    0.5s
Paso 3883
  Set Location    21.1095868     -86.8391682
  Sleep    0.5s
Paso 3884
  Set Location    21.1120578     -86.8387639
  Sleep    0.5s
Paso 3885
  Set Location    21.1120578     -86.8387639
  Sleep    0.5s
Paso 3886
  Set Location    21.1144133     -86.8377403
  Sleep    0.5s
Paso 3887
  Set Location    21.1144133     -86.8377403
  Sleep    0.5s
Paso 3888
  Set Location    21.1167765     -86.8365835
  Sleep    0.5s
Paso 3889
  Set Location    21.1167765     -86.8365835
  Sleep    0.5s
Paso 3890
  Set Location    21.1190382     -86.8354152
  Sleep    0.5s
Paso 3891
  Set Location    21.1190382     -86.8354152
  Sleep    0.5s
Paso 3892
  Set Location    21.1212797     -86.8343287
  Sleep    0.5s
Paso 3893
  Set Location    21.1212797     -86.8343287
  Sleep    0.5s
Paso 3894
  Set Location    21.1236503     -86.8331618
  Sleep    0.5s
Paso 3895
  Set Location    21.1236503     -86.8331618
  Sleep    0.5s
Paso 3896
  Set Location    21.12582     -86.8320948
  Sleep    0.5s
Paso 3897
  Set Location    21.12582     -86.8320948
  Sleep    0.5s
Paso 3898
  Set Location    21.1282219     -86.8309137
  Sleep    0.5s
Paso 3899
  Set Location    21.1282219     -86.8309137
  Sleep    0.5s
Paso 3900
  Set Location    21.1294446     -86.8300573
  Sleep    0.5s
Paso 3901
  Set Location    21.1294446     -86.8300573
  Sleep    0.5s
Paso 3902
  Set Location    21.1303088     -86.8293364
  Sleep    0.5s
Paso 3903
  Set Location    21.1303088     -86.8293364
  Sleep    0.5s
Paso 3904
  Set Location    21.1319423     -86.8290394
  Sleep    0.5s
Paso 3905
  Set Location    21.1319423     -86.8290394
  Sleep    0.5s
Paso 3906
  Set Location    21.1336852     -86.8282019
  Sleep    0.5s
Paso 3907
  Set Location    21.1336852     -86.8282019
  Sleep    0.5s
Paso 3908
  Set Location    21.1354161     -86.8274624
  Sleep    0.5s
Paso 3909
  Set Location    21.1354161     -86.8274624
  Sleep    0.5s
Paso 3910
  Set Location    21.1372227     -86.8265664
  Sleep    0.5s
Paso 3911
  Set Location    21.1372227     -86.8265664
  Sleep    0.5s
Paso 3912
  Set Location    21.1388516     -86.8257461
  Sleep    0.5s
Paso 3913
  Set Location    21.1388516     -86.8257461
  Sleep    0.5s
Paso 3914
  Set Location    21.1407365     -86.8248525
  Sleep    0.5s
Paso 3915
  Set Location    21.1407365     -86.8248525
  Sleep    0.5s
Paso 3916
  Set Location    21.1428733     -86.8242025
  Sleep    0.5s
Paso 3917
  Set Location    21.1428733     -86.8242025
  Sleep    0.5s
Paso 3918
  Set Location    21.1447665     -86.8243152
  Sleep    0.5s
Paso 3919
  Set Location    21.1447665     -86.8243152
  Sleep    0.5s
Paso 3920
  Set Location    21.1463751     -86.824482
  Sleep    0.5s
Paso 3921
  Set Location    21.1463751     -86.824482
  Sleep    0.5s
Paso 3922
  Set Location    21.1465967     -86.8244633
  Sleep    0.5s
Paso 3923
  Set Location    21.1465967     -86.8244633
  Sleep    0.5s
Paso 3924
  Set Location    21.1467453     -86.824488
  Sleep    0.5s
Paso 3925
  Set Location    21.1467453     -86.824488
  Sleep    0.5s
Paso 3926
  Set Location    21.1480022     -86.8246171
  Sleep    0.5s
Paso 3927
  Set Location    21.1480022     -86.8246171
  Sleep    0.5s
Paso 3928
  Set Location    21.1490827     -86.8246213
  Sleep    0.5s
Paso 3929
  Set Location    21.1490827     -86.8246213
  Sleep    0.5s
Paso 3930
  Set Location    21.149085     -86.824625
  Sleep    0.5s
Paso 3931
  Set Location    21.149085     -86.824625
  Sleep    0.5s
Paso 3932
  Set Location    21.1499244     -86.8246723
  Sleep    0.5s
Paso 3933
  Set Location    21.1499244     -86.8246723
  Sleep    0.5s
Paso 3934
  Set Location    21.151682     -86.8248818
  Sleep    0.5s
Paso 3935
  Set Location    21.151682     -86.8248818
  Sleep    0.5s
Paso 3936
  Set Location    21.1536586     -86.8250465
  Sleep    0.5s
Paso 3937
  Set Location    21.1536586     -86.8250465
  Sleep    0.5s
Paso 3938
  Set Location    21.1554439     -86.8251582
  Sleep    0.5s
Paso 3939
  Set Location    21.1554439     -86.8251582
  Sleep    0.5s
Paso 3940
  Set Location    21.1566095     -86.8251467
  Sleep    0.5s
Paso 3941
  Set Location    21.1566095     -86.8251467
  Sleep    0.5s
Paso 3942
  Set Location    21.1577447     -86.825363
  Sleep    0.5s
Paso 3943
  Set Location    21.1577447     -86.825363
  Sleep    0.5s
Paso 3944
  Set Location    21.158627     -86.8254535
  Sleep    0.5s
Paso 3945
  Set Location    21.158627     -86.8254535
  Sleep    0.5s
Paso 3946
  Set Location    21.1598582     -86.8255566
  Sleep    0.5s
Paso 3947
  Set Location    21.1598582     -86.8255566
  Sleep    0.5s
Paso 3948
  Set Location    21.161005     -86.8256334
  Sleep    0.5s
Paso 3949
  Set Location    21.161005     -86.8256334
  Sleep    0.5s
Paso 3950
  Set Location    21.1622726     -86.8257335
  Sleep    0.5s
Paso 3951
  Set Location    21.1622726     -86.8257335
  Sleep    0.5s
Paso 3952
  Set Location    21.1633867     -86.8254115
  Sleep    0.5s
Paso 3953
  Set Location    21.1633867     -86.8254115
  Sleep    0.5s
Paso 3954
  Set Location    21.1641725     -86.8259194
  Sleep    0.5s
Paso 3955
  Set Location    21.1641725     -86.8259194
  Sleep    0.5s
Paso 3956
  Set Location    21.1639831     -86.8266731
  Sleep    0.5s
Paso 3957
  Set Location    21.1639831     -86.8266731
  Sleep    0.5s
Paso 3958
  Set Location    21.1643637     -86.8263018
  Sleep    0.5s
Paso 3959
  Set Location    21.1643637     -86.8263018
  Sleep    0.5s
Paso 3960
  Set Location    21.1643783     -86.82629
  Sleep    0.5s
Paso 3961
  Set Location    21.1643783     -86.82629
  Sleep    0.5s
Paso 3962
  Set Location    21.1643183     -86.826185
  Sleep    0.5s
Paso 3963
  Set Location    21.1643183     -86.826185
  Sleep    0.5s
Paso 3964
  Set Location    21.1641696     -86.8262792
  Sleep    0.5s
Paso 3965
  Set Location    21.1641696     -86.8262792
  Sleep    0.5s
Paso 3966
  Set Location    21.1642033     -86.82623
  Sleep    0.5s
Paso 3967
  Set Location    21.1642033     -86.82623
  Sleep    0.5s
Paso 3968
  Set Location    21.1642723     -86.8262102
  Sleep    0.5s
Paso 3969
  Set Location    21.1642723     -86.8262102
  Sleep    0.5s
Paso 3970
  Set Location    21.1641212     -86.8261462
  Sleep    0.5s
Paso 3971
  Set Location    21.1641212     -86.8261462
  Sleep    0.5s
Paso 3972
  Set Location    21.1638436     -86.8264379
  Sleep    0.5s
Paso 3973
  Set Location    21.1638436     -86.8264379
  Sleep    0.5s
