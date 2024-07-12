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
        Set Location    -23.6179296    -70.3891624
        Sleep    15s

Paso 0
    Set Location    21.1644339    -86.8262717
    Sleep    15s

Paso 1
    Set Location    21.1645116    -86.8262732
    Sleep    3s

Paso 2
    Set Location    21.1645117    -86.8262733
    Sleep    3s

Paso 3
    Set Location    21.1643633    -86.826185
    Sleep    3s

Paso 4
    Set Location    21.1643633    -86.826185
    Sleep    3s

Paso 5
    Set Location    21.1643467    -86.8261433
    Sleep    3s

Paso 6
    Set Location    21.1643467    -86.8261433
    Sleep    3s

Paso 7
    Set Location    21.1643017    -86.8261217
    Sleep    3s

Paso 8
    Set Location    21.1643017    -86.8261217
    Sleep    3s

Paso 9
    Set Location    21.16428    -86.8262183
    Sleep    3s

Paso 10
    Set Location    21.16428    -86.8262183
    Sleep    3s

Paso 11
    Set Location    21.1643382    -86.8262014
    Sleep    3s

Paso 12
    Set Location    21.1643383    -86.8262017
    Sleep    3s

Paso 13
    Set Location    21.1643383    -86.8262017
    Sleep    3s

Paso 14
    Set Location    21.1645009    -86.8264397
    Sleep    3s

Paso 15
    Set Location    21.1644567    -86.8265
    Sleep    3s

Paso 16
    Set Location    21.1644567    -86.8265
    Sleep    3s

Paso 17
    Set Location    21.1644019    -86.8262944
    Sleep    3s

Paso 18
    Set Location    21.1641549    -86.8261095
    Sleep    3s

Paso 19
    Set Location    21.1633586    -86.8261314
    Sleep    3s

Paso 20
    Set Location    21.1624043    -86.8257777
    Sleep    3s

Paso 21
    Set Location    21.1614736    -86.8257166
    Sleep    3s

Paso 22
    Set Location    21.1609011    -86.8256747
    Sleep    3s

Paso 23
    Set Location    21.1598703    -86.8256009
    Sleep    3s

Paso 24
    Set Location    21.1592573    -86.8255446
    Sleep    3s

Paso 25
    Set Location    21.1583624    -86.8254917
    Sleep    3s

Paso 26
    Set Location    21.1580833    -86.8254717
    Sleep    3s

Paso 27
    Set Location    21.1573076    -86.8254626
    Sleep    3s

Paso 28
    Set Location    21.1566237    -86.8254687
    Sleep    3s

Paso 29
    Set Location    21.1555527    -86.8252545
    Sleep    3s

Paso 30
    Set Location    21.1535337    -86.8250998
    Sleep    3s

Paso 31
    Set Location    21.1517044    -86.82498
    Sleep    3s

Paso 32
    Set Location    21.1504813    -86.8249212
    Sleep    3s

Paso 33
    Set Location    21.1504667    -86.8249233
    Sleep    3s

Paso 34
    Set Location    21.1496396    -86.8248817
    Sleep    3s

Paso 35
    Set Location    21.148127    -86.8247184
    Sleep    3s

Paso 36
    Set Location    21.1462911    -86.8245451
    Sleep    3s

Paso 37
    Set Location    21.1453463    -86.8245064
    Sleep    3s

Paso 38
    Set Location    21.1453467    -86.8245099
    Sleep    3s

Paso 39
    Set Location    21.1453467    -86.82451
    Sleep    3s

Paso 40
    Set Location    21.145161    -86.8245146
    Sleep    3s

Paso 41
    Set Location    21.1438492    -86.8244424
    Sleep    3s

Paso 42
    Set Location    21.1418464    -86.8244723
    Sleep    3s

Paso 43
    Set Location    21.1414852    -86.8246078
    Sleep    3s

Paso 44
    Set Location    21.140869    -86.8249178
    Sleep    3s

Paso 45
    Set Location    21.1408182    -86.8249413
    Sleep    3s

Paso 46
    Set Location    21.1398403    -86.8254991
    Sleep    3s

Paso 47
    Set Location    21.1381806    -86.8262128
    Sleep    3s

Paso 48
    Set Location    21.1360853    -86.8272328
    Sleep    3s

Paso 49
    Set Location    21.1336765    -86.8284099
    Sleep    3s

Paso 50
    Set Location    21.1310785    -86.8296725
    Sleep    3s

Paso 51
    Set Location    21.1286198    -86.830855
    Sleep    3s

Paso 52
    Set Location    21.1267165    -86.8318163
    Sleep    3s

Paso 53
    Set Location    21.1245227    -86.8328956
    Sleep    3s

Paso 54
    Set Location    21.1223521    -86.8339546
    Sleep    3s

Paso 55
    Set Location    21.1201137    -86.8350527
    Sleep    3s

Paso 56
    Set Location    21.1177089    -86.8362214
    Sleep    3s

Paso 57
    Set Location    21.1153067    -86.8373922
    Sleep    3s

Paso 58
    Set Location    21.1128232    -86.8385963
    Sleep    3s

Paso 59
    Set Location    21.1102813    -86.8391599
    Sleep    3s

Paso 60
    Set Location    21.1077237    -86.8395579
    Sleep    3s

Paso 61
    Set Location    21.1052285    -86.8399479
    Sleep    3s

Paso 62
    Set Location    21.1033334    -86.8402317
    Sleep    3s

Paso 63
    Set Location    21.1021131    -86.8404385
    Sleep    3s

Paso 64
    Set Location    21.1002764    -86.8407278
    Sleep    3s

Paso 65
    Set Location    21.0980488    -86.8410629
    Sleep    3s

Paso 66
    Set Location    21.095669    -86.8414365
    Sleep    3s

Paso 67
    Set Location    21.0932354    -86.8418083
    Sleep    3s

Paso 68
    Set Location    21.090772    -86.8421532
    Sleep    3s

Paso 69
    Set Location    21.0882539    -86.8425181
    Sleep    3s

Paso 70
    Set Location    21.085692    -86.8429325
    Sleep    3s

Paso 71
    Set Location    21.0831635    -86.8433966
    Sleep    3s

Paso 72
    Set Location    21.0806154    -86.8438064
    Sleep    3s

Paso 73
    Set Location    21.0779599    -86.8442119
    Sleep    3s

Paso 74
    Set Location    21.0751347    -86.8446632
    Sleep    3s

Paso 75
    Set Location    21.0723522    -86.8450724
    Sleep    3s

Paso 76
    Set Location    21.0695586    -86.8455183
    Sleep    3s

Paso 77
    Set Location    21.0667517    -86.8459579
    Sleep    3s

Paso 78
    Set Location    21.0639964    -86.8463948
    Sleep    3s

Paso 79
    Set Location    21.0612421    -86.8468059
    Sleep    3s

Paso 80
    Set Location    21.0590779    -86.847156
    Sleep    3s

Paso 81
    Set Location    21.0558135    -86.8476649
    Sleep    3s

Paso 82
    Set Location    21.0530915    -86.8480789
    Sleep    3s

Paso 83
    Set Location    21.0504483    -86.8484995
    Sleep    3s

Paso 84
    Set Location    21.048204    -86.8488281
    Sleep    3s

Paso 85
    Set Location    21.0458374    -86.8492119
    Sleep    3s

Paso 86
    Set Location    21.0431431    -86.8496584
    Sleep    3s

Paso 87
    Set Location    21.0403682    -86.8501243
    Sleep    3s

Paso 88
    Set Location    21.0376929    -86.8506563
    Sleep    3s

Paso 89
    Set Location    21.0351486    -86.85181
    Sleep    3s

Paso 90
    Set Location    21.0342334    -86.8545768
    Sleep    3s

Paso 91
    Set Location    21.0354593    -86.8570939
    Sleep    3s

Paso 92
    Set Location    21.0369349    -86.8593342
    Sleep    3s

Paso 93
    Set Location    21.0381014    -86.8613273
    Sleep    3s

Paso 94
    Set Location    21.0393431    -86.8633559
    Sleep    3s

Paso 95
    Set Location    21.0406214    -86.8653277
    Sleep    3s

Paso 96
    Set Location    21.0417114    -86.8670567
    Sleep    3s

Paso 97
    Set Location    21.0428762    -86.8689067
    Sleep    3s

Paso 98
    Set Location    21.0441968    -86.8710249
    Sleep    3s

Paso 99
    Set Location    21.0455347    -86.8731745
    Sleep    3s

Paso 100
    Set Location    21.0465768    -86.8752293
    Sleep    3s

Paso 101
    Set Location    21.045662    -86.8767714
    Sleep    3s

Paso 102
    Set Location    21.0465201    -86.8782819
    Sleep    3s

Paso 103
    Set Location    21.0469849    -86.8790029
    Sleep    3s

Paso 104
    Set Location    21.0469194    -86.8796815
    Sleep    3s

Paso 105
    Set Location    21.0462195    -86.8801498
    Sleep    3s

Paso 106
    Set Location    21.045626    -86.8805811
    Sleep    3s

Paso 107
    Set Location    21.044818    -86.880819
    Sleep    3s

Paso 108
    Set Location    21.0452283    -86.8802697
    Sleep    3s

Paso 109
    Set Location    21.0452283    -86.88027
    Sleep    3s

Paso 110
    Set Location    21.0455508    -86.8800484
    Sleep    3s

Paso 111
    Set Location    21.0449636    -86.8788228
    Sleep    3s

Paso 112
    Set Location    21.0444193    -86.8772519
    Sleep    3s

Paso 113
    Set Location    21.0460543    -86.8760322
    Sleep    3s

Paso 114
    Set Location    21.0459001    -86.8739785
    Sleep    3s

Paso 115
    Set Location    21.0447381    -86.8721956
    Sleep    3s

Paso 116
    Set Location    21.043609    -86.8725193
    Sleep    3s

Paso 117
    Set Location    21.0420365    -86.8735544
    Sleep    3s

Paso 118
    Set Location    21.0410752    -86.8740748
    Sleep    3s

Paso 119
    Set Location    21.0408367    -86.8737054
    Sleep    3s

Paso 120
    Set Location    21.04066    -86.8734265
    Sleep    3s

Paso 121
    Set Location    21.0404647    -86.8731019
    Sleep    3s

Paso 122
    Set Location    21.0400513    -86.8724759
    Sleep    3s

Paso 123
    Set Location    21.04    -86.8720319
    Sleep    3s

Paso 124
    Set Location    21.04    -86.8720317
    Sleep    3s

Paso 125
    Set Location    21.04    -86.8720317
    Sleep    3s

Paso 126
    Set Location    21.040432    -86.8716104
    Sleep    3s

Paso 127
    Set Location    21.0399695    -86.8706068
    Sleep    3s

Paso 128
    Set Location    21.0388142    -86.8698916
    Sleep    3s

Paso 129
    Set Location    21.03847    -86.8695333
    Sleep    3s

Paso 130
    Set Location    21.038298    -86.8691961
    Sleep    3s

Paso 131
    Set Location    21.0380952    -86.8684777
    Sleep    3s

Paso 132
    Set Location    21.038855    -86.8690469
    Sleep    3s

Paso 133
    Set Location    21.0392658    -86.8697634
    Sleep    3s

Paso 134
    Set Location    21.0387592    -86.8702709
    Sleep    3s

Paso 135
    Set Location    21.0380328    -86.8708487
    Sleep    3s

Paso 136
    Set Location    21.0385346    -86.8717255
    Sleep    3s

Paso 137
    Set Location    21.0389443    -86.872482
    Sleep    3s

Paso 138
    Set Location    21.0395592    -86.8723457
    Sleep    3s

Paso 139
    Set Location    21.0397667    -86.8721967
    Sleep    3s

Paso 140
    Set Location    21.039845    -86.8721367
    Sleep    3s

Paso 141
    Set Location    21.039845    -86.8721367
    Sleep    3s

Paso 142
    Set Location    21.0398833    -86.87208
    Sleep    3s

Paso 143
    Set Location    21.0398833    -86.87208
    Sleep    3s

Paso 144
    Set Location    21.03995    -86.8720367
    Sleep    3s

Paso 145
    Set Location    21.03995    -86.8720367
    Sleep    3s

Paso 146
    Set Location    21.0400333    -86.8720833
    Sleep    3s

Paso 147
    Set Location    21.0400333    -86.8720833
    Sleep    3s

Paso 148
    Set Location    21.0401985    -86.8719435
    Sleep    3s

Paso 149
    Set Location    21.040289    -86.8712626
    Sleep    3s

Paso 150
    Set Location    21.0396874    -86.8701208
    Sleep    3s

Paso 151
    Set Location    21.0401113    -86.8692937
    Sleep    3s

Paso 152
    Set Location    21.0404992    -86.8689988
    Sleep    3s

Paso 153
    Set Location    21.0413199    -86.868367
    Sleep    3s

Paso 154
    Set Location    21.0416327    -86.8671469
    Sleep    3s

Paso 155
    Set Location    21.04051    -86.8653885
    Sleep    3s

Paso 156
    Set Location    21.0390226    -86.863009
    Sleep    3s

Paso 157
    Set Location    21.037629    -86.8607433
    Sleep    3s

Paso 158
    Set Location    21.0370784    -86.8598921
    Sleep    3s

Paso 159
    Set Location    21.0364506    -86.8588669
    Sleep    3s

Paso 160
    Set Location    21.0352182    -86.8569264
    Sleep    3s

Paso 161
    Set Location    21.033875    -86.8547279
    Sleep    3s

Paso 162
    Set Location    21.0332917    -86.8525446
    Sleep    3s

Paso 163
    Set Location    21.0328906    -86.8509382
    Sleep    3s

Paso 164
    Set Location    21.0321852    -86.8516785
    Sleep    3s

Paso 165
    Set Location    21.0331661    -86.8518504
    Sleep    3s

Paso 166
    Set Location    21.0349323    -86.8514679
    Sleep    3s

Paso 167
    Set Location    21.0373505    -86.8505566
    Sleep    3s

Paso 168
    Set Location    21.0400296    -86.8500118
    Sleep    3s

Paso 169
    Set Location    21.0427947    -86.849605
    Sleep    3s

Paso 170
    Set Location    21.0455278    -86.8491732
    Sleep    3s

Paso 171
    Set Location    21.0482634    -86.8487383
    Sleep    3s

Paso 172
    Set Location    21.0510148    -86.8483165
    Sleep    3s

Paso 173
    Set Location    21.0537814    -86.8478934
    Sleep    3s

Paso 174
    Set Location    21.0565302    -86.8474637
    Sleep    3s

Paso 175
    Set Location    21.0592831    -86.8470254
    Sleep    3s

Paso 176
    Set Location    21.0620549    -86.8466286
    Sleep    3s

Paso 177
    Set Location    21.0648485    -86.8461954
    Sleep    3s

Paso 178
    Set Location    21.0676611    -86.845739
    Sleep    3s

Paso 179
    Set Location    21.0705348    -86.8452368
    Sleep    3s

Paso 180
    Set Location    21.0733552    -86.8448244
    Sleep    3s

Paso 181
    Set Location    21.0761263    -86.8443937
    Sleep    3s

Paso 182
    Set Location    21.0810644    -86.8436208
    Sleep    3s

Paso 183
    Set Location    21.0839014    -86.8431856
    Sleep    3s

Paso 184
    Set Location    21.0866927    -86.8426738
    Sleep    3s

Paso 185
    Set Location    21.088397    -86.8423702
    Sleep    3s

Paso 186
    Set Location    21.0921152    -86.8418919
    Sleep    3s

Paso 187
    Set Location    21.0948634    -86.8414719
    Sleep    3s

Paso 188
    Set Location    21.0975044    -86.8410501
    Sleep    3s

Paso 189
    Set Location    21.099735    -86.8407017
    Sleep    3s

Paso 190
    Set Location    21.1007774    -86.8405403
    Sleep    3s

Paso 191
    Set Location    21.1030098    -86.8401856
    Sleep    3s

Paso 192
    Set Location    21.1055797    -86.8397852
    Sleep    3s

Paso 193
    Set Location    21.1080793    -86.8393871
    Sleep    3s

Paso 194
    Set Location    21.1107015    -86.8389832
    Sleep    3s

Paso 195
    Set Location    21.1132121    -86.8383204
    Sleep    3s

Paso 196
    Set Location    21.1152603    -86.8373139
    Sleep    3s

Paso 197
    Set Location    21.1173777    -86.8362755
    Sleep    3s

Paso 198
    Set Location    21.1197131    -86.8351334
    Sleep    3s

Paso 199
    Set Location    21.1219305    -86.8340454
    Sleep    3s

Paso 200
    Set Location    21.1243776    -86.8328485
    Sleep    3s

Paso 201
    Set Location    21.1268532    -86.8316653
    Sleep    3s

Paso 202
    Set Location    21.1294204    -86.8303836
    Sleep    3s

Paso 203
    Set Location    21.131897    -86.82915
    Sleep    3s

Paso 204
    Set Location    21.1341967    -86.828035
    Sleep    3s

Paso 205
    Set Location    21.1364823    -86.8269181
    Sleep    3s

Paso 206
    Set Location    21.1378861    -86.8262199
    Sleep    3s

Paso 207
    Set Location    21.13792    -86.8262067
    Sleep    3s

Paso 208
    Set Location    21.1387419    -86.8257787
    Sleep    3s

Paso 209
    Set Location    21.1400972    -86.8251413
    Sleep    3s

Paso 210
    Set Location    21.1416697    -86.8243829
    Sleep    3s

Paso 211
    Set Location    21.143433    -86.8241971
    Sleep    3s

Paso 212
    Set Location    21.1436017    -86.8242217
    Sleep    3s

Paso 213
    Set Location    21.1436017    -86.8242217
    Sleep    3s

Paso 214
    Set Location    21.1437354    -86.8242306
    Sleep    3s

Paso 215
    Set Location    21.1450361    -86.8243223
    Sleep    3s

Paso 216
    Set Location    21.14652    -86.8244417
    Sleep    3s

Paso 217
    Set Location    21.1465483    -86.824455
    Sleep    3s

Paso 218
    Set Location    21.1465483    -86.824455
    Sleep    3s

Paso 219
    Set Location    21.1465808    -86.8244704
    Sleep    3s

Paso 220
    Set Location    21.1476182    -86.8245755
    Sleep    3s

Paso 221
    Set Location    21.1484648    -86.8246417
    Sleep    3s

Paso 222
    Set Location    21.1487167    -86.8246416
    Sleep    3s

Paso 223
    Set Location    21.1499521    -86.8246689
    Sleep    3s

Paso 224
    Set Location    21.152124    -86.8249136
    Sleep    3s

Paso 225
    Set Location    21.154582    -86.8251056
    Sleep    3s

Paso 226
    Set Location    21.1560828    -86.8252039
    Sleep    3s

Paso 227
    Set Location    21.1560667    -86.8252067
    Sleep    3s

Paso 228
    Set Location    21.1560667    -86.8252067
    Sleep    3s

Paso 229
    Set Location    21.1564812    -86.8251617
    Sleep    3s

Paso 230
    Set Location    21.1572214    -86.8251445
    Sleep    3s

Paso 231
    Set Location    21.1582067    -86.8254101
    Sleep    3s

Paso 232
    Set Location    21.1585967    -86.8254633
    Sleep    3s

Paso 233
    Set Location    21.1597148    -86.8255315
    Sleep    3s

Paso 234
    Set Location    21.160778    -86.825607
    Sleep    3s

Paso 235
    Set Location    21.1618615    -86.8256966
    Sleep    3s

Paso 236
    Set Location    21.1629664    -86.825709
    Sleep    3s

Paso 237
    Set Location    21.1633506    -86.8253899
    Sleep    3s

Paso 238
    Set Location    21.1641913    -86.8259803
    Sleep    3s

Paso 239
    Set Location    21.1639811    -86.8266563
    Sleep    3s

Paso 240
    Set Location    21.1642955    -86.8264662
    Sleep    3s

Paso 241
    Set Location    21.1642933    -86.8264817
    Sleep    3s

Paso 242
    Set Location    21.164195    -86.8265
    Sleep    3s

Paso 243
    Set Location    21.164195    -86.8265
    Sleep    3s

Paso 244
    Set Location    21.1642854    -86.8263343
    Sleep    3s

Paso 245
    Set Location    21.1643033    -86.8263217
    Sleep    3s

Paso 246
    Set Location    21.1642057    -86.8263161
    Sleep    3s

Paso 247
    Set Location    21.1642    -86.8263167
    Sleep    3s

Paso 248
    Set Location    21.1642    -86.8263167
    Sleep    3s

Paso 249
    Set Location    21.16412    -86.82627
    Sleep    3s

Paso 250
    Set Location    21.16412    -86.82627
    Sleep    3s

Paso 251
    Set Location    21.164325    -86.8262176
    Sleep    3s

Paso 252
    Set Location    21.16442    -86.8262417
    Sleep    3s

Paso 253
    Set Location    21.16442    -86.8262417
    Sleep    3s

Paso 254
    Set Location    21.1642693    -86.826159
    Sleep    3s

Paso 255
    Set Location    21.1642617    -86.8261533
    Sleep    3s

Paso 256
    Set Location    21.1642617    -86.8261533
    Sleep    3s

Paso 257
    Set Location    21.1643382    -86.8262282
    Sleep    3s

Paso 258
    Set Location    21.1643929    -86.8262962
    Sleep    3s

Paso 259
    Set Location    21.1644117    -86.8262833
    Sleep    3s

Paso 260
    Set Location    21.1644117    -86.8262833
    Sleep    3s

Paso 261
    Set Location    21.1642829    -86.8262217
    Sleep    3s

Paso 262
    Set Location    21.1641957    -86.8261192
    Sleep    3s

Paso 263
    Set Location    21.1638154    -86.8262046
    Sleep    3s

Paso 264
    Set Location    21.162662    -86.8258047
    Sleep    3s

Paso 265
    Set Location    21.1614694    -86.8257
    Sleep    3s

Paso 266
    Set Location    21.1602583    -86.8256284
    Sleep    3s

Paso 267
    Set Location    21.1595093    -86.8255407
    Sleep    3s

Paso 268
    Set Location    21.1586326    -86.8254912
    Sleep    3s

Paso 269
    Set Location    21.1583357    -86.82547
    Sleep    3s

Paso 270
    Set Location    21.15801    -86.8254483
    Sleep    3s

Paso 271
    Set Location    21.15801    -86.8254483
    Sleep    3s

Paso 272
    Set Location    21.1571249    -86.8255173
    Sleep    3s

Paso 273
    Set Location    21.156073    -86.8253271
    Sleep    3s

Paso 274
    Set Location    21.1542801    -86.8251698
    Sleep    3s

Paso 275
    Set Location    21.1520882    -86.8249965
    Sleep    3s

Paso 276
    Set Location    21.1506142    -86.8249058
    Sleep    3s

Paso 277
    Set Location    21.1504767    -86.8249167
    Sleep    3s

Paso 278
    Set Location    21.1504767    -86.8249167
    Sleep    3s

Paso 279
    Set Location    21.1496124    -86.8248846
    Sleep    3s

Paso 280
    Set Location    21.1481301    -86.8246963
    Sleep    3s

Paso 281
    Set Location    21.1463534    -86.824573
    Sleep    3s

Paso 282
    Set Location    21.1451441    -86.8245415
    Sleep    3s

Paso 283
    Set Location    21.145075    -86.8245383
    Sleep    3s

Paso 284
    Set Location    21.1449095    -86.8245167
    Sleep    3s

Paso 285
    Set Location    21.1436729    -86.824467
    Sleep    3s

Paso 286
    Set Location    21.1417043    -86.8245337
    Sleep    3s

Paso 287
    Set Location    21.1401661    -86.8252553
    Sleep    3s

Paso 288
    Set Location    21.1399983    -86.8253133
    Sleep    3s

Paso 289
    Set Location    21.1399983    -86.8253133
    Sleep    3s

Paso 290
    Set Location    21.1396352    -86.8256314
    Sleep    3s

Paso 291
    Set Location    21.1380962    -86.8262828
    Sleep    3s

Paso 292
    Set Location    21.1359606    -86.8272737
    Sleep    3s

Paso 293
    Set Location    21.1334351    -86.8285345
    Sleep    3s

Paso 294
    Set Location    21.1308538    -86.829789
    Sleep    3s

Paso 295
    Set Location    21.128524    -86.830917
    Sleep    3s

Paso 296
    Set Location    21.125762    -86.8323191
    Sleep    3s

Paso 297
    Set Location    21.1233802    -86.8334882
    Sleep    3s

Paso 298
    Set Location    21.1213121    -86.8344367
    Sleep    3s

Paso 299
    Set Location    21.1188606    -86.835669
    Sleep    3s

Paso 300
    Set Location    21.1162811    -86.8369237
    Sleep    3s

Paso 301
    Set Location    21.1137414    -86.8381667
    Sleep    3s

Paso 302
    Set Location    21.1111094    -86.8390629
    Sleep    3s

Paso 303
    Set Location    21.108448    -86.8394444
    Sleep    3s

Paso 304
    Set Location    21.1056511    -86.8398871
    Sleep    3s

Paso 305
    Set Location    21.1030203    -86.8403297
    Sleep    3s

Paso 306
    Set Location    21.1026584    -86.8403898
    Sleep    3s

Paso 307
    Set Location    21.10207    -86.8404867
    Sleep    3s

Paso 308
    Set Location    21.1020363    -86.8404937
    Sleep    3s

Paso 309
    Set Location    21.1008305    -86.8406716
    Sleep    3s

Paso 310
    Set Location    21.098665    -86.8410115
    Sleep    3s

Paso 311
    Set Location    21.0961423    -86.8413962
    Sleep    3s

Paso 312
    Set Location    21.0940419    -86.8417524
    Sleep    3s

Paso 313
    Set Location    21.0912678    -86.8421205
    Sleep    3s

Paso 314
    Set Location    21.0884475    -86.8425261
    Sleep    3s

Paso 315
    Set Location    21.0855755    -86.8429471
    Sleep    3s

Paso 316
    Set Location    21.0827795    -86.8434881
    Sleep    3s

Paso 317
    Set Location    21.0798864    -86.843946
    Sleep    3s

Paso 318
    Set Location    21.0770079    -86.8443816
    Sleep    3s

Paso 319
    Set Location    21.0741833    -86.8448258
    Sleep    3s

Paso 320
    Set Location    21.0713066    -86.8452763
    Sleep    3s

Paso 321
    Set Location    21.068461    -86.8457497
    Sleep    3s

Paso 322
    Set Location    21.0656766    -86.8461813
    Sleep    3s

Paso 323
    Set Location    21.0628536    -86.8466096
    Sleep    3s

Paso 324
    Set Location    21.060095    -86.8470584
    Sleep    3s

Paso 325
    Set Location    21.0573597    -86.847491
    Sleep    3s

Paso 326
    Set Location    21.0545849    -86.8479249
    Sleep    3s

Paso 327
    Set Location    21.05187    -86.8483528
    Sleep    3s

Paso 328
    Set Location    21.0491846    -86.8487816
    Sleep    3s

Paso 329
    Set Location    21.0465067    -86.8491772
    Sleep    3s

Paso 330
    Set Location    21.0439604    -86.8495868
    Sleep    3s

Paso 331
    Set Location    21.0412312    -86.850045
    Sleep    3s

Paso 332
    Set Location    21.0386242    -86.8504665
    Sleep    3s

Paso 333
    Set Location    21.0374112    -86.850834
    Sleep    3s

Paso 334
    Set Location    21.0374117    -86.8508333
    Sleep    3s

Paso 335
    Set Location    21.0364522    -86.8511679
    Sleep    3s

Paso 336
    Set Location    21.0347808    -86.8522779
    Sleep    3s

Paso 337
    Set Location    21.0343082    -86.8549128
    Sleep    3s

Paso 338
    Set Location    21.0355208    -86.8571768
    Sleep    3s

Paso 339
    Set Location    21.0370651    -86.8595288
    Sleep    3s

Paso 340
    Set Location    21.0385687    -86.8620307
    Sleep    3s

Paso 341
    Set Location    21.0399545    -86.8642342
    Sleep    3s

Paso 342
    Set Location    21.0412954    -86.8663869
    Sleep    3s

Paso 343
    Set Location    21.0424656    -86.8682722
    Sleep    3s

Paso 344
    Set Location    21.0437956    -86.8704078
    Sleep    3s

Paso 345
    Set Location    21.0450284    -86.8723655
    Sleep    3s

Paso 346
    Set Location    21.0462387    -86.8743685
    Sleep    3s

Paso 347
    Set Location    21.0460618    -86.8762787
    Sleep    3s

Paso 348
    Set Location    21.0460791    -86.8775768
    Sleep    3s

Paso 349
    Set Location    21.0468235    -86.8787389
    Sleep    3s

Paso 350
    Set Location    21.0469968    -86.8790235
    Sleep    3s

Paso 351
    Set Location    21.0471898    -86.8793661
    Sleep    3s

Paso 352
    Set Location    21.0468829    -86.8797553
    Sleep    3s

Paso 353
    Set Location    21.0465784    -86.8799755
    Sleep    3s

Paso 354
    Set Location    21.0465023    -86.8800073
    Sleep    3s

Paso 355
    Set Location    21.0459876    -86.8803496
    Sleep    3s

Paso 356
    Set Location    21.0451524    -86.8809641
    Sleep    3s

Paso 357
    Set Location    21.0451793    -86.8803654
    Sleep    3s

Paso 358
    Set Location    21.04531    -86.880315
    Sleep    3s

Paso 359
    Set Location    21.04531    -86.880315
    Sleep    3s

Paso 360
    Set Location    21.0455536    -86.8801923
    Sleep    3s

Paso 361
    Set Location    21.0450824    -86.8789737
    Sleep    3s

Paso 362
    Set Location    21.044376    -86.8774039
    Sleep    3s

Paso 363
    Set Location    21.0445527    -86.8771869
    Sleep    3s

Paso 364
    Set Location    21.0463785    -86.8756463
    Sleep    3s

Paso 365
    Set Location    21.0459064    -86.8739869
    Sleep    3s

Paso 366
    Set Location    21.0457318    -86.8736982
    Sleep    3s

Paso 367
    Set Location    21.0456417    -86.87356
    Sleep    3s

Paso 368
    Set Location    21.0453324    -86.873082
    Sleep    3s

Paso 369
    Set Location    21.0443474    -86.8720705
    Sleep    3s

Paso 370
    Set Location    21.0429817    -86.8729495
    Sleep    3s

Paso 371
    Set Location    21.041454    -86.8740252
    Sleep    3s

Paso 372
    Set Location    21.0409507    -86.8738903
    Sleep    3s

Paso 373
    Set Location    21.0406934    -86.8735065
    Sleep    3s

Paso 374
    Set Location    21.0403135    -86.8729251
    Sleep    3s

Paso 375
    Set Location    21.0398788    -86.8723165
    Sleep    3s

Paso 376
    Set Location    21.0398233    -86.8722783
    Sleep    3s

Paso 377
    Set Location    21.0398233    -86.8722783
    Sleep    3s

Paso 378
    Set Location    21.0397733    -86.8723033
    Sleep    3s

Paso 379
    Set Location    21.0397733    -86.8723033
    Sleep    3s

Paso 380
    Set Location    21.0394398    -86.8725276
    Sleep    3s

Paso 381
    Set Location    21.03934    -86.872595
    Sleep    3s

Paso 382
    Set Location    21.0391833    -86.8727731
    Sleep    3s

Paso 383
    Set Location    21.0391717    -86.872765
    Sleep    3s

Paso 384
    Set Location    21.0391717    -86.872765
    Sleep    3s

Paso 385
    Set Location    21.0392433    -86.8726867
    Sleep    3s

Paso 386
    Set Location    21.0392433    -86.8726867
    Sleep    3s

Paso 387
    Set Location    21.0392841    -86.8726179
    Sleep    3s

Paso 388
    Set Location    21.0392917    -86.8726017
    Sleep    3s

Paso 389
    Set Location    21.0392917    -86.8726017
    Sleep    3s

Paso 390
    Set Location    21.0393793    -86.8725292
    Sleep    3s

Paso 391
    Set Location    21.0396717    -86.8722749
    Sleep    3s

Paso 392
    Set Location    21.03968    -86.8722667
    Sleep    3s

Paso 393
    Set Location    21.03968    -86.8722667
    Sleep    3s

Paso 394
    Set Location    21.0397183    -86.8722
    Sleep    3s

Paso 395
    Set Location    21.0397183    -86.8722
    Sleep    3s

Paso 396
    Set Location    21.0398    -86.8721517
    Sleep    3s

Paso 397
    Set Location    21.0398    -86.8721517
    Sleep    3s

Paso 398
    Set Location    21.039883    -86.8720918
    Sleep    3s

Paso 399
    Set Location    21.0399117    -86.8720683
    Sleep    3s

Paso 400
    Set Location    21.0399117    -86.8720683
    Sleep    3s

Paso 401
    Set Location    21.0400017    -86.872005
    Sleep    3s

Paso 402
    Set Location    21.0400017    -86.872005
    Sleep    3s

Paso 403
    Set Location    21.0401911    -86.8719136
    Sleep    3s

Paso 404
    Set Location    21.0402374    -86.8711309
    Sleep    3s

Paso 405
    Set Location    21.0396114    -86.8697217
    Sleep    3s

Paso 406
    Set Location    21.0404348    -86.8690463
    Sleep    3s

Paso 407
    Set Location    21.0405908    -86.8689287
    Sleep    3s

Paso 408
    Set Location    21.0414847    -86.868292
    Sleep    3s

Paso 409
    Set Location    21.0415367    -86.8669416
    Sleep    3s

Paso 410
    Set Location    21.0402536    -86.8649017
    Sleep    3s

Paso 411
    Set Location    21.0387459    -86.8625255
    Sleep    3s

Paso 412
    Set Location    21.0373096    -86.8601887
    Sleep    3s

Paso 413
    Set Location    21.036905    -86.8595367
    Sleep    3s

Paso 414
    Set Location    21.0365045    -86.858901
    Sleep    3s

Paso 415
    Set Location    21.0353746    -86.8571492
    Sleep    3s

Paso 416
    Set Location    21.033975    -86.8548779
    Sleep    3s

Paso 417
    Set Location    21.0332807    -86.8524897
    Sleep    3s

Paso 418
    Set Location    21.03274    -86.8508452
    Sleep    3s

Paso 419
    Set Location    21.0322624    -86.8517627
    Sleep    3s

Paso 420
    Set Location    21.0335379    -86.8517547
    Sleep    3s

Paso 421
    Set Location    21.0355688    -86.851132
    Sleep    3s

Paso 422
    Set Location    21.0379101    -86.8503572
    Sleep    3s

Paso 423
    Set Location    21.040548    -86.8499032
    Sleep    3s

Paso 424
    Set Location    21.0432482    -86.8494853
    Sleep    3s

Paso 425
    Set Location    21.045975    -86.8490606
    Sleep    3s

Paso 426
    Set Location    21.0487032    -86.8486458
    Sleep    3s

Paso 427
    Set Location    21.0514612    -86.8482116
    Sleep    3s

Paso 428
    Set Location    21.0542263    -86.8477904
    Sleep    3s

Paso 429
    Set Location    21.0569937    -86.8473548
    Sleep    3s

Paso 430
    Set Location    21.0597717    -86.8469237
    Sleep    3s

Paso 431
    Set Location    21.0625658    -86.846487
    Sleep    3s

Paso 432
    Set Location    21.065363    -86.8460391
    Sleep    3s

Paso 433
    Set Location    21.0680649    -86.8456057
    Sleep    3s

Paso 434
    Set Location    21.0707817    -86.84516
    Sleep    3s

Paso 435
    Set Location    21.0734498    -86.8447831
    Sleep    3s

Paso 436
    Set Location    21.0762459    -86.8443323
    Sleep    3s

Paso 437
    Set Location    21.0790269    -86.8438707
    Sleep    3s

Paso 438
    Set Location    21.0817898    -86.8434718
    Sleep    3s

Paso 439
    Set Location    21.0845985    -86.843
    Sleep    3s

Paso 440
    Set Location    21.0874287    -86.8425216
    Sleep    3s

Paso 441
    Set Location    21.0891278    -86.8422322
    Sleep    3s

Paso 442
    Set Location    21.0946556    -86.841482
    Sleep    3s

Paso 443
    Set Location    21.0974951    -86.8410255
    Sleep    3s

Paso 444
    Set Location    21.1001793    -86.8406013
    Sleep    3s

Paso 445
    Set Location    21.1009649    -86.8404767
    Sleep    3s

Paso 446
    Set Location    21.100965    -86.8404767
    Sleep    3s

Paso 447
    Set Location    21.1017598    -86.840357
    Sleep    3s

Paso 448
    Set Location    21.1037902    -86.8400338
    Sleep    3s

Paso 449
    Set Location    21.1062104    -86.83966
    Sleep    3s

Paso 450
    Set Location    21.1084284    -86.8393103
    Sleep    3s

Paso 451
    Set Location    21.1105706    -86.8389818
    Sleep    3s

Paso 452
    Set Location    21.1115898    -86.8388201
    Sleep    3s

Paso 453
    Set Location    21.1122322    -86.8386738
    Sleep    3s

Paso 454
    Set Location    21.112819    -86.8384689
    Sleep    3s

Paso 455
    Set Location    21.1131598    -86.8382923
    Sleep    3s

Paso 456
    Set Location    21.1136287    -86.8380634
    Sleep    3s

Paso 457
    Set Location    21.1139345    -86.8379164
    Sleep    3s

Paso 458
    Set Location    21.1145586    -86.8376211
    Sleep    3s

Paso 459
    Set Location    21.1152449    -86.837282
    Sleep    3s

Paso 460
    Set Location    21.1158014    -86.8370174
    Sleep    3s

Paso 461
    Set Location    21.11633    -86.8367607
    Sleep    3s

Paso 462
    Set Location    21.1172275    -86.8363175
    Sleep    3s

Paso 463
    Set Location    21.1181689    -86.8358753
    Sleep    3s

Paso 464
    Set Location    21.1199374    -86.8350168
    Sleep    3s

Paso 465
    Set Location    21.1221349    -86.8339461
    Sleep    3s

Paso 466
    Set Location    21.1246489    -86.8327137
    Sleep    3s

Paso 467
    Set Location    21.1272283    -86.8314498
    Sleep    3s

Paso 468
    Set Location    21.129885    -86.8301577
    Sleep    3s

Paso 469
    Set Location    21.1324073    -86.8289345
    Sleep    3s

Paso 470
    Set Location    21.1346845    -86.827774
    Sleep    3s

Paso 471
    Set Location    21.1368881    -86.8266657
    Sleep    3s

Paso 472
    Set Location    21.1387219    -86.825762
    Sleep    3s

Paso 473
    Set Location    21.1401467    -86.8250989
    Sleep    3s

Paso 474
    Set Location    21.1419529    -86.8242903
    Sleep    3s

Paso 475
    Set Location    21.1430961    -86.8241548
    Sleep    3s

Paso 476
    Set Location    21.1430967    -86.824155
    Sleep    3s

Paso 477
    Set Location    21.1438428    -86.8241885
    Sleep    3s

Paso 478
    Set Location    21.1453892    -86.8243082
    Sleep    3s

Paso 479
    Set Location    21.1465922    -86.8243979
    Sleep    3s

Paso 480
    Set Location    21.1466067    -86.824405
    Sleep    3s

Paso 481
    Set Location    21.1466067    -86.824405
    Sleep    3s

Paso 482
    Set Location    21.1473653    -86.8245086
    Sleep    3s

Paso 483
    Set Location    21.1486598    -86.8246006
    Sleep    3s

Paso 484
    Set Location    21.1500991    -86.8246198
    Sleep    3s

Paso 485
    Set Location    21.1522831    -86.8249207
    Sleep    3s

Paso 486
    Set Location    21.1547563    -86.8250747
    Sleep    3s

Paso 487
    Set Location    21.1563403    -86.8251731
    Sleep    3s

Paso 488
    Set Location    21.1563683    -86.8251683
    Sleep    3s

Paso 489
    Set Location    21.1563683    -86.8251683
    Sleep    3s

Paso 490
    Set Location    21.1567469    -86.8250381
    Sleep    3s

Paso 491
    Set Location    21.158162    -86.825357
    Sleep    3s

Paso 492
    Set Location    21.1586065    -86.8253699
    Sleep    3s

Paso 493
    Set Location    21.1598141    -86.8254734
    Sleep    3s

Paso 494
    Set Location    21.1607514    -86.8255383
    Sleep    3s

Paso 495
    Set Location    21.1618333    -86.825633
    Sleep    3s

Paso 496
    Set Location    21.1630688    -86.8256486
    Sleep    3s

Paso 497
    Set Location    21.1640622    -86.8254213
    Sleep    3s

Paso 498
    Set Location    21.1639255    -86.8263054
    Sleep    3s

Paso 499
    Set Location    21.1640317    -86.8265918
    Sleep    3s

Paso 500
    Set Location    21.164242    -86.826328
    Sleep    3s

Paso 501
    Set Location    21.1643133    -86.8261833
    Sleep    3s

Paso 502
    Set Location    21.1644033    -86.8261833
    Sleep    3s

Paso 503
    Set Location    21.1644033    -86.8261833
    Sleep    3s

Paso 504
    Set Location    21.164315    -86.8261567
    Sleep    3s

Paso 505
    Set Location    21.164315    -86.8261567
    Sleep    3s

Paso 506
    Set Location    21.1642454    -86.8260855
    Sleep    3s

Paso 507
    Set Location    21.1634637    -86.8261396
    Sleep    3s

Paso 508
    Set Location    21.1621737    -86.8257349
    Sleep    3s

Paso 509
    Set Location    21.1612484    -86.8256663
    Sleep    3s

Paso 510
    Set Location    21.1610657    -86.8256683
    Sleep    3s

Paso 511
    Set Location    21.1608524    -86.8256722
    Sleep    3s

Paso 512
    Set Location    21.1606218    -86.8256278
    Sleep    3s

Paso 513
    Set Location    21.1604252    -86.8256083
    Sleep    3s

Paso 514
    Set Location    21.1601769    -86.82557
    Sleep    3s

Paso 515
    Set Location    21.1599171    -86.8255368
    Sleep    3s

Paso 516
    Set Location    21.1596334    -86.8255468
    Sleep    3s

Paso 517
    Set Location    21.1593579    -86.8255617
    Sleep    3s

Paso 518
    Set Location    21.1591533    -86.8255317
    Sleep    3s

Paso 519
    Set Location    21.1591533    -86.8255317
    Sleep    3s

Paso 520
    Set Location    21.1590517    -86.8255167
    Sleep    3s

Paso 521
    Set Location    21.1590264    -86.8255111
    Sleep    3s

Paso 522
    Set Location    21.158672    -86.8254664
    Sleep    3s

Paso 523
    Set Location    21.1583174    -86.8254599
    Sleep    3s

Paso 524
    Set Location    21.1580783    -86.8254417
    Sleep    3s

Paso 525
    Set Location    21.1580783    -86.8254417
    Sleep    3s

Paso 526
    Set Location    21.1579731    -86.8254415
    Sleep    3s

Paso 527
    Set Location    21.1571682    -86.8255219
    Sleep    3s

Paso 528
    Set Location    21.1565826    -86.8254291
    Sleep    3s

Paso 529
    Set Location    21.1550813    -86.8252128
    Sleep    3s

Paso 530
    Set Location    21.1527527    -86.8250359
    Sleep    3s

Paso 531
    Set Location    21.1513151    -86.8249369
    Sleep    3s

Paso 532
    Set Location    21.1498267    -86.8248762
    Sleep    3s

Paso 533
    Set Location    21.149465    -86.8248417
    Sleep    3s

Paso 534
    Set Location    21.149465    -86.8248417
    Sleep    3s

Paso 535
    Set Location    21.14843    -86.8246966
    Sleep    3s

Paso 536
    Set Location    21.1467369    -86.8245896
    Sleep    3s

Paso 537
    Set Location    21.1448533    -86.82454
    Sleep    3s

Paso 538
    Set Location    21.1448533    -86.82454
    Sleep    3s

Paso 539
    Set Location    21.1447926    -86.8245368
    Sleep    3s

Paso 540
    Set Location    21.1436129    -86.8244104
    Sleep    3s

Paso 541
    Set Location    21.1415322    -86.8245448
    Sleep    3s

Paso 542
    Set Location    21.1403062    -86.8251549
    Sleep    3s

Paso 543
    Set Location    21.1386167    -86.8259555
    Sleep    3s

Paso 544
    Set Location    21.1365948    -86.8269464
    Sleep    3s

Paso 545
    Set Location    21.1342895    -86.8280716
    Sleep    3s

Paso 546
    Set Location    21.1321397    -86.8291183
    Sleep    3s

Paso 547
    Set Location    21.1300189    -86.8301823
    Sleep    3s

Paso 548
    Set Location    21.1278202    -86.8312787
    Sleep    3s

Paso 549
    Set Location    21.1254797    -86.8324163
    Sleep    3s

Paso 550
    Set Location    21.1233454    -86.8334491
    Sleep    3s

Paso 551
    Set Location    21.1230422    -86.8335999
    Sleep    3s

Paso 552
    Set Location    21.1219886    -86.8341264
    Sleep    3s

Paso 553
    Set Location    21.1199954    -86.8350882
    Sleep    3s

Paso 554
    Set Location    21.1177339    -86.8361858
    Sleep    3s

Paso 555
    Set Location    21.1154285    -86.8373099
    Sleep    3s

Paso 556
    Set Location    21.1130877    -86.8384519
    Sleep    3s

Paso 557
    Set Location    21.1103563    -86.8391226
    Sleep    3s

Paso 558
    Set Location    21.1076634    -86.8395462
    Sleep    3s

Paso 559
    Set Location    21.1049997    -86.8399637
    Sleep    3s

Paso 560
    Set Location    21.1032076    -86.8402436
    Sleep    3s

Paso 561
    Set Location    21.1029575    -86.8402848
    Sleep    3s

Paso 562
    Set Location    21.0983654    -86.8409977
    Sleep    3s

Paso 563
    Set Location    21.0956927    -86.8414481
    Sleep    3s

Paso 564
    Set Location    21.0931118    -86.8418911
    Sleep    3s

Paso 565
    Set Location    21.0907523    -86.8422728
    Sleep    3s

Paso 566
    Set Location    21.088664    -86.84259
    Sleep    3s

Paso 567
    Set Location    21.0870626    -86.8428045
    Sleep    3s

Paso 568
    Set Location    21.0854617    -86.8430782
    Sleep    3s

Paso 569
    Set Location    21.0840567    -86.8432767
    Sleep    3s

Paso 570
    Set Location    21.0789416    -86.8440451
    Sleep    3s

Paso 571
    Set Location    21.0762136    -86.8444748
    Sleep    3s

Paso 572
    Set Location    21.0741617    -86.8447824
    Sleep    3s

Paso 573
    Set Location    21.0715289    -86.8452111
    Sleep    3s

Paso 574
    Set Location    21.0687451    -86.8456429
    Sleep    3s

Paso 575
    Set Location    21.0659966    -86.8460551
    Sleep    3s

Paso 576
    Set Location    21.0633281    -86.846479
    Sleep    3s

Paso 577
    Set Location    21.0607201    -86.846891
    Sleep    3s

Paso 578
    Set Location    21.0581049    -86.84733
    Sleep    3s

Paso 579
    Set Location    21.0554422    -86.8477411
    Sleep    3s

Paso 580
    Set Location    21.0528472    -86.8481442
    Sleep    3s

Paso 581
    Set Location    21.0502702    -86.8485511
    Sleep    3s

Paso 582
    Set Location    21.04766    -86.8489174
    Sleep    3s

Paso 583
    Set Location    21.0450372    -86.8493548
    Sleep    3s

Paso 584
    Set Location    21.0424433    -86.8497429
    Sleep    3s

Paso 585
    Set Location    21.0398599    -86.8501874
    Sleep    3s

Paso 586
    Set Location    21.0375547    -86.8506934
    Sleep    3s

Paso 587
    Set Location    21.0355346    -86.8515449
    Sleep    3s

Paso 588
    Set Location    21.0342032    -86.8538665
    Sleep    3s

Paso 589
    Set Location    21.0350948    -86.8564569
    Sleep    3s

Paso 590
    Set Location    21.0353865    -86.8569154
    Sleep    3s

Paso 591
    Set Location    21.0366877    -86.8588664
    Sleep    3s

Paso 592
    Set Location    21.0378778    -86.8608402
    Sleep    3s

Paso 593
    Set Location    21.0392922    -86.8631359
    Sleep    3s

Paso 594
    Set Location    21.0408585    -86.8656309
    Sleep    3s

Paso 595
    Set Location    21.0423949    -86.86808
    Sleep    3s

Paso 596
    Set Location    21.0439215    -86.8705205
    Sleep    3s

Paso 597
    Set Location    21.045427    -86.872854
    Sleep    3s

Paso 598
    Set Location    21.0466318    -86.8751104
    Sleep    3s

Paso 599
    Set Location    21.0456691    -86.8768072
    Sleep    3s

Paso 600
    Set Location    21.0465251    -86.8782089
    Sleep    3s

Paso 601
    Set Location    21.0470118    -86.8789601
    Sleep    3s

Paso 602
    Set Location    21.0470834    -86.8795459
    Sleep    3s

Paso 603
    Set Location    21.0462903    -86.880082
    Sleep    3s

Paso 604
    Set Location    21.0453282    -86.8808061
    Sleep    3s

Paso 605
    Set Location    21.0450793    -86.8803982
    Sleep    3s

Paso 606
    Set Location    21.0454    -86.8801833
    Sleep    3s

Paso 607
    Set Location    21.0456661    -86.8799109
    Sleep    3s

Paso 608
    Set Location    21.0449025    -86.8785018
    Sleep    3s

Paso 609
    Set Location    21.0446516    -86.8770418
    Sleep    3s

Paso 610
    Set Location    21.0463379    -86.8757497
    Sleep    3s

Paso 611
    Set Location    21.0455933    -86.8734195
    Sleep    3s

Paso 612
    Set Location    21.0442762    -86.8720291
    Sleep    3s

Paso 613
    Set Location    21.04256    -86.8731794
    Sleep    3s

Paso 614
    Set Location    21.0412001    -86.8741447
    Sleep    3s

Paso 615
    Set Location    21.0409017    -86.8736814
    Sleep    3s

Paso 616
    Set Location    21.0405449    -86.8731195
    Sleep    3s

Paso 617
    Set Location    21.0402139    -86.8726293
    Sleep    3s

Paso 618
    Set Location    21.0397413    -86.8722835
    Sleep    3s

Paso 619
    Set Location    21.03974    -86.8722833
    Sleep    3s

Paso 620
    Set Location    21.039361    -86.8725698
    Sleep    3s

Paso 621
    Set Location    21.0395222    -86.8723615
    Sleep    3s

Paso 622
    Set Location    21.0397333    -86.8721983
    Sleep    3s

Paso 623
    Set Location    21.0397333    -86.8721983
    Sleep    3s

Paso 624
    Set Location    21.0397683    -86.8721817
    Sleep    3s

Paso 625
    Set Location    21.0397683    -86.8721817
    Sleep    3s

Paso 626
    Set Location    21.0399083    -86.8721
    Sleep    3s

Paso 627
    Set Location    21.0399083    -86.8721
    Sleep    3s

Paso 628
    Set Location    21.0400117    -86.8720033
    Sleep    3s

Paso 629
    Set Location    21.0400117    -86.8720033
    Sleep    3s

Paso 630
    Set Location    21.0400683    -86.8719598
    Sleep    3s

Paso 631
    Set Location    21.0400717    -86.8719567
    Sleep    3s

Paso 632
    Set Location    21.0400717    -86.8719567
    Sleep    3s

Paso 633
    Set Location    21.0402044    -86.8719015
    Sleep    3s

Paso 634
    Set Location    21.0403087    -86.8710291
    Sleep    3s

Paso 635
    Set Location    21.0397199    -86.8696244
    Sleep    3s

Paso 636
    Set Location    21.0405531    -86.8689397
    Sleep    3s

Paso 637
    Set Location    21.0413804    -86.8683005
    Sleep    3s

Paso 638
    Set Location    21.0415774    -86.866927
    Sleep    3s

Paso 639
    Set Location    21.0402121    -86.8647587
    Sleep    3s

Paso 640
    Set Location    21.0386748    -86.8623019
    Sleep    3s

Paso 641
    Set Location    21.037351    -86.8602452
    Sleep    3s

Paso 642
    Set Location    21.0365527    -86.8589461
    Sleep    3s

Paso 643
    Set Location    21.0353041    -86.8569874
    Sleep    3s

Paso 644
    Set Location    21.0340018    -86.8548505
    Sleep    3s

Paso 645
    Set Location    21.0333436    -86.8527613
    Sleep    3s

Paso 646
    Set Location    21.0330006    -86.8509674
    Sleep    3s

Paso 647
    Set Location    21.0322766    -86.8517064
    Sleep    3s

Paso 648
    Set Location    21.0338677    -86.8517589
    Sleep    3s

Paso 649
    Set Location    21.0362251    -86.8509686
    Sleep    3s

Paso 650
    Set Location    21.0389099    -86.8501716
    Sleep    3s

Paso 651
    Set Location    21.0417667    -86.849722
    Sleep    3s

Paso 652
    Set Location    21.0446037    -86.8492853
    Sleep    3s

Paso 653
    Set Location    21.0475163    -86.8488334
    Sleep    3s

Paso 654
    Set Location    21.0504881    -86.8484183
    Sleep    3s

Paso 655
    Set Location    21.053457    -86.847967
    Sleep    3s

Paso 656
    Set Location    21.0565031    -86.8474839
    Sleep    3s

Paso 657
    Set Location    21.0595054    -86.846938
    Sleep    3s

Paso 658
    Set Location    21.0623816    -86.8464837
    Sleep    3s

Paso 659
    Set Location    21.0653092    -86.84602
    Sleep    3s

Paso 660
    Set Location    21.0682696    -86.845567
    Sleep    3s

Paso 661
    Set Location    21.0712428    -86.8450605
    Sleep    3s

Paso 662
    Set Location    21.0741917    -86.8446432
    Sleep    3s

Paso 663
    Set Location    21.0771466    -86.8441807
    Sleep    3s

Paso 664
    Set Location    21.0799101    -86.8437524
    Sleep    3s

Paso 665
    Set Location    21.0823716    -86.8433602
    Sleep    3s

Paso 666
    Set Location    21.0848223    -86.8428826
    Sleep    3s

Paso 667
    Set Location    21.086971    -86.8425031
    Sleep    3s

Paso 668
    Set Location    21.0877056    -86.8422535
    Sleep    3s

Paso 669
    Set Location    21.0878142    -86.8422412
    Sleep    3s

Paso 670
    Set Location    21.0887498    -86.8422559
    Sleep    3s

Paso 671
    Set Location    21.0902135    -86.8420267
    Sleep    3s

Paso 672
    Set Location    21.0916989    -86.8418934
    Sleep    3s

Paso 673
    Set Location    21.0940442    -86.8415571
    Sleep    3s

Paso 674
    Set Location    21.0967453    -86.8411068
    Sleep    3s

Paso 675
    Set Location    21.0990569    -86.840727
    Sleep    3s

Paso 676
    Set Location    21.1004776    -86.8404779
    Sleep    3s

Paso 677
    Set Location    21.1008502    -86.8404305
    Sleep    3s

Paso 678
    Set Location    21.1023566    -86.8401937
    Sleep    3s

Paso 679
    Set Location    21.1044211    -86.8398806
    Sleep    3s

Paso 680
    Set Location    21.1062332    -86.8396139
    Sleep    3s

Paso 681
    Set Location    21.1070731    -86.8394871
    Sleep    3s

Paso 682
    Set Location    21.1074338    -86.8394317
    Sleep    3s

Paso 683
    Set Location    21.107956    -86.839366
    Sleep    3s

Paso 684
    Set Location    21.1088356    -86.8392205
    Sleep    3s
