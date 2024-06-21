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
    [Documentation]    Prueba ADO
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

Paso 0
    Set Location    21.1561848    -86.8563556
    Sleep    45s

Paso 1
    Set Location    21.1563223    -86.8562574
    Sleep    1s

Paso 2
    Set Location    21.1564556    -86.8560233
    Sleep    1s

Paso 3
    Set Location    21.1566098    -86.8556981
    Sleep    1s

Paso 4
    Set Location    21.1568422    -86.8552449
    Sleep    1s

Paso 5
    Set Location    21.157089    -86.8547129
    Sleep    1s

Paso 6
    Set Location    21.1573388    -86.8541807
    Sleep    1s

Paso 7
    Set Location    21.1575778    -86.8537029
    Sleep    1s

Paso 8
    Set Location    21.1577499    -86.8534448
    Sleep    1s

Paso 9
    Set Location    21.1578179    -86.8533262
    Sleep    1s

Paso 10
    Set Location    21.1579378    -86.8531229
    Sleep    1s

Paso 11
    Set Location    21.1580025    -86.8528399
    Sleep    1s

Paso 12
    Set Location    21.1579773    -86.8524343
    Sleep    1s

Paso 13
    Set Location    21.1579504    -86.851892
    Sleep    1s

Paso 14
    Set Location    21.157916    -86.8513315
    Sleep    1s

Paso 15
    Set Location    21.1579463    -86.8506293
    Sleep    1s

Paso 16
    Set Location    21.1584873    -86.8490411
    Sleep    1s

Paso 17
    Set Location    21.1585819    -86.8487915
    Sleep    1s

Paso 18
    Set Location    21.1587129    -86.8483633
    Sleep    1s

Paso 19
    Set Location    21.1588356    -86.8479612
    Sleep    1s

Paso 20
    Set Location    21.1589953    -86.847577
    Sleep    1s

Paso 21
    Set Location    21.1634514    -86.8416291
    Sleep    1s

Paso 22
    Set Location    21.1635228    -86.8413934
    Sleep    1s

Paso 23
    Set Location    21.1636846    -86.8410879
    Sleep    1s

Paso 24
    Set Location    21.1639307    -86.8406236
    Sleep    1s

Paso 25
    Set Location    21.1641186    -86.8401211
    Sleep    1s

Paso 26
    Set Location    21.164696    -86.838854
    Sleep    1s

Paso 27
    Set Location    21.1653298    -86.8377864
    Sleep    1s

Paso 28
    Set Location    21.1653906    -86.8376015
    Sleep    1s

Paso 29
    Set Location    21.1654667    -86.8373123
    Sleep    1s

Paso 30
    Set Location    21.1657042    -86.8369202
    Sleep    1s

Paso 31
    Set Location    21.1659516    -86.8364261
    Sleep    1s

Paso 32
    Set Location    21.1661002    -86.8358625
    Sleep    1s

Paso 33
    Set Location    21.1663797    -86.8353956
    Sleep    1s

Paso 34
    Set Location    21.1666483    -86.8350457
    Sleep    1s

Paso 35
    Set Location    21.1667595    -86.8348785
    Sleep    1s

Paso 36
    Set Location    21.1667932    -86.8347756
    Sleep    1s

Paso 37
    Set Location    21.1668212    -86.8347209
    Sleep    1s

Paso 38
    Set Location    21.1668198    -86.8347075
    Sleep    1s

Paso 39
    Set Location    21.1668064    -86.8346995
    Sleep    1s

Paso 40
    Set Location    21.1668057    -86.8346973
    Sleep    1s

Paso 41
    Set Location    21.1668062    -86.8346984
    Sleep    1s

Paso 42
    Set Location    21.1668029    -86.8347021
    Sleep    1s

Paso 43
    Set Location    21.1668037    -86.834701
    Sleep    1s

Paso 44
    Set Location    21.1668034    -86.834701
    Sleep    1s

Paso 45
    Set Location    21.1668032    -86.8347009
    Sleep    1s

Paso 46
    Set Location    21.1668028    -86.8347005
    Sleep    1s

Paso 47
    Set Location    21.1668022    -86.8346998
    Sleep    1s

Paso 48
    Set Location    21.1668076    -86.8346448
    Sleep    1s

Paso 49
    Set Location    21.1669554    -86.8344919
    Sleep    1s

Paso 50
    Set Location    21.1670815    -86.8342198
    Sleep    1s

Paso 51
    Set Location    21.167249    -86.833837
    Sleep    1s

Paso 52
    Set Location    21.1672988    -86.833407
    Sleep    1s

Paso 53
    Set Location    21.1671375    -86.8329291
    Sleep    1s

Paso 54
    Set Location    21.1668883    -86.8323788
    Sleep    1s

Paso 55
    Set Location    21.1666111    -86.8319439
    Sleep    1s

Paso 56
    Set Location    21.1664025    -86.8315267
    Sleep    1s

Paso 57
    Set Location    21.1662757    -86.8312854
    Sleep    1s

Paso 58
    Set Location    21.1662839    -86.831246
    Sleep    1s

Paso 59
    Set Location    21.1662312    -86.8312284
    Sleep    1s

Paso 60
    Set Location    21.1661584    -86.8310205
    Sleep    1s

Paso 61
    Set Location    21.1659831    -86.8307424
    Sleep    1s

Paso 62
    Set Location    21.165762    -86.8303608
    Sleep    1s

Paso 63
    Set Location    21.1655422    -86.829888
    Sleep    1s

Paso 64
    Set Location    21.1654058    -86.829557
    Sleep    1s

Paso 65
    Set Location    21.1653929    -86.8295782
    Sleep    1s

Paso 66
    Set Location    21.1653636    -86.8295644
    Sleep    1s

Paso 67
    Set Location    21.1652583    -86.8293856
    Sleep    1s

Paso 68
    Set Location    21.1651128    -86.8290761
    Sleep    1s

Paso 69
    Set Location    21.164896    -86.8287264
    Sleep    1s

Paso 70
    Set Location    21.1646987    -86.8283625
    Sleep    1s

Paso 71
    Set Location    21.1644912    -86.8279728
    Sleep    1s

Paso 72
    Set Location    21.164354    -86.8276535
    Sleep    1s

Paso 73
    Set Location    21.1642373    -86.8274643
    Sleep    1s

Paso 74
    Set Location    21.1642126    -86.8274094
    Sleep    1s

Paso 75
    Set Location    21.164226    -86.8273946
    Sleep    1s

Paso 76
    Set Location    21.1642105    -86.827377
    Sleep    1s

Paso 77
    Set Location    21.1641109    -86.8271949
    Sleep    1s

Paso 78
    Set Location    21.1639757    -86.8269274
    Sleep    1s

Paso 79
    Set Location    21.1638022    -86.8266304
    Sleep    1s

Paso 80
    Set Location    21.1635604    -86.8263835
    Sleep    1s

Paso 81
    Set Location    21.1634198    -86.8261905
    Sleep    1s

Paso 82
    Set Location    21.1631495    -86.8259669
    Sleep    1s

Paso 83
    Set Location    21.16391    -86.8254393
    Sleep    1s

Paso 84
    Set Location    21.1641939    -86.8256954
    Sleep    1s

Paso 85
    Set Location    21.1641155    -86.8260545
    Sleep    1s

Paso 86
    Set Location    21.1638842    -86.8263577
    Sleep    1s

Paso 87
    Set Location    21.1638965    -86.8266207
    Sleep    1s

Paso 88
    Set Location    21.1639525    -86.8267094
    Sleep    1s

Paso 89
    Set Location    21.1639948    -86.8267256
    Sleep    1s

Paso 90
    Set Location    21.1640054    -86.8267188
    Sleep    1s

Paso 91
    Set Location    21.164017    -86.8267216
    Sleep    1s

Paso 92
    Set Location    21.1641368    -86.8265599
    Sleep    1s

Paso 93
    Set Location    21.1641944    -86.8264879
    Sleep    1s

Paso 94
    Set Location    21.1642457    -86.8263726
    Sleep    1s

Paso 95
    Set Location    21.1642516    -86.8263555
    Sleep    1s

Paso 96
    Set Location    21.164234    -86.8263619
    Sleep    1s

Paso 97
    Set Location    21.1642461    -86.8263386
    Sleep    1s

Paso 98
    Set Location    21.1642505    -86.8263427
    Sleep    1s

Paso 99
    Set Location    21.1643214    -86.8263046
    Sleep    1s

Paso 100
    Set Location    21.1644003    -86.826298
    Sleep    1s

Paso 101
    Set Location    21.164384    -86.8263077
    Sleep    1s

Paso 102
    Set Location    21.1643743    -86.826316
    Sleep    1s

Paso 103
    Set Location    21.1643672    -86.8263223
    Sleep    1s

Paso 104
    Set Location    21.1644019    -86.8263362
    Sleep    1s

Paso 105
    Set Location    21.1644112    -86.8263372
    Sleep    1s

Paso 106
    Set Location    21.1644161    -86.8263385
    Sleep    1s

Paso 107
    Set Location    21.1644185    -86.826339
    Sleep    1s

Paso 108
    Set Location    21.1644191    -86.8263389
    Sleep    1s

Paso 109
    Set Location    21.1644187    -86.8263376
    Sleep    1s

Paso 110
    Set Location    21.1644181    -86.8263359
    Sleep    1s

Paso 111
    Set Location    21.1644153    -86.8263311
    Sleep    1s

Paso 112
    Set Location    21.1644136    -86.8263287
    Sleep    1s

Paso 113
    Set Location    21.1644133    -86.8263285
    Sleep    1s

Paso 114
    Set Location    21.1644129    -86.826328
    Sleep    1s

Paso 115
    Set Location    21.1644118    -86.826326
    Sleep    1s

Paso 116
    Set Location    21.1644108    -86.8263242
    Sleep    1s

Paso 117
    Set Location    21.1644103    -86.8263236
    Sleep    1s

Paso 118
    Set Location    21.1644102    -86.8263236
    Sleep    1s

Paso 119
    Set Location    21.1644102    -86.8263231
    Sleep    1s

Paso 120
    Set Location    21.1644102    -86.8263228
    Sleep    1s

Paso 121
    Set Location    21.1644103    -86.8263229
    Sleep    1s

Paso 122
    Set Location    21.1644104    -86.826323
    Sleep    1s

Paso 123
    Set Location    21.1644104    -86.8263231
    Sleep    1s

Paso 124
    Set Location    21.1644104    -86.8263232
    Sleep    1s

Paso 125
    Set Location    21.1644106    -86.8263231
    Sleep    1s

Paso 126
    Set Location    21.1644107    -86.8263231
    Sleep    1s

Paso 127
    Set Location    21.1644109    -86.8263228
    Sleep    1s

Paso 128
    Set Location    21.164411    -86.8263231
    Sleep    1s

Paso 129
    Set Location    21.1642965    -86.8262908
    Sleep    1s

Paso 130
    Set Location    21.1642744    -86.826259
    Sleep    1s

Paso 131
    Set Location    21.1642801    -86.826223
    Sleep    1s

Paso 132
    Set Location    21.1642863    -86.826213
    Sleep    1s

Paso 133
    Set Location    21.1642809    -86.8262025
    Sleep    1s

Paso 134
    Set Location    21.1642765    -86.8261947
    Sleep    1s

Paso 135
    Set Location    21.1642779    -86.8261954
    Sleep    1s

Paso 136
    Set Location    21.1642795    -86.8261964
    Sleep    1s

Paso 137
    Set Location    21.1642566    -86.8261639
    Sleep    1s

Paso 138
    Set Location    21.1641867    -86.826109
    Sleep    1s

Paso 139
    Set Location    21.1641049    -86.8260792
    Sleep    1s

Paso 140
    Set Location    21.1639887    -86.8261195
    Sleep    1s

Paso 141
    Set Location    21.1637387    -86.8262775
    Sleep    1s

Paso 142
    Set Location    21.1633602    -86.8261604
    Sleep    1s

Paso 143
    Set Location    21.1629658    -86.8259786
    Sleep    1s

Paso 144
    Set Location    21.1625847    -86.8258399
    Sleep    1s

Paso 145
    Set Location    21.1621066    -86.8258222
    Sleep    1s

Paso 146
    Set Location    21.1616398    -86.8257571
    Sleep    1s

Paso 147
    Set Location    21.1613319    -86.8257382
    Sleep    1s

Paso 148
    Set Location    21.1609461    -86.8257207
    Sleep    1s

Paso 149
    Set Location    21.1604958    -86.8256857
    Sleep    1s

Paso 150
    Set Location    21.1600899    -86.8256341
    Sleep    1s

Paso 151
    Set Location    21.1598202    -86.8256154
    Sleep    1s

Paso 152
    Set Location    21.1595797    -86.8256258
    Sleep    1s

Paso 153
    Set Location    21.159334    -86.8255787
    Sleep    1s

Paso 154
    Set Location    21.1589852    -86.8255604
    Sleep    1s

Paso 155
    Set Location    21.158777    -86.8255459
    Sleep    1s

Paso 156
    Set Location    21.1586646    -86.8255009
    Sleep    1s

Paso 157
    Set Location    21.1585273    -86.8254997
    Sleep    1s

Paso 158
    Set Location    21.1577794    -86.8255125
    Sleep    1s

Paso 159
    Set Location    21.1577349    -86.8255079
    Sleep    1s

Paso 160
    Set Location    21.1576768    -86.8255213
    Sleep    1s

Paso 161
    Set Location    21.1576218    -86.8255046
    Sleep    1s

Paso 162
    Set Location    21.1576223    -86.8254917
    Sleep    1s

Paso 163
    Set Location    21.1576233    -86.8254944
    Sleep    1s

Paso 164
    Set Location    21.1576256    -86.8254987
    Sleep    1s

Paso 165
    Set Location    21.1576262    -86.825508
    Sleep    1s

Paso 166
    Set Location    21.1576274    -86.8255102
    Sleep    1s

Paso 167
    Set Location    21.1576269    -86.8255104
    Sleep    1s

Paso 168
    Set Location    21.1576271    -86.8255099
    Sleep    1s

Paso 169
    Set Location    21.1576272    -86.8255095
    Sleep    1s

Paso 170
    Set Location    21.157627    -86.8255093
    Sleep    1s

Paso 171
    Set Location    21.1576271    -86.8255087
    Sleep    1s

Paso 172
    Set Location    21.1576272    -86.8255085
    Sleep    1s

Paso 173
    Set Location    21.157627    -86.8255083
    Sleep    1s

Paso 174
    Set Location    21.1575559    -86.8255293
    Sleep    1s

Paso 175
    Set Location    21.1573215    -86.8255636
    Sleep    1s

Paso 176
    Set Location    21.1569604    -86.8255767
    Sleep    1s

Paso 177
    Set Location    21.1565514    -86.8255327
    Sleep    1s

Paso 178
    Set Location    21.156096    -86.8253633
    Sleep    1s

Paso 179
    Set Location    21.1555662    -86.8253053
    Sleep    1s

Paso 180
    Set Location    21.1549803    -86.8252582
    Sleep    1s

Paso 181
    Set Location    21.1529908    -86.8250917
    Sleep    1s

Paso 182
    Set Location    21.1522828    -86.8250587
    Sleep    1s

Paso 183
    Set Location    21.1515558    -86.825004
    Sleep    1s

Paso 184
    Set Location    21.1508157    -86.8249323
    Sleep    1s

Paso 185
    Set Location    21.1502212    -86.8249314
    Sleep    1s

Paso 186
    Set Location    21.1497337    -86.8249071
    Sleep    1s

Paso 187
    Set Location    21.1494102    -86.8248713
    Sleep    1s

Paso 188
    Set Location    21.1493802    -86.8249093
    Sleep    1s

Paso 189
    Set Location    21.1493867    -86.8249047
    Sleep    1s

Paso 190
    Set Location    21.1493926    -86.8249091
    Sleep    1s

Paso 191
    Set Location    21.1493941    -86.8249003
    Sleep    1s

Paso 192
    Set Location    21.1493923    -86.8249025
    Sleep    1s

Paso 193
    Set Location    21.1493897    -86.8248992
    Sleep    1s

Paso 194
    Set Location    21.1493892    -86.8248949
    Sleep    1s

Paso 195
    Set Location    21.1493708    -86.8248901
    Sleep    1s

Paso 196
    Set Location    21.1492532    -86.824862
    Sleep    1s

Paso 197
    Set Location    21.1489529    -86.8248211
    Sleep    1s

Paso 198
    Set Location    21.1485247    -86.8247674
    Sleep    1s

Paso 199
    Set Location    21.1479644    -86.8247167
    Sleep    1s

Paso 200
    Set Location    21.1473451    -86.8246552
    Sleep    1s

Paso 201
    Set Location    21.1466403    -86.824601
    Sleep    1s

Paso 202
    Set Location    21.1459931    -86.8245684
    Sleep    1s

Paso 203
    Set Location    21.1455329    -86.8245265
    Sleep    1s

Paso 204
    Set Location    21.1451014    -86.8245632
    Sleep    1s

Paso 205
    Set Location    21.1446621    -86.8245258
    Sleep    1s

Paso 206
    Set Location    21.1441628    -86.824466
    Sleep    1s

Paso 207
    Set Location    21.1435698    -86.8244571
    Sleep    1s

Paso 208
    Set Location    21.142921    -86.8244087
    Sleep    1s

Paso 209
    Set Location    21.1422222    -86.8244499
    Sleep    1s

Paso 210
    Set Location    21.1415429    -86.824631
    Sleep    1s

Paso 211
    Set Location    21.1408447    -86.8249267
    Sleep    1s

Paso 212
    Set Location    21.1402932    -86.8252351
    Sleep    1s

Paso 213
    Set Location    21.140082    -86.8253649
    Sleep    1s

Paso 214
    Set Location    21.1401047    -86.8254078
    Sleep    1s

Paso 215
    Set Location    21.1401025    -86.8253637
    Sleep    1s

Paso 216
    Set Location    21.1400854    -86.8253686
    Sleep    1s

Paso 217
    Set Location    21.1400843    -86.8253677
    Sleep    1s

Paso 218
    Set Location    21.1400942    -86.8253687
    Sleep    1s

Paso 219
    Set Location    21.1400953    -86.8253816
    Sleep    1s

Paso 220
    Set Location    21.1400985    -86.8253805
    Sleep    1s

Paso 221
    Set Location    21.1400964    -86.8253807
    Sleep    1s

Paso 222
    Set Location    21.1398507    -86.8255981
    Sleep    1s

Paso 223
    Set Location    21.1394971    -86.8257819
    Sleep    1s

Paso 224
    Set Location    21.1390003    -86.8259824
    Sleep    1s

Paso 225
    Set Location    21.1384901    -86.8261595
    Sleep    1s

Paso 226
    Set Location    21.1379195    -86.8264175
    Sleep    1s

Paso 227
    Set Location    21.1372764    -86.8267216
    Sleep    1s

Paso 228
    Set Location    21.1365582    -86.8270743
    Sleep    1s

Paso 229
    Set Location    21.1358056    -86.8274389
    Sleep    1s

Paso 230
    Set Location    21.1350773    -86.8278182
    Sleep    1s

Paso 231
    Set Location    21.1342638    -86.8282035
    Sleep    1s

Paso 232
    Set Location    21.1334329    -86.8285963
    Sleep    1s

Paso 233
    Set Location    21.1326161    -86.8290103
    Sleep    1s

Paso 234
    Set Location    21.1318909    -86.8293527
    Sleep    1s

Paso 235
    Set Location    21.131118    -86.829713
    Sleep    1s

Paso 236
    Set Location    21.1303258    -86.8300648
    Sleep    1s

Paso 237
    Set Location    21.1293563    -86.8305558
    Sleep    1s

Paso 238
    Set Location    21.1286753    -86.8308909
    Sleep    1s

Paso 239
    Set Location    21.1258821    -86.832276
    Sleep    1s

Paso 240
    Set Location    21.1250624    -86.8326794
    Sleep    1s

Paso 241
    Set Location    21.1243812    -86.8329635
    Sleep    1s

Paso 242
    Set Location    21.1237711    -86.8332607
    Sleep    1s

Paso 243
    Set Location    21.123195    -86.8335385
    Sleep    1s

Paso 244
    Set Location    21.1226866    -86.8338432
    Sleep    1s

Paso 245
    Set Location    21.1221941    -86.834034
    Sleep    1s

Paso 246
    Set Location    21.1218896    -86.834221
    Sleep    1s

Paso 247
    Set Location    21.1217195    -86.8342913
    Sleep    1s

Paso 248
    Set Location    21.1217205    -86.8342963
    Sleep    1s

Paso 249
    Set Location    21.1217233    -86.8342892
    Sleep    1s

Paso 250
    Set Location    21.1217345    -86.8342842
    Sleep    1s

Paso 251
    Set Location    21.1217353    -86.8342802
    Sleep    1s

Paso 252
    Set Location    21.1216794    -86.8343081
    Sleep    1s

Paso 253
    Set Location    21.1214457    -86.8344125
    Sleep    1s

Paso 254
    Set Location    21.1210604    -86.8346071
    Sleep    1s

Paso 255
    Set Location    21.1205907    -86.8348397
    Sleep    1s

Paso 256
    Set Location    21.1200065    -86.835114
    Sleep    1s

Paso 257
    Set Location    21.1192767    -86.8354806
    Sleep    1s

Paso 258
    Set Location    21.1184987    -86.8358612
    Sleep    1s

Paso 259
    Set Location    21.1177057    -86.8362605
    Sleep    1s

Paso 260
    Set Location    21.1168807    -86.8366438
    Sleep    1s

Paso 261
    Set Location    21.1160448    -86.8370454
    Sleep    1s

Paso 262
    Set Location    21.1152149    -86.8374829
    Sleep    1s

Paso 263
    Set Location    21.114339    -86.8378874
    Sleep    1s

Paso 264
    Set Location    21.1134526    -86.8383216
    Sleep    1s

Paso 265
    Set Location    21.112548    -86.8387573
    Sleep    1s

Paso 266
    Set Location    21.1116413    -86.8390236
    Sleep    1s

Paso 267
    Set Location    21.110718    -86.8391567
    Sleep    1s

Paso 268
    Set Location    21.1097762    -86.8392895
    Sleep    1s

Paso 269
    Set Location    21.1088331    -86.8394536
    Sleep    1s

Paso 270
    Set Location    21.1078779    -86.8395698
    Sleep    1s

Paso 271
    Set Location    21.1069451    -86.839711
    Sleep    1s

Paso 272
    Set Location    21.1060197    -86.8398341
    Sleep    1s

Paso 273
    Set Location    21.1051567    -86.8399831
    Sleep    1s

Paso 274
    Set Location    21.1043376    -86.8401119
    Sleep    1s

Paso 275
    Set Location    21.1036752    -86.8402168
    Sleep    1s

Paso 276
    Set Location    21.1031078    -86.8403356
    Sleep    1s

Paso 277
    Set Location    21.1025623    -86.8404146
    Sleep    1s

Paso 278
    Set Location    21.1020936    -86.8404927
    Sleep    1s

Paso 279
    Set Location    21.1015961    -86.8405886
    Sleep    1s

Paso 280
    Set Location    21.1010411    -86.8406548
    Sleep    1s

Paso 281
    Set Location    21.100409    -86.8407344
    Sleep    1s

Paso 282
    Set Location    21.0996284    -86.8408373
    Sleep    1s

Paso 283
    Set Location    21.0989039    -86.8409258
    Sleep    1s

Paso 284
    Set Location    21.0981922    -86.8410638
    Sleep    1s

Paso 285
    Set Location    21.0974216    -86.8411588
    Sleep    1s

Paso 286
    Set Location    21.0966006    -86.8413122
    Sleep    1s

Paso 287
    Set Location    21.0957594    -86.8414434
    Sleep    1s

Paso 288
    Set Location    21.0949178    -86.8416185
    Sleep    1s

Paso 289
    Set Location    21.0940593    -86.8417609
    Sleep    1s

Paso 290
    Set Location    21.0931364    -86.8418577
    Sleep    1s

Paso 291
    Set Location    21.0921897    -86.8420199
    Sleep    1s

Paso 292
    Set Location    21.0912367    -86.8421178
    Sleep    1s

Paso 293
    Set Location    21.0902688    -86.8422401
    Sleep    1s

Paso 294
    Set Location    21.0893337    -86.8423556
    Sleep    1s

Paso 295
    Set Location    21.0883152    -86.8425191
    Sleep    1s

Paso 296
    Set Location    21.0873017    -86.8426661
    Sleep    1s

Paso 297
    Set Location    21.0861002    -86.8428813
    Sleep    1s

Paso 298
    Set Location    21.0824058    -86.8435408
    Sleep    1s

Paso 299
    Set Location    21.0813868    -86.8437039
    Sleep    1s

Paso 300
    Set Location    21.0803988    -86.8438712
    Sleep    1s

Paso 301
    Set Location    21.0793946    -86.8440072
    Sleep    1s

Paso 302
    Set Location    21.0784071    -86.8441616
    Sleep    1s

Paso 303
    Set Location    21.0773933    -86.8443181
    Sleep    1s

Paso 304
    Set Location    21.0763689    -86.8444803
    Sleep    1s

Paso 305
    Set Location    21.0732585    -86.8449678
    Sleep    1s

Paso 306
    Set Location    21.0721968    -86.8451105
    Sleep    1s

Paso 307
    Set Location    21.071176    -86.8452841
    Sleep    1s

Paso 308
    Set Location    21.0701293    -86.8454481
    Sleep    1s

Paso 309
    Set Location    21.0690937    -86.8456128
    Sleep    1s

Paso 310
    Set Location    21.0680642    -86.8457893
    Sleep    1s

Paso 311
    Set Location    21.0670351    -86.8459066
    Sleep    1s

Paso 312
    Set Location    21.0660291    -86.8460761
    Sleep    1s

Paso 313
    Set Location    21.0649856    -86.846243
    Sleep    1s

Paso 314
    Set Location    21.0639523    -86.8464202
    Sleep    1s

Paso 315
    Set Location    21.0629342    -86.8465712
    Sleep    1s

Paso 316
    Set Location    21.0619337    -86.8467112
    Sleep    1s

Paso 317
    Set Location    21.0609201    -86.8468951
    Sleep    1s

Paso 318
    Set Location    21.0598995    -86.8470259
    Sleep    1s

Paso 319
    Set Location    21.0589144    -86.8471914
    Sleep    1s

Paso 320
    Set Location    21.0578864    -86.847359
    Sleep    1s

Paso 321
    Set Location    21.0568608    -86.8475306
    Sleep    1s

Paso 322
    Set Location    21.0559359    -86.8476645
    Sleep    1s

Paso 323
    Set Location    21.0550482    -86.8477992
    Sleep    1s

Paso 324
    Set Location    21.0541329    -86.8479445
    Sleep    1s

Paso 325
    Set Location    21.0532109    -86.8481136
    Sleep    1s

Paso 326
    Set Location    21.0523804    -86.8482522
    Sleep    1s

Paso 327
    Set Location    21.0515708    -86.8483913
    Sleep    1s

Paso 328
    Set Location    21.048188    -86.8488838
    Sleep    1s

Paso 329
    Set Location    21.0473318    -86.8489918
    Sleep    1s

Paso 330
    Set Location    21.0464746    -86.8491577
    Sleep    1s

Paso 331
    Set Location    21.0456195    -86.8492976
    Sleep    1s

Paso 332
    Set Location    21.0447713    -86.8494343
    Sleep    1s

Paso 333
    Set Location    21.0439214    -86.8495821
    Sleep    1s

Paso 334
    Set Location    21.0431262    -86.8497108
    Sleep    1s

Paso 335
    Set Location    21.0422518    -86.8498371
    Sleep    1s

Paso 336
    Set Location    21.0414196    -86.849959
    Sleep    1s

Paso 337
    Set Location    21.0405318    -86.8501256
    Sleep    1s

Paso 338
    Set Location    21.039597    -86.8502522
    Sleep    1s

Paso 339
    Set Location    21.0387154    -86.8504113
    Sleep    1s

Paso 340
    Set Location    21.0377596    -86.8506161
    Sleep    1s

Paso 341
    Set Location    21.0369029    -86.8509552
    Sleep    1s

Paso 342
    Set Location    21.0361175    -86.8512794
    Sleep    1s

Paso 343
    Set Location    21.0353597    -86.8516565
    Sleep    1s

Paso 344
    Set Location    21.0347253    -86.8522656
    Sleep    1s

Paso 345
    Set Location    21.0343662    -86.8531246
    Sleep    1s

Paso 346
    Set Location    21.0342091    -86.8540498
    Sleep    1s

Paso 347
    Set Location    21.0343456    -86.8550254
    Sleep    1s

Paso 348
    Set Location    21.0347141    -86.855859
    Sleep    1s

Paso 349
    Set Location    21.0351705    -86.8566502
    Sleep    1s

Paso 350
    Set Location    21.0363714    -86.8584622
    Sleep    1s

Paso 351
    Set Location    21.0364765    -86.8586772
    Sleep    1s

Paso 352
    Set Location    21.0365337    -86.8587341
    Sleep    1s

Paso 353
    Set Location    21.0365217    -86.8587682
    Sleep    1s

Paso 354
    Set Location    21.036524    -86.8587501
    Sleep    1s

Paso 355
    Set Location    21.0365876    -86.8588259
    Sleep    1s

Paso 356
    Set Location    21.0375616    -86.8603726
    Sleep    1s

Paso 357
    Set Location    21.0379444    -86.8609679
    Sleep    1s

Paso 358
    Set Location    21.0384159    -86.8618319
    Sleep    1s

Paso 359
    Set Location    21.0397962    -86.8640408
    Sleep    1s

Paso 360
    Set Location    21.0411639    -86.8661942
    Sleep    1s

Paso 361
    Set Location    21.0415937    -86.866947
    Sleep    1s

Paso 362
    Set Location    21.0421027    -86.8677466
    Sleep    1s

Paso 363
    Set Location    21.042698    -86.8686618
    Sleep    1s

Paso 364
    Set Location    21.0431854    -86.8694343
    Sleep    1s

Paso 365
    Set Location    21.0449712    -86.8721953
    Sleep    1s

Paso 366
    Set Location    21.0453867    -86.8729538
    Sleep    1s

Paso 367
    Set Location    21.0458228    -86.8736232
    Sleep    1s

Paso 368
    Set Location    21.046217    -86.8743092
    Sleep    1s

Paso 369
    Set Location    21.0466103    -86.8751465
    Sleep    1s

Paso 370
    Set Location    21.0459175    -86.8773632
    Sleep    1s

Paso 371
    Set Location    21.0469724    -86.8790192
    Sleep    1s

Paso 372
    Set Location    21.0470085    -86.8790682
    Sleep    1s

Paso 373
    Set Location    21.047079    -86.8792389
    Sleep    1s

Paso 374
    Set Location    21.0471072    -86.8795133
    Sleep    1s

Paso 375
    Set Location    21.0468216    -86.8797596
    Sleep    1s

Paso 376
    Set Location    21.0465159    -86.8799989
    Sleep    1s

Paso 377
    Set Location    21.0464992    -86.880028
    Sleep    1s

Paso 378
    Set Location    21.0465102    -86.8800176
    Sleep    1s

Paso 379
    Set Location    21.0464994    -86.8800041
    Sleep    1s

Paso 380
    Set Location    21.0463753    -86.8801232
    Sleep    1s

Paso 381
    Set Location    21.0461998    -86.8802771
    Sleep    1s

Paso 382
    Set Location    21.0461619    -86.8803196
    Sleep    1s

Paso 383
    Set Location    21.0456373    -86.8806399
    Sleep    1s

Paso 384
    Set Location    21.0453013    -86.8808401
    Sleep    1s

Paso 385
    Set Location    21.045376    -86.8802084
    Sleep    1s

Paso 386
    Set Location    21.0453537    -86.8802231
    Sleep    1s

Paso 387
    Set Location    21.0453369    -86.8802486
    Sleep    1s

Paso 388
    Set Location    21.0453363    -86.8802524
    Sleep    1s

Paso 389
    Set Location    21.0455532    -86.8797774
    Sleep    1s

Paso 390
    Set Location    21.0452852    -86.8793409
    Sleep    1s

Paso 391
    Set Location    21.0450122    -86.8788992
    Sleep    1s

Paso 392
    Set Location    21.0447464    -86.878417
    Sleep    1s

Paso 393
    Set Location    21.044432    -86.8779372
    Sleep    1s

Paso 394
    Set Location    21.0443361    -86.8774557
    Sleep    1s

Paso 395
    Set Location    21.0447887    -86.8769942
    Sleep    1s

Paso 396
    Set Location    21.0462851    -86.8757324
    Sleep    1s

Paso 397
    Set Location    21.0464091    -86.8750324
    Sleep    1s

Paso 398
    Set Location    21.0461114    -86.874341
    Sleep    1s

Paso 399
    Set Location    21.045674    -86.8736243
    Sleep    1s

Paso 400
    Set Location    21.0452403    -86.8729689
    Sleep    1s

Paso 401
    Set Location    21.0448595    -86.8723535
    Sleep    1s

Paso 402
    Set Location    21.044448    -86.8720362
    Sleep    1s

Paso 403
    Set Location    21.0440535    -86.8721639
    Sleep    1s

Paso 404
    Set Location    21.0436079    -86.8725369
    Sleep    1s

Paso 405
    Set Location    21.0430861    -86.8728858
    Sleep    1s

Paso 406
    Set Location    21.0425991    -86.8732277
    Sleep    1s

Paso 407
    Set Location    21.0413255    -86.8740896
    Sleep    1s

Paso 408
    Set Location    21.0410471    -86.8741334
    Sleep    1s

Paso 409
    Set Location    21.0409422    -86.8739777
    Sleep    1s

Paso 410
    Set Location    21.0408675    -86.8737779
    Sleep    1s

Paso 411
    Set Location    21.0407533    -86.8735818
    Sleep    1s

Paso 412
    Set Location    21.0404259    -86.8730355
    Sleep    1s

Paso 413
    Set Location    21.0404137    -86.8730163
    Sleep    1s

Paso 414
    Set Location    21.0403256    -86.8728799
    Sleep    1s

Paso 415
    Set Location    21.0402157    -86.872674
    Sleep    1s

Paso 416
    Set Location    21.0400655    -86.8725018
    Sleep    1s

Paso 417
    Set Location    21.0397349    -86.8722763
    Sleep    1s

Paso 418
    Set Location    21.0397271    -86.8722805
    Sleep    1s

Paso 419
    Set Location    21.039725    -86.8722803
    Sleep    1s

Paso 420
    Set Location    21.039729    -86.8722857
    Sleep    1s

Paso 421
    Set Location    21.0397289    -86.8722907
    Sleep    1s

Paso 422
    Set Location    21.0397274    -86.8722934
    Sleep    1s

Paso 423
    Set Location    21.0397273    -86.8722935
    Sleep    1s

Paso 424
    Set Location    21.0397269    -86.8722941
    Sleep    1s

Paso 425
    Set Location    21.0397267    -86.8723019
    Sleep    1s

Paso 426
    Set Location    21.0396052    -86.8723994
    Sleep    1s

Paso 427
    Set Location    21.039423    -86.8725681
    Sleep    1s

Paso 428
    Set Location    21.0391045    -86.8727489
    Sleep    1s

Paso 429
    Set Location    21.0391381    -86.8727452
    Sleep    1s

Paso 430
    Set Location    21.0391728    -86.8727276
    Sleep    1s

Paso 431
    Set Location    21.0391809    -86.8726737
    Sleep    1s

Paso 432
    Set Location    21.0391878    -86.8726765
    Sleep    1s

Paso 433
    Set Location    21.0392006    -86.8726796
    Sleep    1s

Paso 434
    Set Location    21.0392103    -86.8726831
    Sleep    1s

Paso 435
    Set Location    21.039209    -86.8726816
    Sleep    1s

Paso 436
    Set Location    21.0392086    -86.8726808
    Sleep    1s

Paso 437
    Set Location    21.0392075    -86.8726803
    Sleep    1s

Paso 438
    Set Location    21.0392074    -86.8726801
    Sleep    1s

Paso 439
    Set Location    21.0392074    -86.8726799
    Sleep    1s

Paso 440
    Set Location    21.0392073    -86.8726797
    Sleep    1s

Paso 441
    Set Location    21.0392072    -86.8726795
    Sleep    1s

Paso 442
    Set Location    21.0392062    -86.8726795
    Sleep    1s

Paso 443
    Set Location    21.0392057    -86.8726797
    Sleep    1s

Paso 444
    Set Location    21.0392055    -86.8726804
    Sleep    1s

Paso 445
    Set Location    21.0392055    -86.8726803
    Sleep    1s

Paso 446
    Set Location    21.0392055    -86.8726803
    Sleep    1s

Paso 447
    Set Location    21.0392054    -86.8726806
    Sleep    1s

Paso 448
    Set Location    21.0392055    -86.8726805
    Sleep    1s

Paso 449
    Set Location    21.0392055    -86.8726805
    Sleep    1s

Paso 450
    Set Location    21.0392055    -86.8726804
    Sleep    1s

Paso 451
    Set Location    21.0392054    -86.8726804
    Sleep    1s

Paso 452
    Set Location    21.039205    -86.8726809
    Sleep    1s

Paso 453
    Set Location    21.0392051    -86.8726808
    Sleep    1s

Paso 454
    Set Location    21.0392048    -86.8726819
    Sleep    1s

Paso 455
    Set Location    21.0392049    -86.8726818
    Sleep    1s

Paso 456
    Set Location    21.039205    -86.8726817
    Sleep    1s

Paso 457
    Set Location    21.0392051    -86.8726816
    Sleep    1s

Paso 458
    Set Location    21.0392052    -86.8726815
    Sleep    1s

Paso 459
    Set Location    21.0392053    -86.8726814
    Sleep    1s

Paso 460
    Set Location    21.0392054    -86.8726814
    Sleep    1s

Paso 461
    Set Location    21.0392047    -86.8726833
    Sleep    1s

Paso 462
    Set Location    21.0392044    -86.8726838
    Sleep    1s

Paso 463
    Set Location    21.0392043    -86.8726844
    Sleep    1s

Paso 464
    Set Location    21.0392044    -86.8726843
    Sleep    1s

Paso 465
    Set Location    21.0392045    -86.872684
    Sleep    1s

Paso 466
    Set Location    21.0392046    -86.8726838
    Sleep    1s

Paso 467
    Set Location    21.0392047    -86.8726836
    Sleep    1s

Paso 468
    Set Location    21.0392047    -86.8726835
    Sleep    1s

Paso 469
    Set Location    21.0392048    -86.8726834
    Sleep    1s

Paso 470
    Set Location    21.0392044    -86.872684
    Sleep    1s

Paso 471
    Set Location    21.0392044    -86.8726839
    Sleep    1s

Paso 472
    Set Location    21.0392035    -86.8726857
    Sleep    1s

Paso 473
    Set Location    21.0392036    -86.8726864
    Sleep    1s

Paso 474
    Set Location    21.0392032    -86.8726869
    Sleep    1s

Paso 475
    Set Location    21.0392028    -86.8726881
    Sleep    1s

Paso 476
    Set Location    21.0392023    -86.8726888
    Sleep    1s

Paso 477
    Set Location    21.0392019    -86.8726901
    Sleep    1s

Paso 478
    Set Location    21.0392017    -86.8726905
    Sleep    1s

Paso 479
    Set Location    21.0392007    -86.8726936
    Sleep    1s

Paso 480
    Set Location    21.0392005    -86.8726945
    Sleep    1s

Paso 481
    Set Location    21.0392001    -86.8726956
    Sleep    1s

Paso 482
    Set Location    21.0391993    -86.8726978
    Sleep    1s

Paso 483
    Set Location    21.0391985    -86.8727003
    Sleep    1s

Paso 484
    Set Location    21.039198    -86.872701
    Sleep    1s

Paso 485
    Set Location    21.039198    -86.8727017
    Sleep    1s

Paso 486
    Set Location    21.0391979    -86.8727021
    Sleep    1s

Paso 487
    Set Location    21.0391978    -86.8727029
    Sleep    1s

Paso 488
    Set Location    21.0391975    -86.8727036
    Sleep    1s

Paso 489
    Set Location    21.0391973    -86.872704
    Sleep    1s

Paso 490
    Set Location    21.0391969    -86.8727044
    Sleep    1s

Paso 491
    Set Location    21.0391967    -86.8727052
    Sleep    1s

Paso 492
    Set Location    21.0391964    -86.8727058
    Sleep    1s

Paso 493
    Set Location    21.0391962    -86.8727063
    Sleep    1s

Paso 494
    Set Location    21.039196    -86.8727067
    Sleep    1s

Paso 495
    Set Location    21.0391955    -86.8727093
    Sleep    1s

Paso 496
    Set Location    21.0391953    -86.8727099
    Sleep    1s

Paso 497
    Set Location    21.0391953    -86.8727105
    Sleep    1s

Paso 498
    Set Location    21.0391947    -86.8727122
    Sleep    1s

Paso 499
    Set Location    21.0391945    -86.8727126
    Sleep    1s

Paso 500
    Set Location    21.0391944    -86.8727128
    Sleep    1s

Paso 501
    Set Location    21.0391943    -86.8727131
    Sleep    1s

Paso 502
    Set Location    21.0391939    -86.8727136
    Sleep    1s

Paso 503
    Set Location    21.0391936    -86.8727142
    Sleep    1s

Paso 504
    Set Location    21.0391938    -86.872714
    Sleep    1s

Paso 505
    Set Location    21.0391937    -86.8727142
    Sleep    1s

Paso 506
    Set Location    21.0391936    -86.8727145
    Sleep    1s

Paso 507
    Set Location    21.0391935    -86.8727149
    Sleep    1s

Paso 508
    Set Location    21.0391935    -86.8727156
    Sleep    1s

Paso 509
    Set Location    21.0391935    -86.8727162
    Sleep    1s

Paso 510
    Set Location    21.0391929    -86.8727177
    Sleep    1s

Paso 511
    Set Location    21.0391926    -86.8727181
    Sleep    1s

Paso 512
    Set Location    21.0391921    -86.8727194
    Sleep    1s

Paso 513
    Set Location    21.0391915    -86.8727206
    Sleep    1s

Paso 514
    Set Location    21.0391914    -86.8727206
    Sleep    1s

Paso 515
    Set Location    21.0391911    -86.8727213
    Sleep    1s

Paso 516
    Set Location    21.0391909    -86.8727216
    Sleep    1s

Paso 517
    Set Location    21.0391907    -86.8727223
    Sleep    1s

Paso 518
    Set Location    21.0391899    -86.872724
    Sleep    1s

Paso 519
    Set Location    21.0391899    -86.8727243
    Sleep    1s

Paso 520
    Set Location    21.0391898    -86.8727244
    Sleep    1s

Paso 521
    Set Location    21.0391895    -86.8727248
    Sleep    1s

Paso 522
    Set Location    21.0391892    -86.872725
    Sleep    1s

Paso 523
    Set Location    21.0391893    -86.8727252
    Sleep    1s

Paso 524
    Set Location    21.0391889    -86.8727253
    Sleep    1s

Paso 525
    Set Location    21.0391887    -86.8727256
    Sleep    1s

Paso 526
    Set Location    21.0391885    -86.8727258
    Sleep    1s

Paso 527
    Set Location    21.0391885    -86.872726
    Sleep    1s

Paso 528
    Set Location    21.0391883    -86.8727264
    Sleep    1s

Paso 529
    Set Location    21.0391882    -86.8727266
    Sleep    1s

Paso 530
    Set Location    21.039188    -86.8727269
    Sleep    1s

Paso 531
    Set Location    21.0391881    -86.8727268
    Sleep    1s

Paso 532
    Set Location    21.0391878    -86.872727
    Sleep    1s

Paso 533
    Set Location    21.0391879    -86.8727269
    Sleep    1s

Paso 534
    Set Location    21.0391878    -86.8727269
    Sleep    1s

Paso 535
    Set Location    21.0391877    -86.8727271
    Sleep    1s

Paso 536
    Set Location    21.0391877    -86.872727
    Sleep    1s

Paso 537
    Set Location    21.0391877    -86.8727269
    Sleep    1s

Paso 538
    Set Location    21.0391876    -86.8727271
    Sleep    1s

Paso 539
    Set Location    21.0391878    -86.8727274
    Sleep    1s

Paso 540
    Set Location    21.0391878    -86.8727273
    Sleep    1s

Paso 541
    Set Location    21.0391878    -86.8727271
    Sleep    1s

Paso 542
    Set Location    21.0391878    -86.872727
    Sleep    1s

Paso 543
    Set Location    21.0391878    -86.8727268
    Sleep    1s

Paso 544
    Set Location    21.0391879    -86.8727268
    Sleep    1s

Paso 545
    Set Location    21.0391876    -86.8727271
    Sleep    1s

Paso 546
    Set Location    21.0391874    -86.8727275
    Sleep    1s

Paso 547
    Set Location    21.0391872    -86.8727272
    Sleep    1s

Paso 548
    Set Location    21.0391871    -86.8727272
    Sleep    1s

Paso 549
    Set Location    21.039187    -86.8727275
    Sleep    1s

Paso 550
    Set Location    21.039187    -86.872727
    Sleep    1s

Paso 551
    Set Location    21.0391868    -86.8727264
    Sleep    1s

Paso 552
    Set Location    21.0391869    -86.8727261
    Sleep    1s

Paso 553
    Set Location    21.0391869    -86.8727258
    Sleep    1s

Paso 554
    Set Location    21.0391869    -86.8727255
    Sleep    1s

Paso 555
    Set Location    21.0391869    -86.8727254
    Sleep    1s

Paso 556
    Set Location    21.0391868    -86.8727256
    Sleep    1s

Paso 557
    Set Location    21.0391867    -86.8727253
    Sleep    1s

Paso 558
    Set Location    21.0391867    -86.8727252
    Sleep    1s

Paso 559
    Set Location    21.0391866    -86.872725
    Sleep    1s

Paso 560
    Set Location    21.0391864    -86.872725
    Sleep    1s

Paso 561
    Set Location    21.0391863    -86.8727243
    Sleep    1s

Paso 562
    Set Location    21.0391862    -86.8727244
    Sleep    1s

Paso 563
    Set Location    21.0391861    -86.8727245
    Sleep    1s

Paso 564
    Set Location    21.0391895    -86.8727134
    Sleep    1s

Paso 565
    Set Location    21.0391904    -86.8727093
    Sleep    1s

Paso 566
    Set Location    21.0391921    -86.8727056
    Sleep    1s

Paso 567
    Set Location    21.0391923    -86.8727018
    Sleep    1s

Paso 568
    Set Location    21.0391924    -86.8727007
    Sleep    1s

Paso 569
    Set Location    21.0391925    -86.8727012
    Sleep    1s

Paso 570
    Set Location    21.0392014    -86.8726895
    Sleep    1s

Paso 571
    Set Location    21.0392017    -86.8726883
    Sleep    1s

Paso 572
    Set Location    21.0392007    -86.8726889
    Sleep    1s

Paso 573
    Set Location    21.0392012    -86.8726889
    Sleep    1s

Paso 574
    Set Location    21.039201    -86.8726891
    Sleep    1s

Paso 575
    Set Location    21.0392009    -86.8726893
    Sleep    1s

Paso 576
    Set Location    21.0392008    -86.8726894
    Sleep    1s

Paso 577
    Set Location    21.0392009    -86.8726885
    Sleep    1s

Paso 578
    Set Location    21.0392009    -86.8726883
    Sleep    1s

Paso 579
    Set Location    21.0391999    -86.8726824
    Sleep    1s

Paso 580
    Set Location    21.0391995    -86.8726813
    Sleep    1s

Paso 581
    Set Location    21.0391993    -86.8726807
    Sleep    1s

Paso 582
    Set Location    21.0392027    -86.8726777
    Sleep    1s

Paso 583
    Set Location    21.0392043    -86.8726746
    Sleep    1s

Paso 584
    Set Location    21.0392052    -86.8726728
    Sleep    1s

Paso 585
    Set Location    21.0392068    -86.8726712
    Sleep    1s

Paso 586
    Set Location    21.0392074    -86.8726698
    Sleep    1s

Paso 587
    Set Location    21.039314    -86.8725439
    Sleep    1s

Paso 588
    Set Location    21.0395412    -86.8723578
    Sleep    1s

Paso 589
    Set Location    21.0395409    -86.8723605
    Sleep    1s

Paso 590
    Set Location    21.0395398    -86.8723763
    Sleep    1s

Paso 591
    Set Location    21.0395345    -86.8723829
    Sleep    1s

Paso 592
    Set Location    21.0395317    -86.8723855
    Sleep    1s

Paso 593
    Set Location    21.0395329    -86.8723854
    Sleep    1s

Paso 594
    Set Location    21.0395334    -86.8723855
    Sleep    1s

Paso 595
    Set Location    21.0395336    -86.8723855
    Sleep    1s

Paso 596
    Set Location    21.0395337    -86.8723854
    Sleep    1s

Paso 597
    Set Location    21.0395338    -86.8723854
    Sleep    1s

Paso 598
    Set Location    21.0395339    -86.8723854
    Sleep    1s

Paso 599
    Set Location    21.0395339    -86.8723854
    Sleep    1s

Paso 600
    Set Location    21.039534    -86.8723853
    Sleep    1s

Paso 601
    Set Location    21.0395341    -86.8723853
    Sleep    1s

Paso 602
    Set Location    21.0395342    -86.8723854
    Sleep    1s

Paso 603
    Set Location    21.0395343    -86.8723853
    Sleep    1s

Paso 604
    Set Location    21.0395343    -86.8723853
    Sleep    1s

Paso 605
    Set Location    21.0395751    -86.8723535
    Sleep    1s

Paso 606
    Set Location    21.0396601    -86.8723013
    Sleep    1s

Paso 607
    Set Location    21.039726    -86.872249
    Sleep    1s

Paso 608
    Set Location    21.0397403    -86.8722467
    Sleep    1s

Paso 609
    Set Location    21.0397433    -86.87225
    Sleep    1s

Paso 610
    Set Location    21.039746    -86.8722576
    Sleep    1s

Paso 611
    Set Location    21.0397502    -86.8722677
    Sleep    1s

Paso 612
    Set Location    21.039744    -86.8722665
    Sleep    1s

Paso 613
    Set Location    21.0397423    -86.8722666
    Sleep    1s

Paso 614
    Set Location    21.0397422    -86.8722666
    Sleep    1s

Paso 615
    Set Location    21.0397423    -86.8722664
    Sleep    1s

Paso 616
    Set Location    21.0397424    -86.8722663
    Sleep    1s

Paso 617
    Set Location    21.0397425    -86.8722663
    Sleep    1s

Paso 618
    Set Location    21.0397425    -86.8722662
    Sleep    1s

Paso 619
    Set Location    21.0397426    -86.8722662
    Sleep    1s

Paso 620
    Set Location    21.0397424    -86.8722662
    Sleep    1s

Paso 621
    Set Location    21.0397422    -86.8722661
    Sleep    1s

Paso 622
    Set Location    21.0397421    -86.872266
    Sleep    1s

Paso 623
    Set Location    21.039742    -86.8722661
    Sleep    1s

Paso 624
    Set Location    21.0397419    -86.8722662
    Sleep    1s

Paso 625
    Set Location    21.0397417    -86.8722664
    Sleep    1s

Paso 626
    Set Location    21.0397416    -86.8722667
    Sleep    1s

Paso 627
    Set Location    21.0397413    -86.8722672
    Sleep    1s

Paso 628
    Set Location    21.0397413    -86.8722673
    Sleep    1s

Paso 629
    Set Location    21.0397499    -86.8722541
    Sleep    1s

Paso 630
    Set Location    21.0397681    -86.8722321
    Sleep    1s

Paso 631
    Set Location    21.0397752    -86.8722062
    Sleep    1s

Paso 632
    Set Location    21.0397867    -86.872202
    Sleep    1s

Paso 633
    Set Location    21.0397855    -86.8722016
    Sleep    1s

Paso 634
    Set Location    21.039784    -86.8721986
    Sleep    1s

Paso 635
    Set Location    21.0397835    -86.8721959
    Sleep    1s

Paso 636
    Set Location    21.0397823    -86.8721918
    Sleep    1s

Paso 637
    Set Location    21.0397815    -86.8721911
    Sleep    1s

Paso 638
    Set Location    21.0397801    -86.8721899
    Sleep    1s

Paso 639
    Set Location    21.0397796    -86.8721895
    Sleep    1s

Paso 640
    Set Location    21.0397791    -86.8721892
    Sleep    1s

Paso 641
    Set Location    21.0397787    -86.8721892
    Sleep    1s

Paso 642
    Set Location    21.0397785    -86.8721892
    Sleep    1s

Paso 643
    Set Location    21.0397781    -86.8721893
    Sleep    1s

Paso 644
    Set Location    21.0397778    -86.8721891
    Sleep    1s

Paso 645
    Set Location    21.0397776    -86.8721891
    Sleep    1s

Paso 646
    Set Location    21.0397774    -86.8721891
    Sleep    1s

Paso 647
    Set Location    21.039777    -86.8721893
    Sleep    1s

Paso 648
    Set Location    21.0397768    -86.8721892
    Sleep    1s

Paso 649
    Set Location    21.0397765    -86.8721892
    Sleep    1s

Paso 650
    Set Location    21.0397763    -86.8721892
    Sleep    1s

Paso 651
    Set Location    21.0397761    -86.8721891
    Sleep    1s

Paso 652
    Set Location    21.0397759    -86.872189
    Sleep    1s

Paso 653
    Set Location    21.0397759    -86.8721889
    Sleep    1s

Paso 654
    Set Location    21.0397758    -86.8721889
    Sleep    1s

Paso 655
    Set Location    21.0397755    -86.8721889
    Sleep    1s

Paso 656
    Set Location    21.0397754    -86.8721889
    Sleep    1s

Paso 657
    Set Location    21.0397752    -86.8721889
    Sleep    1s

Paso 658
    Set Location    21.0397751    -86.8721889
    Sleep    1s

Paso 659
    Set Location    21.0397748    -86.872189
    Sleep    1s

Paso 660
    Set Location    21.0397746    -86.872189
    Sleep    1s

Paso 661
    Set Location    21.0397743    -86.8721889
    Sleep    1s

Paso 662
    Set Location    21.0397739    -86.8721888
    Sleep    1s

Paso 663
    Set Location    21.0397738    -86.8721886
    Sleep    1s

Paso 664
    Set Location    21.0397736    -86.8721886
    Sleep    1s

Paso 665
    Set Location    21.0397735    -86.8721887
    Sleep    1s

Paso 666
    Set Location    21.0397734    -86.8721887
    Sleep    1s

Paso 667
    Set Location    21.0397733    -86.8721886
    Sleep    1s

Paso 668
    Set Location    21.0397729    -86.8721885
    Sleep    1s

Paso 669
    Set Location    21.0398063    -86.8721705
    Sleep    1s

Paso 670
    Set Location    21.0398621    -86.8721353
    Sleep    1s

Paso 671
    Set Location    21.0398708    -86.8721275
    Sleep    1s

Paso 672
    Set Location    21.0398764    -86.8721237
    Sleep    1s

Paso 673
    Set Location    21.0398779    -86.8721192
    Sleep    1s

Paso 674
    Set Location    21.0398773    -86.872116
    Sleep    1s

Paso 675
    Set Location    21.0398776    -86.8721146
    Sleep    1s

Paso 676
    Set Location    21.039878    -86.8721138
    Sleep    1s

Paso 677
    Set Location    21.0398786    -86.8721132
    Sleep    1s

Paso 678
    Set Location    21.0398791    -86.8721127
    Sleep    1s

Paso 679
    Set Location    21.0398796    -86.8721123
    Sleep    1s

Paso 680
    Set Location    21.03988    -86.872112
    Sleep    1s

Paso 681
    Set Location    21.0398804    -86.8721116
    Sleep    1s

Paso 682
    Set Location    21.0398807    -86.8721113
    Sleep    1s

Paso 683
    Set Location    21.039881    -86.872111
    Sleep    1s

Paso 684
    Set Location    21.0398813    -86.8721108
    Sleep    1s

Paso 685
    Set Location    21.0398816    -86.8721105
    Sleep    1s

Paso 686
    Set Location    21.0398818    -86.8721103
    Sleep    1s

Paso 687
    Set Location    21.039882    -86.8721101
    Sleep    1s

Paso 688
    Set Location    21.0398823    -86.87211
    Sleep    1s

Paso 689
    Set Location    21.0398825    -86.8721098
    Sleep    1s

Paso 690
    Set Location    21.0398827    -86.8721097
    Sleep    1s

Paso 691
    Set Location    21.0398829    -86.8721095
    Sleep    1s

Paso 692
    Set Location    21.0398831    -86.8721094
    Sleep    1s

Paso 693
    Set Location    21.0398833    -86.8721093
    Sleep    1s

Paso 694
    Set Location    21.0398835    -86.872109
    Sleep    1s

Paso 695
    Set Location    21.0398837    -86.8721088
    Sleep    1s

Paso 696
    Set Location    21.039884    -86.8721086
    Sleep    1s

Paso 697
    Set Location    21.0398841    -86.8721086
    Sleep    1s

Paso 698
    Set Location    21.0398843    -86.8721084
    Sleep    1s

Paso 699
    Set Location    21.0398845    -86.8721083
    Sleep    1s

Paso 700
    Set Location    21.0398847    -86.8721082
    Sleep    1s

Paso 701
    Set Location    21.0398848    -86.8721081
    Sleep    1s

Paso 702
    Set Location    21.0398849    -86.8721079
    Sleep    1s

Paso 703
    Set Location    21.039885    -86.8721078
    Sleep    1s

Paso 704
    Set Location    21.0398852    -86.8721077
    Sleep    1s

Paso 705
    Set Location    21.0398853    -86.8721076
    Sleep    1s

Paso 706
    Set Location    21.0398854    -86.8721076
    Sleep    1s

Paso 707
    Set Location    21.0398856    -86.8721075
    Sleep    1s

Paso 708
    Set Location    21.0398857    -86.8721075
    Sleep    1s

Paso 709
    Set Location    21.0398858    -86.8721074
    Sleep    1s

Paso 710
    Set Location    21.0398859    -86.8721074
    Sleep    1s

Paso 711
    Set Location    21.039886    -86.8721073
    Sleep    1s

Paso 712
    Set Location    21.0398861    -86.8721073
    Sleep    1s

Paso 713
    Set Location    21.0398862    -86.8721072
    Sleep    1s

Paso 714
    Set Location    21.0398863    -86.8721072
    Sleep    1s

Paso 715
    Set Location    21.0398864    -86.8721071
    Sleep    1s

Paso 716
    Set Location    21.0398865    -86.8721071
    Sleep    1s

Paso 717
    Set Location    21.0398866    -86.872107
    Sleep    1s

Paso 718
    Set Location    21.0399107    -86.8721081
    Sleep    1s

Paso 719
    Set Location    21.0399363    -86.8720885
    Sleep    1s

Paso 720
    Set Location    21.0399226    -86.8720831
    Sleep    1s

Paso 721
    Set Location    21.0399041    -86.8720878
    Sleep    1s

Paso 722
    Set Location    21.0398933    -86.8720851
    Sleep    1s

Paso 723
    Set Location    21.0398877    -86.8720849
    Sleep    1s

Paso 724
    Set Location    21.0398861    -86.8720825
    Sleep    1s

Paso 725
    Set Location    21.0398856    -86.872082
    Sleep    1s

Paso 726
    Set Location    21.0398855    -86.8720818
    Sleep    1s

Paso 727
    Set Location    21.0398855    -86.8720818
    Sleep    1s

Paso 728
    Set Location    21.0398856    -86.8720818
    Sleep    1s

Paso 729
    Set Location    21.0398857    -86.872082
    Sleep    1s

Paso 730
    Set Location    21.0398858    -86.8720821
    Sleep    1s

Paso 731
    Set Location    21.0398858    -86.8720821
    Sleep    1s

Paso 732
    Set Location    21.0398859    -86.8720823
    Sleep    1s

Paso 733
    Set Location    21.039886    -86.8720825
    Sleep    1s

Paso 734
    Set Location    21.039886    -86.8720827
    Sleep    1s

Paso 735
    Set Location    21.039886    -86.8720828
    Sleep    1s

Paso 736
    Set Location    21.039886    -86.8720828
    Sleep    1s

Paso 737
    Set Location    21.0398857    -86.8720829
    Sleep    1s

Paso 738
    Set Location    21.0398855    -86.872083
    Sleep    1s

Paso 739
    Set Location    21.0398851    -86.872083
    Sleep    1s

Paso 740
    Set Location    21.0398849    -86.872083
    Sleep    1s

Paso 741
    Set Location    21.0398847    -86.8720832
    Sleep    1s

Paso 742
    Set Location    21.0398846    -86.8720832
    Sleep    1s

Paso 743
    Set Location    21.0398845    -86.8720835
    Sleep    1s

Paso 744
    Set Location    21.0398842    -86.8720836
    Sleep    1s

Paso 745
    Set Location    21.039884    -86.8720837
    Sleep    1s

Paso 746
    Set Location    21.0398838    -86.8720837
    Sleep    1s

Paso 747
    Set Location    21.0398836    -86.8720838
    Sleep    1s

Paso 748
    Set Location    21.0398835    -86.8720839
    Sleep    1s

Paso 749
    Set Location    21.0398834    -86.8720839
    Sleep    1s

Paso 750
    Set Location    21.0398832    -86.872084
    Sleep    1s

Paso 751
    Set Location    21.0398831    -86.8720841
    Sleep    1s

Paso 752
    Set Location    21.0398829    -86.8720842
    Sleep    1s

Paso 753
    Set Location    21.0398827    -86.8720842
    Sleep    1s

Paso 754
    Set Location    21.0398824    -86.8720842
    Sleep    1s

Paso 755
    Set Location    21.0398822    -86.8720842
    Sleep    1s

Paso 756
    Set Location    21.0398819    -86.8720843
    Sleep    1s

Paso 757
    Set Location    21.0398815    -86.8720843
    Sleep    1s

Paso 758
    Set Location    21.0398812    -86.8720843
    Sleep    1s

Paso 759
    Set Location    21.0398809    -86.8720844
    Sleep    1s

Paso 760
    Set Location    21.0398807    -86.8720845
    Sleep    1s

Paso 761
    Set Location    21.0398803    -86.8720844
    Sleep    1s

Paso 762
    Set Location    21.03988    -86.8720845
    Sleep    1s

Paso 763
    Set Location    21.0398797    -86.8720845
    Sleep    1s

Paso 764
    Set Location    21.0398795    -86.8720846
    Sleep    1s

Paso 765
    Set Location    21.0398792    -86.8720847
    Sleep    1s

Paso 766
    Set Location    21.0398788    -86.8720848
    Sleep    1s

Paso 767
    Set Location    21.0398786    -86.8720849
    Sleep    1s

Paso 768
    Set Location    21.0398783    -86.8720851
    Sleep    1s

Paso 769
    Set Location    21.0398781    -86.8720852
    Sleep    1s

Paso 770
    Set Location    21.0398779    -86.8720853
    Sleep    1s

Paso 771
    Set Location    21.0398777    -86.8720855
    Sleep    1s

Paso 772
    Set Location    21.0398775    -86.8720856
    Sleep    1s

Paso 773
    Set Location    21.0398773    -86.8720858
    Sleep    1s

Paso 774
    Set Location    21.0398771    -86.8720861
    Sleep    1s

Paso 775
    Set Location    21.0398766    -86.8720862
    Sleep    1s

Paso 776
    Set Location    21.0398762    -86.8720863
    Sleep    1s

Paso 777
    Set Location    21.0399033    -86.8720654
    Sleep    1s

Paso 778
    Set Location    21.0399385    -86.8720313
    Sleep    1s

Paso 779
    Set Location    21.0399562    -86.8720302
    Sleep    1s

Paso 780
    Set Location    21.0399602    -86.8720357
    Sleep    1s

Paso 781
    Set Location    21.0399624    -86.8720387
    Sleep    1s

Paso 782
    Set Location    21.0399659    -86.8720386
    Sleep    1s

Paso 783
    Set Location    21.0399658    -86.8720374
    Sleep    1s

Paso 784
    Set Location    21.0399641    -86.8720364
    Sleep    1s

Paso 785
    Set Location    21.0399631    -86.8720362
    Sleep    1s

Paso 786
    Set Location    21.0399625    -86.8720362
    Sleep    1s

Paso 787
    Set Location    21.039962    -86.8720362
    Sleep    1s

Paso 788
    Set Location    21.0399617    -86.8720364
    Sleep    1s

Paso 789
    Set Location    21.0399614    -86.8720367
    Sleep    1s

Paso 790
    Set Location    21.0399612    -86.8720369
    Sleep    1s

Paso 791
    Set Location    21.039961    -86.8720372
    Sleep    1s

Paso 792
    Set Location    21.0399607    -86.8720374
    Sleep    1s

Paso 793
    Set Location    21.0399604    -86.8720376
    Sleep    1s

Paso 794
    Set Location    21.0399601    -86.8720379
    Sleep    1s

Paso 795
    Set Location    21.0399597    -86.8720381
    Sleep    1s

Paso 796
    Set Location    21.0399594    -86.8720382
    Sleep    1s

Paso 797
    Set Location    21.039959    -86.8720383
    Sleep    1s

Paso 798
    Set Location    21.0399586    -86.8720384
    Sleep    1s

Paso 799
    Set Location    21.0399583    -86.8720386
    Sleep    1s

Paso 800
    Set Location    21.0399581    -86.8720388
    Sleep    1s

Paso 801
    Set Location    21.0399579    -86.8720389
    Sleep    1s

Paso 802
    Set Location    21.0399577    -86.8720392
    Sleep    1s

Paso 803
    Set Location    21.0399575    -86.8720394
    Sleep    1s

Paso 804
    Set Location    21.0399571    -86.8720397
    Sleep    1s

Paso 805
    Set Location    21.0399568    -86.8720398
    Sleep    1s

Paso 806
    Set Location    21.0399565    -86.87204
    Sleep    1s

Paso 807
    Set Location    21.0399562    -86.8720401
    Sleep    1s

Paso 808
    Set Location    21.0399558    -86.8720403
    Sleep    1s

Paso 809
    Set Location    21.0399556    -86.8720406
    Sleep    1s

Paso 810
    Set Location    21.0399551    -86.8720408
    Sleep    1s

Paso 811
    Set Location    21.0399547    -86.872041
    Sleep    1s

Paso 812
    Set Location    21.0399542    -86.8720412
    Sleep    1s

Paso 813
    Set Location    21.0399537    -86.8720414
    Sleep    1s

Paso 814
    Set Location    21.0399533    -86.8720417
    Sleep    1s

Paso 815
    Set Location    21.039953    -86.8720418
    Sleep    1s

Paso 816
    Set Location    21.0399527    -86.872042
    Sleep    1s

Paso 817
    Set Location    21.0400143    -86.8720245
    Sleep    1s

Paso 818
    Set Location    21.0401641    -86.8719518
    Sleep    1s

Paso 819
    Set Location    21.0403404    -86.8718399
    Sleep    1s

Paso 820
    Set Location    21.0404822    -86.8716609
    Sleep    1s

Paso 821
    Set Location    21.0403424    -86.8713773
    Sleep    1s

Paso 822
    Set Location    21.040209    -86.8711884
    Sleep    1s

Paso 823
    Set Location    21.0400023    -86.8709557
    Sleep    1s

Paso 824
    Set Location    21.0398218    -86.870547
    Sleep    1s

Paso 825
    Set Location    21.0396067    -86.8699363
    Sleep    1s

Paso 826
    Set Location    21.0403524    -86.8691048
    Sleep    1s

Paso 827
    Set Location    21.0406018    -86.8689689
    Sleep    1s

Paso 828
    Set Location    21.0409238    -86.8687111
    Sleep    1s

Paso 829
    Set Location    21.0413129    -86.8684375
    Sleep    1s

Paso 830
    Set Location    21.0417275    -86.8680177
    Sleep    1s

Paso 831
    Set Location    21.0418054    -86.8675488
    Sleep    1s

Paso 832
    Set Location    21.0415397    -86.8670453
    Sleep    1s

Paso 833
    Set Location    21.0412097    -86.8665193
    Sleep    1s

Paso 834
    Set Location    21.0408266    -86.865907
    Sleep    1s

Paso 835
    Set Location    21.0404261    -86.8652662
    Sleep    1s

Paso 836
    Set Location    21.0400391    -86.8646136
    Sleep    1s

Paso 837
    Set Location    21.0395944    -86.8639385
    Sleep    1s

Paso 838
    Set Location    21.0391529    -86.8632855
    Sleep    1s

Paso 839
    Set Location    21.0385913    -86.8623153
    Sleep    1s

Paso 840
    Set Location    21.0381034    -86.8614951
    Sleep    1s

Paso 841
    Set Location    21.0362891    -86.8586036
    Sleep    1s

Paso 842
    Set Location    21.0358011    -86.8578456
    Sleep    1s

Paso 843
    Set Location    21.0353467    -86.857092
    Sleep    1s

Paso 844
    Set Location    21.0348407    -86.8562811
    Sleep    1s

Paso 845
    Set Location    21.0343298    -86.8554595
    Sleep    1s

Paso 846
    Set Location    21.033865    -86.854671
    Sleep    1s

Paso 847
    Set Location    21.0335413    -86.8538731
    Sleep    1s

Paso 848
    Set Location    21.0333985    -86.8530961
    Sleep    1s

Paso 849
    Set Location    21.033272    -86.8523403
    Sleep    1s

Paso 850
    Set Location    21.0331636    -86.8516968
    Sleep    1s

Paso 851
    Set Location    21.0331367    -86.8512966
    Sleep    1s

Paso 852
    Set Location    21.0330777    -86.8511358
    Sleep    1s

Paso 853
    Set Location    21.033052    -86.8511355
    Sleep    1s

Paso 854
    Set Location    21.0330105    -86.8510663
    Sleep    1s

Paso 855
    Set Location    21.032843    -86.8509573
    Sleep    1s

Paso 856
    Set Location    21.032528    -86.8509229
    Sleep    1s

Paso 857
    Set Location    21.0322742    -86.8510945
    Sleep    1s

Paso 858
    Set Location    21.0321579    -86.8513528
    Sleep    1s

Paso 859
    Set Location    21.0321875    -86.8516016
    Sleep    1s

Paso 860
    Set Location    21.0323189    -86.8517929
    Sleep    1s

Paso 861
    Set Location    21.0325481    -86.8519232
    Sleep    1s

Paso 862
    Set Location    21.0338813    -86.8517948
    Sleep    1s

Paso 863
    Set Location    21.0345066    -86.8516149
    Sleep    1s

Paso 864
    Set Location    21.0351629    -86.8513924
    Sleep    1s

Paso 865
    Set Location    21.0358948    -86.8510947
    Sleep    1s

Paso 866
    Set Location    21.0366226    -86.8508019
    Sleep    1s

Paso 867
    Set Location    21.0374079    -86.8505469
    Sleep    1s

Paso 868
    Set Location    21.0382087    -86.8502972
    Sleep    1s

Paso 869
    Set Location    21.03898    -86.8501653
    Sleep    1s

Paso 870
    Set Location    21.0397998    -86.8500818
    Sleep    1s

Paso 871
    Set Location    21.0406592    -86.8499586
    Sleep    1s

Paso 872
    Set Location    21.0415204    -86.8497953
    Sleep    1s

Paso 873
    Set Location    21.0423616    -86.8496723
    Sleep    1s

Paso 874
    Set Location    21.0432198    -86.8495603
    Sleep    1s

Paso 875
    Set Location    21.044076    -86.8494215
    Sleep    1s

Paso 876
    Set Location    21.0449695    -86.8492907
    Sleep    1s

Paso 877
    Set Location    21.0458879    -86.8491377
    Sleep    1s

Paso 878
    Set Location    21.0467516    -86.8490047
    Sleep    1s

Paso 879
    Set Location    21.0476426    -86.8488223
    Sleep    1s

Paso 880
    Set Location    21.048587    -86.8487017
    Sleep    1s

Paso 881
    Set Location    21.0494961    -86.8485734
    Sleep    1s

Paso 882
    Set Location    21.0504456    -86.8484316
    Sleep    1s

Paso 883
    Set Location    21.0514002    -86.8482787
    Sleep    1s

Paso 884
    Set Location    21.0522712    -86.8481431
    Sleep    1s

Paso 885
    Set Location    21.0531612    -86.8480003
    Sleep    1s

Paso 886
    Set Location    21.0540654    -86.847879
    Sleep    1s

Paso 887
    Set Location    21.0549978    -86.8477327
    Sleep    1s

Paso 888
    Set Location    21.0558685    -86.8476039
    Sleep    1s

Paso 889
    Set Location    21.0567375    -86.8474378
    Sleep    1s

Paso 890
    Set Location    21.0575764    -86.8473118
    Sleep    1s

Paso 891
    Set Location    21.0584874    -86.8471599
    Sleep    1s

Paso 892
    Set Location    21.0593663    -86.8470423
    Sleep    1s

Paso 893
    Set Location    21.0602469    -86.846914
    Sleep    1s

Paso 894
    Set Location    21.0611209    -86.8467539
    Sleep    1s

Paso 895
    Set Location    21.0620109    -86.8466378
    Sleep    1s

Paso 896
    Set Location    21.0629929    -86.8465129
    Sleep    1s

Paso 897
    Set Location    21.0639804    -86.8463565
    Sleep    1s

Paso 898
    Set Location    21.0649545    -86.8461823
    Sleep    1s

Paso 899
    Set Location    21.0659444    -86.8460453
    Sleep    1s

Paso 900
    Set Location    21.0669721    -86.8458919
    Sleep    1s

Paso 901
    Set Location    21.0679417    -86.8457274
    Sleep    1s

Paso 902
    Set Location    21.0688962    -86.8455772
    Sleep    1s

Paso 903
    Set Location    21.0697737    -86.8454413
    Sleep    1s

Paso 904
    Set Location    21.0707021    -86.8452671
    Sleep    1s

Paso 905
    Set Location    21.0716531    -86.8451297
    Sleep    1s

Paso 906
    Set Location    21.0726461    -86.8449809
    Sleep    1s

Paso 907
    Set Location    21.0736547    -86.8448541
    Sleep    1s

Paso 908
    Set Location    21.0746638    -86.8447009
    Sleep    1s

Paso 909
    Set Location    21.0756089    -86.8445346
    Sleep    1s

Paso 910
    Set Location    21.0765541    -86.8443537
    Sleep    1s

Paso 911
    Set Location    21.077477    -86.8442156
    Sleep    1s

Paso 912
    Set Location    21.0783142    -86.8440779
    Sleep    1s

Paso 913
    Set Location    21.0791704    -86.8439307
    Sleep    1s

Paso 914
    Set Location    21.0799497    -86.8438112
    Sleep    1s

Paso 915
    Set Location    21.0806519    -86.8436803
    Sleep    1s

Paso 916
    Set Location    21.0813739    -86.8435807
    Sleep    1s

Paso 917
    Set Location    21.0821707    -86.8434639
    Sleep    1s

Paso 918
    Set Location    21.0830119    -86.8433396
    Sleep    1s

Paso 919
    Set Location    21.0839649    -86.8431893
    Sleep    1s

Paso 920
    Set Location    21.0848979    -86.8430097
    Sleep    1s

Paso 921
    Set Location    21.085784    -86.842833
    Sleep    1s

Paso 922
    Set Location    21.0866837    -86.8426806
    Sleep    1s

Paso 923
    Set Location    21.0876213    -86.8425313
    Sleep    1s

Paso 924
    Set Location    21.0887056    -86.8423429
    Sleep    1s

Paso 925
    Set Location    21.0921018    -86.8419246
    Sleep    1s

Paso 926
    Set Location    21.0929155    -86.8417965
    Sleep    1s

Paso 927
    Set Location    21.093695    -86.841678
    Sleep    1s

Paso 928
    Set Location    21.0944247    -86.8415376
    Sleep    1s

Paso 929
    Set Location    21.0951371    -86.8414262
    Sleep    1s

Paso 930
    Set Location    21.0958715    -86.8413054
    Sleep    1s

Paso 931
    Set Location    21.0966731    -86.8411394
    Sleep    1s

Paso 932
    Set Location    21.097511    -86.841057
    Sleep    1s

Paso 933
    Set Location    21.0982934    -86.8409308
    Sleep    1s

Paso 934
    Set Location    21.0990127    -86.8408193
    Sleep    1s

Paso 935
    Set Location    21.0996682    -86.8407503
    Sleep    1s

Paso 936
    Set Location    21.1000701    -86.8407115
    Sleep    1s

Paso 937
    Set Location    21.1002181    -86.8406683
    Sleep    1s

Paso 938
    Set Location    21.1003911    -86.8406257
    Sleep    1s

Paso 939
    Set Location    21.1007041    -86.840574
    Sleep    1s

Paso 940
    Set Location    21.1011297    -86.8405109
    Sleep    1s

Paso 941
    Set Location    21.1015848    -86.8403973
    Sleep    1s

Paso 942
    Set Location    21.1021685    -86.840329
    Sleep    1s

Paso 943
    Set Location    21.1028401    -86.8402651
    Sleep    1s

Paso 944
    Set Location    21.1035061    -86.8401481
    Sleep    1s

Paso 945
    Set Location    21.1042377    -86.8400343
    Sleep    1s

Paso 946
    Set Location    21.1050268    -86.8399416
    Sleep    1s

Paso 947
    Set Location    21.1058852    -86.8397961
    Sleep    1s

Paso 948
    Set Location    21.1068401    -86.8396305
    Sleep    1s

Paso 949
    Set Location    21.1077395    -86.8394848
    Sleep    1s

Paso 950
    Set Location    21.1087391    -86.8393415
    Sleep    1s

Paso 951
    Set Location    21.1098112    -86.8391782
    Sleep    1s

Paso 952
    Set Location    21.1108515    -86.8390039
    Sleep    1s

Paso 953
    Set Location    21.1118622    -86.8388146
    Sleep    1s

Paso 954
    Set Location    21.1127702    -86.8385306
    Sleep    1s

Paso 955
    Set Location    21.1137297    -86.8380917
    Sleep    1s

Paso 956
    Set Location    21.1147083    -86.8376142
    Sleep    1s

Paso 957
    Set Location    21.1156618    -86.8371598
    Sleep    1s

Paso 958
    Set Location    21.1166023    -86.8366925
    Sleep    1s

Paso 959
    Set Location    21.1175114    -86.8362302
    Sleep    1s

Paso 960
    Set Location    21.1184391    -86.8357602
    Sleep    1s

Paso 961
    Set Location    21.1194245    -86.8353095
    Sleep    1s

Paso 962
    Set Location    21.1203313    -86.8348725
    Sleep    1s

Paso 963
    Set Location    21.1212375    -86.8344278
    Sleep    1s

Paso 964
    Set Location    21.1221269    -86.833973
    Sleep    1s

Paso 965
    Set Location    21.123007    -86.8335287
    Sleep    1s

Paso 966
    Set Location    21.1239455    -86.8330914
    Sleep    1s

Paso 967
    Set Location    21.1248265    -86.8326247
    Sleep    1s

Paso 968
    Set Location    21.125713    -86.8321924
    Sleep    1s

Paso 969
    Set Location    21.1265967    -86.8317644
    Sleep    1s

Paso 970
    Set Location    21.1274884    -86.8313172
    Sleep    1s

Paso 971
    Set Location    21.1284196    -86.830911
    Sleep    1s

Paso 972
    Set Location    21.1293061    -86.8304811
    Sleep    1s

Paso 973
    Set Location    21.1300977    -86.8299941
    Sleep    1s

Paso 974
    Set Location    21.1311711    -86.8294936
    Sleep    1s

Paso 975
    Set Location    21.1334244    -86.8284425
    Sleep    1s

Paso 976
    Set Location    21.1341849    -86.8280502
    Sleep    1s

Paso 977
    Set Location    21.1348398    -86.8277546
    Sleep    1s

Paso 978
    Set Location    21.1354278    -86.8274694
    Sleep    1s

Paso 979
    Set Location    21.1360168    -86.8271559
    Sleep    1s

Paso 980
    Set Location    21.1366615    -86.8268497
    Sleep    1s

Paso 981
    Set Location    21.1374242    -86.8265226
    Sleep    1s

Paso 982
    Set Location    21.1381839    -86.8261376
    Sleep    1s

Paso 983
    Set Location    21.1387866    -86.8257873
    Sleep    1s

Paso 984
    Set Location    21.1392417    -86.8254288
    Sleep    1s

Paso 985
    Set Location    21.1398563    -86.8252171
    Sleep    1s

Paso 986
    Set Location    21.1405023    -86.8249272
    Sleep    1s

Paso 987
    Set Location    21.1411711    -86.8246372
    Sleep    1s

Paso 988
    Set Location    21.1418697    -86.8243543
    Sleep    1s

Paso 989
    Set Location    21.1425855    -86.8242531
    Sleep    1s

Paso 990
    Set Location    21.1432405    -86.8242185
    Sleep    1s

Paso 991
    Set Location    21.1435643    -86.8242475
    Sleep    1s

Paso 992
    Set Location    21.1436307    -86.824266
    Sleep    1s

Paso 993
    Set Location    21.1435912    -86.8242504
    Sleep    1s

Paso 994
    Set Location    21.1435605    -86.8242138
    Sleep    1s

Paso 995
    Set Location    21.1435957    -86.8242004
    Sleep    1s

Paso 996
    Set Location    21.1435973    -86.8242045
    Sleep    1s

Paso 997
    Set Location    21.143674    -86.8242033
    Sleep    1s

Paso 998
    Set Location    21.1439612    -86.8242686
    Sleep    1s

Paso 999
    Set Location    21.1443429    -86.8242909
    Sleep    1s

Paso 1000
    Set Location    21.1448653    -86.8243004
    Sleep    1s

Paso 1001
    Set Location    21.1454018    -86.8243919
    Sleep    1s

Paso 1002
    Set Location    21.1459492    -86.8244756
    Sleep    1s

Paso 1003
    Set Location    21.1464286    -86.8244738
    Sleep    1s

Paso 1004
    Set Location    21.1465435    -86.8244552
    Sleep    1s

Paso 1005
    Set Location    21.1465764    -86.8244643
    Sleep    1s

Paso 1006
    Set Location    21.1465728    -86.8244729
    Sleep    1s

Paso 1007
    Set Location    21.146583    -86.8244719
    Sleep    1s

Paso 1008
    Set Location    21.1465786    -86.8244665
    Sleep    1s

Paso 1009
    Set Location    21.1466039    -86.8244836
    Sleep    1s

Paso 1010
    Set Location    21.1467641    -86.82455
    Sleep    1s

Paso 1011
    Set Location    21.1469891    -86.82456
    Sleep    1s

Paso 1012
    Set Location    21.1474542    -86.8245737
    Sleep    1s

Paso 1013
    Set Location    21.1480769    -86.8246024
    Sleep    1s

Paso 1014
    Set Location    21.148786    -86.8246137
    Sleep    1s

Paso 1015
    Set Location    21.1495031    -86.8246301
    Sleep    1s

Paso 1016
    Set Location    21.1501887    -86.8247001
    Sleep    1s

Paso 1017
    Set Location    21.1508543    -86.8248323
    Sleep    1s

Paso 1018
    Set Location    21.1515871    -86.8249184
    Sleep    1s

Paso 1019
    Set Location    21.1524122    -86.8249477
    Sleep    1s

Paso 1020
    Set Location    21.1532635    -86.8250218
    Sleep    1s

Paso 1021
    Set Location    21.1540942    -86.8250825
    Sleep    1s

Paso 1022
    Set Location    21.1548814    -86.825135
    Sleep    1s

Paso 1023
    Set Location    21.1554383    -86.8252093
    Sleep    1s

Paso 1024
    Set Location    21.1558167    -86.8252435
    Sleep    1s

Paso 1025
    Set Location    21.1561285    -86.8252693
    Sleep    1s

Paso 1026
    Set Location    21.1564457    -86.8251962
    Sleep    1s

Paso 1027
    Set Location    21.1566714    -86.8251052
    Sleep    1s

Paso 1028
    Set Location    21.1567729    -86.8250814
    Sleep    1s

Paso 1029
    Set Location    21.1569586    -86.8250736
    Sleep    1s

Paso 1030
    Set Location    21.157015    -86.8250643
    Sleep    1s

Paso 1031
    Set Location    21.1570012    -86.8250672
    Sleep    1s

Paso 1032
    Set Location    21.1570038    -86.8250763
    Sleep    1s

Paso 1033
    Set Location    21.1570106    -86.8250953
    Sleep    1s

Paso 1034
    Set Location    21.1570105    -86.8250946
    Sleep    1s

Paso 1035
    Set Location    21.1570106    -86.8250944
    Sleep    1s

Paso 1036
    Set Location    21.1570107    -86.825094
    Sleep    1s

Paso 1037
    Set Location    21.1570107    -86.8250941
    Sleep    1s

Paso 1038
    Set Location    21.157011    -86.8250941
    Sleep    1s

Paso 1039
    Set Location    21.1570121    -86.825094
    Sleep    1s

Paso 1040
    Set Location    21.1570758    -86.8251069
    Sleep    1s

Paso 1041
    Set Location    21.1573371    -86.8252449
    Sleep    1s

Paso 1042
    Set Location    21.1576495    -86.8253742
    Sleep    1s

Paso 1043
    Set Location    21.1580572    -86.8254346
    Sleep    1s

Paso 1044
    Set Location    21.1583684    -86.8254287
    Sleep    1s

Paso 1045
    Set Location    21.1585686    -86.8254534
    Sleep    1s

Paso 1046
    Set Location    21.1588443    -86.8255024
    Sleep    1s

Paso 1047
    Set Location    21.1592704    -86.8255099
    Sleep    1s

Paso 1048
    Set Location    21.1596795    -86.8255467
    Sleep    1s

Paso 1049
    Set Location    21.1599225    -86.8255143
    Sleep    1s

Paso 1050
    Set Location    21.1601408    -86.825526
    Sleep    1s

Paso 1051
    Set Location    21.1605742    -86.8255472
    Sleep    1s

Paso 1052
    Set Location    21.1610039    -86.8256351
    Sleep    1s

Paso 1053
    Set Location    21.1613546    -86.8256553
    Sleep    1s

Paso 1054
    Set Location    21.1617069    -86.8257008
    Sleep    1s

Paso 1055
    Set Location    21.1621649    -86.8257419
    Sleep    1s

Paso 1056
    Set Location    21.1626786    -86.8257531
    Sleep    1s

Paso 1057
    Set Location    21.1629912    -86.8257147
    Sleep    1s

Paso 1058
    Set Location    21.1630097    -86.825649
    Sleep    1s

Paso 1059
    Set Location    21.1630161    -86.825635
    Sleep    1s

Paso 1060
    Set Location    21.1630915    -86.8255831
    Sleep    1s

Paso 1061
    Set Location    21.1641065    -86.8254342
    Sleep    1s

Paso 1062
    Set Location    21.1641973    -86.8259366
    Sleep    1s

Paso 1063
    Set Location    21.1639508    -86.826709
    Sleep    1s

Paso 1064
    Set Location    21.1640651    -86.8265609
    Sleep    1s

Paso 1065
    Set Location    21.1641504    -86.826335
    Sleep    1s

Paso 1066
    Set Location    21.1643191    -86.8262733
    Sleep    1s

Paso 1067
    Set Location    21.1644184    -86.8262662
    Sleep    1s

Paso 1068
    Set Location    21.1644516    -86.8262157
    Sleep    1s

Paso 1069
    Set Location    21.1644808    -86.8261874
    Sleep    1s

Paso 1070
    Set Location    21.1644935    -86.8261867
    Sleep    1s

Paso 1071
    Set Location    21.1644785    -86.8261838
    Sleep    1s

Paso 1072
    Set Location    21.1644577    -86.8261855
    Sleep    1s

Paso 1073
    Set Location    21.164455    -86.8261966
    Sleep    1s

Paso 1074
    Set Location    21.1644532    -86.8261987
    Sleep    1s

Paso 1075
    Set Location    21.1644521    -86.8262004
    Sleep    1s

Paso 1076
    Set Location    21.1644511    -86.8262045
    Sleep    1s

Paso 1077
    Set Location    21.1644523    -86.8262079
    Sleep    1s

Paso 1078
    Set Location    21.1644521    -86.8262103
    Sleep    1s

Paso 1079
    Set Location    21.1644543    -86.826214
    Sleep    1s

Paso 1080
    Set Location    21.1644538    -86.8262192
    Sleep    1s

Paso 1081
    Set Location    21.1644533    -86.8262208
    Sleep    1s

Paso 1082
    Set Location    21.1644543    -86.8262232
    Sleep    1s

Paso 1083
    Set Location    21.1644541    -86.8262245
    Sleep    1s

Paso 1084
    Set Location    21.1644539    -86.8262246
    Sleep    1s

Paso 1085
    Set Location    21.1644529    -86.8262282
    Sleep    1s

Paso 1086
    Set Location    21.1644524    -86.8262289
    Sleep    1s

Paso 1087
    Set Location    21.1644521    -86.8262288
    Sleep    1s

Paso 1088
    Set Location    21.164451    -86.8262304
    Sleep    1s

Paso 1089
    Set Location    21.1644504    -86.8262315
    Sleep    1s

Paso 1090
    Set Location    21.1644502    -86.8262318
    Sleep    1s

Paso 1091
    Set Location    21.1644501    -86.826232
    Sleep    1s

Paso 1092
    Set Location    21.1644498    -86.8262319
    Sleep    1s

Paso 1093
    Set Location    21.1644495    -86.8262321
    Sleep    1s

Paso 1094
    Set Location    21.1644492    -86.8262322
    Sleep    1s

Paso 1095
    Set Location    21.1644489    -86.8262337
    Sleep    1s

Paso 1096
    Set Location    21.1644484    -86.8262343
    Sleep    1s

Paso 1097
    Set Location    21.1644484    -86.8262344
    Sleep    1s

Paso 1098
    Set Location    21.1644474    -86.826236
    Sleep    1s

Paso 1099
    Set Location    21.1644474    -86.8262366
    Sleep    1s

Paso 1100
    Set Location    21.1644471    -86.8262371
    Sleep    1s

Paso 1101
    Set Location    21.1644472    -86.8262379
    Sleep    1s

Paso 1102
    Set Location    21.1644004    -86.8262527
    Sleep    1s

Paso 1103
    Set Location    21.1642998    -86.826149
    Sleep    1s

Paso 1104
    Set Location    21.1642457    -86.8261117
    Sleep    1s

Paso 1105
    Set Location    21.164169    -86.8261038
    Sleep    1s

Paso 1106
    Set Location    21.1639536    -86.8262159
    Sleep    1s

Paso 1107
    Set Location    21.1636557    -86.8262344
    Sleep    1s

Paso 1108
    Set Location    21.1633102    -86.8261618
    Sleep    1s

Paso 1109
    Set Location    21.1629544    -86.8259812
    Sleep    1s

Paso 1110
    Set Location    21.1625748    -86.8258438
    Sleep    1s

Paso 1111
    Set Location    21.162109    -86.8257752
    Sleep    1s

Paso 1112
    Set Location    21.1617101    -86.8257361
    Sleep    1s

Paso 1113
    Set Location    21.1615748    -86.825712
    Sleep    1s

Paso 1114
    Set Location    21.1614214    -86.8256904
    Sleep    1s

Paso 1115
    Set Location    21.1611326    -86.8256865
    Sleep    1s

Paso 1116
    Set Location    21.160749    -86.8256674
    Sleep    1s

Paso 1117
    Set Location    21.1603637    -86.8255955
    Sleep    1s

Paso 1118
    Set Location    21.1600283    -86.8256264
    Sleep    1s

Paso 1119
    Set Location    21.1598335    -86.8255696
    Sleep    1s

Paso 1120
    Set Location    21.1596227    -86.8255935
    Sleep    1s

Paso 1121
    Set Location    21.159238    -86.8255868
    Sleep    1s

Paso 1122
    Set Location    21.1588261    -86.8255584
    Sleep    1s

Paso 1123
    Set Location    21.1585158    -86.8255173
    Sleep    1s

Paso 1124
    Set Location    21.15828    -86.8255347
    Sleep    1s

Paso 1125
    Set Location    21.158052    -86.8254991
    Sleep    1s

Paso 1126
    Set Location    21.1577377    -86.8254517
    Sleep    1s

Paso 1127
    Set Location    21.1574979    -86.8254638
    Sleep    1s

Paso 1128
    Set Location    21.157481    -86.8254855
    Sleep    1s

Paso 1129
    Set Location    21.1574736    -86.8254405
    Sleep    1s

Paso 1130
    Set Location    21.1574709    -86.8254467
    Sleep    1s

Paso 1131
    Set Location    21.1574695    -86.8254479
    Sleep    1s

Paso 1132
    Set Location    21.1574689    -86.8254481
    Sleep    1s

Paso 1133
    Set Location    21.1574679    -86.825448
    Sleep    1s

Paso 1134
    Set Location    21.1574683    -86.8254469
    Sleep    1s

Paso 1135
    Set Location    21.1574683    -86.8254463
    Sleep    1s

Paso 1136
    Set Location    21.1574462    -86.825447
    Sleep    1s

Paso 1137
    Set Location    21.1572617    -86.8254957
    Sleep    1s

Paso 1138
    Set Location    21.1569197    -86.8255325
    Sleep    1s

Paso 1139
    Set Location    21.1565075    -86.825437
    Sleep    1s

Paso 1140
    Set Location    21.1560272    -86.8253186
    Sleep    1s

Paso 1141
    Set Location    21.155509    -86.8252601
    Sleep    1s

Paso 1142
    Set Location    21.1548669    -86.8251788
    Sleep    1s

Paso 1143
    Set Location    21.154121    -86.8251656
    Sleep    1s

Paso 1144
    Set Location    21.1533275    -86.8251046
    Sleep    1s

Paso 1145
    Set Location    21.1525909    -86.8250776
    Sleep    1s

Paso 1146
    Set Location    21.1517871    -86.8249986
    Sleep    1s

Paso 1147
    Set Location    21.1510312    -86.8249797
    Sleep    1s

Paso 1148
    Set Location    21.1502467    -86.8249302
    Sleep    1s

Paso 1149
    Set Location    21.1494401    -86.8248672
    Sleep    1s

Paso 1150
    Set Location    21.1486461    -86.8247323
    Sleep    1s

Paso 1151
    Set Location    21.1478249    -86.8246749
    Sleep    1s

Paso 1152
    Set Location    21.1470215    -86.8246051
    Sleep    1s

Paso 1153
    Set Location    21.1462319    -86.8245749
    Sleep    1s

Paso 1154
    Set Location    21.1454342    -86.8245628
    Sleep    1s

Paso 1155
    Set Location    21.144645    -86.8245107
    Sleep    1s

Paso 1156
    Set Location    21.1440324    -86.8244726
    Sleep    1s

Paso 1157
    Set Location    21.1437539    -86.82445
    Sleep    1s

Paso 1158
    Set Location    21.1437361    -86.8244521
    Sleep    1s

Paso 1159
    Set Location    21.1437348    -86.8244358
    Sleep    1s

Paso 1160
    Set Location    21.1437063    -86.8244447
    Sleep    1s

Paso 1161
    Set Location    21.1420867    -86.8244243
    Sleep    1s

Paso 1162
    Set Location    21.1415036    -86.8246333
    Sleep    1s

Paso 1163
    Set Location    21.1409236    -86.8249297
    Sleep    1s

Paso 1164
    Set Location    21.140287    -86.8252582
    Sleep    1s

Paso 1165
    Set Location    21.1398365    -86.8255552
    Sleep    1s

Paso 1166
    Set Location    21.1398367    -86.8255455
    Sleep    1s

Paso 1167
    Set Location    21.1398362    -86.8255419
    Sleep    1s

Paso 1168
    Set Location    21.1398355    -86.8255333
    Sleep    1s

Paso 1169
    Set Location    21.13983    -86.8255249
    Sleep    1s

Paso 1170
    Set Location    21.1386241    -86.8260962
    Sleep    1s

Paso 1171
    Set Location    21.1367288    -86.8269815
    Sleep    1s

Paso 1172
    Set Location    21.135976    -86.827388
    Sleep    1s

Paso 1173
    Set Location    21.1352521    -86.8277263
    Sleep    1s

Paso 1174
    Set Location    21.1344806    -86.8281056
    Sleep    1s

Paso 1175
    Set Location    21.1336945    -86.8285154
    Sleep    1s

Paso 1176
    Set Location    21.1329316    -86.8288635
    Sleep    1s

Paso 1177
    Set Location    21.132221    -86.8291742
    Sleep    1s

Paso 1178
    Set Location    21.1315618    -86.8294704
    Sleep    1s

Paso 1179
    Set Location    21.1306564    -86.8298953
    Sleep    1s

Paso 1180
    Set Location    21.1298245    -86.8303193
    Sleep    1s
