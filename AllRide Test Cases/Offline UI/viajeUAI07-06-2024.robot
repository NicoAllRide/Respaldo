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
    Set Location    -33.4934512    -70.512381
    Sleep    5s

Paso 0.5
    Set Location    -33.4934512    -70.512381
    Sleep    5s

Paso 1
    Set Location    -33.4934611    -70.5123789
    Sleep    5s

Paso 2
    Set Location    -33.4934553    -70.5123718
    Sleep    5s

Paso 3
    Set Location    -33.4934584    -70.5123874
    Sleep    5s

Paso 4
    Set Location    -33.4934577    -70.5124022
    Sleep    5s

Paso 5
    Set Location    -33.4934434    -70.512384
    Sleep    5s

Paso 6
    Set Location    -33.4934447    -70.5123847
    Sleep    5s

Paso 7
    Set Location    -33.493445    -70.512385
    Sleep    5s

Paso 8
    Set Location    -33.493429    -70.5123978
    Sleep    5s

Paso 9
    Set Location    -33.4933651    -70.5124473
    Sleep    5s

Paso 10
    Set Location    -33.4931772    -70.5126111
    Sleep    5s

Paso 11
    Set Location    -33.4929191    -70.5128499
    Sleep    5s

Paso 12
    Set Location    -33.4926548    -70.513045
    Sleep    5s

Paso 13
    Set Location    -33.492456    -70.513298
    Sleep    5s

Paso 14
    Set Location    -33.4922249    -70.5135686
    Sleep    5s

Paso 15
    Set Location    -33.4919049    -70.5135205
    Sleep    5s

Paso 16
    Set Location    -33.4916028    -70.5133345
    Sleep    5s

Paso 17
    Set Location    -33.4906955    -70.5140643
    Sleep    5s

Paso 18
    Set Location    -33.4905631    -70.5146829
    Sleep    5s

Paso 19
    Set Location    -33.4905173    -70.5149123
    Sleep    5s

Paso 20
    Set Location    -33.4902047    -70.515633
    Sleep    5s

Paso 21
    Set Location    -33.4901499    -70.5158172
    Sleep    5s

Paso 22
    Set Location    -33.4899279    -70.5160422
    Sleep    5s

Paso 23
    Set Location    -33.4894821    -70.5160961
    Sleep    5s

Paso 24
    Set Location    -33.4890915    -70.5161467
    Sleep    5s

Paso 25
    Set Location    -33.4889892    -70.51639
    Sleep    5s

Paso 26
    Set Location    -33.488983    -70.5168349
    Sleep    5s

Paso 27
    Set Location    -33.4891154    -70.5173261
    Sleep    5s

Paso 28
    Set Location    -33.4892104    -70.5177291
    Sleep    5s

Paso 29
    Set Location    -33.4890844    -70.5181114
    Sleep    5s

Paso 30
    Set Location    -33.4890928    -70.5184617
    Sleep    5s

Paso 31
    Set Location    -33.4890159    -70.5186238
    Sleep    5s

Paso 32
    Set Location    -33.4888739    -70.5187385
    Sleep    5s

Paso 33
    Set Location    -33.4886493    -70.518966
    Sleep    5s

Paso 34
    Set Location    -33.4883473    -70.5191929
    Sleep    5s

Paso 35
    Set Location    -33.4880412    -70.5192919
    Sleep    5s

Paso 36
    Set Location    -33.4876948    -70.5192062
    Sleep    5s

Paso 37
    Set Location    -33.4873459    -70.5190123
    Sleep    5s

Paso 38
    Set Location    -33.4869977    -70.5188349
    Sleep    5s

Paso 39
    Set Location    -33.4867043    -70.5186487
    Sleep    5s

Paso 40
    Set Location    -33.4865227    -70.5186209
    Sleep    5s

Paso 41
    Set Location    -33.4863997    -70.5186357
    Sleep    5s

Paso 42
    Set Location    -33.4863213    -70.5186214
    Sleep    5s

Paso 43
    Set Location    -33.48632    -70.5186232
    Sleep    5s

Paso 44
    Set Location    -33.48632    -70.5186233
    Sleep    5s

Paso 45
    Set Location    -33.48632    -70.5186233
    Sleep    5s

Paso 46
    Set Location    -33.486288    -70.5186681
    Sleep    5s

Paso 47
    Set Location    -33.4863822    -70.5188329
    Sleep    5s

Paso 48
    Set Location    -33.4866574    -70.5189932
    Sleep    5s

Paso 49
    Set Location    -33.486986    -70.5191959
    Sleep    5s

Paso 50
    Set Location    -33.4873186    -70.5193681
    Sleep    5s

Paso 51
    Set Location    -33.4877397    -70.5194687
    Sleep    5s

Paso 52
    Set Location    -33.4880016    -70.5193609
    Sleep    5s

Paso 53
    Set Location    -33.4882275    -70.5192696
    Sleep    5s

Paso 54
    Set Location    -33.4885909    -70.5190767
    Sleep    5s

Paso 55
    Set Location    -33.4889001    -70.5187967
    Sleep    5s

Paso 56
    Set Location    -33.4890439    -70.5187364
    Sleep    5s

Paso 57
    Set Location    -33.4891276    -70.5185918
    Sleep    5s

Paso 58
    Set Location    -33.4890978    -70.5183287
    Sleep    5s

Paso 59
    Set Location    -33.4891467    -70.5180492
    Sleep    5s

Paso 60
    Set Location    -33.489236    -70.5177021
    Sleep    5s

Paso 61
    Set Location    -33.4891439    -70.5173303
    Sleep    5s

Paso 62
    Set Location    -33.4890471    -70.5169795
    Sleep    5s

Paso 63
    Set Location    -33.4889874    -70.5166379
    Sleep    5s

Paso 64
    Set Location    -33.4890366    -70.5163356
    Sleep    5s

Paso 65
    Set Location    -33.489205    -70.5162058
    Sleep    5s

Paso 66
    Set Location    -33.4896353    -70.5161527
    Sleep    5s

Paso 67
    Set Location    -33.4899131    -70.5161866
    Sleep    5s

Paso 68
    Set Location    -33.4900763    -70.5162022
    Sleep    5s

Paso 69
    Set Location    -33.4902257    -70.5159283
    Sleep    5s

Paso 70
    Set Location    -33.4903763    -70.5156145
    Sleep    5s

Paso 71
    Set Location    -33.4905047    -70.5153344
    Sleep    5s

Paso 72
    Set Location    -33.4906236    -70.5150387
    Sleep    5s

Paso 73
    Set Location    -33.490736    -70.5147697
    Sleep    5s

Paso 74
    Set Location    -33.4907455    -70.5145967
    Sleep    5s

Paso 75
    Set Location    -33.4907374    -70.5145806
    Sleep    5s

Paso 76
    Set Location    -33.4907383    -70.5145832
    Sleep    5s

Paso 77
    Set Location    -33.4907383    -70.5145833
    Sleep    5s

Paso 78
    Set Location    -33.4907335    -70.5145321
    Sleep    5s

Paso 79
    Set Location    -33.4906752    -70.5143832
    Sleep    5s

Paso 80
    Set Location    -33.4906957    -70.5142384
    Sleep    5s

Paso 81
    Set Location    -33.4907266    -70.5140983
    Sleep    5s

Paso 82
    Set Location    -33.4907677    -70.5139731
    Sleep    5s

Paso 83
    Set Location    -33.4908212    -70.5138448
    Sleep    5s

Paso 84
    Set Location    -33.4909294    -70.513723
    Sleep    5s

Paso 85
    Set Location    -33.4911478    -70.5136307
    Sleep    5s

Paso 86
    Set Location    -33.4914676    -70.5134273
    Sleep    5s

Paso 87
    Set Location    -33.491748    -70.513423
    Sleep    5s

Paso 88
    Set Location    -33.4919793    -70.5136088
    Sleep    5s

Paso 89
    Set Location    -33.4922052    -70.5136152
    Sleep    5s

Paso 90
    Set Location    -33.4924229    -70.5134585
    Sleep    5s

Paso 91
    Set Location    -33.4925711    -70.5132288
    Sleep    5s

Paso 92
    Set Location    -33.4927339    -70.5130303
    Sleep    5s

Paso 93
    Set Location    -33.4929283    -70.512867
    Sleep    5s

Paso 94
    Set Location    -33.4931649    -70.5126644
    Sleep    5s

Paso 95
    Set Location    -33.4933963    -70.5124727
    Sleep    5s

Paso 96
    Set Location    -33.4936184    -70.5122652
    Sleep    5s

Paso 97
    Set Location    -33.493809    -70.5120041
    Sleep    5s

Paso 98
    Set Location    -33.4939355    -70.5117972
    Sleep    5s

Paso 99
    Set Location    -33.4939359    -70.5117285
    Sleep    5s

Paso 100
    Set Location    -33.4939334    -70.5117331
    Sleep    5s

Paso 101
    Set Location    -33.4939222    -70.5118149
    Sleep    5s

Paso 102
    Set Location    -33.4939328    -70.5118552
    Sleep    5s

Paso 103
    Set Location    -33.4939333    -70.511855
    Sleep    5s

Paso 104
    Set Location    -33.4937991    -70.5119526
    Sleep    5s

Paso 105
    Set Location    -33.4936049    -70.5122123
    Sleep    5s

Paso 106
    Set Location    -33.4934564    -70.512374
    Sleep    5s

Paso 107
    Set Location    -33.4934326    -70.5123878
    Sleep    5s

Paso 108
    Set Location    -33.4934349    -70.5123851
    Sleep    5s

Paso 109
    Set Location    -33.493435    -70.512385
    Sleep    5s

Paso 110
    Set Location    -33.493435    -70.512385
    Sleep    5s

Paso 111
    Set Location    -33.493346    -70.5124704
    Sleep    5s

Paso 112
    Set Location    -33.4931683    -70.5126419
    Sleep    5s

Paso 113
    Set Location    -33.4929379    -70.5128284
    Sleep    5s

Paso 114
    Set Location    -33.4926766    -70.5130014
    Sleep    5s

Paso 115
    Set Location    -33.4916802    -70.5133662
    Sleep    5s

Paso 116
    Set Location    -33.4913572    -70.5134511
    Sleep    5s

Paso 117
    Set Location    -33.4909801    -70.5136615
    Sleep    5s

Paso 118
    Set Location    -33.4907404    -70.5139097
    Sleep    5s

Paso 119
    Set Location    -33.4906568    -70.5142179
    Sleep    5s

Paso 120
    Set Location    -33.4906464    -70.5144764
    Sleep    5s

Paso 121
    Set Location    -33.4906563    -70.5148009
    Sleep    5s

Paso 122
    Set Location    -33.4905424    -70.515201
    Sleep    5s

Paso 123
    Set Location    -33.4903579    -70.5155049
    Sleep    5s

Paso 124
    Set Location    -33.4901656    -70.5157779
    Sleep    5s

Paso 125
    Set Location    -33.4900062    -70.5159823
    Sleep    5s

Paso 126
    Set Location    -33.4897667    -70.5160468
    Sleep    5s

Paso 127
    Set Location    -33.4894871    -70.5160894
    Sleep    5s

Paso 128
    Set Location    -33.4892204    -70.5161281
    Sleep    5s

Paso 129
    Set Location    -33.4890293    -70.516213
    Sleep    5s

Paso 130
    Set Location    -33.4889831    -70.5165176
    Sleep    5s

Paso 131
    Set Location    -33.4889869    -70.5168519
    Sleep    5s

Paso 132
    Set Location    -33.4891001    -70.5171876
    Sleep    5s

Paso 133
    Set Location    -33.4891622    -70.5174493
    Sleep    5s

Paso 134
    Set Location    -33.4892092    -70.5177421
    Sleep    5s

Paso 135
    Set Location    -33.4891261    -70.5179887
    Sleep    5s

Paso 136
    Set Location    -33.489085    -70.5181018
    Sleep    5s

Paso 137
    Set Location    -33.4890866    -70.5180985
    Sleep    5s

Paso 138
    Set Location    -33.4890867    -70.5180983
    Sleep    5s

Paso 139
    Set Location    -33.4890755    -70.5182119
    Sleep    5s

Paso 140
    Set Location    -33.4890846    -70.5185007
    Sleep    5s

Paso 141
    Set Location    -33.4889459    -70.5186933
    Sleep    5s

Paso 142
    Set Location    -33.4887045    -70.5188916
    Sleep    5s

Paso 143
    Set Location    -33.4884201    -70.5191535
    Sleep    5s

Paso 144
    Set Location    -33.488093    -70.5192821
    Sleep    5s

Paso 145
    Set Location    -33.4878037    -70.5192554
    Sleep    5s

Paso 146
    Set Location    -33.4875584    -70.5191382
    Sleep    5s

Paso 147
    Set Location    -33.487324    -70.5190125
    Sleep    5s

Paso 148
    Set Location    -33.4870683    -70.518876
    Sleep    5s

Paso 149
    Set Location    -33.486816    -70.5186985
    Sleep    5s

Paso 150
    Set Location    -33.4865716    -70.5185957
    Sleep    5s

Paso 151
    Set Location    -33.4864605    -70.5186192
    Sleep    5s

Paso 152
    Set Location    -33.4863612    -70.5186204
    Sleep    5s

Paso 153
    Set Location    -33.4863153    -70.518634
    Sleep    5s

Paso 154
    Set Location    -33.4863166    -70.518635
    Sleep    5s

Paso 155
    Set Location    -33.4863167    -70.518635
    Sleep    5s

Paso 156
    Set Location    -33.4863167    -70.518635
    Sleep    5s

Paso 157
    Set Location    -33.4862831    -70.5186286
    Sleep    5s

Paso 158
    Set Location    -33.4863144    -70.5187641
    Sleep    5s

Paso 159
    Set Location    -33.4865751    -70.5189197
    Sleep    5s

Paso 160
    Set Location    -33.4868381    -70.5190633
    Sleep    5s

Paso 161
    Set Location    -33.4871612    -70.5192466
    Sleep    5s

Paso 162
    Set Location    -33.487335    -70.5193513
    Sleep    5s

Paso 163
    Set Location    -33.4875999    -70.519449
    Sleep    5s

Paso 164
    Set Location    -33.4878609    -70.519441
    Sleep    5s

Paso 165
    Set Location    -33.488034    -70.5193502
    Sleep    5s

Paso 166
    Set Location    -33.4883151    -70.5192499
    Sleep    5s

Paso 167
    Set Location    -33.4886414    -70.5190229
    Sleep    5s

Paso 168
    Set Location    -33.489137    -70.5185521
    Sleep    5s

Paso 169
    Set Location    -33.4891095    -70.5183033
    Sleep    5s

Paso 170
    Set Location    -33.4891506    -70.5180427
    Sleep    5s

Paso 171
    Set Location    -33.4892404    -70.5177576
    Sleep    5s

Paso 172
    Set Location    -33.4891807    -70.5174395
    Sleep    5s

Paso 173
    Set Location    -33.4891054    -70.5171158
    Sleep    5s

Paso 174
    Set Location    -33.4890244    -70.5168134
    Sleep    5s

Paso 175
    Set Location    -33.4890226    -70.5165164
    Sleep    5s

Paso 176
    Set Location    -33.4890791    -70.5162584
    Sleep    5s

Paso 177
    Set Location    -33.4893969    -70.5161996
    Sleep    5s

Paso 178
    Set Location    -33.4897958    -70.5161536
    Sleep    5s

Paso 179
    Set Location    -33.4899722    -70.5162218
    Sleep    5s

Paso 180
    Set Location    -33.4901342    -70.5161004
    Sleep    5s

Paso 181
    Set Location    -33.4903012    -70.5157852
    Sleep    5s

Paso 182
    Set Location    -33.49044    -70.5154904
    Sleep    5s

Paso 183
    Set Location    -33.4905726    -70.5152178
    Sleep    5s

Paso 184
    Set Location    -33.4906755    -70.5149147
    Sleep    5s

Paso 185
    Set Location    -33.4907664    -70.5146978
    Sleep    5s

Paso 186
    Set Location    -33.4907351    -70.5145695
    Sleep    5s

Paso 187
    Set Location    -33.4907334    -70.5145731
    Sleep    5s

Paso 188
    Set Location    -33.4907333    -70.5145733
    Sleep    5s

Paso 189
    Set Location    -33.4907333    -70.5145733
    Sleep    5s

Paso 190
    Set Location    -33.4906997    -70.5144646
    Sleep    5s

Paso 191
    Set Location    -33.4907063    -70.5142856
    Sleep    5s

Paso 192
    Set Location    -33.49073    -70.5141436
    Sleep    5s

Paso 193
    Set Location    -33.4907536    -70.5140007
    Sleep    5s

Paso 194
    Set Location    -33.4908139    -70.5138581
    Sleep    5s

Paso 195
    Set Location    -33.4909155    -70.5137478
    Sleep    5s

Paso 196
    Set Location    -33.4910398    -70.5136851
    Sleep    5s

Paso 197
    Set Location    -33.4912852    -70.5135823
    Sleep    5s

Paso 198
    Set Location    -33.4916001    -70.5133894
    Sleep    5s

Paso 199
    Set Location    -33.4918832    -70.5135389
    Sleep    5s

Paso 200
    Set Location    -33.4921758    -70.5136294
    Sleep    5s

Paso 201
    Set Location    -33.4923197    -70.5135549
    Sleep    5s

Paso 202
    Set Location    -33.4924569    -70.5134097
    Sleep    5s

Paso 203
    Set Location    -33.4925655    -70.5132255
    Sleep    5s

Paso 204
    Set Location    -33.4926989    -70.5130558
    Sleep    5s

Paso 205
    Set Location    -33.4928792    -70.5129224
    Sleep    5s

Paso 206
    Set Location    -33.4930766    -70.5127778
    Sleep    5s

Paso 207
    Set Location    -33.4932709    -70.5126111
    Sleep    5s

Paso 208
    Set Location    -33.4934603    -70.5124565
    Sleep    5s

Paso 209
    Set Location    -33.4936528    -70.5122484
    Sleep    5s

Paso 210
    Set Location    -33.493821    -70.5120076
    Sleep    5s

Paso 211
    Set Location    -33.4939404    -70.5118243
    Sleep    5s

Paso 212
    Set Location    -33.4939571    -70.5117254
    Sleep    5s

Paso 213
    Set Location    -33.4939407    -70.5117555
    Sleep    5s

Paso 214
    Set Location    -33.4939321    -70.5118093
    Sleep    5s

Paso 215
    Set Location    -33.4939428    -70.511842
    Sleep    5s

Paso 216
    Set Location    -33.4939018    -70.5118401
    Sleep    5s

Paso 217
    Set Location    -33.4937938    -70.5119706
    Sleep    5s

Paso 218
    Set Location    -33.4936087    -70.5122245
    Sleep    5s

Paso 219
    Set Location    -33.4934615    -70.512371
    Sleep    5s

Paso 220
    Set Location    -33.4934426    -70.5123854
    Sleep    5s

Paso 221
    Set Location    -33.4934449    -70.5123834
    Sleep    5s

Paso 222
    Set Location    -33.493445    -70.5123833
    Sleep    5s

Paso 223
    Set Location    -33.493445    -70.5123833
    Sleep    5s

Paso 224
    Set Location    -33.4934173    -70.5124078
    Sleep    5s

Paso 225
    Set Location    -33.4932603    -70.5125613
    Sleep    5s

Paso 226
    Set Location    -33.4930203    -70.5127807
    Sleep    5s

Paso 227
    Set Location    -33.492692    -70.5130283
    Sleep    5s

Paso 228
    Set Location    -33.4924379    -70.5133749
    Sleep    5s

Paso 229
    Set Location    -33.4920844    -70.5135743
    Sleep    5s

Paso 230
    Set Location    -33.4917179    -70.5133762
    Sleep    5s

Paso 231
    Set Location    -33.4906523    -70.5144671
    Sleep    5s

Paso 232
    Set Location    -33.4905732    -70.5145936
    Sleep    5s

Paso 233
    Set Location    -33.4905631    -70.5146141
    Sleep    5s

Paso 234
    Set Location    -33.4905474    -70.5146741
    Sleep    5s

Paso 235
    Set Location    -33.4901943    -70.5156277
    Sleep    5s

Paso 236
    Set Location    -33.4901647    -70.5157491
    Sleep    5s

Paso 237
    Set Location    -33.4901682    -70.5157435
    Sleep    5s

Paso 238
    Set Location    -33.490026    -70.5159709
    Sleep    5s

Paso 239
    Set Location    -33.4896622    -70.5160653
    Sleep    5s

Paso 240
    Set Location    -33.4892037    -70.5161136
    Sleep    5s

Paso 241
    Set Location    -33.489084    -70.5172216
    Sleep    5s

Paso 242
    Set Location    -33.4892046    -70.5176702
    Sleep    5s

Paso 243
    Set Location    -33.4890868    -70.5184381
    Sleep    5s

Paso 244
    Set Location    -33.4889537    -70.5186708
    Sleep    5s

Paso 245
    Set Location    -33.4876954    -70.5192073
    Sleep    5s

Paso 246
    Set Location    -33.4864465    -70.5186259
    Sleep    5s

Paso 247
    Set Location    -33.4863246    -70.5186339
    Sleep    5s

Paso 248
    Set Location    -33.4864091    -70.5188287
    Sleep    5s

Paso 249
    Set Location    -33.4867118    -70.5190162
    Sleep    5s

Paso 250
    Set Location    -33.4870558    -70.5191953
    Sleep    5s

Paso 251
    Set Location    -33.4871988    -70.5192401
    Sleep    5s

Paso 252
    Set Location    -33.4872399    -70.5192585
    Sleep    5s

Paso 253
    Set Location    -33.4872383    -70.5192567
    Sleep    5s

Paso 254
    Set Location    -33.4872383    -70.5192567
    Sleep    5s

Paso 255
    Set Location    -33.4873103    -70.5193254
    Sleep    5s

Paso 256
    Set Location    -33.4874317    -70.5194165
    Sleep    5s

Paso 257
    Set Location    -33.4876892    -70.5194483
    Sleep    5s

Paso 258
    Set Location    -33.4879181    -70.5194077
    Sleep    5s

Paso 259
    Set Location    -33.4880501    -70.5193509
    Sleep    5s

Paso 260
    Set Location    -33.4882301    -70.5192816
    Sleep    5s

Paso 261
    Set Location    -33.4884426    -70.5192036
    Sleep    5s

Paso 262
    Set Location    -33.4885961    -70.519091
    Sleep    5s

Paso 263
    Set Location    -33.4887451    -70.5189379
    Sleep    5s

Paso 264
    Set Location    -33.4888827    -70.5188163
    Sleep    5s

Paso 265
    Set Location    -33.4890273    -70.5187525
    Sleep    5s

Paso 266
    Set Location    -33.489037    -70.5187526
    Sleep    5s

Paso 267
    Set Location    -33.4890351    -70.5187533
    Sleep    5s

Paso 268
    Set Location    -33.489035    -70.5187533
    Sleep    5s

Paso 269
    Set Location    -33.489035    -70.5187533
    Sleep    5s

Paso 270
    Set Location    -33.4891331    -70.5186334
    Sleep    5s

Paso 271
    Set Location    -33.4891336    -70.5184868
    Sleep    5s

Paso 272
    Set Location    -33.4891179    -70.5183382
    Sleep    5s

Paso 273
    Set Location    -33.489124    -70.5182037
    Sleep    5s

Paso 274
    Set Location    -33.4891644    -70.5180545
    Sleep    5s

Paso 275
    Set Location    -33.4892265    -70.5178564
    Sleep    5s

Paso 276
    Set Location    -33.4892238    -70.5175602
    Sleep    5s

Paso 277
    Set Location    -33.4891764    -70.5173343
    Sleep    5s

Paso 278
    Set Location    -33.4891012    -70.5170522
    Sleep    5s

Paso 279
    Set Location    -33.4892221    -70.5162254
    Sleep    5s

Paso 280
    Set Location    -33.4896177    -70.5161419
    Sleep    5s

Paso 281
    Set Location    -33.4898889    -70.516163
    Sleep    5s

Paso 282
    Set Location    -33.4900354    -70.5162271
    Sleep    5s

Paso 283
    Set Location    -33.4901882    -70.5160461
    Sleep    5s

Paso 284
    Set Location    -33.4903239    -70.5157473
    Sleep    5s

Paso 285
    Set Location    -33.4904564    -70.515479
    Sleep    5s

Paso 286
    Set Location    -33.49057    -70.51521
    Sleep    5s

Paso 287
    Set Location    -33.4906659    -70.514927
    Sleep    5s

Paso 288
    Set Location    -33.4907127    -70.5146155
    Sleep    5s

Paso 289
    Set Location    -33.4907066    -70.514295
    Sleep    5s

Paso 290
    Set Location    -33.4907734    -70.5139927
    Sleep    5s

Paso 291
    Set Location    -33.4909158    -70.5137562
    Sleep    5s

Paso 292
    Set Location    -33.4911781    -70.5136437
    Sleep    5s

Paso 293
    Set Location    -33.4914761    -70.5134392
    Sleep    5s

Paso 294
    Set Location    -33.4918211    -70.5134709
    Sleep    5s

Paso 295
    Set Location    -33.4921576    -70.5136144
    Sleep    5s

Paso 296
    Set Location    -33.492376    -70.5135255
    Sleep    5s

Paso 297
    Set Location    -33.4925341    -70.5133153
    Sleep    5s

Paso 298
    Set Location    -33.4926728    -70.5130825
    Sleep    5s

Paso 299
    Set Location    -33.4928787    -70.5129334
    Sleep    5s

Paso 300
    Set Location    -33.49309    -70.5127718
    Sleep    5s

Paso 301
    Set Location    -33.4938724    -70.5119547
    Sleep    5s

Paso 302
    Set Location    -33.4939616    -70.5117483
    Sleep    5s

Paso 303
    Set Location    -33.4939608    -70.5117176
    Sleep    5s

Paso 304
    Set Location    -33.4939504    -70.5117759
    Sleep    5s

Paso 305
    Set Location    -33.4939548    -70.5118071
    Sleep    5s

Paso 306
    Set Location    -33.493955    -70.5118083
    Sleep    5s

Paso 307
    Set Location    -33.4938176    -70.5119363
    Sleep    5s

Paso 308
    Set Location    -33.4936516    -70.5121596
    Sleep    5s

Paso 309
    Set Location    -33.4934796    -70.5123335
    Sleep    5s

Paso 310
    Set Location    -33.4934286    -70.5123762
    Sleep    5s

Paso 311
    Set Location    -33.4934316    -70.5123734
    Sleep    5s

Paso 312
    Set Location    -33.4934317    -70.5123733
    Sleep    5s

Paso 313
    Set Location    -33.4934317    -70.5123733
    Sleep    5s

Paso 314
    Set Location    -33.4934044    -70.5123957
    Sleep    5s

Paso 315
    Set Location    -33.4932879    -70.512518
    Sleep    5s

Paso 316
    Set Location    -33.4930682    -70.51273
    Sleep    5s

Paso 317
    Set Location    -33.4927991    -70.5129375
    Sleep    5s

Paso 318
    Set Location    -33.4925293    -70.5131948
    Sleep    5s

Paso 319
    Set Location    -33.4922899    -70.5135146
    Sleep    5s

Paso 320
    Set Location    -33.4919325    -70.5135369
    Sleep    5s

Paso 321
    Set Location    -33.4915863    -70.5133429
    Sleep    5s

Paso 322
    Set Location    -33.4911492    -70.5135665
    Sleep    5s

Paso 323
    Set Location    -33.4907968    -70.5138135
    Sleep    5s

Paso 324
    Set Location    -33.4906876    -70.5141571
    Sleep    5s

Paso 325
    Set Location    -33.4906693    -70.5144737
    Sleep    5s

Paso 326
    Set Location    -33.4905733    -70.5146133
    Sleep    5s

Paso 327
    Set Location    -33.4905733    -70.5146133
    Sleep    5s

Paso 328
    Set Location    -33.4905301    -70.5148484
    Sleep    5s

Paso 329
    Set Location    -33.4903711    -70.5152275
    Sleep    5s

Paso 330
    Set Location    -33.4902256    -70.5155622
    Sleep    5s

Paso 331
    Set Location    -33.4901822    -70.5157155
    Sleep    5s

Paso 332
    Set Location    -33.4901833    -70.5157134
    Sleep    5s

Paso 333
    Set Location    -33.490121    -70.5158765
    Sleep    5s

Paso 334
    Set Location    -33.4898264    -70.5160439
    Sleep    5s

Paso 335
    Set Location    -33.4889809    -70.5165895
    Sleep    5s

Paso 336
    Set Location    -33.4890255    -70.5170043
    Sleep    5s

Paso 337
    Set Location    -33.4885722    -70.5190407
    Sleep    5s

Paso 338
    Set Location    -33.4882397    -70.5192174
    Sleep    5s

Paso 339
    Set Location    -33.4880141    -70.5192916
    Sleep    5s

Paso 340
    Set Location    -33.4878305    -70.5192507
    Sleep    5s

Paso 341
    Set Location    -33.4877703    -70.5192078
    Sleep    5s

Paso 342
    Set Location    -33.4876356    -70.5191555
    Sleep    5s

Paso 343
    Set Location    -33.4875167    -70.5190915
    Sleep    5s

Paso 344
    Set Location    -33.4874245    -70.5190287
    Sleep    5s

Paso 345
    Set Location    -33.4873652    -70.5189943
    Sleep    5s

Paso 346
    Set Location    -33.4873297    -70.5189742
    Sleep    5s

Paso 347
    Set Location    -33.4873044    -70.5189594
    Sleep    5s

Paso 348
    Set Location    -33.487305    -70.51896
    Sleep    5s

Paso 349
    Set Location    -33.487305    -70.51896
    Sleep    5s

Paso 350
    Set Location    -33.4872203    -70.5189264
    Sleep    5s

Paso 351
    Set Location    -33.4870735    -70.518873
    Sleep    5s

Paso 352
    Set Location    -33.4869133    -70.5187704
    Sleep    5s

Paso 353
    Set Location    -33.4868412    -70.5187081
    Sleep    5s

Paso 354
    Set Location    -33.4867844    -70.518658
    Sleep    5s

Paso 355
    Set Location    -33.4867716    -70.5186521
    Sleep    5s

Paso 356
    Set Location    -33.4867732    -70.5186532
    Sleep    5s

Paso 357
    Set Location    -33.4866982    -70.5186005
    Sleep    5s

Paso 358
    Set Location    -33.4866638    -70.5185856
    Sleep    5s

Paso 359
    Set Location    -33.4866649    -70.5185867
    Sleep    5s

Paso 360
    Set Location    -33.486665    -70.5185867
    Sleep    5s

Paso 361
    Set Location    -33.486665    -70.5185867
    Sleep    5s

Paso 362
    Set Location    -33.4865706    -70.5185627
    Sleep    5s

Paso 363
    Set Location    -33.4865636    -70.5185649
    Sleep    5s

Paso 364
    Set Location    -33.4865633    -70.518565
    Sleep    5s

Paso 365
    Set Location    -33.4864621    -70.51863
    Sleep    5s

Paso 366
    Set Location    -33.4864089    -70.5186092
    Sleep    5s

Paso 367
    Set Location    -33.4863537    -70.5186138
    Sleep    5s

Paso 368
    Set Location    -33.4863533    -70.518615
    Sleep    5s

Paso 369
    Set Location    -33.4863533    -70.518615
    Sleep    5s

Paso 370
    Set Location    -33.4863085    -70.518703
    Sleep    5s

Paso 371
    Set Location    -33.486443    -70.5188425
    Sleep    5s

Paso 372
    Set Location    -33.4866692    -70.5189702
    Sleep    5s

Paso 373
    Set Location    -33.4869277    -70.5191223
    Sleep    5s

Paso 374
    Set Location    -33.4882079    -70.5192893
    Sleep    5s

Paso 375
    Set Location    -33.4885528    -70.5191203
    Sleep    5s

Paso 376
    Set Location    -33.4889801    -70.5187757
    Sleep    5s

Paso 377
    Set Location    -33.4891419    -70.5181017
    Sleep    5s

Paso 378
    Set Location    -33.4890171    -70.5165936
    Sleep    5s

Paso 379
    Set Location    -33.4890769    -70.5162941
    Sleep    5s

Paso 380
    Set Location    -33.4893293    -70.5162005
    Sleep    5s

Paso 381
    Set Location    -33.4897681    -70.5161116
    Sleep    5s

Paso 382
    Set Location    -33.4899525    -70.5161857
    Sleep    5s

Paso 383
    Set Location    -33.4901275    -70.5161259
    Sleep    5s

Paso 384
    Set Location    -33.4903257    -70.5157826
    Sleep    5s

Paso 385
    Set Location    -33.4904759    -70.5154404
    Sleep    5s

Paso 386
    Set Location    -33.4906216    -70.515136
    Sleep    5s

Paso 387
    Set Location    -33.4907139    -70.5148489
    Sleep    5s

Paso 388
    Set Location    -33.4907684    -70.5146145
    Sleep    5s

Paso 389
    Set Location    -33.4907594    -70.5145605
    Sleep    5s

Paso 390
    Set Location    -33.49076    -70.5145632
    Sleep    5s

Paso 391
    Set Location    -33.49076    -70.5145633
    Sleep    5s

Paso 392
    Set Location    -33.49076    -70.5145633
    Sleep    5s

Paso 393
    Set Location    -33.4907233    -70.5144642
    Sleep    5s

Paso 394
    Set Location    -33.4907281    -70.5142679
    Sleep    5s

Paso 395
    Set Location    -33.4907487    -70.5141045
    Sleep    5s

Paso 396
    Set Location    -33.4907755    -70.5139543
    Sleep    5s

Paso 397
    Set Location    -33.4908653    -70.5138038
    Sleep    5s

Paso 398
    Set Location    -33.4910218    -70.5137052
    Sleep    5s

Paso 399
    Set Location    -33.4912665    -70.5136067
    Sleep    5s

Paso 400
    Set Location    -33.4916024    -70.5133932
    Sleep    5s

Paso 401
    Set Location    -33.4919022    -70.5135187
    Sleep    5s

Paso 402
    Set Location    -33.4921771    -70.5136158
    Sleep    5s

Paso 403
    Set Location    -33.4923957    -70.5134978
    Sleep    5s

Paso 404
    Set Location    -33.4925462    -70.5133025
    Sleep    5s

Paso 405
    Set Location    -33.4926859    -70.5130962
    Sleep    5s

Paso 406
    Set Location    -33.4928707    -70.5129546
    Sleep    5s

Paso 407
    Set Location    -33.4930819    -70.5127783
    Sleep    5s

Paso 408
    Set Location    -33.4932871    -70.5126007
    Sleep    5s

Paso 409
    Set Location    -33.4934602    -70.5124558
    Sleep    5s

Paso 410
    Set Location    -33.4935997    -70.5123267
    Sleep    5s

Paso 411
    Set Location    -33.4938104    -70.5120693
    Sleep    5s

Paso 412
    Set Location    -33.4939194    -70.5119058
    Sleep    5s

Paso 413
    Set Location    -33.493944    -70.5118643
    Sleep    5s

Paso 414
    Set Location    -33.4939709    -70.5117336
    Sleep    5s

Paso 415
    Set Location    -33.4939588    -70.5117606
    Sleep    5s

Paso 416
    Set Location    -33.4939519    -70.5118095
    Sleep    5s

Paso 417
    Set Location    -33.4939645    -70.5118468
    Sleep    5s

Paso 418
    Set Location    -33.4939091    -70.511853
    Sleep    5s

Paso 419
    Set Location    -33.493712    -70.5120747
    Sleep    5s

Paso 420
    Set Location    -33.4934517    -70.5123617
    Sleep    5s

Paso 421
    Set Location    -33.4934517    -70.5123617
    Sleep    5s

Paso 422
    Set Location    -33.4934245    -70.512368
    Sleep    5s

Paso 423
    Set Location    -33.4932149    -70.512551
    Sleep    5s

Paso 424
    Set Location    -33.4928437    -70.5128941
    Sleep    5s

Paso 425
    Set Location    -33.4925176    -70.5132045
    Sleep    5s

Paso 426
    Set Location    -33.4922569    -70.5135145
    Sleep    5s

Paso 427
    Set Location    -33.4919091    -70.5135084
    Sleep    5s

Paso 428
    Set Location    -33.4915241    -70.5133314
    Sleep    5s

Paso 429
    Set Location    -33.4906157    -70.514584
    Sleep    5s

Paso 430
    Set Location    -33.4905574    -70.5146166
    Sleep    5s

Paso 431
    Set Location    -33.4905599    -70.5146151
    Sleep    5s

Paso 432
    Set Location    -33.49056    -70.514615
    Sleep    5s

Paso 433
    Set Location    -33.49056    -70.514615
    Sleep    5s

Paso 434
    Set Location    -33.4905312    -70.5148404
    Sleep    5s

Paso 435
    Set Location    -33.490409    -70.5151527
    Sleep    5s

Paso 436
    Set Location    -33.4902608    -70.5154503
    Sleep    5s

Paso 437
    Set Location    -33.4902063    -70.5156871
    Sleep    5s

Paso 438
    Set Location    -33.4901184    -70.5158844
    Sleep    5s

Paso 439
    Set Location    -33.4898508    -70.5160402
    Sleep    5s

Paso 440
    Set Location    -33.4893922    -70.5161008
    Sleep    5s

Paso 441
    Set Location    -33.4890526    -70.5161769
    Sleep    5s

Paso 442
    Set Location    -33.4889692    -70.5165644
    Sleep    5s

Paso 443
    Set Location    -33.4890164    -70.5169684
    Sleep    5s

Paso 444
    Set Location    -33.4891417    -70.5173955
    Sleep    5s

Paso 445
    Set Location    -33.4891956    -70.5178512
    Sleep    5s

Paso 446
    Set Location    -33.4889353    -70.5187113
    Sleep    5s

Paso 447
    Set Location    -33.4863131    -70.5187191
    Sleep    5s

Paso 448
    Set Location    -33.4877723    -70.5194523
    Sleep    5s

Paso 449
    Set Location    -33.4879749    -70.5193848
    Sleep    5s

Paso 450
    Set Location    -33.488138    -70.5193102
    Sleep    5s

Paso 451
    Set Location    -33.4883974    -70.5192268
    Sleep    5s

Paso 452
    Set Location    -33.48869    -70.5190069
    Sleep    5s

Paso 453
    Set Location    -33.4889739    -70.5187576
    Sleep    5s

Paso 454
    Set Location    -33.4890823    -70.5187305
    Sleep    5s

Paso 455
    Set Location    -33.4891384    -70.5185183
    Sleep    5s

Paso 456
    Set Location    -33.4891129    -70.5182402
    Sleep    5s

Paso 457
    Set Location    -33.4891949    -70.5179778
    Sleep    5s

Paso 458
    Set Location    -33.4892494    -70.5176365
    Sleep    5s

Paso 459
    Set Location    -33.4891657    -70.5172585
    Sleep    5s

Paso 460
    Set Location    -33.4890762    -70.5169188
    Sleep    5s

Paso 461
    Set Location    -33.489026    -70.5165839
    Sleep    5s

Paso 462
    Set Location    -33.4890618    -70.5163097
    Sleep    5s

Paso 463
    Set Location    -33.4892275    -70.5162133
    Sleep    5s

Paso 464
    Set Location    -33.4894738    -70.5161736
    Sleep    5s

Paso 465
    Set Location    -33.4897364    -70.5161212
    Sleep    5s

Paso 466
    Set Location    -33.4899183    -70.5161807
    Sleep    5s

Paso 467
    Set Location    -33.4902242    -70.515964
    Sleep    5s

Paso 468
    Set Location    -33.4904027    -70.5156065
    Sleep    5s

Paso 469
    Set Location    -33.49077    -70.5145749
    Sleep    5s

Paso 470
    Set Location    -33.4907204    -70.5144581
    Sleep    5s

Paso 471
    Set Location    -33.490715    -70.5142631
    Sleep    5s

Paso 472
    Set Location    -33.4907544    -70.5140862
    Sleep    5s

Paso 473
    Set Location    -33.490803    -70.5139079
    Sleep    5s

Paso 474
    Set Location    -33.4909084    -70.5137755
    Sleep    5s

Paso 475
    Set Location    -33.4910495    -70.513682
    Sleep    5s

Paso 476
    Set Location    -33.4913172    -70.51357
    Sleep    5s

Paso 477
    Set Location    -33.4916322    -70.5133801
    Sleep    5s

Paso 478
    Set Location    -33.491915    -70.5135343
    Sleep    5s

Paso 479
    Set Location    -33.4921885    -70.5136143
    Sleep    5s

Paso 480
    Set Location    -33.4923792    -70.5134965
    Sleep    5s

Paso 481
    Set Location    -33.4925437    -70.5133054
    Sleep    5s

Paso 482
    Set Location    -33.4926703    -70.5131807
    Sleep    5s

Paso 483
    Set Location    -33.4926684    -70.51318
    Sleep    5s

Paso 484
    Set Location    -33.4926683    -70.51318
    Sleep    5s

Paso 485
    Set Location    -33.4926683    -70.51318
    Sleep    5s

Paso 486
    Set Location    -33.492662    -70.5131368
    Sleep    5s

Paso 487
    Set Location    -33.492715    -70.5130182
    Sleep    5s

Paso 488
    Set Location    -33.4928408    -70.5129563
    Sleep    5s

Paso 489
    Set Location    -33.4929211    -70.5129197
    Sleep    5s

Paso 490
    Set Location    -33.4930437    -70.5128308
    Sleep    5s

Paso 491
    Set Location    -33.4931617    -70.5126979
    Sleep    5s

Paso 492
    Set Location    -33.4932951    -70.5125811
    Sleep    5s

Paso 493
    Set Location    -33.4934441    -70.5124525
    Sleep    5s

Paso 494
    Set Location    -33.4936164    -70.5122866
    Sleep    5s

Paso 495
    Set Location    -33.493772    -70.5121074
    Sleep    5s

Paso 496
    Set Location    -33.4938901    -70.511926
    Sleep    5s

Paso 497
    Set Location    -33.4939757    -70.511761
    Sleep    5s

Paso 498
    Set Location    -33.4939639    -70.5117301
    Sleep    5s

Paso 499
    Set Location    -33.4939489    -70.5117972
    Sleep    5s

Paso 500
    Set Location    -33.4939579    -70.5118432
    Sleep    5s

Paso 501
    Set Location    -33.4939088    -70.5118481
    Sleep    5s

Paso 502
    Set Location    -33.4937336    -70.5120541
    Sleep    5s

Paso 503
    Set Location    -33.4935388    -70.5122775
    Sleep    5s

Paso 504
    Set Location    -33.4934318    -70.5123783
    Sleep    5s

Paso 505
    Set Location    -33.4934349    -70.5123751
    Sleep    5s

Paso 506
    Set Location    -33.493435    -70.512375
    Sleep    5s

Paso 507
    Set Location    -33.493435    -70.512375
    Sleep    5s

Paso 508
    Set Location    -33.4933774    -70.5124182
    Sleep    5s

Paso 509
    Set Location    -33.4932042    -70.512587
    Sleep    5s

Paso 510
    Set Location    -33.4929787    -70.5127896
    Sleep    5s

Paso 511
    Set Location    -33.4927314    -70.5129547
    Sleep    5s

Paso 512
    Set Location    -33.4925107    -70.5132254
    Sleep    5s

Paso 513
    Set Location    -33.4923239    -70.5134683
    Sleep    5s

Paso 514
    Set Location    -33.4920495    -70.5135704
    Sleep    5s

Paso 515
    Set Location    -33.4917648    -70.5133794
    Sleep    5s

Paso 516
    Set Location    -33.4914244    -70.5134018
    Sleep    5s

Paso 517
    Set Location    -33.4906694    -70.5144915
    Sleep    5s

Paso 518
    Set Location    -33.49067    -70.5144837
    Sleep    5s

Paso 519
    Set Location    -33.490678    -70.5146865
    Sleep    5s

Paso 520
    Set Location    -33.4905645    -70.5151753
    Sleep    5s

Paso 521
    Set Location    -33.490312    -70.5155926
    Sleep    5s

Paso 522
    Set Location    -33.4900814    -70.5159226
    Sleep    5s

Paso 523
    Set Location    -33.4890307    -70.5163591
    Sleep    5s

Paso 524
    Set Location    -33.4889867    -70.5167257
    Sleep    5s

Paso 525
    Set Location    -33.4890844    -70.5171212
    Sleep    5s

Paso 526
    Set Location    -33.4891861    -70.5175024
    Sleep    5s

Paso 527
    Set Location    -33.4891894    -70.5178836
    Sleep    5s

Paso 528
    Set Location    -33.4890879    -70.5182285
    Sleep    5s

Paso 529
    Set Location    -33.4890984    -70.5185123
    Sleep    5s

Paso 530
    Set Location    -33.4889752    -70.5186826
    Sleep    5s

Paso 531
    Set Location    -33.4887687    -70.5188619
    Sleep    5s

Paso 532
    Set Location    -33.4885215    -70.5190868
    Sleep    5s

Paso 533
    Set Location    -33.4882252    -70.5192212
    Sleep    5s

Paso 534
    Set Location    -33.4879139    -70.519274
    Sleep    5s

Paso 535
    Set Location    -33.487611    -70.5191335
    Sleep    5s

Paso 536
    Set Location    -33.487323    -70.5189756
    Sleep    5s

Paso 537
    Set Location    -33.4870374    -70.5188036
    Sleep    5s

Paso 538
    Set Location    -33.4868269    -70.5186568
    Sleep    5s

Paso 539
    Set Location    -33.4866937    -70.5185866
    Sleep    5s

Paso 540
    Set Location    -33.4866351    -70.5185676
    Sleep    5s

Paso 541
    Set Location    -33.4866018    -70.5185643
    Sleep    5s

Paso 542
    Set Location    -33.4866032    -70.518565
    Sleep    5s

Paso 543
    Set Location    -33.4864717    -70.5186161
    Sleep    5s

Paso 544
    Set Location    -33.4863494    -70.518645
    Sleep    5s

Paso 545
    Set Location    -33.4863918    -70.5188163
    Sleep    5s

Paso 546
    Set Location    -33.4865883    -70.5189253
    Sleep    5s

Paso 547
    Set Location    -33.486869    -70.5190923
    Sleep    5s

Paso 548
    Set Location    -33.4870969    -70.5192453
    Sleep    5s

Paso 549
    Set Location    -33.487235    -70.5193467
    Sleep    5s

Paso 550
    Set Location    -33.487235    -70.5193467
    Sleep    5s

Paso 551
    Set Location    -33.4872925    -70.5193434
    Sleep    5s

Paso 552
    Set Location    -33.4874302    -70.519401
    Sleep    5s

Paso 553
    Set Location    -33.487653    -70.5194366
    Sleep    5s

Paso 554
    Set Location    -33.4879036    -70.5194303
    Sleep    5s

Paso 555
    Set Location    -33.4879469    -70.5192943
    Sleep    5s

Paso 556
    Set Location    -33.4870378    -70.5187969
    Sleep    5s

Paso 557
    Set Location    -33.4867969    -70.5186657
    Sleep    5s

Paso 558
    Set Location    -33.4866019    -70.5185819
    Sleep    5s

Paso 559
    Set Location    -33.486486    -70.5186296
    Sleep    5s

Paso 560
    Set Location    -33.4863732    -70.5186224
    Sleep    5s

Paso 561
    Set Location    -33.4863574    -70.5186291
    Sleep    5s

Paso 562
    Set Location    -33.4863599    -70.5186283
    Sleep    5s

Paso 563
    Set Location    -33.48636    -70.5186283
    Sleep    5s

Paso 564
    Set Location    -33.48636    -70.5186283
    Sleep    5s

Paso 565
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 566
    Set Location    -33.4882746    -70.5192631
    Sleep    5s

Paso 567
    Set Location    -33.4886008    -70.519086
    Sleep    5s

Paso 568
    Set Location    -33.4888813    -70.5188237
    Sleep    5s

Paso 569
    Set Location    -33.4890454    -70.5187442
    Sleep    5s

Paso 570
    Set Location    -33.4891515    -70.518648
    Sleep    5s

Paso 571
    Set Location    -33.4891333    -70.518371
    Sleep    5s

Paso 572
    Set Location    -33.4891369    -70.5181073
    Sleep    5s

Paso 573
    Set Location    -33.4892499    -70.5177976
    Sleep    5s

Paso 574
    Set Location    -33.4892202    -70.5174333
    Sleep    5s

Paso 575
    Set Location    -33.4891203    -70.5170787
    Sleep    5s

Paso 576
    Set Location    -33.4890207    -70.5166939
    Sleep    5s

Paso 577
    Set Location    -33.4890529    -70.5163506
    Sleep    5s

Paso 578
    Set Location    -33.4892544    -70.5162215
    Sleep    5s

Paso 579
    Set Location    -33.4896358    -70.5161387
    Sleep    5s

Paso 580
    Set Location    -33.4899221    -70.5161511
    Sleep    5s

Paso 581
    Set Location    -33.4900944    -70.5161929
    Sleep    5s

Paso 582
    Set Location    -33.4902578    -70.5159185
    Sleep    5s

Paso 583
    Set Location    -33.4904195    -70.5155691
    Sleep    5s

Paso 584
    Set Location    -33.4905517    -70.5152689
    Sleep    5s

Paso 585
    Set Location    -33.490661    -70.5149721
    Sleep    5s

Paso 586
    Set Location    -33.4907723    -70.5147061
    Sleep    5s

Paso 587
    Set Location    -33.4907541    -70.5145727
    Sleep    5s

Paso 588
    Set Location    -33.4907533    -70.5145797
    Sleep    5s

Paso 589
    Set Location    -33.4907533    -70.51458
    Sleep    5s

Paso 590
    Set Location    -33.4907533    -70.51458
    Sleep    5s

Paso 591
    Set Location    -33.4907214    -70.5144632
    Sleep    5s

Paso 592
    Set Location    -33.4907225    -70.5142367
    Sleep    5s

Paso 593
    Set Location    -33.4907693    -70.5140295
    Sleep    5s

Paso 594
    Set Location    -33.490846    -70.5138266
    Sleep    5s

Paso 595
    Set Location    -33.4910448    -70.5136718
    Sleep    5s

Paso 596
    Set Location    -33.4913755    -70.5135071
    Sleep    5s

Paso 597
    Set Location    -33.4917494    -70.5133793
    Sleep    5s

Paso 598
    Set Location    -33.4920934    -70.513597
    Sleep    5s

Paso 599
    Set Location    -33.4923437    -70.5135455
    Sleep    5s

Paso 600
    Set Location    -33.4924661    -70.5134177
    Sleep    5s

Paso 601
    Set Location    -33.4925721    -70.5132357
    Sleep    5s

Paso 602
    Set Location    -33.4926879    -70.5130758
    Sleep    5s

Paso 603
    Set Location    -33.4928669    -70.5129505
    Sleep    5s

Paso 604
    Set Location    -33.493558    -70.5123492
    Sleep    5s

Paso 605
    Set Location    -33.4937691    -70.5121227
    Sleep    5s

Paso 606
    Set Location    -33.4938773    -70.5119433
    Sleep    5s

Paso 607
    Set Location    -33.4938735    -70.5119417
    Sleep    5s

Paso 608
    Set Location    -33.4939085    -70.5118921
    Sleep    5s

Paso 609
    Set Location    -33.4939618    -70.511753
    Sleep    5s

Paso 610
    Set Location    -33.4939564    -70.5117279
    Sleep    5s

Paso 611
    Set Location    -33.4939455    -70.5118132
    Sleep    5s

Paso 612
    Set Location    -33.4939506    -70.5118404
    Sleep    5s

Paso 613
    Set Location    -33.49395    -70.5118383
    Sleep    5s

Paso 614
    Set Location    -33.4934635    -70.5123672
    Sleep    5s

Paso 615
    Set Location    -33.4934649    -70.5123636
    Sleep    5s

Paso 616
    Set Location    -33.4934649    -70.5123632
    Sleep    5s

Paso 617
    Set Location    -33.4934574    -70.5123618
    Sleep    5s

Paso 618
    Set Location    -33.4934582    -70.5123586
    Sleep    5s

Paso 619
    Set Location    -33.4934583    -70.5123583
    Sleep    5s

Paso 620
    Set Location    -33.4934583    -70.5123583
    Sleep    5s

Paso 621
    Set Location    -33.4933552    -70.5124799
    Sleep    5s

Paso 622
    Set Location    -33.4931197    -70.5126856
    Sleep    5s

Paso 623
    Set Location    -33.4930589    -70.5127285
    Sleep    5s

Paso 624
    Set Location    -33.4929229    -70.5128323
    Sleep    5s

Paso 625
    Set Location    -33.492733    -70.51297
    Sleep    5s

Paso 626
    Set Location    -33.4925824    -70.5131278
    Sleep    5s

Paso 627
    Set Location    -33.4923483    -70.513472
    Sleep    5s

Paso 628
    Set Location    -33.4920027    -70.5135694
    Sleep    5s

Paso 629
    Set Location    -33.4916827    -70.5133691
    Sleep    5s

Paso 630
    Set Location    -33.4906664    -70.5144544
    Sleep    5s

Paso 631
    Set Location    -33.490681    -70.5146124
    Sleep    5s

Paso 632
    Set Location    -33.4906279    -70.5150016
    Sleep    5s

Paso 633
    Set Location    -33.4903818    -70.5154769
    Sleep    5s

Paso 634
    Set Location    -33.4901032    -70.5159138
    Sleep    5s

Paso 635
    Set Location    -33.4889797    -70.516656
    Sleep    5s

Paso 636
    Set Location    -33.4891081    -70.5172344
    Sleep    5s

Paso 637
    Set Location    -33.4891259    -70.5180741
    Sleep    5s

Paso 638
    Set Location    -33.4891005    -70.5184502
    Sleep    5s

Paso 639
    Set Location    -33.486819    -70.5186584
    Sleep    5s

Paso 640
    Set Location    -33.486557    -70.5185995
    Sleep    5s

Paso 641
    Set Location    -33.4863633    -70.5186167
    Sleep    5s

Paso 642
    Set Location    -33.4863633    -70.5186167
    Sleep    5s

Paso 643
    Set Location    -33.4863297    -70.5186503
    Sleep    5s

Paso 644
    Set Location    -33.4868918    -70.5191004
    Sleep    5s

Paso 645
    Set Location    -33.4879509    -70.5194121
    Sleep    5s

Paso 646
    Set Location    -33.4880152    -70.5193446
    Sleep    5s

Paso 647
    Set Location    -33.488285    -70.5192377
    Sleep    5s

Paso 648
    Set Location    -33.4891594    -70.5186121
    Sleep    5s

Paso 649
    Set Location    -33.4891299    -70.5182722
    Sleep    5s

Paso 650
    Set Location    -33.4892077    -70.5179377
    Sleep    5s

Paso 651
    Set Location    -33.4892518    -70.5175169
    Sleep    5s

Paso 652
    Set Location    -33.4890567    -70.5163582
    Sleep    5s

Paso 653
    Set Location    -33.4892424    -70.5162156
    Sleep    5s

Paso 654
    Set Location    -33.489683    -70.5161217
    Sleep    5s

Paso 655
    Set Location    -33.4899646    -70.5161771
    Sleep    5s

Paso 656
    Set Location    -33.490598    -70.5151824
    Sleep    5s

Paso 657
    Set Location    -33.4907085    -70.5148626
    Sleep    5s

Paso 658
    Set Location    -33.4907746    -70.5145991
    Sleep    5s

Paso 659
    Set Location    -33.4907523    -70.5145726
    Sleep    5s

Paso 660
    Set Location    -33.4907533    -70.5145781
    Sleep    5s

Paso 661
    Set Location    -33.4907533    -70.5145783
    Sleep    5s

Paso 662
    Set Location    -33.4907533    -70.5145783
    Sleep    5s

Paso 663
    Set Location    -33.4907149    -70.5144616
    Sleep    5s

Paso 664
    Set Location    -33.4907296    -70.5142342
    Sleep    5s

Paso 665
    Set Location    -33.4907775    -70.5140309
    Sleep    5s

Paso 666
    Set Location    -33.4908638    -70.5138283
    Sleep    5s

Paso 667
    Set Location    -33.4910719    -70.5136848
    Sleep    5s

Paso 668
    Set Location    -33.4913884    -70.5134984
    Sleep    5s

Paso 669
    Set Location    -33.4917907    -70.513425
    Sleep    5s

Paso 670
    Set Location    -33.4921681    -70.5136026
    Sleep    5s

Paso 671
    Set Location    -33.4923947    -70.5135059
    Sleep    5s

Paso 672
    Set Location    -33.4925178    -70.5133413
    Sleep    5s

Paso 673
    Set Location    -33.4930058    -70.5128539
    Sleep    5s

Paso 674
    Set Location    -33.4937003    -70.5121921
    Sleep    5s

Paso 675
    Set Location    -33.4938984    -70.5119244
    Sleep    5s

Paso 676
    Set Location    -33.4939662    -70.5117309
    Sleep    5s

Paso 677
    Set Location    -33.4939615    -70.5117259
    Sleep    5s

Paso 678
    Set Location    -33.4939457    -70.5118002
    Sleep    5s

Paso 679
    Set Location    -33.4939585    -70.51184
    Sleep    5s

Paso 680
    Set Location    -33.4938449    -70.5119247
    Sleep    5s

Paso 681
    Set Location    -33.4936726    -70.5121508
    Sleep    5s

Paso 682
    Set Location    -33.4934877    -70.5123445
    Sleep    5s

Paso 683
    Set Location    -33.4934627    -70.5123705
    Sleep    5s

Paso 684
    Set Location    -33.4934665    -70.5123669
    Sleep    5s

Paso 685
    Set Location    -33.4934667    -70.5123667
    Sleep    5s

Paso 686
    Set Location    -33.4934667    -70.5123667
    Sleep    5s

Paso 687
    Set Location    -33.4933931    -70.5124386
    Sleep    5s

Paso 688
    Set Location    -33.4931104    -70.512679
    Sleep    5s

Paso 689
    Set Location    -33.4927697    -70.5129438
    Sleep    5s

Paso 690
    Set Location    -33.4924692    -70.5133119
    Sleep    5s

Paso 691
    Set Location    -33.4921367    -70.5135809
    Sleep    5s

Paso 692
    Set Location    -33.4917835    -70.5134259
    Sleep    5s

Paso 693
    Set Location    -33.4906943    -70.5141586
    Sleep    5s

Paso 694
    Set Location    -33.4906726    -70.5143521
    Sleep    5s

Paso 695
    Set Location    -33.4905667    -70.514605
    Sleep    5s

Paso 696
    Set Location    -33.4905667    -70.514605
    Sleep    5s

Paso 697
    Set Location    -33.4905315    -70.5148853
    Sleep    5s

Paso 698
    Set Location    -33.489765    -70.5160653
    Sleep    5s

Paso 699
    Set Location    -33.4892961    -70.5161354
    Sleep    5s

Paso 700
    Set Location    -33.4890305    -70.5162095
    Sleep    5s

Paso 701
    Set Location    -33.4889813    -70.5166355
    Sleep    5s

Paso 702
    Set Location    -33.489107    -70.5172203
    Sleep    5s

Paso 703
    Set Location    -33.4892367    -70.5176895
    Sleep    5s

Paso 704
    Set Location    -33.4891122    -70.5181046
    Sleep    5s

Paso 705
    Set Location    -33.4890963    -70.5184979
    Sleep    5s

Paso 706
    Set Location    -33.4888949    -70.5187489
    Sleep    5s

Paso 707
    Set Location    -33.4885663    -70.5190627
    Sleep    5s

Paso 708
    Set Location    -33.48818    -70.5192534
    Sleep    5s

Paso 709
    Set Location    -33.4877836    -70.5192475
    Sleep    5s

Paso 710
    Set Location    -33.4873948    -70.5190417
    Sleep    5s

Paso 711
    Set Location    -33.4870371    -70.518835
    Sleep    5s

Paso 712
    Set Location    -33.486701    -70.5186479
    Sleep    5s

Paso 713
    Set Location    -33.4865309    -70.5186106
    Sleep    5s

Paso 714
    Set Location    -33.4864182    -70.5186241
    Sleep    5s

Paso 715
    Set Location    -33.4863475    -70.5186337
    Sleep    5s

Paso 716
    Set Location    -33.4863499    -70.5186349
    Sleep    5s

Paso 717
    Set Location    -33.48635    -70.518635
    Sleep    5s

Paso 718
    Set Location    -33.48635    -70.518635
    Sleep    5s

Paso 719
    Set Location    -33.4863116    -70.5186558
    Sleep    5s

Paso 720
    Set Location    -33.486363    -70.5188091
    Sleep    5s

Paso 721
    Set Location    -33.4866039    -70.5189484
    Sleep    5s

Paso 722
    Set Location    -33.4871634    -70.5192318
    Sleep    5s

Paso 723
    Set Location    -33.4871633    -70.5192317
    Sleep    5s

Paso 724
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 725
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 726
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 727
    Set Location    -33.4904633    -70.5154423
    Sleep    5s

Paso 728
    Set Location    -33.4905377    -70.5152904
    Sleep    5s

Paso 729
    Set Location    -33.4906132    -70.5151415
    Sleep    5s

Paso 730
    Set Location    -33.490677    -70.5149572
    Sleep    5s

Paso 731
    Set Location    -33.490749    -70.5147827
    Sleep    5s

Paso 732
    Set Location    -33.4907726    -70.5146164
    Sleep    5s

Paso 733
    Set Location    -33.4907643    -70.5145915
    Sleep    5s

Paso 734
    Set Location    -33.490765    -70.514595
    Sleep    5s

Paso 735
    Set Location    -33.490765    -70.514595
    Sleep    5s

Paso 736
    Set Location    -33.4907072    -70.5143866
    Sleep    5s

Paso 737
    Set Location    -33.4907128    -70.5142159
    Sleep    5s

Paso 738
    Set Location    -33.4908954    -70.5137792
    Sleep    5s

Paso 739
    Set Location    -33.4910459    -70.5136892
    Sleep    5s

Paso 740
    Set Location    -33.4913273    -70.513567
    Sleep    5s

Paso 741
    Set Location    -33.4917075    -70.5133913
    Sleep    5s

Paso 742
    Set Location    -33.4924575    -70.5134345
    Sleep    5s

Paso 743
    Set Location    -33.4925691    -70.5132593
    Sleep    5s

Paso 744
    Set Location    -33.4926856    -70.5130942
    Sleep    5s

Paso 745
    Set Location    -33.4928441    -70.512969
    Sleep    5s

Paso 746
    Set Location    -33.4935193    -70.5123923
    Sleep    5s

Paso 747
    Set Location    -33.4937501    -70.5121343
    Sleep    5s

Paso 748
    Set Location    -33.4939413    -70.5118452
    Sleep    5s

Paso 749
    Set Location    -33.493968    -70.5117235
    Sleep    5s

Paso 750
    Set Location    -33.4939635    -70.5117266
    Sleep    5s

Paso 751
    Set Location    -33.4939522    -70.5117874
    Sleep    5s

Paso 752
    Set Location    -33.4939563    -70.5118075
    Sleep    5s

Paso 753
    Set Location    -33.4939567    -70.5118051
    Sleep    5s

Paso 754
    Set Location    -33.4939567    -70.511805
    Sleep    5s

Paso 755
    Set Location    -33.4937777    -70.5120367
    Sleep    5s

Paso 756
    Set Location    -33.4935362    -70.5122928
    Sleep    5s

Paso 757
    Set Location    -33.4934509    -70.5123642
    Sleep    5s

Paso 758
    Set Location    -33.4934548    -70.5123602
    Sleep    5s

Paso 759
    Set Location    -33.493455    -70.51236
    Sleep    5s

Paso 760
    Set Location    -33.493455    -70.51236
    Sleep    5s

Paso 761
    Set Location    -33.4933718    -70.5124528
    Sleep    5s

Paso 762
    Set Location    -33.4931407    -70.5126517
    Sleep    5s

Paso 763
    Set Location    -33.4927902    -70.5129203
    Sleep    5s

Paso 764
    Set Location    -33.4924905    -70.5132851
    Sleep    5s

Paso 765
    Set Location    -33.4921891    -70.5135698
    Sleep    5s

Paso 766
    Set Location    -33.4918299    -70.5134409
    Sleep    5s

Paso 767
    Set Location    -33.4914594    -70.5133649
    Sleep    5s

Paso 768
    Set Location    -33.4910584    -70.5136154
    Sleep    5s

Paso 769
    Set Location    -33.4906728    -70.5146837
    Sleep    5s

Paso 770
    Set Location    -33.4905579    -70.5151486
    Sleep    5s

Paso 771
    Set Location    -33.4902763    -70.5156454
    Sleep    5s

Paso 772
    Set Location    -33.4899927    -70.5160032
    Sleep    5s

Paso 773
    Set Location    -33.489016    -70.5169074
    Sleep    5s

Paso 774
    Set Location    -33.4891499    -70.5173943
    Sleep    5s

Paso 775
    Set Location    -33.4876301    -70.5191519
    Sleep    5s

Paso 776
    Set Location    -33.486525    -70.5186099
    Sleep    5s

Paso 777
    Set Location    -33.4863416    -70.51862
    Sleep    5s

Paso 778
    Set Location    -33.4863417    -70.51862
    Sleep    5s

Paso 779
    Set Location    -33.4863417    -70.51862
    Sleep    5s

Paso 780
    Set Location    -33.4863257    -70.5187463
    Sleep    5s

Paso 781
    Set Location    -33.4865521    -70.5189108
    Sleep    5s

Paso 782
    Set Location    -33.486906    -70.5191135
    Sleep    5s

Paso 783
    Set Location    -33.4872997    -70.5193284
    Sleep    5s

Paso 784
    Set Location    -33.4882313    -70.5192759
    Sleep    5s

Paso 785
    Set Location    -33.4885763    -70.5191072
    Sleep    5s

Paso 786
    Set Location    -33.4891227    -70.518261
    Sleep    5s

Paso 787
    Set Location    -33.4892083    -70.5179441
    Sleep    5s

Paso 788
    Set Location    -33.4903039    -70.5158346
    Sleep    5s

Paso 789
    Set Location    -33.4907741    -70.5146072
    Sleep    5s

Paso 790
    Set Location    -33.4907556    -70.5145861
    Sleep    5s

Paso 791
    Set Location    -33.4907567    -70.5145933
    Sleep    5s

Paso 792
    Set Location    -33.4907263    -70.5145277
    Sleep    5s

Paso 793
    Set Location    -33.4907093    -70.5142875
    Sleep    5s

Paso 794
    Set Location    -33.4913736    -70.5135198
    Sleep    5s

Paso 795
    Set Location    -33.4923846    -70.5135018
    Sleep    5s

Paso 796
    Set Location    -33.4924977    -70.5133577
    Sleep    5s

Paso 797
    Set Location    -33.4931174    -70.5127531
    Sleep    5s

Paso 798
    Set Location    -33.4933656    -70.5125322
    Sleep    5s

Paso 799
    Set Location    -33.493622    -70.5122826
    Sleep    5s

Paso 800
    Set Location    -33.493838    -70.5119958
    Sleep    5s

Paso 801
    Set Location    -33.4939592    -70.5117827
    Sleep    5s

Paso 802
    Set Location    -33.493951    -70.5117195
    Sleep    5s

Paso 803
    Set Location    -33.4939405    -70.5117855
    Sleep    5s

Paso 804
    Set Location    -33.4939493    -70.5118368
    Sleep    5s

Paso 805
    Set Location    -33.4938285    -70.5119311
    Sleep    5s

Paso 806
    Set Location    -33.4936323    -70.5122068
    Sleep    5s

Paso 807
    Set Location    -33.4934645    -70.5123627
    Sleep    5s

Paso 808
    Set Location    -33.493465    -70.5123601
    Sleep    5s

Paso 809
    Set Location    -33.493465    -70.51236
    Sleep    5s

Paso 810
    Set Location    -33.493465    -70.51236
    Sleep    5s

Paso 811
    Set Location    -33.4933819    -70.5124271
    Sleep    5s

Paso 812
    Set Location    -33.4931626    -70.5126406
    Sleep    5s

Paso 813
    Set Location    -33.4927993    -70.5129165
    Sleep    5s

Paso 814
    Set Location    -33.4924743    -70.5132833
    Sleep    5s

Paso 815
    Set Location    -33.4921647    -70.5135776
    Sleep    5s

Paso 816
    Set Location    -33.4917918    -70.5134083
    Sleep    5s

Paso 817
    Set Location    -33.4914179    -70.5133931
    Sleep    5s

Paso 818
    Set Location    -33.4910085    -70.5136325
    Sleep    5s

Paso 819
    Set Location    -33.4907483    -70.5139439
    Sleep    5s

Paso 820
    Set Location    -33.4906572    -70.5143454
    Sleep    5s

Paso 821
    Set Location    -33.4906293    -70.5145332
    Sleep    5s

Paso 822
    Set Location    -33.4905773    -70.5146183
    Sleep    5s

Paso 823
    Set Location    -33.4905799    -70.5146168
    Sleep    5s

Paso 824
    Set Location    -33.49058    -70.5146167
    Sleep    5s

Paso 825
    Set Location    -33.49058    -70.5146167
    Sleep    5s

Paso 826
    Set Location    -33.490556    -70.514735
    Sleep    5s

Paso 827
    Set Location    -33.4904537    -70.5151132
    Sleep    5s

Paso 828
    Set Location    -33.4902586    -70.5155177
    Sleep    5s

Paso 829
    Set Location    -33.4901948    -70.5157298
    Sleep    5s

Paso 830
    Set Location    -33.4901934    -70.5157284
    Sleep    5s

Paso 831
    Set Location    -33.4900527    -70.5159636
    Sleep    5s

Paso 832
    Set Location    -33.4890917    -70.5171374
    Sleep    5s

Paso 833
    Set Location    -33.4892211    -70.5175609
    Sleep    5s

Paso 834
    Set Location    -33.4890823    -70.5183539
    Sleep    5s

Paso 835
    Set Location    -33.4879967    -70.5193045
    Sleep    5s

Paso 836
    Set Location    -33.4863474    -70.5186125
    Sleep    5s

Paso 837
    Set Location    -33.48635    -70.5186117
    Sleep    5s

Paso 838
    Set Location    -33.48635    -70.5186117
    Sleep    5s

Paso 839
    Set Location    -33.4863164    -70.5187571
    Sleep    5s

Paso 840
    Set Location    -33.486497    -70.518889
    Sleep    5s

Paso 841
    Set Location    -33.4868009    -70.5190627
    Sleep    5s

Paso 842
    Set Location    -33.4887557    -70.5189384
    Sleep    5s

Paso 843
    Set Location    -33.488956    -70.5187738
    Sleep    5s

Paso 844
    Set Location    -33.4889843    -70.518759
    Sleep    5s

Paso 845
    Set Location    -33.4890442    -70.5187535
    Sleep    5s

Paso 846
    Set Location    -33.489155    -70.5186197
    Sleep    5s

Paso 847
    Set Location    -33.4891223    -70.5183451
    Sleep    5s

Paso 848
    Set Location    -33.4891382    -70.5180988
    Sleep    5s

Paso 849
    Set Location    -33.4892459    -70.5177756
    Sleep    5s

Paso 850
    Set Location    -33.4891843    -70.5173984
    Sleep    5s

Paso 851
    Set Location    -33.4890713    -70.5170302
    Sleep    5s

Paso 852
    Set Location    -33.4889995    -70.5166326
    Sleep    5s

Paso 853
    Set Location    -33.4890761    -70.5162919
    Sleep    5s

Paso 854
    Set Location    -33.4893088    -70.5161689
    Sleep    5s

Paso 855
    Set Location    -33.4897568    -70.5161224
    Sleep    5s

Paso 856
    Set Location    -33.4899839    -70.516189
    Sleep    5s

Paso 857
    Set Location    -33.4901565    -70.5161001
    Sleep    5s

Paso 858
    Set Location    -33.490344    -70.5157314
    Sleep    5s

Paso 859
    Set Location    -33.4904869    -70.5153993
    Sleep    5s

Paso 860
    Set Location    -33.4906181    -70.515124
    Sleep    5s

Paso 861
    Set Location    -33.4907396    -70.5148233
    Sleep    5s

Paso 862
    Set Location    -33.4907699    -70.5145876
    Sleep    5s

Paso 863
    Set Location    -33.4907666    -70.5145822
    Sleep    5s

Paso 864
    Set Location    -33.4907667    -70.5145849
    Sleep    5s

Paso 865
    Set Location    -33.4907667    -70.514585
    Sleep    5s

Paso 866
    Set Location    -33.4907667    -70.514585
    Sleep    5s

Paso 867
    Set Location    -33.4907555    -70.5145514
    Sleep    5s

Paso 868
    Set Location    -33.4907566    -70.514558
    Sleep    5s

Paso 869
    Set Location    -33.4907136    -70.5144431
    Sleep    5s

Paso 870
    Set Location    -33.4907155    -70.5142831
    Sleep    5s

Paso 871
    Set Location    -33.4907429    -70.5141863
    Sleep    5s

Paso 872
    Set Location    -33.4907684    -70.5140238
    Sleep    5s

Paso 873
    Set Location    -33.4908273    -70.5138682
    Sleep    5s

Paso 874
    Set Location    -33.4909386    -70.5137505
    Sleep    5s

Paso 875
    Set Location    -33.4910916    -70.5136828
    Sleep    5s

Paso 876
    Set Location    -33.4913778    -70.5135173
    Sleep    5s

Paso 877
    Set Location    -33.491736    -70.5134005
    Sleep    5s

Paso 878
    Set Location    -33.4925554    -70.5132693
    Sleep    5s

Paso 879
    Set Location    -33.4926804    -70.5130815
    Sleep    5s

Paso 880
    Set Location    -33.492847    -70.5129538
    Sleep    5s

Paso 881
    Set Location    -33.4930464    -70.5128044
    Sleep    5s

Paso 882
    Set Location    -33.4932727    -70.5125989
    Sleep    5s

Paso 883
    Set Location    -33.4934921    -70.5124031
    Sleep    5s

Paso 884
    Set Location    -33.493687    -70.512177
    Sleep    5s

Paso 885
    Set Location    -33.4938802    -70.511932
    Sleep    5s

Paso 886
    Set Location    -33.4939445    -70.5117299
    Sleep    5s

Paso 887
    Set Location    -33.4939388    -70.5117201
    Sleep    5s

Paso 888
    Set Location    -33.4939304    -70.511816
    Sleep    5s

Paso 889
    Set Location    -33.493467    -70.5123557
    Sleep    5s

Paso 890
    Set Location    -33.4934682    -70.5123534
    Sleep    5s

Paso 891
    Set Location    -33.4934683    -70.5123533
    Sleep    5s

Paso 892
    Set Location    -33.4934683    -70.5123533
    Sleep    5s

Paso 893
    Set Location    -33.4934267    -70.5123917
    Sleep    5s

Paso 894
    Set Location    -33.4932984    -70.5124986
    Sleep    5s

Paso 895
    Set Location    -33.4930145    -70.5127571
    Sleep    5s

Paso 896
    Set Location    -33.4926865    -70.513006
    Sleep    5s

Paso 897
    Set Location    -33.4924507    -70.5133402
    Sleep    5s

Paso 898
    Set Location    -33.4920959    -70.513579
    Sleep    5s

Paso 899
    Set Location    -33.4917697    -70.5133878
    Sleep    5s

Paso 900
    Set Location    -33.4914364    -70.5133679
    Sleep    5s

Paso 901
    Set Location    -33.4910535    -70.5136098
    Sleep    5s

Paso 902
    Set Location    -33.490743    -70.5139568
    Sleep    5s

Paso 903
    Set Location    -33.4906638    -70.5143771
    Sleep    5s

Paso 904
    Set Location    -33.4906146    -70.5145695
    Sleep    5s

Paso 905
    Set Location    -33.4905727    -70.5146128
    Sleep    5s

Paso 906
    Set Location    -33.4905749    -70.5146101
    Sleep    5s

Paso 907
    Set Location    -33.490575    -70.51461
    Sleep    5s

Paso 908
    Set Location    -33.490575    -70.51461
    Sleep    5s

Paso 909
    Set Location    -33.4905335    -70.514892
    Sleep    5s

Paso 910
    Set Location    -33.4903246    -70.5153676
    Sleep    5s

Paso 911
    Set Location    -33.4902101    -70.5156988
    Sleep    5s

Paso 912
    Set Location    -33.4902079    -70.515716
    Sleep    5s

Paso 913
    Set Location    -33.4901092    -70.5158942
    Sleep    5s

Paso 914
    Set Location    -33.4893565    -70.5161291
    Sleep    5s

Paso 915
    Set Location    -33.4890822    -70.5171024
    Sleep    5s

Paso 916
    Set Location    -33.4892156    -70.517571
    Sleep    5s

Paso 917
    Set Location    -33.4866083    -70.5185909
    Sleep    5s

Paso 918
    Set Location    -33.4863367    -70.518615
    Sleep    5s

Paso 919
    Set Location    -33.4863367    -70.518615
    Sleep    5s

Paso 920
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 921
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 922
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 923
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 924
    Set Location    -33.4874849    -70.5194336
    Sleep    5s

Paso 925
    Set Location    -33.4877923    -70.5194556
    Sleep    5s

Paso 926
    Set Location    -33.4880029    -70.5193715
    Sleep    5s

Paso 927
    Set Location    -33.4882818    -70.5192658
    Sleep    5s

Paso 928
    Set Location    -33.4886275    -70.5190616
    Sleep    5s

Paso 929
    Set Location    -33.4889475    -70.5187914
    Sleep    5s

Paso 930
    Set Location    -33.4890509    -70.5187508
    Sleep    5s

Paso 931
    Set Location    -33.4891335    -70.5186172
    Sleep    5s

Paso 932
    Set Location    -33.489116    -70.5183315
    Sleep    5s

Paso 933
    Set Location    -33.4891412    -70.5180819
    Sleep    5s

Paso 934
    Set Location    -33.4892456    -70.5177618
    Sleep    5s

Paso 935
    Set Location    -33.489187    -70.5173898
    Sleep    5s

Paso 936
    Set Location    -33.4890831    -70.5169909
    Sleep    5s

Paso 937
    Set Location    -33.4890156    -70.5166129
    Sleep    5s

Paso 938
    Set Location    -33.4890785    -70.5162934
    Sleep    5s

Paso 939
    Set Location    -33.4893173    -70.5162088
    Sleep    5s

Paso 940
    Set Location    -33.4897326    -70.5161175
    Sleep    5s

Paso 941
    Set Location    -33.4902881    -70.5158529
    Sleep    5s

Paso 942
    Set Location    -33.4904253    -70.5155243
    Sleep    5s

Paso 943
    Set Location    -33.4905465    -70.5152298
    Sleep    5s

Paso 944
    Set Location    -33.490662    -70.514965
    Sleep    5s

Paso 945
    Set Location    -33.490777    -70.5146872
    Sleep    5s

Paso 946
    Set Location    -33.4907652    -70.5145793
    Sleep    5s

Paso 947
    Set Location    -33.4907633    -70.514585
    Sleep    5s

Paso 948
    Set Location    -33.4907633    -70.514585
    Sleep    5s

Paso 949
    Set Location    -33.490788    -70.513963
    Sleep    5s

Paso 950
    Set Location    -33.4908753    -70.5137922
    Sleep    5s

Paso 951
    Set Location    -33.4911017    -70.5136687
    Sleep    5s

Paso 952
    Set Location    -33.4914314    -70.5134702
    Sleep    5s

Paso 953
    Set Location    -33.4918344    -70.5134659
    Sleep    5s

Paso 954
    Set Location    -33.4921868    -70.5136259
    Sleep    5s

Paso 955
    Set Location    -33.4923796    -70.5135322
    Sleep    5s

Paso 956
    Set Location    -33.4925162    -70.5133696
    Sleep    5s

Paso 957
    Set Location    -33.4926222    -70.5131651
    Sleep    5s

Paso 958
    Set Location    -33.4927742    -70.5130154
    Sleep    5s

Paso 959
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 960
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 961
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 962
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 963
    Set Location    -33.4934733    -70.512355
    Sleep    5s

Paso 964
    Set Location    -33.4934733    -70.512355
    Sleep    5s

Paso 965
    Set Location    -33.4934733    -70.5123981
    Sleep    5s

Paso 966
    Set Location    -33.4932865    -70.5125708
    Sleep    5s

Paso 967
    Set Location    -33.4920545    -70.5135682
    Sleep    5s

Paso 968
    Set Location    -33.4916718    -70.5133562
    Sleep    5s

Paso 969
    Set Location    -33.4906741    -70.5145042
    Sleep    5s

Paso 970
    Set Location    -33.4905765    -70.5146052
    Sleep    5s

Paso 971
    Set Location    -33.4905751    -70.5146019
    Sleep    5s

Paso 972
    Set Location    -33.490575    -70.5146017
    Sleep    5s

Paso 973
    Set Location    -33.490575    -70.5146017
    Sleep    5s

Paso 974
    Set Location    -33.4905622    -70.5147136
    Sleep    5s

Paso 975
    Set Location    -33.4904777    -70.5150833
    Sleep    5s

Paso 976
    Set Location    -33.4902555    -70.5154747
    Sleep    5s

Paso 977
    Set Location    -33.4902118    -70.5156971
    Sleep    5s

Paso 978
    Set Location    -33.4901275    -70.5158862
    Sleep    5s

Paso 979
    Set Location    -33.4897832    -70.5160403
    Sleep    5s

Paso 980
    Set Location    -33.489313    -70.5161383
    Sleep    5s

Paso 981
    Set Location    -33.4891088    -70.517212
    Sleep    5s

Paso 982
    Set Location    -33.4892073    -70.5176672
    Sleep    5s

Paso 983
    Set Location    -33.4891259    -70.5180586
    Sleep    5s

Paso 984
    Set Location    -33.4891058    -70.5184593
    Sleep    5s

Paso 985
    Set Location    -33.4889277    -70.5187196
    Sleep    5s

Paso 986
    Set Location    -33.4886076    -70.5190028
    Sleep    5s

Paso 987
    Set Location    -33.4882038    -70.5192409
    Sleep    5s

Paso 988
    Set Location    -33.4878064    -70.5192479
    Sleep    5s

Paso 989
    Set Location    -33.4874047    -70.519021
    Sleep    5s

Paso 990
    Set Location    -33.4870145    -70.518799
    Sleep    5s

Paso 991
    Set Location    -33.4866883    -70.5186117
    Sleep    5s

Paso 992
    Set Location    -33.4865192    -70.5186038
    Sleep    5s

Paso 993
    Set Location    -33.4863805    -70.518602
    Sleep    5s

Paso 994
    Set Location    -33.4863439    -70.5186066
    Sleep    5s

Paso 995
    Set Location    -33.4863466    -70.5186067
    Sleep    5s

Paso 996
    Set Location    -33.4863467    -70.5186067
    Sleep    5s

Paso 997
    Set Location    -33.4863467    -70.5186067
    Sleep    5s

Paso 998
    Set Location    -33.4863259    -70.5186451
    Sleep    5s

Paso 999
    Set Location    -33.4863551    -70.5187852
    Sleep    5s

Paso 1000
    Set Location    -33.4865591    -70.5189245
    Sleep    5s

Paso 1001
    Set Location    -33.4868853    -70.5191075
    Sleep    5s

Paso 1002
    Set Location    -33.4872584    -70.5193407
    Sleep    5s

Paso 1003
    Set Location    -33.4882908    -70.5192529
    Sleep    5s

Paso 1004
    Set Location    -33.4886416    -70.5190379
    Sleep    5s

Paso 1005
    Set Location    -33.4889387    -70.5187784
    Sleep    5s

Paso 1006
    Set Location    -33.4890991    -70.518193
    Sleep    5s

Paso 1007
    Set Location    -33.4890169    -70.5167395
    Sleep    5s

Paso 1008
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 1009
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 1010
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 1011
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 1012
    Set Location    -33.4907329    -70.5144945
    Sleep    5s

Paso 1013
    Set Location    -33.4907042    -70.5142846
    Sleep    5s

Paso 1014
    Set Location    -33.4907522    -70.5140826
    Sleep    5s

Paso 1015
    Set Location    -33.4908096    -70.513911
    Sleep    5s

Paso 1016
    Set Location    -33.4909197    -70.5137674
    Sleep    5s

Paso 1017
    Set Location    -33.4911582    -70.5136425
    Sleep    5s

Paso 1018
    Set Location    -33.4915029    -70.5134349
    Sleep    5s

Paso 1019
    Set Location    -33.4918865    -70.5134938
    Sleep    5s

Paso 1020
    Set Location    -33.4922117    -70.5135956
    Sleep    5s

Paso 1021
    Set Location    -33.4923891    -70.5135121
    Sleep    5s

Paso 1022
    Set Location    -33.4925156    -70.5133574
    Sleep    5s

Paso 1023
    Set Location    -33.4926281    -70.5131605
    Sleep    5s

Paso 1024
    Set Location    -33.4927547    -70.5130188
    Sleep    5s

Paso 1025
    Set Location    -33.4929262    -70.5128999
    Sleep    5s

Paso 1026
    Set Location    -33.493142    -70.5127265
    Sleep    5s

Paso 1027
    Set Location    -33.4933811    -70.5125041
    Sleep    5s

Paso 1028
    Set Location    -33.493599    -70.5122898
    Sleep    5s

Paso 1029
    Set Location    -33.4938022    -70.5120279
    Sleep    5s

Paso 1030
    Set Location    -33.4939499    -70.5118005
    Sleep    5s

Paso 1031
    Set Location    -33.4939482    -70.5117269
    Sleep    5s

Paso 1032
    Set Location    -33.4939468    -70.5117315
    Sleep    5s

Paso 1033
    Set Location    -33.4939338    -70.5117637
    Sleep    5s

Paso 1034
    Set Location    -33.4939405    -70.5118362
    Sleep    5s

Paso 1035
    Set Location    -33.4938745    -70.5118575
    Sleep    5s

Paso 1036
    Set Location    -33.4937488    -70.5120695
    Sleep    5s

Paso 1037
    Set Location    -33.4935434    -70.5122804
    Sleep    5s

Paso 1038
    Set Location    -33.4934633    -70.5123598
    Sleep    5s

Paso 1039
    Set Location    -33.4934681    -70.5123584
    Sleep    5s

Paso 1040
    Set Location    -33.4934683    -70.5123583
    Sleep    5s

Paso 1041
    Set Location    -33.4934683    -70.5123583
    Sleep    5s

Paso 1042
    Set Location    -33.4934443    -70.5124398
    Sleep    5s

Paso 1043
    Set Location    -33.4932948    -70.5125664
    Sleep    5s

Paso 1044
    Set Location    -33.4930013    -70.5128002
    Sleep    5s

Paso 1045
    Set Location    -33.4928075    -70.5129423
    Sleep    5s

Paso 1046
    Set Location    -33.4928115    -70.5129417
    Sleep    5s

Paso 1047
    Set Location    -33.4928117    -70.5129417
    Sleep    5s

Paso 1048
    Set Location    -33.4925969    -70.5131415
    Sleep    5s

Paso 1049
    Set Location    -33.4923467    -70.5134608
    Sleep    5s

Paso 1050
    Set Location    -33.4919756    -70.5135474
    Sleep    5s

Paso 1051
    Set Location    -33.491615    -70.5133304
    Sleep    5s

Paso 1052
    Set Location    -33.490666    -70.5144524
    Sleep    5s

Paso 1053
    Set Location    -33.4905795    -70.5145908
    Sleep    5s

Paso 1054
    Set Location    -33.4905613    -70.514609
    Sleep    5s

Paso 1055
    Set Location    -33.4905632    -70.5146052
    Sleep    5s

Paso 1056
    Set Location    -33.4905314    -70.5147649
    Sleep    5s

Paso 1057
    Set Location    -33.4904069    -70.5151905
    Sleep    5s

Paso 1058
    Set Location    -33.4902062    -70.5156143
    Sleep    5s

Paso 1059
    Set Location    -33.49014    -70.5158463
    Sleep    5s

Paso 1060
    Set Location    -33.4898365    -70.5160491
    Sleep    5s

Paso 1061
    Set Location    -33.4893748    -70.5161136
    Sleep    5s

Paso 1062
    Set Location    -33.489051    -70.5161882
    Sleep    5s

Paso 1063
    Set Location    -33.4889704    -70.5166358
    Sleep    5s

Paso 1064
    Set Location    -33.4890926    -70.5172101
    Sleep    5s

Paso 1065
    Set Location    -33.489076    -70.518504
    Sleep    5s

Paso 1066
    Set Location    -33.4888665    -70.5187634
    Sleep    5s

Paso 1067
    Set Location    -33.4878255    -70.5192754
    Sleep    5s

Paso 1068
    Set Location    -33.4867984    -70.5186942
    Sleep    5s

Paso 1069
    Set Location    -33.4865559    -70.5185973
    Sleep    5s

Paso 1070
    Set Location    -33.4864306    -70.5186303
    Sleep    5s

Paso 1071
    Set Location    -33.4863235    -70.5186147
    Sleep    5s

Paso 1072
    Set Location    -33.4863266    -70.5186182
    Sleep    5s

Paso 1073
    Set Location    -33.4863267    -70.5186183
    Sleep    5s

Paso 1074
    Set Location    -33.4863267    -70.5186183
    Sleep    5s

Paso 1075
    Set Location    -33.4871181    -70.5192419
    Sleep    5s

Paso 1076
    Set Location    -33.4874578    -70.5194164
    Sleep    5s

Paso 1077
    Set Location    -33.4878716    -70.5194312
    Sleep    5s

Paso 1078
    Set Location    -33.4880655    -70.5193266
    Sleep    5s

Paso 1079
    Set Location    -33.4883772    -70.5191981
    Sleep    5s

Paso 1080
    Set Location    -33.4887533    -70.5189191
    Sleep    5s

Paso 1081
    Set Location    -33.489014    -70.5187388
    Sleep    5s

Paso 1082
    Set Location    -33.4891304    -70.5186647
    Sleep    5s

Paso 1083
    Set Location    -33.4891175    -70.5183758
    Sleep    5s

Paso 1084
    Set Location    -33.4891329    -70.5180935
    Sleep    5s

Paso 1085
    Set Location    -33.4892507    -70.5177271
    Sleep    5s

Paso 1086
    Set Location    -33.4891691    -70.5173075
    Sleep    5s

Paso 1087
    Set Location    -33.4890573    -70.5169177
    Sleep    5s

Paso 1088
    Set Location    -33.4890228    -70.5165543
    Sleep    5s

Paso 1089
    Set Location    -33.4890889    -70.5162646
    Sleep    5s

Paso 1090
    Set Location    -33.4893646    -70.5161969
    Sleep    5s

Paso 1091
    Set Location    -33.4897449    -70.5161324
    Sleep    5s

Paso 1092
    Set Location    -33.4899199    -70.5161781
    Sleep    5s

Paso 1093
    Set Location    -33.4900834    -70.5161728
    Sleep    5s

Paso 1094
    Set Location    -33.4902738    -70.5158528
    Sleep    5s

Paso 1095
    Set Location    -33.4904284    -70.5155039
    Sleep    5s

Paso 1096
    Set Location    -33.4905725    -70.5151929
    Sleep    5s

Paso 1097
    Set Location    -33.490695    -70.5148708
    Sleep    5s

Paso 1098
    Set Location    -33.4907755    -70.5146016
    Sleep    5s

Paso 1099
    Set Location    -33.4907568    -70.5145696
    Sleep    5s

Paso 1100
    Set Location    -33.4907567    -70.5145764
    Sleep    5s

Paso 1101
    Set Location    -33.4907567    -70.5145767
    Sleep    5s

Paso 1102
    Set Location    -33.4907567    -70.5145767
    Sleep    5s

Paso 1103
    Set Location    -33.4907679    -70.5139764
    Sleep    5s

Paso 1104
    Set Location    -33.490888    -70.5137928
    Sleep    5s

Paso 1105
    Set Location    -33.4911087    -70.5136585
    Sleep    5s

Paso 1106
    Set Location    -33.4914369    -70.5134719
    Sleep    5s

Paso 1107
    Set Location    -33.49183    -70.5134607
    Sleep    5s

Paso 1108
    Set Location    -33.4921773    -70.5136193
    Sleep    5s

Paso 1109
    Set Location    -33.4923796    -70.513502
    Sleep    5s

Paso 1110
    Set Location    -33.4924958    -70.5133538
    Sleep    5s

Paso 1111
    Set Location    -33.4926063    -70.5131667
    Sleep    5s

Paso 1112
    Set Location    -33.4931311    -70.5127293
    Sleep    5s

Paso 1113
    Set Location    -33.4933597    -70.512507
    Sleep    5s

Paso 1114
    Set Location    -33.4934597    -70.5124104
    Sleep    5s

Paso 1115
    Set Location    -33.4934536    -70.5124148
    Sleep    5s

Paso 1116
    Set Location    -33.4934533    -70.512415
    Sleep    5s

Paso 1117
    Set Location    -33.4934533    -70.512415
    Sleep    5s

Paso 1118
    Set Location    -33.4935045    -70.512375
    Sleep    5s

Paso 1119
    Set Location    -33.4936398    -70.5122611
    Sleep    5s

Paso 1120
    Set Location    -33.4937795    -70.5120908
    Sleep    5s

Paso 1121
    Set Location    -33.4939402    -70.5118437
    Sleep    5s

Paso 1122
    Set Location    -33.4939575    -70.5117281
    Sleep    5s

Paso 1123
    Set Location    -33.4939439    -70.5117828
    Sleep    5s

Paso 1124
    Set Location    -33.4939457    -70.5118516
    Sleep    5s

Paso 1125
    Set Location    -33.4938795    -70.5118757
    Sleep    5s

Paso 1126
    Set Location    -33.4937163    -70.5120792
    Sleep    5s

Paso 1127
    Set Location    -33.4935516    -70.5122821
    Sleep    5s

Paso 1128
    Set Location    -33.4934659    -70.5123502
    Sleep    5s

Paso 1129
    Set Location    -33.4934682    -70.51235
    Sleep    5s

Paso 1130
    Set Location    -33.4934683    -70.51235
    Sleep    5s

Paso 1131
    Set Location    -33.4934683    -70.51235
    Sleep    5s

Paso 1132
    Set Location    -33.4934555    -70.5124219
    Sleep    5s

Paso 1133
    Set Location    -33.4931721    -70.5126343
    Sleep    5s

Paso 1134
    Set Location    -33.4928019    -70.5129303
    Sleep    5s

Paso 1135
    Set Location    -33.492457    -70.5133186
    Sleep    5s

Paso 1136
    Set Location    -33.4920667    -70.5135802
    Sleep    5s

Paso 1137
    Set Location    -33.4916801    -70.5133597
    Sleep    5s

Paso 1138
    Set Location    -33.4912676    -70.5134958
    Sleep    5s

Paso 1139
    Set Location    -33.4905639    -70.5145945
    Sleep    5s

Paso 1140
    Set Location    -33.4905601    -70.5146144
    Sleep    5s

Paso 1141
    Set Location    -33.4905616    -70.5146102
    Sleep    5s

Paso 1142
    Set Location    -33.4905617    -70.51461
    Sleep    5s

Paso 1143
    Set Location    -33.4905617    -70.51461
    Sleep    5s

Paso 1144
    Set Location    -33.4905601    -70.5146836
    Sleep    5s

Paso 1145
    Set Location    -33.4904733    -70.5150482
    Sleep    5s

Paso 1146
    Set Location    -33.4902494    -70.5154733
    Sleep    5s

Paso 1147
    Set Location    -33.4901976    -70.5157238
    Sleep    5s

Paso 1148
    Set Location    -33.4900311    -70.5159843
    Sleep    5s

Paso 1149
    Set Location    -33.4896064    -70.5160851
    Sleep    5s

Paso 1150
    Set Location    -33.4891778    -70.5161139
    Sleep    5s

Paso 1151
    Set Location    -33.4890139    -70.516343
    Sleep    5s

Paso 1152
    Set Location    -33.4890011    -70.516857
    Sleep    5s

Paso 1153
    Set Location    -33.4891444    -70.5173949
    Sleep    5s

Paso 1154
    Set Location    -33.4890671    -70.5185469
    Sleep    5s

Paso 1155
    Set Location    -33.4877858    -70.519231
    Sleep    5s

Paso 1156
    Set Location    -33.4865024    -70.518608
    Sleep    5s

Paso 1157
    Set Location    -33.4863578    -70.5186204
    Sleep    5s

Paso 1158
    Set Location    -33.4863466    -70.5186372
    Sleep    5s

Paso 1159
    Set Location    -33.4863499    -70.5186367
    Sleep    5s

Paso 1160
    Set Location    -33.48635    -70.5186367
    Sleep    5s

Paso 1161
    Set Location    -33.48635    -70.5186367
    Sleep    5s

Paso 1162
    Set Location    -33.4863115    -70.5186814
    Sleep    5s

Paso 1163
    Set Location    -33.4863518    -70.5188113
    Sleep    5s

Paso 1164
    Set Location    -33.486505    -70.5188676
    Sleep    5s

Paso 1165
    Set Location    -33.4867524    -70.5190338
    Sleep    5s

Paso 1166
    Set Location    -33.488475    -70.5191621
    Sleep    5s

Paso 1167
    Set Location    -33.48875    -70.5189219
    Sleep    5s

Paso 1168
    Set Location    -33.4891309    -70.5186362
    Sleep    5s

Paso 1169
    Set Location    -33.4891285    -70.5183819
    Sleep    5s

Paso 1170
    Set Location    -33.4891327    -70.5181271
    Sleep    5s

Paso 1171
    Set Location    -33.4892411    -70.5177648
    Sleep    5s

Paso 1172
    Set Location    -33.4891724    -70.5173677
    Sleep    5s

Paso 1173
    Set Location    -33.489055    -70.5169536
    Sleep    5s

Paso 1174
    Set Location    -33.4890273    -70.5165545
    Sleep    5s

Paso 1175
    Set Location    -33.4891039    -70.5162539
    Sleep    5s

Paso 1176
    Set Location    -33.489407    -70.5161829
    Sleep    5s

Paso 1177
    Set Location    -33.4898466    -70.5161521
    Sleep    5s

Paso 1178
    Set Location    -33.4903863    -70.5156236
    Sleep    5s

Paso 1179
    Set Location    -33.4905189    -70.5152998
    Sleep    5s

Paso 1180
    Set Location    -33.4906497    -70.5149983
    Sleep    5s

Paso 1181
    Set Location    -33.4907752    -70.5147003
    Sleep    5s

Paso 1182
    Set Location    -33.4907646    -70.5145735
    Sleep    5s

Paso 1183
    Set Location    -33.4907602    -70.5145797
    Sleep    5s

Paso 1184
    Set Location    -33.49076    -70.51458
    Sleep    5s

Paso 1185
    Set Location    -33.49076    -70.51458
    Sleep    5s

Paso 1186
    Set Location    -33.4907312    -70.5145448
    Sleep    5s

Paso 1187
    Set Location    -33.4906888    -70.5143247
    Sleep    5s

Paso 1188
    Set Location    -33.4907405    -70.5141082
    Sleep    5s

Paso 1189
    Set Location    -33.4908188    -70.513893
    Sleep    5s

Paso 1190
    Set Location    -33.4909792    -70.5137091
    Sleep    5s

Paso 1191
    Set Location    -33.4912937    -70.5135677
    Sleep    5s

Paso 1192
    Set Location    -33.4916729    -70.5133798
    Sleep    5s

Paso 1193
    Set Location    -33.4920535    -70.5135449
    Sleep    5s

Paso 1194
    Set Location    -33.4923305    -70.5135579
    Sleep    5s

Paso 1195
    Set Location    -33.4924643    -70.5134244
    Sleep    5s

Paso 1196
    Set Location    -33.4925836    -70.5132214
    Sleep    5s

Paso 1197
    Set Location    -33.4933687    -70.5125166
    Sleep    5s

Paso 1198
    Set Location    -33.4936317    -70.5122607
    Sleep    5s

Paso 1199
    Set Location    -33.4938539    -70.5119726
    Sleep    5s

Paso 1200
    Set Location    -33.4939735    -70.5117598
    Sleep    5s

Paso 1201
    Set Location    -33.4939584    -70.5117231
    Sleep    5s

Paso 1202
    Set Location    -33.4939455    -70.5118193
    Sleep    5s

Paso 1203
    Set Location    -33.493949    -70.5118377
    Sleep    5s

Paso 1204
    Set Location    -33.4937949    -70.5119936
    Sleep    5s

Paso 1205
    Set Location    -33.4934697    -70.5123651
    Sleep    5s

Paso 1206
    Set Location    -33.49347    -70.512365
    Sleep    5s

Paso 1207
    Set Location    -33.49347    -70.512365
    Sleep    5s

Paso 1208
    Set Location    -33.4933836    -70.5124482
    Sleep    5s

Paso 1209
    Set Location    -33.4931927    -70.5126309
    Sleep    5s

Paso 1210
    Set Location    -33.4928614    -70.5128843
    Sleep    5s

Paso 1211
    Set Location    -33.4925447    -70.5131869
    Sleep    5s

Paso 1212
    Set Location    -33.49225    -70.5135417
    Sleep    5s

Paso 1213
    Set Location    -33.4918356    -70.51345
    Sleep    5s

Paso 1214
    Set Location    -33.491443    -70.5133764
    Sleep    5s

Paso 1215
    Set Location    -33.4910141    -70.5136122
    Sleep    5s

Paso 1216
    Set Location    -33.4907263    -70.5139363
    Sleep    5s

Paso 1217
    Set Location    -33.490672    -70.5142163
    Sleep    5s

Paso 1218
    Set Location    -33.4906462    -70.5144843
    Sleep    5s

Paso 1219
    Set Location    -33.4905683    -70.5146067
    Sleep    5s

Paso 1220
    Set Location    -33.4905683    -70.5146067
    Sleep    5s

Paso 1221
    Set Location    -33.4905699    -70.5146707
    Sleep    5s

Paso 1222
    Set Location    -33.4901925    -70.515703
    Sleep    5s

Paso 1223
    Set Location    -33.4900361    -70.5159572
    Sleep    5s

Paso 1224
    Set Location    -33.4896258    -70.5160803
    Sleep    5s

Paso 1225
    Set Location    -33.4892034    -70.5161123
    Sleep    5s

Paso 1226
    Set Location    -33.4890081    -70.5162951
    Sleep    5s

Paso 1227
    Set Location    -33.4889623    -70.5167619
    Sleep    5s

Paso 1228
    Set Location    -33.4891329    -70.5173098
    Sleep    5s

Paso 1229
    Set Location    -33.4891856    -70.5178786
    Sleep    5s

Paso 1230
    Set Location    -33.4890809    -70.5183092
    Sleep    5s

Paso 1231
    Set Location    -33.4890845    -70.5185436
    Sleep    5s

Paso 1232
    Set Location    -33.4890199    -70.5186004
    Sleep    5s

Paso 1233
    Set Location    -33.4888533    -70.5187615
    Sleep    5s

Paso 1234
    Set Location    -33.4886043    -70.5189876
    Sleep    5s

Paso 1235
    Set Location    -33.4882604    -70.51922
    Sleep    5s

Paso 1236
    Set Location    -33.4878495    -70.5192485
    Sleep    5s

Paso 1237
    Set Location    -33.4874922    -70.5190626
    Sleep    5s

Paso 1238
    Set Location    -33.4872039    -70.5188981
    Sleep    5s

Paso 1239
    Set Location    -33.486982    -70.5187756
    Sleep    5s

Paso 1240
    Set Location    -33.4867881    -70.51866
    Sleep    5s

Paso 1241
    Set Location    -33.4865929    -70.5185757
    Sleep    5s

Paso 1242
    Set Location    -33.4864597    -70.5186101
    Sleep    5s

Paso 1243
    Set Location    -33.4863536    -70.5186224
    Sleep    5s

Paso 1244
    Set Location    -33.4863549    -70.5186265
    Sleep    5s

Paso 1245
    Set Location    -33.486355    -70.5186267
    Sleep    5s

Paso 1246
    Set Location    -33.486355    -70.5186267
    Sleep    5s

Paso 1247
    Set Location    -33.4863022    -70.5186762
    Sleep    5s

Paso 1248
    Set Location    -33.4863749    -70.518817
    Sleep    5s

Paso 1249
    Set Location    -33.486598    -70.5189394
    Sleep    5s

Paso 1250
    Set Location    -33.4868907    -70.5191202
    Sleep    5s

Paso 1251
    Set Location    -33.487192    -70.5192869
    Sleep    5s

Paso 1252
    Set Location    -33.4874873    -70.5194207
    Sleep    5s

Paso 1253
    Set Location    -33.4878727    -70.5194257
    Sleep    5s

Paso 1254
    Set Location    -33.4881123    -70.5193041
    Sleep    5s

Paso 1255
    Set Location    -33.4884525    -70.5191744
    Sleep    5s

Paso 1256
    Set Location    -33.488775    -70.5189172
    Sleep    5s

Paso 1257
    Set Location    -33.4889991    -70.5187489
    Sleep    5s

Paso 1258
    Set Location    -33.4891267    -70.518624
    Sleep    5s

Paso 1259
    Set Location    -33.4891055    -70.518357
    Sleep    5s

Paso 1260
    Set Location    -33.4891158    -70.5181035
    Sleep    5s

Paso 1261
    Set Location    -33.4892475    -70.5177736
    Sleep    5s

Paso 1262
    Set Location    -33.4892024    -70.5174214
    Sleep    5s

Paso 1263
    Set Location    -33.4891076    -70.5170904
    Sleep    5s

Paso 1264
    Set Location    -33.4890156    -70.5166991
    Sleep    5s

Paso 1265
    Set Location    -33.4890567    -70.5163553
    Sleep    5s

Paso 1266
    Set Location    -33.4892545    -70.5162027
    Sleep    5s

Paso 1267
    Set Location    -33.4897112    -70.5161096
    Sleep    5s

Paso 1268
    Set Location    -33.4899267    -70.5161676
    Sleep    5s

Paso 1269
    Set Location    -33.4900558    -70.5161854
    Sleep    5s

Paso 1270
    Set Location    -33.4902462    -70.5159018
    Sleep    5s

Paso 1271
    Set Location    -33.4904187    -70.5155567
    Sleep    5s

Paso 1272
    Set Location    -33.490558    -70.515251
    Sleep    5s

Paso 1273
    Set Location    -33.490682    -70.5149682
    Sleep    5s

Paso 1274
    Set Location    -33.4907892    -70.5146657
    Sleep    5s

Paso 1275
    Set Location    -33.4907717    -70.5145844
    Sleep    5s

Paso 1276
    Set Location    -33.4907701    -70.5145914
    Sleep    5s

Paso 1277
    Set Location    -33.49077    -70.5145917
    Sleep    5s

Paso 1278
    Set Location    -33.49077    -70.5145917
    Sleep    5s

Paso 1279
    Set Location    -33.4907173    -70.5145037
    Sleep    5s

Paso 1280
    Set Location    -33.4906977    -70.5143011
    Sleep    5s

Paso 1281
    Set Location    -33.4907339    -70.5141388
    Sleep    5s

Paso 1282
    Set Location    -33.4907677    -70.5140264
    Sleep    5s

Paso 1283
    Set Location    -33.4908374    -70.513872
    Sleep    5s

Paso 1284
    Set Location    -33.4909518    -70.5137412
    Sleep    5s

Paso 1285
    Set Location    -33.4911271    -70.5136584
    Sleep    5s

Paso 1286
    Set Location    -33.4914416    -70.5134662
    Sleep    5s

Paso 1287
    Set Location    -33.4918183    -70.5134403
    Sleep    5s

Paso 1288
    Set Location    -33.4921556    -70.5136113
    Sleep    5s

Paso 1289
    Set Location    -33.4923683    -70.513514
    Sleep    5s

Paso 1290
    Set Location    -33.492507    -70.5133758
    Sleep    5s

Paso 1291
    Set Location    -33.4929479    -70.5128813
    Sleep    5s

Paso 1292
    Set Location    -33.4931433    -70.5127189
    Sleep    5s

Paso 1293
    Set Location    -33.4933557    -70.5125298
    Sleep    5s

Paso 1294
    Set Location    -33.4936224    -70.5122868
    Sleep    5s

Paso 1295
    Set Location    -33.4938363    -70.5119887
    Sleep    5s

Paso 1296
    Set Location    -33.4939696    -70.511751
    Sleep    5s

Paso 1297
    Set Location    -33.4939568    -70.5117282
    Sleep    5s

Paso 1298
    Set Location    -33.4939503    -70.5118243
    Sleep    5s

Paso 1299
    Set Location    -33.49395    -70.511833
    Sleep    5s

Paso 1300
    Set Location    -33.4937822    -70.5120002
    Sleep    5s

Paso 1301
    Set Location    -33.4936534    -70.512185
    Sleep    5s

Paso 1302
    Set Location    -33.4935015    -70.5123207
    Sleep    5s

Paso 1303
    Set Location    -33.4934545    -70.5123536
    Sleep    5s

Paso 1304
    Set Location    -33.4934581    -70.5123518
    Sleep    5s

Paso 1305
    Set Location    -33.4934583    -70.5123517
    Sleep    5s

Paso 1306
    Set Location    -33.4934583    -70.5123517
    Sleep    5s

Paso 1307
    Set Location    -33.4934103    -70.512398
    Sleep    5s

Paso 1308
    Set Location    -33.4932746    -70.5125307
    Sleep    5s

Paso 1309
    Set Location    -33.4929978    -70.5127629
    Sleep    5s

Paso 1310
    Set Location    -33.4926741    -70.5130135
    Sleep    5s

Paso 1311
    Set Location    -33.4924311    -70.5133625
    Sleep    5s

Paso 1312
    Set Location    -33.4920941    -70.5135818
    Sleep    5s

Paso 1313
    Set Location    -33.4917516    -70.5133933
    Sleep    5s

Paso 1314
    Set Location    -33.491342    -70.5134488
    Sleep    5s

Paso 1315
    Set Location    -33.4909581    -70.5136918
    Sleep    5s

Paso 1316
    Set Location    -33.4906633    -70.51436
    Sleep    5s

Paso 1317
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 1318
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 1319
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 1320
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 1321
    Set Location    -33.4891067    -70.5161187
    Sleep    5s

Paso 1322
    Set Location    -33.4891954    -70.5178231
    Sleep    5s

Paso 1323
    Set Location    -33.4890991    -70.5181296
    Sleep    5s

Paso 1324
    Set Location    -33.4890877    -70.5184247
    Sleep    5s

Paso 1325
    Set Location    -33.4890599    -70.5185628
    Sleep    5s

Paso 1326
    Set Location    -33.488964    -70.5186594
    Sleep    5s

Paso 1327
    Set Location    -33.4887515    -70.5188396
    Sleep    5s

Paso 1328
    Set Location    -33.4884853    -70.5190959
    Sleep    5s

Paso 1329
    Set Location    -33.4881533    -70.5192644
    Sleep    5s

Paso 1330
    Set Location    -33.4878134    -70.519235
    Sleep    5s

Paso 1331
    Set Location    -33.4875156    -70.5190898
    Sleep    5s

Paso 1332
    Set Location    -33.487261    -70.5189373
    Sleep    5s

Paso 1333
    Set Location    -33.4870178    -70.5188035
    Sleep    5s

Paso 1334
    Set Location    -33.4868027    -70.5186668
    Sleep    5s

Paso 1335
    Set Location    -33.4867059    -70.5186123
    Sleep    5s

Paso 1336
    Set Location    -33.4866297    -70.5185915
    Sleep    5s

Paso 1337
    Set Location    -33.4864868    -70.5186067
    Sleep    5s

Paso 1338
    Set Location    -33.48636    -70.5185964
    Sleep    5s

Paso 1339
    Set Location    -33.486336    -70.5186202
    Sleep    5s

Paso 1340
    Set Location    -33.4863382    -70.51862
    Sleep    5s

Paso 1341
    Set Location    -33.4863383    -70.51862
    Sleep    5s

Paso 1342
    Set Location    -33.4863383    -70.51862
    Sleep    5s

Paso 1343
    Set Location    -33.486308    -70.5186792
    Sleep    5s

Paso 1344
    Set Location    -33.4864202    -70.5188251
    Sleep    5s

Paso 1345
    Set Location    -33.4866842    -70.518975
    Sleep    5s

Paso 1346
    Set Location    -33.4869776    -70.5191529
    Sleep    5s

Paso 1347
    Set Location    -33.4873039    -70.519346
    Sleep    5s

Paso 1348
    Set Location    -33.4881875    -70.5192774
    Sleep    5s

Paso 1349
    Set Location    -33.4892215    -70.5174734
    Sleep    5s

Paso 1350
    Set Location    -33.4891225    -70.5171141
    Sleep    5s

Paso 1351
    Set Location    -33.4891584    -70.5162115
    Sleep    5s

Paso 1352
    Set Location    -33.4895008    -70.5161532
    Sleep    5s

Paso 1353
    Set Location    -33.4898481    -70.5161466
    Sleep    5s

Paso 1354
    Set Location    -33.4900163    -70.516207
    Sleep    5s

Paso 1355
    Set Location    -33.490188    -70.5160212
    Sleep    5s

Paso 1356
    Set Location    -33.4903571    -70.5156689
    Sleep    5s

Paso 1357
    Set Location    -33.490479    -70.5153637
    Sleep    5s

Paso 1358
    Set Location    -33.4906048    -70.5150795
    Sleep    5s

Paso 1359
    Set Location    -33.4907342    -70.5147898
    Sleep    5s

Paso 1360
    Set Location    -33.4907758    -70.5145952
    Sleep    5s

Paso 1361
    Set Location    -33.490774    -70.5145858
    Sleep    5s

Paso 1362
    Set Location    -33.490775    -70.5145882
    Sleep    5s

Paso 1363
    Set Location    -33.490775    -70.5145883
    Sleep    5s

Paso 1364
    Set Location    -33.490775    -70.5145883
    Sleep    5s

Paso 1365
    Set Location    -33.490711    -70.514422
    Sleep    5s

Paso 1366
    Set Location    -33.4907244    -70.5142114
    Sleep    5s

Paso 1367
    Set Location    -33.4907809    -70.5140176
    Sleep    5s

Paso 1368
    Set Location    -33.4908458    -70.513851
    Sleep    5s

Paso 1369
    Set Location    -33.4909556    -70.5137305
    Sleep    5s

Paso 1370
    Set Location    -33.4912331    -70.5136179
    Sleep    5s

Paso 1371
    Set Location    -33.4915653    -70.5134023
    Sleep    5s

Paso 1372
    Set Location    -33.4924044    -70.5135018
    Sleep    5s

Paso 1373
    Set Location    -33.492531    -70.5133249
    Sleep    5s

Paso 1374
    Set Location    -33.4926316    -70.5131232
    Sleep    5s

Paso 1375
    Set Location    -33.492792    -70.5129887
    Sleep    5s

Paso 1376
    Set Location    -33.4929843    -70.5128587
    Sleep    5s

Paso 1377
    Set Location    -33.4931847    -70.5126472
    Sleep    5s

Paso 1378
    Set Location    -33.493862    -70.5119655
    Sleep    5s

Paso 1379
    Set Location    -33.4939598    -70.5117608
    Sleep    5s

Paso 1380
    Set Location    -33.4939495    -70.5117283
    Sleep    5s

Paso 1381
    Set Location    -33.4939404    -70.5118115
    Sleep    5s

Paso 1382
    Set Location    -33.4939482    -70.5118354
    Sleep    5s

Paso 1383
    Set Location    -33.4938061    -70.5119694
    Sleep    5s

Paso 1384
    Set Location    -33.4935885    -70.5122275
    Sleep    5s

Paso 1385
    Set Location    -33.4934634    -70.5123575
    Sleep    5s

Paso 1386
    Set Location    -33.4934712    -70.5123518
    Sleep    5s

Paso 1387
    Set Location    -33.4934732    -70.5123501
    Sleep    5s

Paso 1388
    Set Location    -33.4934733    -70.51235
    Sleep    5s

Paso 1389
    Set Location    -33.4934733    -70.51235
    Sleep    5s

Paso 1390
    Set Location    -33.4934174    -70.5123819
    Sleep    5s

Paso 1391
    Set Location    -33.4933515    -70.5124423
    Sleep    5s

Paso 1392
    Set Location    -33.4931149    -70.5126592
    Sleep    5s

Paso 1393
    Set Location    -33.4927555    -70.5129471
    Sleep    5s

Paso 1394
    Set Location    -33.4924638    -70.5133308
    Sleep    5s

Paso 1395
    Set Location    -33.4921139    -70.5135809
    Sleep    5s

Paso 1396
    Set Location    -33.4917451    -70.5133735
    Sleep    5s

Paso 1397
    Set Location    -33.4913403    -70.5134294
    Sleep    5s

Paso 1398
    Set Location    -33.4909419    -70.513654
    Sleep    5s

Paso 1399
    Set Location    -33.4905731    -70.5145978
    Sleep    5s

Paso 1400
    Set Location    -33.4905733    -70.5145983
    Sleep    5s

Paso 1401
    Set Location    -33.4905733    -70.5145983
    Sleep    5s

Paso 1402
    Set Location    -33.4905445    -70.5147615
    Sleep    5s

Paso 1403
    Set Location    -33.4904551    -70.5150698
    Sleep    5s

Paso 1404
    Set Location    -33.4900472    -70.5159653
    Sleep    5s

Paso 1405
    Set Location    -33.4889894    -70.5168576
    Sleep    5s

Paso 1406
    Set Location    -33.4890125    -70.5186425
    Sleep    5s

Paso 1407
    Set Location    -33.4887328    -70.5188759
    Sleep    5s

Paso 1408
    Set Location    -33.4884101    -70.5191553
    Sleep    5s

Paso 1409
    Set Location    -33.4880243    -70.5192778
    Sleep    5s

Paso 1410
    Set Location    -33.4876317    -70.5191329
    Sleep    5s

Paso 1411
    Set Location    -33.4872609    -70.5189337
    Sleep    5s

Paso 1412
    Set Location    -33.4868995    -70.5187142
    Sleep    5s

Paso 1413
    Set Location    -33.4863454    -70.5186042
    Sleep    5s

Paso 1414
    Set Location    -33.4863483    -70.5186033
    Sleep    5s

Paso 1415
    Set Location    -33.4863483    -70.5186033
    Sleep    5s

Paso 1416
    Set Location    -33.4870395    -70.5191786
    Sleep    5s

Paso 1417
    Set Location    -33.487401    -70.5193732
    Sleep    5s

Paso 1418
    Set Location    -33.487804    -70.5194556
    Sleep    5s

Paso 1419
    Set Location    -33.4880664    -70.5193353
    Sleep    5s

Paso 1420
    Set Location    -33.4883352    -70.5192206
    Sleep    5s

Paso 1421
    Set Location    -33.4886578    -70.5190294
    Sleep    5s

Paso 1422
    Set Location    -33.4889391    -70.5187667
    Sleep    5s

Paso 1423
    Set Location    -33.4891034    -70.5186901
    Sleep    5s

Paso 1424
    Set Location    -33.4891363    -70.5184052
    Sleep    5s

Paso 1425
    Set Location    -33.4891322    -70.5170895
    Sleep    5s

Paso 1426
    Set Location    -33.4890361    -70.5167593
    Sleep    5s

Paso 1427
    Set Location    -33.4890536    -70.5164098
    Sleep    5s

Paso 1428
    Set Location    -33.4891795    -70.5162149
    Sleep    5s

Paso 1429
    Set Location    -33.4895506    -70.5161539
    Sleep    5s

Paso 1430
    Set Location    -33.4899095    -70.5161585
    Sleep    5s

Paso 1431
    Set Location    -33.4900841    -70.5161864
    Sleep    5s

Paso 1432
    Set Location    -33.4902491    -70.515905
    Sleep    5s

Paso 1433
    Set Location    -33.490416    -70.5155275
    Sleep    5s

Paso 1434
    Set Location    -33.490563    -70.5152186
    Sleep    5s

Paso 1435
    Set Location    -33.4906744    -70.5149003
    Sleep    5s

Paso 1436
    Set Location    -33.4907167    -70.5145195
    Sleep    5s

Paso 1437
    Set Location    -33.4908472    -70.5138309
    Sleep    5s

Paso 1438
    Set Location    -33.4911141    -70.5136444
    Sleep    5s

Paso 1439
    Set Location    -33.4918487    -70.5134412
    Sleep    5s

Paso 1440
    Set Location    -33.4921947    -70.5136086
    Sleep    5s

Paso 1441
    Set Location    -33.492643    -70.5131271
    Sleep    5s

Paso 1442
    Set Location    -33.4934823    -70.5124145
    Sleep    5s

Paso 1443
    Set Location    -33.4936857    -70.5122
    Sleep    5s

Paso 1444
    Set Location    -33.4938494    -70.5119701
    Sleep    5s

Paso 1445
    Set Location    -33.4939662    -70.5117582
    Sleep    5s

Paso 1446
    Set Location    -33.4939642    -70.5117162
    Sleep    5s

Paso 1447
    Set Location    -33.4939602    -70.5118142
    Sleep    5s

Paso 1448
    Set Location    -33.4934999    -70.5123113
    Sleep    5s

Paso 1449
    Set Location    -33.4934638    -70.5123365
    Sleep    5s

Paso 1450
    Set Location    -33.4934666    -70.5123334
    Sleep    5s

Paso 1451
    Set Location    -33.4934667    -70.5123333
    Sleep    5s

Paso 1452
    Set Location    -33.4934667    -70.5123333
    Sleep    5s

Paso 1453
    Set Location    -33.4933914    -70.5124181
    Sleep    5s

Paso 1454
    Set Location    -33.4932766    -70.5125223
    Sleep    5s

Paso 1455
    Set Location    -33.4923172    -70.5134913
    Sleep    5s

Paso 1456
    Set Location    -33.491905    -70.513495
    Sleep    5s

Paso 1457
    Set Location    -33.4915243    -70.5133332
    Sleep    5s

Paso 1458
    Set Location    -33.4911033    -70.5135818
    Sleep    5s

Paso 1459
    Set Location    -33.4906902    -70.5146421
    Sleep    5s

Paso 1460
    Set Location    -33.4893727    -70.5161133
    Sleep    5s

Paso 1461
    Set Location    -33.4889989    -70.5165289
    Sleep    5s

Paso 1462
    Set Location    -33.4890405    -70.5169758
    Sleep    5s

Paso 1463
    Set Location    -33.4890968    -70.5180868
    Sleep    5s

Paso 1464
    Set Location    -33.4890886    -70.5182019
    Sleep    5s

Paso 1465
    Set Location    -33.4890868    -70.518509
    Sleep    5s

Paso 1466
    Set Location    -33.488867    -70.518758
    Sleep    5s

Paso 1467
    Set Location    -33.4885498    -70.5190505
    Sleep    5s

Paso 1468
    Set Location    -33.4881803    -70.5192292
    Sleep    5s

Paso 1469
    Set Location    -33.487834    -70.5192422
    Sleep    5s

Paso 1470
    Set Location    -33.4874642    -70.5190376
    Sleep    5s

Paso 1471
    Set Location    -33.487122    -70.5188499
    Sleep    5s

Paso 1472
    Set Location    -33.4868175    -70.51866
    Sleep    5s

Paso 1473
    Set Location    -33.4865776    -70.5185777
    Sleep    5s

Paso 1474
    Set Location    -33.4864463    -70.5186032
    Sleep    5s

Paso 1475
    Set Location    -33.4863509    -70.5186098
    Sleep    5s

Paso 1476
    Set Location    -33.4863517    -70.5186116
    Sleep    5s

Paso 1477
    Set Location    -33.4864888    -70.5188756
    Sleep    5s

Paso 1478
    Set Location    -33.4872148    -70.5192889
    Sleep    5s

Paso 1479
    Set Location    -33.4872469    -70.5192979
    Sleep    5s

Paso 1480
    Set Location    -33.4873097    -70.5193337
    Sleep    5s

Paso 1481
    Set Location    -33.4874316    -70.5194052
    Sleep    5s

Paso 1482
    Set Location    -33.4876961    -70.5194544
    Sleep    5s

Paso 1483
    Set Location    -33.487787    -70.5194504
    Sleep    5s

Paso 1484
    Set Location    -33.4877819    -70.51945
    Sleep    5s

Paso 1485
    Set Location    -33.4879049    -70.5194181
    Sleep    5s

Paso 1486
    Set Location    -33.4880457    -70.5193342
    Sleep    5s

Paso 1487
    Set Location    -33.4882798    -70.5192408
    Sleep    5s

Paso 1488
    Set Location    -33.488586    -70.5190922
    Sleep    5s

Paso 1489
    Set Location    -33.4891471    -70.5186509
    Sleep    5s

Paso 1490
    Set Location    -33.4891443    -70.5183761
    Sleep    5s

Paso 1491
    Set Location    -33.489136    -70.518119
    Sleep    5s

Paso 1492
    Set Location    -33.489225    -70.5178586
    Sleep    5s

Paso 1493
    Set Location    -33.4892536    -70.5175524
    Sleep    5s

Paso 1494
    Set Location    -33.4891731    -70.5172657
    Sleep    5s

Paso 1495
    Set Location    -33.4890994    -70.516962
    Sleep    5s

Paso 1496
    Set Location    -33.4890303    -70.5166814
    Sleep    5s

Paso 1497
    Set Location    -33.4890599    -70.516385
    Sleep    5s

Paso 1498
    Set Location    -33.4891524    -70.5162197
    Sleep    5s

Paso 1499
    Set Location    -33.4894497    -70.5161634
    Sleep    5s

Paso 1500
    Set Location    -33.4898214    -70.5161267
    Sleep    5s

Paso 1501
    Set Location    -33.4899145    -70.516158
    Sleep    5s

Paso 1502
    Set Location    -33.489907    -70.5161568
    Sleep    5s

Paso 1503
    Set Location    -33.4901164    -70.5161599
    Sleep    5s

Paso 1504
    Set Location    -33.4903114    -70.5158313
    Sleep    5s

Paso 1505
    Set Location    -33.4904473    -70.5154799
    Sleep    5s

Paso 1506
    Set Location    -33.4905975    -70.5151743
    Sleep    5s

Paso 1507
    Set Location    -33.4907031    -70.5148397
    Sleep    5s

Paso 1508
    Set Location    -33.4907235    -70.5144897
    Sleep    5s

Paso 1509
    Set Location    -33.4907433    -70.5141493
    Sleep    5s

Paso 1510
    Set Location    -33.4908326    -70.5138509
    Sleep    5s

Paso 1511
    Set Location    -33.4910827    -70.5136585
    Sleep    5s

Paso 1512
    Set Location    -33.4914392    -70.5134567
    Sleep    5s

Paso 1513
    Set Location    -33.4918465    -70.5134482
    Sleep    5s

Paso 1514
    Set Location    -33.4922244    -70.5135947
    Sleep    5s

Paso 1515
    Set Location    -33.4924202    -70.5134816
    Sleep    5s

Paso 1516
    Set Location    -33.4925345    -70.5133162
    Sleep    5s

Paso 1517
    Set Location    -33.4926416    -70.5131233
    Sleep    5s

Paso 1518
    Set Location    -33.4927991    -70.5129711
    Sleep    5s

Paso 1519
    Set Location    -33.4932924    -70.5125606
    Sleep    5s

Paso 1520
    Set Location    -33.4934722    -70.5123902
    Sleep    5s

Paso 1521
    Set Location    -33.4936965    -70.5121647
    Sleep    5s

Paso 1522
    Set Location    -33.4938751    -70.5119291
    Sleep    5s

Paso 1523
    Set Location    -33.493973    -70.5117326
    Sleep    5s

Paso 1524
    Set Location    -33.4939711    -70.5116985
    Sleep    5s

Paso 1525
    Set Location    -33.4939717    -70.5117031
    Sleep    5s

Paso 1526
    Set Location    -33.4939621    -70.5118041
    Sleep    5s

Paso 1527
    Set Location    -33.4939603    -70.5118168
    Sleep    5s

Paso 1528
    Set Location    -33.4938529    -70.5118998
    Sleep    5s

Paso 1529
    Set Location    -33.4936768    -70.5121289
    Sleep    5s

Paso 1530
    Set Location    -33.4935075    -70.5122987
    Sleep    5s

Paso 1531
    Set Location    -33.49347    -70.5123396
    Sleep    5s

Paso 1532
    Set Location    -33.4934732    -70.5123368
    Sleep    5s

Paso 1533
    Set Location    -33.4934733    -70.5123367
    Sleep    5s

Paso 1534
    Set Location    -33.4934733    -70.5123367
    Sleep    5s

Paso 1535
    Set Location    -33.4933982    -70.5124054
    Sleep    5s

Paso 1536
    Set Location    -33.4933415    -70.5124762
    Sleep    5s

Paso 1537
    Set Location    -33.4931049    -70.5126893
    Sleep    5s

Paso 1538
    Set Location    -33.4927671    -70.5129343
    Sleep    5s

Paso 1539
    Set Location    -33.492479    -70.5132912
    Sleep    5s

Paso 1540
    Set Location    -33.4921682    -70.5135652
    Sleep    5s

Paso 1541
    Set Location    -33.4917914    -70.5133917
    Sleep    5s

Paso 1542
    Set Location    -33.4914107    -70.5134067
    Sleep    5s

Paso 1543
    Set Location    -33.4910383    -70.5136236
    Sleep    5s

Paso 1544
    Set Location    -33.4907688    -70.5138876
    Sleep    5s

Paso 1545
    Set Location    -33.4904855    -70.5152907
    Sleep    5s

Paso 1546
    Set Location    -33.4891017    -70.5161276
    Sleep    5s

Paso 1547
    Set Location    -33.4889955    -70.5164875
    Sleep    5s

Paso 1548
    Set Location    -33.4890644    -70.5170076
    Sleep    5s

Paso 1549
    Set Location    -33.4892075    -70.5175257
    Sleep    5s

Paso 1550
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 1551
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 1552
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 1553
    Set Location    -33.4869451    -70.5187346
    Sleep    5s

Paso 1554
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 1555
    Set Location    -33.4891067    -70.5161187
    Sleep    5s

Paso 1556
    Set Location    -33.488121    -70.5192387
    Sleep    5s

Paso 1557
    Set Location    -33.4867345    -70.5186009
    Sleep    5s

Paso 1558
    Set Location    -33.4866425    -70.5185598
    Sleep    5s

Paso 1559
    Set Location    -33.4865568    -70.5185895
    Sleep    5s

Paso 1560
    Set Location    -33.4865582    -70.5185916
    Sleep    5s

Paso 1561
    Set Location    -33.4865583    -70.5185917
    Sleep    5s

Paso 1562
    Set Location    -33.4863417    -70.5186105
    Sleep    5s

Paso 1563
    Set Location    -33.4863289    -70.5187507
    Sleep    5s

Paso 1564
    Set Location    -33.4865019    -70.5188719
    Sleep    5s

Paso 1565
    Set Location    -33.4875837    -70.5194385
    Sleep    5s

Paso 1566
    Set Location    -33.4888954    -70.5188086
    Sleep    5s

Paso 1567
    Set Location    -33.4890557    -70.5187334
    Sleep    5s

Paso 1568
    Set Location    -33.4891081    -70.5187014
    Sleep    5s

Paso 1569
    Set Location    -33.4891484    -70.5184157
    Sleep    5s

Paso 1570
    Set Location    -33.4891425    -70.5181319
    Sleep    5s

Paso 1571
    Set Location    -33.4892496    -70.51781
    Sleep    5s

Paso 1572
    Set Location    -33.4892302    -70.5174516
    Sleep    5s

Paso 1573
    Set Location    -33.4891296    -70.5170904
    Sleep    5s

Paso 1574
    Set Location    -33.4890298    -70.5167252
    Sleep    5s

Paso 1575
    Set Location    -33.4890645    -70.5163873
    Sleep    5s

Paso 1576
    Set Location    -33.4892093    -70.5161878
    Sleep    5s

Paso 1577
    Set Location    -33.4900694    -70.5161992
    Sleep    5s

Paso 1578
    Set Location    -33.490251    -70.5159226
    Sleep    5s

Paso 1579
    Set Location    -33.4904118    -70.5155752
    Sleep    5s

Paso 1580
    Set Location    -33.4905517    -70.515269
    Sleep    5s

Paso 1581
    Set Location    -33.4906629    -70.5149511
    Sleep    5s

Paso 1582
    Set Location    -33.4907801    -70.5146744
    Sleep    5s

Paso 1583
    Set Location    -33.4907796    -70.514559
    Sleep    5s

Paso 1584
    Set Location    -33.4907816    -70.5145664
    Sleep    5s

Paso 1585
    Set Location    -33.4907817    -70.5145667
    Sleep    5s

Paso 1586
    Set Location    -33.4907386    -70.5144819
    Sleep    5s

Paso 1587
    Set Location    -33.490726    -70.5142561
    Sleep    5s

Paso 1588
    Set Location    -33.4907833    -70.5140235
    Sleep    5s

Paso 1589
    Set Location    -33.4908498    -70.5138292
    Sleep    5s

Paso 1590
    Set Location    -33.4910342    -70.5136753
    Sleep    5s

Paso 1591
    Set Location    -33.4913518    -70.5135266
    Sleep    5s

Paso 1592
    Set Location    -33.491716    -70.5133856
    Sleep    5s

Paso 1593
    Set Location    -33.4920613    -70.5135998
    Sleep    5s

Paso 1594
    Set Location    -33.4923286    -70.5135565
    Sleep    5s

Paso 1595
    Set Location    -33.4924577    -70.5134285
    Sleep    5s

Paso 1596
    Set Location    -33.4925656    -70.5132598
    Sleep    5s

Paso 1597
    Set Location    -33.4926613    -70.5130928
    Sleep    5s

Paso 1598
    Set Location    -33.4928088    -70.5129544
    Sleep    5s

Paso 1599
    Set Location    -33.4932025    -70.5126491
    Sleep    5s

Paso 1600
    Set Location    -33.4934444    -70.5124265
    Sleep    5s

Paso 1601
    Set Location    -33.4936622    -70.5122039
    Sleep    5s

Paso 1602
    Set Location    -33.4938654    -70.5119487
    Sleep    5s

Paso 1603
    Set Location    -33.4939788    -70.5117576
    Sleep    5s

Paso 1604
    Set Location    -33.4939686    -70.5117093
    Sleep    5s

Paso 1605
    Set Location    -33.4939604    -70.511774
    Sleep    5s

Paso 1606
    Set Location    -33.4939583    -70.5118276
    Sleep    5s

Paso 1607
    Set Location    -33.4938544    -70.5118908
    Sleep    5s

Paso 1608
    Set Location    -33.4936686    -70.512145
    Sleep    5s

Paso 1609
    Set Location    -33.4935001    -70.5123178
    Sleep    5s

Paso 1610
    Set Location    -33.4934472    -70.5123618
    Sleep    5s

Paso 1611
    Set Location    -33.4934499    -70.5123601
    Sleep    5s

Paso 1612
    Set Location    -33.49345    -70.51236
    Sleep    5s

Paso 1613
    Set Location    -33.49345    -70.51236
    Sleep    5s

Paso 1614
    Set Location    -33.4933764    -70.5124495
    Sleep    5s

Paso 1615
    Set Location    -33.4931987    -70.5125992
    Sleep    5s

Paso 1616
    Set Location    -33.4929035    -70.5128426
    Sleep    5s

Paso 1617
    Set Location    -33.4926128    -70.5130789
    Sleep    5s

Paso 1618
    Set Location    -33.4923644    -70.5134451
    Sleep    5s

Paso 1619
    Set Location    -33.4919969    -70.5135335
    Sleep    5s

Paso 1620
    Set Location    -33.4916845    -70.5133195
    Sleep    5s

Paso 1621
    Set Location    -33.4906762    -70.5143257
    Sleep    5s

Paso 1622
    Set Location    -33.4906828    -70.5145919
    Sleep    5s

Paso 1623
    Set Location    -33.4906054    -70.5150511
    Sleep    5s

Paso 1624
    Set Location    -33.4903449    -70.5155341
    Sleep    5s

Paso 1625
    Set Location    -33.4900679    -70.5159223
    Sleep    5s

Paso 1626
    Set Location    -33.4897448    -70.5160445
    Sleep    5s

Paso 1627
    Set Location    -33.4893321    -70.5161111
    Sleep    5s

Paso 1628
    Set Location    -33.4890902    -70.516171
    Sleep    5s

Paso 1629
    Set Location    -33.4890154    -70.5165324
    Sleep    5s

Paso 1630
    Set Location    -33.4890492    -70.5170002
    Sleep    5s

Paso 1631
    Set Location    -33.489171    -70.5174358
    Sleep    5s

Paso 1632
    Set Location    -33.4891076    -70.5181415
    Sleep    5s

Paso 1633
    Set Location    -33.4891044    -70.5184554
    Sleep    5s

Paso 1634
    Set Location    -33.4871625    -70.518869
    Sleep    5s

Paso 1635
    Set Location    -33.4868624    -70.5186768
    Sleep    5s

Paso 1636
    Set Location    -33.4866112    -70.5185624
    Sleep    5s

Paso 1637
    Set Location    -33.4865036    -70.5185964
    Sleep    5s

Paso 1638
    Set Location    -33.4863675    -70.5185986
    Sleep    5s

Paso 1639
    Set Location    -33.4863483    -70.5186067
    Sleep    5s

Paso 1640
    Set Location    -33.4863483    -70.5186067
    Sleep    5s

Paso 1641
    Set Location    -33.4863291    -70.5186274
    Sleep    5s

Paso 1642
    Set Location    -33.4863345    -70.5187543
    Sleep    5s

Paso 1643
    Set Location    -33.4864975    -70.5188624
    Sleep    5s

Paso 1644
    Set Location    -33.4867258    -70.5189814
    Sleep    5s

Paso 1645
    Set Location    -33.4870079    -70.5191528
    Sleep    5s

Paso 1646
    Set Location    -33.4873618    -70.5193496
    Sleep    5s

Paso 1647
    Set Location    -33.4877503    -70.519446
    Sleep    5s

Paso 1648
    Set Location    -33.4879957    -70.5193788
    Sleep    5s

Paso 1649
    Set Location    -33.4882282    -70.5192639
    Sleep    5s

Paso 1650
    Set Location    -33.48854    -70.5191036
    Sleep    5s

Paso 1651
    Set Location    -33.4888442    -70.5188199
    Sleep    5s

Paso 1652
    Set Location    -33.4890457    -70.5187134
    Sleep    5s

Paso 1653
    Set Location    -33.4891534    -70.5185719
    Sleep    5s

Paso 1654
    Set Location    -33.4891396    -70.5182799
    Sleep    5s

Paso 1655
    Set Location    -33.4891907    -70.5180132
    Sleep    5s

Paso 1656
    Set Location    -33.4892763    -70.5176822
    Sleep    5s

Paso 1657
    Set Location    -33.4891951    -70.5172868
    Sleep    5s

Paso 1658
    Set Location    -33.4890875    -70.5169128
    Sleep    5s

Paso 1659
    Set Location    -33.4890499    -70.5165327
    Sleep    5s

Paso 1660
    Set Location    -33.4891188    -70.5162461
    Sleep    5s

Paso 1661
    Set Location    -33.4893946    -70.5161827
    Sleep    5s

Paso 1662
    Set Location    -33.4897221    -70.5161168
    Sleep    5s

Paso 1663
    Set Location    -33.489938    -70.516164
    Sleep    5s

Paso 1664
    Set Location    -33.4901159    -70.5161684
    Sleep    5s

Paso 1665
    Set Location    -33.4902938    -70.5158454
    Sleep    5s

Paso 1666
    Set Location    -33.4904531    -70.5155161
    Sleep    5s

Paso 1667
    Set Location    -33.4905797    -70.5152441
    Sleep    5s

Paso 1668
    Set Location    -33.4906874    -70.5149511
    Sleep    5s

Paso 1669
    Set Location    -33.4907269    -70.5146195
    Sleep    5s

Paso 1670
    Set Location    -33.4907333    -70.5142634
    Sleep    5s

Paso 1671
    Set Location    -33.4907987    -70.5139412
    Sleep    5s

Paso 1672
    Set Location    -33.4909733    -70.5137023
    Sleep    5s

Paso 1673
    Set Location    -33.4913058    -70.5135523
    Sleep    5s

Paso 1674
    Set Location    -33.4917027    -70.5133759
    Sleep    5s

Paso 1675
    Set Location    -33.4920863    -70.5135895
    Sleep    5s

Paso 1676
    Set Location    -33.4923829    -70.5135198
    Sleep    5s

Paso 1677
    Set Location    -33.4924987    -70.5133732
    Sleep    5s

Paso 1678
    Set Location    -33.4926034    -70.5132052
    Sleep    5s

Paso 1679
    Set Location    -33.4927195    -70.5130335
    Sleep    5s

Paso 1680
    Set Location    -33.4928696    -70.5129272
    Sleep    5s

Paso 1681
    Set Location    -33.4930531    -70.5127945
    Sleep    5s

Paso 1682
    Set Location    -33.4932707    -70.5125845
    Sleep    5s

Paso 1683
    Set Location    -33.4935117    -70.5123769
    Sleep    5s

Paso 1684
    Set Location    -33.4937353    -70.5121373
    Sleep    5s

Paso 1685
    Set Location    -33.4939285    -70.5118906
    Sleep    5s

Paso 1686
    Set Location    -33.493963    -70.5117298
    Sleep    5s

Paso 1687
    Set Location    -33.4939618    -70.511775
    Sleep    5s

Paso 1688
    Set Location    -33.493969    -70.5118463
    Sleep    5s

Paso 1689
    Set Location    -33.4938901    -70.5118563
    Sleep    5s

Paso 1690
    Set Location    -33.49376    -70.5120325
    Sleep    5s

Paso 1691
    Set Location    -33.4935764    -70.5122355
    Sleep    5s

Paso 1692
    Set Location    -33.4934794    -70.512339
    Sleep    5s

Paso 1693
    Set Location    -33.49348    -70.5123368
    Sleep    5s

Paso 1694
    Set Location    -33.49348    -70.5123367
    Sleep    5s

Paso 1695
    Set Location    -33.49348    -70.5123367
    Sleep    5s

Paso 1696
    Set Location    -33.4933505    -70.5124518
    Sleep    5s

Paso 1697
    Set Location    -33.4930607    -70.5127193
    Sleep    5s

Paso 1698
    Set Location    -33.4929078    -70.5128545
    Sleep    5s

Paso 1699
    Set Location    -33.4929131    -70.512847
    Sleep    5s

Paso 1700
    Set Location    -33.4929133    -70.5128467
    Sleep    5s

Paso 1701
    Set Location    -33.4929133    -70.5128467
    Sleep    5s

Paso 1702
    Set Location    -33.4928893    -70.5128482
    Sleep    5s

Paso 1703
    Set Location    -33.4927068    -70.5129736
    Sleep    5s

Paso 1704
    Set Location    -33.4924859    -70.5132872
    Sleep    5s

Paso 1705
    Set Location    -33.4921625    -70.5135505
    Sleep    5s

Paso 1706
    Set Location    -33.4917967    -70.5133854
    Sleep    5s

Paso 1707
    Set Location    -33.4913922    -70.5133826
    Sleep    5s

Paso 1708
    Set Location    -33.4909981    -70.5136331
    Sleep    5s

Paso 1709
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 1710
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 1711
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 1712
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 1713
    Set Location    -33.4891067    -70.5161187
    Sleep    5s

Paso 1714
    Set Location    -33.488121    -70.5192387
    Sleep    5s

Paso 1715
    Set Location    -33.4892519    -70.5161029
    Sleep    5s

Paso 1716
    Set Location    -33.4890372    -70.5162762
    Sleep    5s

Paso 1717
    Set Location    -33.4890134    -70.5167994
    Sleep    5s

Paso 1718
    Set Location    -33.489145    -70.5173598
    Sleep    5s

Paso 1719
    Set Location    -33.4892207    -70.517805
    Sleep    5s

Paso 1720
    Set Location    -33.4890904    -70.5181719
    Sleep    5s

Paso 1721
    Set Location    -33.4890948    -70.5185034
    Sleep    5s

Paso 1722
    Set Location    -33.488887    -70.5187688
    Sleep    5s

Paso 1723
    Set Location    -33.4885682    -70.5190669
    Sleep    5s

Paso 1724
    Set Location    -33.4881982    -70.5192544
    Sleep    5s

Paso 1725
    Set Location    -33.4878169    -70.519224
    Sleep    5s

Paso 1726
    Set Location    -33.4874382    -70.5190503
    Sleep    5s

Paso 1727
    Set Location    -33.4870629    -70.5188273
    Sleep    5s

Paso 1728
    Set Location    -33.4867354    -70.5186164
    Sleep    5s

Paso 1729
    Set Location    -33.4866136    -70.5185565
    Sleep    5s

Paso 1730
    Set Location    -33.4865259    -70.5185873
    Sleep    5s

Paso 1731
    Set Location    -33.4863869    -70.5185894
    Sleep    5s

Paso 1732
    Set Location    -33.4863583    -70.5186033
    Sleep    5s

Paso 1733
    Set Location    -33.4863583    -70.5186033
    Sleep    5s

Paso 1734
    Set Location    -33.486328    -70.5187152
    Sleep    5s

Paso 1735
    Set Location    -33.4871721    -70.5192452
    Sleep    5s

Paso 1736
    Set Location    -33.4884118    -70.5191977
    Sleep    5s

Paso 1737
    Set Location    -33.4886792    -70.5189952
    Sleep    5s

Paso 1738
    Set Location    -33.4891028    -70.5169423
    Sleep    5s

Paso 1739
    Set Location    -33.4890408    -70.5165632
    Sleep    5s

Paso 1740
    Set Location    -33.4890975    -70.5162675
    Sleep    5s

Paso 1741
    Set Location    -33.4893248    -70.5161883
    Sleep    5s

Paso 1742
    Set Location    -33.4896995    -70.516114
    Sleep    5s

Paso 1743
    Set Location    -33.4899465    -70.5161486
    Sleep    5s

Paso 1744
    Set Location    -33.4901022    -70.5161848
    Sleep    5s

Paso 1745
    Set Location    -33.4902693    -70.5159208
    Sleep    5s

Paso 1746
    Set Location    -33.4904365    -70.5155758
    Sleep    5s

Paso 1747
    Set Location    -33.4905813    -70.5152611
    Sleep    5s

Paso 1748
    Set Location    -33.4907039    -70.5149523
    Sleep    5s

Paso 1749
    Set Location    -33.4908044    -70.5146616
    Sleep    5s

Paso 1750
    Set Location    -33.4907895    -70.5145686
    Sleep    5s

Paso 1751
    Set Location    -33.4907883    -70.5145747
    Sleep    5s

Paso 1752
    Set Location    -33.4907883    -70.514575
    Sleep    5s

Paso 1753
    Set Location    -33.4907835    -70.5145383
    Sleep    5s

Paso 1754
    Set Location    -33.490735    -70.5143815
    Sleep    5s

Paso 1755
    Set Location    -33.490754    -70.5141629
    Sleep    5s

Paso 1756
    Set Location    -33.4908129    -70.5139647
    Sleep    5s

Paso 1757
    Set Location    -33.4908986    -70.5137925
    Sleep    5s

Paso 1758
    Set Location    -33.4910955    -70.5136623
    Sleep    5s

Paso 1759
    Set Location    -33.4913967    -70.5135093
    Sleep    5s

Paso 1760
    Set Location    -33.4917745    -70.5133876
    Sleep    5s

Paso 1761
    Set Location    -33.492113    -70.5136071
    Sleep    5s

Paso 1762
    Set Location    -33.4923302    -70.5135486
    Sleep    5s

Paso 1763
    Set Location    -33.4924725    -70.5134117
    Sleep    5s

Paso 1764
    Set Location    -33.4925967    -70.513234
    Sleep    5s

Paso 1765
    Set Location    -33.4927224    -70.5130613
    Sleep    5s

Paso 1766
    Set Location    -33.4928778    -70.5129391
    Sleep    5s

Paso 1767
    Set Location    -33.4930663    -70.512793
    Sleep    5s

Paso 1768
    Set Location    -33.4932903    -70.5125667
    Sleep    5s

Paso 1769
    Set Location    -33.4935493    -70.5123473
    Sleep    5s

Paso 1770
    Set Location    -33.493786    -70.5120758
    Sleep    5s

Paso 1771
    Set Location    -33.4939756    -70.5118042
    Sleep    5s

Paso 1772
    Set Location    -33.4939783    -70.5117033
    Sleep    5s

Paso 1773
    Set Location    -33.4939751    -70.5118074
    Sleep    5s

Paso 1774
    Set Location    -33.4934861    -70.5123399
    Sleep    5s

Paso 1775
    Set Location    -33.4934736    -70.512351
    Sleep    5s

Paso 1776
    Set Location    -33.4934766    -70.5123484
    Sleep    5s

Paso 1777
    Set Location    -33.4934767    -70.5123483
    Sleep    5s

Paso 1778
    Set Location    -33.4934767    -70.5123483
    Sleep    5s

Paso 1779
    Set Location    -33.4933887    -70.5124346
    Sleep    5s

Paso 1780
    Set Location    -33.4932355    -70.5125656
    Sleep    5s

Paso 1781
    Set Location    -33.4930002    -70.512791
    Sleep    5s

Paso 1782
    Set Location    -33.4926914    -70.5130207
    Sleep    5s

Paso 1783
    Set Location    -33.4924243    -70.5133958
    Sleep    5s

Paso 1784
    Set Location    -33.4920544    -70.5135407
    Sleep    5s

Paso 1785
    Set Location    -33.4916737    -70.513331
    Sleep    5s

Paso 1786
    Set Location    -33.491287    -70.5134954
    Sleep    5s

Paso 1787
    Set Location    -33.490913    -70.5136947
    Sleep    5s

Paso 1788
    Set Location    -33.4907289    -70.514038
    Sleep    5s

Paso 1789
    Set Location    -33.4906797    -70.5143784
    Sleep    5s

Paso 1790
    Set Location    -33.490605    -70.5145483
    Sleep    5s

Paso 1791
    Set Location    -33.4905817    -70.5145928
    Sleep    5s

Paso 1792
    Set Location    -33.490585    -70.51459
    Sleep    5s

Paso 1793
    Set Location    -33.490585    -70.51459
    Sleep    5s

Paso 1794
    Set Location    -33.4905802    -70.5146924
    Sleep    5s

Paso 1795
    Set Location    -33.4905009    -70.5150308
    Sleep    5s

Paso 1796
    Set Location    -33.4902143    -70.5157253
    Sleep    5s

Paso 1797
    Set Location    -33.4899511    -70.5160032
    Sleep    5s

Paso 1798
    Set Location    -33.4890193    -70.5164718
    Sleep    5s

Paso 1799
    Set Location    -33.4890781    -70.5170168
    Sleep    5s

Paso 1800
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 1801
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 1802
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 1803
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 1804
    Set Location    -33.4891067    -70.5161187
    Sleep    5s

Paso 1805
    Set Location    -33.488121    -70.5192387
    Sleep    5s

Paso 1806
    Set Location    -33.4869548    -70.518776
    Sleep    5s

Paso 1807
    Set Location    -33.4863533    -70.5186067
    Sleep    5s

Paso 1808
    Set Location    -33.4863533    -70.5186067
    Sleep    5s

Paso 1809
    Set Location    -33.4863197    -70.518693
    Sleep    5s

Paso 1810
    Set Location    -33.4864067    -70.5188204
    Sleep    5s

Paso 1811
    Set Location    -33.4865532    -70.5188952
    Sleep    5s

Paso 1812
    Set Location    -33.4866249    -70.5189328
    Sleep    5s

Paso 1813
    Set Location    -33.4873894    -70.5193704
    Sleep    5s

Paso 1814
    Set Location    -33.4878082    -70.5194385
    Sleep    5s

Paso 1815
    Set Location    -33.4881404    -70.5193062
    Sleep    5s

Paso 1816
    Set Location    -33.4884047    -70.519213
    Sleep    5s

Paso 1817
    Set Location    -33.4891662    -70.5180786
    Sleep    5s

Paso 1818
    Set Location    -33.4890787    -70.5163342
    Sleep    5s

Paso 1819
    Set Location    -33.4892672    -70.5161983
    Sleep    5s

Paso 1820
    Set Location    -33.489706    -70.516103
    Sleep    5s

Paso 1821
    Set Location    -33.4899855    -70.5161365
    Sleep    5s

Paso 1822
    Set Location    -33.4899733    -70.5161485
    Sleep    5s

Paso 1823
    Set Location    -33.4900918    -70.5161947
    Sleep    5s

Paso 1824
    Set Location    -33.4902606    -70.5159391
    Sleep    5s

Paso 1825
    Set Location    -33.4904181    -70.5155944
    Sleep    5s

Paso 1826
    Set Location    -33.4905483    -70.5152991
    Sleep    5s

Paso 1827
    Set Location    -33.4906671    -70.5150345
    Sleep    5s

Paso 1828
    Set Location    -33.4907774    -70.5147481
    Sleep    5s

Paso 1829
    Set Location    -33.4907977    -70.5145555
    Sleep    5s

Paso 1830
    Set Location    -33.4907903    -70.5145581
    Sleep    5s

Paso 1831
    Set Location    -33.49079    -70.5145583
    Sleep    5s

Paso 1832
    Set Location    -33.49079    -70.5145583
    Sleep    5s

Paso 1833
    Set Location    -33.4907629    -70.514528
    Sleep    5s

Paso 1834
    Set Location    -33.4907227    -70.5143315
    Sleep    5s

Paso 1835
    Set Location    -33.490752    -70.5141408
    Sleep    5s

Paso 1836
    Set Location    -33.4907837    -70.5140377
    Sleep    5s

Paso 1837
    Set Location    -33.4908232    -70.5139061
    Sleep    5s

Paso 1838
    Set Location    -33.4909038    -70.5137785
    Sleep    5s

Paso 1839
    Set Location    -33.4910434    -70.5136824
    Sleep    5s

Paso 1840
    Set Location    -33.4912196    -70.5136142
    Sleep    5s

Paso 1841
    Set Location    -33.4915184    -70.51341
    Sleep    5s

Paso 1842
    Set Location    -33.4918481    -70.5134413
    Sleep    5s

Paso 1843
    Set Location    -33.4921296    -70.5136122
    Sleep    5s

Paso 1844
    Set Location    -33.4922944    -70.5135676
    Sleep    5s

Paso 1845
    Set Location    -33.4923881    -70.5135189
    Sleep    5s

Paso 1846
    Set Location    -33.4926781    -70.5130985
    Sleep    5s

Paso 1847
    Set Location    -33.4932174    -70.5126563
    Sleep    5s

Paso 1848
    Set Location    -33.493355    -70.5125363
    Sleep    5s

Paso 1849
    Set Location    -33.4935    -70.512415
    Sleep    5s

Paso 1850
    Set Location    -33.4936319    -70.5122879
    Sleep    5s

Paso 1851
    Set Location    -33.4937599    -70.5121324
    Sleep    5s

Paso 1852
    Set Location    -33.4938765    -70.5119659
    Sleep    5s

Paso 1853
    Set Location    -33.4939995    -70.5118126
    Sleep    5s

Paso 1854
    Set Location    -33.4940194    -70.5117063
    Sleep    5s

Paso 1855
    Set Location    -33.4940168    -70.5117082
    Sleep    5s

Paso 1856
    Set Location    -33.4940167    -70.5117083
    Sleep    5s

Paso 1857
    Set Location    -33.4940167    -70.5117083
    Sleep    5s

Paso 1858
    Set Location    -33.4939847    -70.5118107
    Sleep    5s

Paso 1859
    Set Location    -33.4939834    -70.511818
    Sleep    5s

Paso 1860
    Set Location    -33.4938794    -70.5118759
    Sleep    5s

Paso 1861
    Set Location    -33.4937382    -70.5120718
    Sleep    5s

Paso 1862
    Set Location    -33.4935862    -70.5122784
    Sleep    5s

Paso 1863
    Set Location    -33.4934905    -70.5123326
    Sleep    5s

Paso 1864
    Set Location    -33.4934932    -70.5123237
    Sleep    5s

Paso 1865
    Set Location    -33.4934933    -70.5123233
    Sleep    5s

Paso 1866
    Set Location    -33.4934933    -70.5123233
    Sleep    5s

Paso 1867
    Set Location    -33.4934133    -70.5124001
    Sleep    5s

Paso 1868
    Set Location    -33.4934101    -70.5124032
    Sleep    5s

Paso 1869
    Set Location    -33.49341    -70.5124033
    Sleep    5s

Paso 1870
    Set Location    -33.49341    -70.5124033
    Sleep    5s

Paso 1871
    Set Location    -33.4932725    -70.5125232
    Sleep    5s

Paso 1872
    Set Location    -33.4930034    -70.5127811
    Sleep    5s

Paso 1873
    Set Location    -33.4927397    -70.5129763
    Sleep    5s

Paso 1874
    Set Location    -33.4924998    -70.5133032
    Sleep    5s

Paso 1875
    Set Location    -33.4921695    -70.5135524
    Sleep    5s

Paso 1876
    Set Location    -33.4917778    -70.5133963
    Sleep    5s

Paso 1877
    Set Location    -33.4913862    -70.5134148
    Sleep    5s

Paso 1878
    Set Location    -33.4909359    -70.5136705
    Sleep    5s

Paso 1879
    Set Location    -33.4907206    -70.5140691
    Sleep    5s

Paso 1880
    Set Location    -33.4906823    -70.5144277
    Sleep    5s

Paso 1881
    Set Location    -33.4906354    -70.5145452
    Sleep    5s

Paso 1882
    Set Location    -33.4905814    -70.5145944
    Sleep    5s

Paso 1883
    Set Location    -33.4905832    -70.5145933
    Sleep    5s

Paso 1884
    Set Location    -33.4905833    -70.5145933
    Sleep    5s

Paso 1885
    Set Location    -33.4905785    -70.5146988
    Sleep    5s

Paso 1886
    Set Location    -33.4904782    -70.515081
    Sleep    5s

Paso 1887
    Set Location    -33.4902666    -70.5155123
    Sleep    5s

Paso 1888
    Set Location    -33.4902237    -70.5157137
    Sleep    5s

Paso 1889
    Set Location    -33.4900335    -70.5159798
    Sleep    5s

Paso 1890
    Set Location    -33.4890379    -70.5168909
    Sleep    5s

Paso 1891
    Set Location    -33.4887032    -70.5189203
    Sleep    5s

Paso 1892
    Set Location    -33.4876399    -70.5191332
    Sleep    5s

Paso 1893
    Set Location    -33.48764    -70.5191333
    Sleep    5s

Paso 1894
    Set Location    -33.48764    -70.5191333
    Sleep    5s

Paso 1895
    Set Location    -33.4875456    -70.5190838
    Sleep    5s

Paso 1896
    Set Location    -33.4873283    -70.518951
    Sleep    5s

Paso 1897
    Set Location    -33.4870009    -70.5187855
    Sleep    5s

Paso 1898
    Set Location    -33.486695    -70.5185989
    Sleep    5s

Paso 1899
    Set Location    -33.4865378    -70.5185933
    Sleep    5s

Paso 1900
    Set Location    -33.486396    -70.5186002
    Sleep    5s

Paso 1901
    Set Location    -33.4863621    -70.5186062
    Sleep    5s

Paso 1902
    Set Location    -33.4863426    -70.5186115
    Sleep    5s

Paso 1903
    Set Location    -33.4863754    -70.5187531
    Sleep    5s

Paso 1904
    Set Location    -33.4866431    -70.5189282
    Sleep    5s

Paso 1905
    Set Location    -33.4878849    -70.5194149
    Sleep    5s

Paso 1906
    Set Location    -33.4890581    -70.5187238
    Sleep    5s

Paso 1907
    Set Location    -33.489157    -70.5186407
    Sleep    5s

Paso 1908
    Set Location    -33.4891473    -70.5183204
    Sleep    5s

Paso 1909
    Set Location    -33.489176    -70.5180246
    Sleep    5s

Paso 1910
    Set Location    -33.4892901    -70.5177045
    Sleep    5s

Paso 1911
    Set Location    -33.4892121    -70.5173757
    Sleep    5s

Paso 1912
    Set Location    -33.4891222    -70.5170375
    Sleep    5s

Paso 1913
    Set Location    -33.4890262    -70.5167112
    Sleep    5s

Paso 1914
    Set Location    -33.4890461    -70.5164398
    Sleep    5s

Paso 1915
    Set Location    -33.4891777    -70.5162194
    Sleep    5s

Paso 1916
    Set Location    -33.4895352    -70.5161441
    Sleep    5s

Paso 1917
    Set Location    -33.489865    -70.516116
    Sleep    5s

Paso 1918
    Set Location    -33.4898707    -70.5161265
    Sleep    5s

Paso 1919
    Set Location    -33.4898669    -70.5161251
    Sleep    5s

Paso 1920
    Set Location    -33.4898667    -70.516125
    Sleep    5s

Paso 1921
    Set Location    -33.4898667    -70.516125
    Sleep    5s

Paso 1922
    Set Location    -33.4899131    -70.5161362
    Sleep    5s

Paso 1923
    Set Location    -33.4900431    -70.5161729
    Sleep    5s

Paso 1924
    Set Location    -33.4902053    -70.5159949
    Sleep    5s

Paso 1925
    Set Location    -33.490368    -70.5157076
    Sleep    5s

Paso 1926
    Set Location    -33.4904643    -70.5154678
    Sleep    5s

Paso 1927
    Set Location    -33.4905622    -70.5152331
    Sleep    5s

Paso 1928
    Set Location    -33.4906667    -70.5149916
    Sleep    5s

Paso 1929
    Set Location    -33.4907281    -70.5146799
    Sleep    5s

Paso 1930
    Set Location    -33.4907267    -70.5143471
    Sleep    5s

Paso 1931
    Set Location    -33.4907459    -70.5140516
    Sleep    5s

Paso 1932
    Set Location    -33.4908717    -70.5137693
    Sleep    5s

Paso 1933
    Set Location    -33.49166    -70.5133337
    Sleep    5s

Paso 1934
    Set Location    -33.4919565    -70.5135009
    Sleep    5s

Paso 1935
    Set Location    -33.4922707    -70.5135648
    Sleep    5s

Paso 1936
    Set Location    -33.4925006    -70.513362
    Sleep    5s

Paso 1937
    Set Location    -33.4926389    -70.5130893
    Sleep    5s

Paso 1938
    Set Location    -33.4928531    -70.5128817
    Sleep    5s

Paso 1939
    Set Location    -33.4930959    -70.5127118
    Sleep    5s

Paso 1940
    Set Location    -33.4933189    -70.5124922
    Sleep    5s

Paso 1941
    Set Location    -33.4935449    -70.5123079
    Sleep    5s

Paso 1942
    Set Location    -33.4937579    -70.512063
    Sleep    5s

Paso 1943
    Set Location    -33.4939261    -70.5118305
    Sleep    5s

Paso 1944
    Set Location    -33.493954    -70.5117069
    Sleep    5s

Paso 1945
    Set Location    -33.4939502    -70.5117098
    Sleep    5s

Paso 1946
    Set Location    -33.4939561    -70.5118701
    Sleep    5s

Paso 1947
    Set Location    -33.4939167    -70.511878
    Sleep    5s

Paso 1948
    Set Location    -33.4938428    -70.5119844
    Sleep    5s

Paso 1949
    Set Location    -33.4937327    -70.5121689
    Sleep    5s

Paso 1950
    Set Location    -33.4936431    -70.5122731
    Sleep    5s

Paso 1951
    Set Location    -33.4936481    -70.5122701
    Sleep    5s

Paso 1952
    Set Location    -33.4936483    -70.51227
    Sleep    5s

Paso 1953
    Set Location    -33.4936131    -70.5123614
    Sleep    5s

Paso 1954
    Set Location    -33.4934984    -70.5124493
    Sleep    5s

Paso 1955
    Set Location    -33.4933255    -70.5125959
    Sleep    5s

Paso 1956
    Set Location    -33.4929725    -70.5128781
    Sleep    5s

Paso 1957
    Set Location    -33.492665    -70.5131415
    Sleep    5s

Paso 1958
    Set Location    -33.4924407    -70.5134746
    Sleep    5s

Paso 1959
    Set Location    -33.4920568    -70.5136215
    Sleep    5s

Paso 1960
    Set Location    -33.4917134    -70.5134042
    Sleep    5s

Paso 1961
    Set Location    -33.4913478    -70.5134891
    Sleep    5s

Paso 1962
    Set Location    -33.4910086    -70.5136746
    Sleep    5s

Paso 1963
    Set Location    -33.4907963    -70.5139268
    Sleep    5s

Paso 1964
    Set Location    -33.4907376    -70.5141602
    Sleep    5s

Paso 1965
    Set Location    -33.4907197    -70.5144469
    Sleep    5s

Paso 1966
    Set Location    -33.4906285    -70.5145836
    Sleep    5s

Paso 1967
    Set Location    -33.4906067    -70.5146036
    Sleep    5s

Paso 1968
    Set Location    -33.4906082    -70.5146018
    Sleep    5s

Paso 1969
    Set Location    -33.4906083    -70.5146017
    Sleep    5s

Paso 1970
    Set Location    -33.4906116    -70.5148257
    Sleep    5s

Paso 1971
    Set Location    -33.4904551    -70.5152449
    Sleep    5s

Paso 1972
    Set Location    -33.4903077    -70.515569
    Sleep    5s

Paso 1973
    Set Location    -33.4902688    -70.5156944
    Sleep    5s

Paso 1974
    Set Location    -33.4902716    -70.5156934
    Sleep    5s

Paso 1975
    Set Location    -33.4901087    -70.5159873
    Sleep    5s

Paso 1976
    Set Location    -33.4896805    -70.5160689
    Sleep    5s

Paso 1977
    Set Location    -33.4891576    -70.5171699
    Sleep    5s

Paso 1978
    Set Location    -33.4892779    -70.5176613
    Sleep    5s

Paso 1979
    Set Location    -33.4891739    -70.5180586
    Sleep    5s

Paso 1980
    Set Location    -33.4891254    -70.5183741
    Sleep    5s

Paso 1981
    Set Location    -33.4891296    -70.5185216
    Sleep    5s

Paso 1982
    Set Location    -33.4889829    -70.5187484
    Sleep    5s

Paso 1983
    Set Location    -33.4886704    -70.5190263
    Sleep    5s

Paso 1984
    Set Location    -33.4883593    -70.5192119
    Sleep    5s

Paso 1985
    Set Location    -33.4883043    -70.5192253
    Sleep    5s

Paso 1986
    Set Location    -33.4881968    -70.5192818
    Sleep    5s

Paso 1987
    Set Location    -33.4878493    -70.5192506
    Sleep    5s

Paso 1988
    Set Location    -33.4873969    -70.5190517
    Sleep    5s

Paso 1989
    Set Location    -33.4864941    -70.5186452
    Sleep    5s

Paso 1990
    Set Location    -33.4863949    -70.5186463
    Sleep    5s

Paso 1991
    Set Location    -33.4863933    -70.5186482
    Sleep    5s

Paso 1992
    Set Location    -33.4863933    -70.5186483
    Sleep    5s

Paso 1993
    Set Location    -33.4863933    -70.5186483
    Sleep    5s

Paso 1994
    Set Location    -33.4863661    -70.5187122
    Sleep    5s

Paso 1995
    Set Location    -33.4863948    -70.5187687
    Sleep    5s

Paso 1996
    Set Location    -33.4865563    -70.5188339
    Sleep    5s

Paso 1997
    Set Location    -33.4868021    -70.518979
    Sleep    5s

Paso 1998
    Set Location    -33.4870862    -70.5191383
    Sleep    5s

Paso 1999
    Set Location    -33.4879965    -70.5193104
    Sleep    5s

Paso 2000
    Set Location    -33.4880879    -70.5192556
    Sleep    5s

Paso 2001
    Set Location    -33.4883582    -70.5191773
    Sleep    5s

Paso 2002
    Set Location    -33.4886253    -70.5190053
    Sleep    5s

Paso 2003
    Set Location    -33.4888868    -70.5187751
    Sleep    5s

Paso 2004
    Set Location    -33.4890202    -70.5187026
    Sleep    5s

Paso 2005
    Set Location    -33.4890169    -70.5187001
    Sleep    5s

Paso 2006
    Set Location    -33.4891471    -70.518524
    Sleep    5s

Paso 2007
    Set Location    -33.4891166    -70.5182521
    Sleep    5s

Paso 2008
    Set Location    -33.4892033    -70.5179305
    Sleep    5s

Paso 2009
    Set Location    -33.4892531    -70.5175671
    Sleep    5s

Paso 2010
    Set Location    -33.4891633    -70.5172062
    Sleep    5s

Paso 2011
    Set Location    -33.4890521    -70.5168368
    Sleep    5s

Paso 2012
    Set Location    -33.4890383    -70.5164548
    Sleep    5s

Paso 2013
    Set Location    -33.4891136    -70.5162243
    Sleep    5s

Paso 2014
    Set Location    -33.4893874    -70.5161467
    Sleep    5s

Paso 2015
    Set Location    -33.489761    -70.5160899
    Sleep    5s

Paso 2016
    Set Location    -33.4899262    -70.5161121
    Sleep    5s

Paso 2017
    Set Location    -33.4899604    -70.5161276
    Sleep    5s

Paso 2018
    Set Location    -33.4901191    -70.5161133
    Sleep    5s

Paso 2019
    Set Location    -33.4903042    -70.5157998
    Sleep    5s

Paso 2020
    Set Location    -33.4904672    -70.5154858
    Sleep    5s

Paso 2021
    Set Location    -33.4906021    -70.5151889
    Sleep    5s

Paso 2022
    Set Location    -33.4907193    -70.5148982
    Sleep    5s

Paso 2023
    Set Location    -33.4908019    -70.5146627
    Sleep    5s

Paso 2024
    Set Location    -33.4907593    -70.5145355
    Sleep    5s

Paso 2025
    Set Location    -33.4907328    -70.5144901
    Sleep    5s

Paso 2026
    Set Location    -33.4907141    -70.5143164
    Sleep    5s

Paso 2027
    Set Location    -33.4907607    -70.5140885
    Sleep    5s

Paso 2028
    Set Location    -33.4908206    -70.5138865
    Sleep    5s

Paso 2029
    Set Location    -33.4909331    -70.5137265
    Sleep    5s

Paso 2030
    Set Location    -33.4910895    -70.5136364
    Sleep    5s

Paso 2031
    Set Location    -33.4913171    -70.513532
    Sleep    5s

Paso 2032
    Set Location    -33.4916075    -70.5133543
    Sleep    5s

Paso 2033
    Set Location    -33.491885    -70.5134487
    Sleep    5s

Paso 2034
    Set Location    -33.4921485    -70.5135793
    Sleep    5s

Paso 2035
    Set Location    -33.4923815    -70.513474
    Sleep    5s

Paso 2036
    Set Location    -33.4928078    -70.5129455
    Sleep    5s

Paso 2037
    Set Location    -33.4929727    -70.5128316
    Sleep    5s

Paso 2038
    Set Location    -33.4931419    -70.5126842
    Sleep    5s

Paso 2039
    Set Location    -33.4933283    -70.5125255
    Sleep    5s

Paso 2040
    Set Location    -33.4935407    -70.5123411
    Sleep    5s

Paso 2041
    Set Location    -33.493749    -70.5121091
    Sleep    5s

Paso 2042
    Set Location    -33.4939132    -70.5118718
    Sleep    5s

Paso 2043
    Set Location    -33.4939764    -70.5117171
    Sleep    5s

Paso 2044
    Set Location    -33.4939668    -70.5117042
    Sleep    5s

Paso 2045
    Set Location    -33.4939347    -70.5117866
    Sleep    5s

Paso 2046
    Set Location    -33.4939651    -70.5118786
    Sleep    5s

Paso 2047
    Set Location    -33.4939427    -70.5118655
    Sleep    5s

Paso 2048
    Set Location    -33.4938314    -70.5120149
    Sleep    5s

Paso 2049
    Set Location    -33.4936627    -70.5122446
    Sleep    5s

Paso 2050
    Set Location    -33.4935311    -70.5123868
    Sleep    5s

Paso 2051
    Set Location    -33.4935263    -70.5123926
    Sleep    5s

Paso 2052
    Set Location    -33.4935282    -70.5123901
    Sleep    5s

Paso 2053
    Set Location    -33.4935283    -70.51239
    Sleep    5s

Paso 2054
    Set Location    -33.4935283    -70.51239
    Sleep    5s

Paso 2055
    Set Location    -33.4933689    -70.5125848
    Sleep    5s

Paso 2056
    Set Location    -33.4930377    -70.5128555
    Sleep    5s

Paso 2057
    Set Location    -33.4926945    -70.5131251
    Sleep    5s

Paso 2058
    Set Location    -33.4924337    -70.5134639
    Sleep    5s

Paso 2059
    Set Location    -33.4920518    -70.5136086
    Sleep    5s

Paso 2060
    Set Location    -33.4917007    -70.5133762
    Sleep    5s

Paso 2061
    Set Location    -33.4907201    -70.5143991
    Sleep    5s

Paso 2062
    Set Location    -33.49067    -70.5145751
    Sleep    5s

Paso 2063
    Set Location    -33.490642    -70.5146116
    Sleep    5s

Paso 2064
    Set Location    -33.4906449    -70.5146084
    Sleep    5s

Paso 2065
    Set Location    -33.4906386    -70.5147459
    Sleep    5s

Paso 2066
    Set Location    -33.4905272    -70.5151589
    Sleep    5s

Paso 2067
    Set Location    -33.4901727    -70.5159039
    Sleep    5s

Paso 2068
    Set Location    -33.4890506    -70.516483
    Sleep    5s

Paso 2069
    Set Location    -33.4890963    -70.5169624
    Sleep    5s

Paso 2070
    Set Location    -33.4892735    -70.5175355
    Sleep    5s

Paso 2071
    Set Location    -33.4890634    -70.5186674
    Sleep    5s

Paso 2072
    Set Location    -33.4874855    -70.5190665
    Sleep    5s

Paso 2073
    Set Location    -33.4867579    -70.5186341
    Sleep    5s

Paso 2074
    Set Location    -33.4866233    -70.5186433
    Sleep    5s

Paso 2075
    Set Location    -33.4864948    -70.5186497
    Sleep    5s

Paso 2076
    Set Location    -33.4864267    -70.5186533
    Sleep    5s

Paso 2077
    Set Location    -33.4864267    -70.5186533
    Sleep    5s

Paso 2078
    Set Location    -33.4866185    -70.5189226
    Sleep    5s

Paso 2079
    Set Location    -33.4868827    -70.5190814
    Sleep    5s

Paso 2080
    Set Location    -33.4871648    -70.5192283
    Sleep    5s

Paso 2081
    Set Location    -33.487403    -70.519335
    Sleep    5s

Paso 2082
    Set Location    -33.4873983    -70.5193333
    Sleep    5s

Paso 2083
    Set Location    -33.4873983    -70.5193333
    Sleep    5s

Paso 2084
    Set Location    -33.487838    -70.5193982
    Sleep    5s

Paso 2085
    Set Location    -33.4880039    -70.5193319
    Sleep    5s

Paso 2086
    Set Location    -33.488204    -70.5192093
    Sleep    5s

Paso 2087
    Set Location    -33.4884827    -70.5191111
    Sleep    5s

Paso 2088
    Set Location    -33.4887911    -70.5188893
    Sleep    5s

Paso 2089
    Set Location    -33.4889917    -70.5187349
    Sleep    5s

Paso 2090
    Set Location    -33.4891112    -70.5186741
    Sleep    5s

Paso 2091
    Set Location    -33.4891527    -70.5184777
    Sleep    5s

Paso 2092
    Set Location    -33.4891442    -70.5181779
    Sleep    5s

Paso 2093
    Set Location    -33.4892618    -70.5178502
    Sleep    5s

Paso 2094
    Set Location    -33.4892515    -70.5174493
    Sleep    5s

Paso 2095
    Set Location    -33.4891318    -70.5170438
    Sleep    5s

Paso 2096
    Set Location    -33.4890491    -70.5166331
    Sleep    5s

Paso 2097
    Set Location    -33.4890917    -70.5163052
    Sleep    5s

Paso 2098
    Set Location    -33.4892845    -70.5161533
    Sleep    5s

Paso 2099
    Set Location    -33.4896825    -70.5161004
    Sleep    5s

Paso 2100
    Set Location    -33.4899733    -70.5161438
    Sleep    5s

Paso 2101
    Set Location    -33.4901239    -70.5161744
    Sleep    5s

Paso 2102
    Set Location    -33.4903178    -70.5158894
    Sleep    5s

Paso 2103
    Set Location    -33.4904662    -70.5155522
    Sleep    5s

Paso 2104
    Set Location    -33.4905907    -70.5152546
    Sleep    5s

Paso 2105
    Set Location    -33.4907137    -70.5149586
    Sleep    5s

Paso 2106
    Set Location    -33.4908203    -70.5146946
    Sleep    5s

Paso 2107
    Set Location    -33.4908028    -70.5145615
    Sleep    5s

Paso 2108
    Set Location    -33.4908001    -70.5145665
    Sleep    5s

Paso 2109
    Set Location    -33.4908    -70.5145667
    Sleep    5s

Paso 2110
    Set Location    -33.4908    -70.5145667
    Sleep    5s

Paso 2111
    Set Location    -33.4907504    -70.5143564
    Sleep    5s

Paso 2112
    Set Location    -33.490778    -70.5141513
    Sleep    5s

Paso 2113
    Set Location    -33.4908253    -70.5139552
    Sleep    5s

Paso 2114
    Set Location    -33.490917    -70.5137516
    Sleep    5s

Paso 2115
    Set Location    -33.4910738    -70.5136669
    Sleep    5s

Paso 2116
    Set Location    -33.4921548    -70.5135806
    Sleep    5s

Paso 2117
    Set Location    -33.4924273    -70.5134474
    Sleep    5s

Paso 2118
    Set Location    -33.4925921    -70.5132357
    Sleep    5s

Paso 2119
    Set Location    -33.492733    -70.5130418
    Sleep    5s

Paso 2120
    Set Location    -33.4929157    -70.5128635
    Sleep    5s

Paso 2121
    Set Location    -33.4931037    -70.5127044
    Sleep    5s

Paso 2122
    Set Location    -33.4933062    -70.5125092
    Sleep    5s

Paso 2123
    Set Location    -33.4935787    -70.5123068
    Sleep    5s

Paso 2124
    Set Location    -33.4938113    -70.512017
    Sleep    5s

Paso 2125
    Set Location    -33.4939641    -70.5117791
    Sleep    5s

Paso 2126
    Set Location    -33.4939765    -70.5117107
    Sleep    5s

Paso 2127
    Set Location    -33.4939559    -70.5117838
    Sleep    5s

Paso 2128
    Set Location    -33.4939742    -70.5118554
    Sleep    5s

Paso 2129
    Set Location    -33.4939766    -70.5118598
    Sleep    5s

Paso 2130
    Set Location    -33.4939079    -70.5119016
    Sleep    5s

Paso 2131
    Set Location    -33.4938191    -70.5120789
    Sleep    5s

Paso 2132
    Set Location    -33.493652    -70.5122953
    Sleep    5s

Paso 2133
    Set Location    -33.4935643    -70.5124119
    Sleep    5s

Paso 2134
    Set Location    -33.4935649    -70.5124133
    Sleep    5s

Paso 2135
    Set Location    -33.493565    -70.5124133
    Sleep    5s

Paso 2136
    Set Location    -33.493565    -70.5124133
    Sleep    5s

Paso 2137
    Set Location    -33.4935008    -70.5124807
    Sleep    5s

Paso 2138
    Set Location    -33.4931833    -70.5127309
    Sleep    5s

Paso 2139
    Set Location    -33.492843    -70.5130127
    Sleep    5s

Paso 2140
    Set Location    -33.4925831    -70.5132829
    Sleep    5s

Paso 2141
    Set Location    -33.4923483    -70.5135578
    Sleep    5s

Paso 2142
    Set Location    -33.4919814    -70.5135695
    Sleep    5s

Paso 2143
    Set Location    -33.4907805    -70.5140284
    Sleep    5s

Paso 2144
    Set Location    -33.4907319    -70.5142944
    Sleep    5s

Paso 2145
    Set Location    -33.4907227    -70.5145117
    Sleep    5s

Paso 2146
    Set Location    -33.4906536    -70.5146232
    Sleep    5s

Paso 2147
    Set Location    -33.4906566    -70.5146233
    Sleep    5s

Paso 2148
    Set Location    -33.4906567    -70.5146233
    Sleep    5s

Paso 2149
    Set Location    -33.4906567    -70.5146233
    Sleep    5s

Paso 2150
    Set Location    -33.4906119    -70.5148218
    Sleep    5s

Paso 2151
    Set Location    -33.490265    -70.5157164
    Sleep    5s

Paso 2152
    Set Location    -33.4901749    -70.515946
    Sleep    5s

Paso 2153
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 2154
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 2155
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 2156
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 2157
    Set Location    -33.4891067    -70.5161187
    Sleep    5s

Paso 2158
    Set Location    -33.488121    -70.5192387
    Sleep    5s

Paso 2159
    Set Location    -33.4869548    -70.518776
    Sleep    5s

Paso 2160
    Set Location    -33.4882986    -70.5192395
    Sleep    5s

Paso 2161
    Set Location    -33.4878482    -70.5192668
    Sleep    5s

Paso 2162
    Set Location    -33.4873922    -70.5190304
    Sleep    5s

Paso 2163
    Set Location    -33.4870081    -70.518806
    Sleep    5s

Paso 2164
    Set Location    -33.4866889    -70.5186462
    Sleep    5s

Paso 2165
    Set Location    -33.4864232    -70.5186532
    Sleep    5s

Paso 2166
    Set Location    -33.4864249    -70.5186533
    Sleep    5s

Paso 2167
    Set Location    -33.486425    -70.5186533
    Sleep    5s

Paso 2168
    Set Location    -33.486425    -70.5186533
    Sleep    5s

Paso 2169
    Set Location    -33.4868535    -70.5190107
    Sleep    5s

Paso 2170
    Set Location    -33.4871516    -70.5191801
    Sleep    5s

Paso 2171
    Set Location    -33.4873944    -70.5193218
    Sleep    5s

Paso 2172
    Set Location    -33.4886305    -70.5190261
    Sleep    5s

Paso 2173
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 2174
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 2175
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 2176
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 2177
    Set Location    -33.4891067    -70.5161187
    Sleep    5s

Paso 2178
    Set Location    -33.488121    -70.5192387
    Sleep    5s

Paso 2179
    Set Location    -33.4869548    -70.518776
    Sleep    5s

Paso 2180
    Set Location    -33.4891595    -70.5181166
    Sleep    5s

Paso 2181
    Set Location    -33.4904067    -70.5156513
    Sleep    5s

Paso 2182
    Set Location    -33.4907369    -70.5143778
    Sleep    5s

Paso 2183
    Set Location    -33.4908007    -70.5140407
    Sleep    5s

Paso 2184
    Set Location    -33.4909431    -70.5137683
    Sleep    5s

Paso 2185
    Set Location    -33.4912453    -70.5136103
    Sleep    5s

Paso 2186
    Set Location    -33.492487    -70.5134097
    Sleep    5s

Paso 2187
    Set Location    -33.4930806    -70.5127613
    Sleep    5s

Paso 2188
    Set Location    -33.4933425    -70.5125263
    Sleep    5s

Paso 2189
    Set Location    -33.4935992    -70.5122842
    Sleep    5s

Paso 2190
    Set Location    -33.4938307    -70.5119973
    Sleep    5s

Paso 2191
    Set Location    -33.4939712    -70.5117816
    Sleep    5s

Paso 2192
    Set Location    -33.493985    -70.5117313
    Sleep    5s

Paso 2193
    Set Location    -33.4939627    -70.5118118
    Sleep    5s

Paso 2194
    Set Location    -33.493966    -70.5118728
    Sleep    5s

Paso 2195
    Set Location    -33.4939682    -70.5118701
    Sleep    5s

Paso 2196
    Set Location    -33.4939683    -70.51187
    Sleep    5s

Paso 2197
    Set Location    -33.4939683    -70.51187
    Sleep    5s

Paso 2198
    Set Location    -33.4935411    -70.512394
    Sleep    5s

Paso 2199
    Set Location    -33.493519    -70.5124146
    Sleep    5s

Paso 2200
    Set Location    -33.4935216    -70.5124118
    Sleep    5s

Paso 2201
    Set Location    -33.4935217    -70.5124117
    Sleep    5s

Paso 2202
    Set Location    -33.4935217    -70.5124117
    Sleep    5s

Paso 2203
    Set Location    -33.4935104    -70.5124309
    Sleep    5s

Paso 2204
    Set Location    -33.4933273    -70.5126357
    Sleep    5s

Paso 2205
    Set Location    -33.4922837    -70.5135773
    Sleep    5s

Paso 2206
    Set Location    -33.4919128    -70.5135392
    Sleep    5s

Paso 2207
    Set Location    -33.491573    -70.5133725
    Sleep    5s

Paso 2208
    Set Location    -33.4907569    -70.5140857
    Sleep    5s

Paso 2209
    Set Location    -33.4907202    -70.5144361
    Sleep    5s

Paso 2210
    Set Location    -33.4906378    -70.5145828
    Sleep    5s

Paso 2211
    Set Location    -33.4906264    -70.5146043
    Sleep    5s

Paso 2212
    Set Location    -33.4906282    -70.5146018
    Sleep    5s

Paso 2213
    Set Location    -33.4905687    -70.5150068
    Sleep    5s

Paso 2214
    Set Location    -33.4903678    -70.5154004
    Sleep    5s

Paso 2215
    Set Location    -33.4902604    -70.5156423
    Sleep    5s

Paso 2216
    Set Location    -33.4901931    -70.5158466
    Sleep    5s

Paso 2217
    Set Location    -33.4891208    -70.5161837
    Sleep    5s

Paso 2218
    Set Location    -33.4891063    -70.5169846
    Sleep    5s

Paso 2219
    Set Location    -33.4887175    -70.5189615
    Sleep    5s

Paso 2220
    Set Location    -33.488306    -70.5192546
    Sleep    5s

Paso 2221
    Set Location    -33.4878247    -70.5192682
    Sleep    5s

Paso 2222
    Set Location    -33.4873848    -70.5190504
    Sleep    5s

Paso 2223
    Set Location    -33.4869623    -70.5187825
    Sleep    5s

Paso 2224
    Set Location    -33.4866241    -70.5186123
    Sleep    5s

Paso 2225
    Set Location    -33.4864033    -70.51864
    Sleep    5s

Paso 2226
    Set Location    -33.4864033    -70.51864
    Sleep    5s

Paso 2227
    Set Location    -33.4863921    -70.5187695
    Sleep    5s

Paso 2228
    Set Location    -33.4865841    -70.5188648
    Sleep    5s

Paso 2229
    Set Location    -33.4868692    -70.5190146
    Sleep    5s

Paso 2230
    Set Location    -33.4884349    -70.5191631
    Sleep    5s

Paso 2231
    Set Location    -33.4887435    -70.5189259
    Sleep    5s

Paso 2232
    Set Location    -33.4891353    -70.5186452
    Sleep    5s

Paso 2233
    Set Location    -33.4892742    -70.517799
    Sleep    5s

Paso 2234
    Set Location    -33.4892629    -70.517502
    Sleep    5s

Paso 2235
    Set Location    -33.4891673    -70.517185
    Sleep    5s

Paso 2236
    Set Location    -33.4890738    -70.5168771
    Sleep    5s

Paso 2237
    Set Location    -33.4890445    -70.5165779
    Sleep    5s

Paso 2238
    Set Location    -33.4890781    -70.5163093
    Sleep    5s

Paso 2239
    Set Location    -33.4892461    -70.516184
    Sleep    5s

Paso 2240
    Set Location    -33.4895101    -70.5161447
    Sleep    5s

Paso 2241
    Set Location    -33.4897539    -70.5160816
    Sleep    5s

Paso 2242
    Set Location    -33.4899139    -70.5160993
    Sleep    5s

Paso 2243
    Set Location    -33.4901093    -70.5161615
    Sleep    5s

Paso 2244
    Set Location    -33.4902828    -70.5158949
    Sleep    5s

Paso 2245
    Set Location    -33.4904081    -70.5156163
    Sleep    5s

Paso 2246
    Set Location    -33.4906685    -70.5149747
    Sleep    5s

Paso 2247
    Set Location    -33.4907808    -70.5147159
    Sleep    5s

Paso 2248
    Set Location    -33.4907839    -70.5145662
    Sleep    5s

Paso 2249
    Set Location    -33.4907713    -70.5145616
    Sleep    5s

Paso 2250
    Set Location    -33.4907717    -70.5145632
    Sleep    5s

Paso 2251
    Set Location    -33.4907717    -70.5145633
    Sleep    5s

Paso 2252
    Set Location    -33.4907477    -70.5145168
    Sleep    5s

Paso 2253
    Set Location    -33.4907155    -70.5143196
    Sleep    5s

Paso 2254
    Set Location    -33.4907588    -70.5141016
    Sleep    5s

Paso 2255
    Set Location    -33.4908133    -70.5138904
    Sleep    5s

Paso 2256
    Set Location    -33.4909202    -70.5137221
    Sleep    5s

Paso 2257
    Set Location    -33.4910887    -70.5136213
    Sleep    5s

Paso 2258
    Set Location    -33.4913266    -70.5135283
    Sleep    5s

Paso 2259
    Set Location    -33.4916368    -70.5133278
    Sleep    5s

Paso 2260
    Set Location    -33.4919508    -70.5134954
    Sleep    5s

Paso 2261
    Set Location    -33.4925021    -70.5133657
    Sleep    5s

Paso 2262
    Set Location    -33.4926489    -70.5131128
    Sleep    5s

Paso 2263
    Set Location    -33.4936033    -70.5122422
    Sleep    5s

Paso 2264
    Set Location    -33.493839    -70.5119671
    Sleep    5s

Paso 2265
    Set Location    -33.4939441    -70.5118183
    Sleep    5s

Paso 2266
    Set Location    -33.4936033    -70.5123077
    Sleep    5s

Paso 2267
    Set Location    -33.4935297    -70.512398
    Sleep    5s

Paso 2268
    Set Location    -33.4935348    -70.5123935
    Sleep    5s

Paso 2269
    Set Location    -33.493535    -70.5123933
    Sleep    5s

Paso 2270
    Set Location    -33.493535    -70.5123933
    Sleep    5s

Paso 2271
    Set Location    -33.4934613    -70.5124975
    Sleep    5s

Paso 2272
    Set Location    -33.4931786    -70.5127288
    Sleep    5s

Paso 2273
    Set Location    -33.4928064    -70.5130239
    Sleep    5s

Paso 2274
    Set Location    -33.4925258    -70.5133446
    Sleep    5s

Paso 2275
    Set Location    -33.4921706    -70.5136081
    Sleep    5s

Paso 2276
    Set Location    -33.4917823    -70.513423
    Sleep    5s

Paso 2277
    Set Location    -33.4913936    -70.5134726
    Sleep    5s

Paso 2278
    Set Location    -33.490995    -70.5136997
    Sleep    5s

Paso 2279
    Set Location    -33.4907927    -70.5139743
    Sleep    5s

Paso 2280
    Set Location    -33.4907366    -70.5143492
    Sleep    5s

Paso 2281
    Set Location    -33.4906603    -70.514568
    Sleep    5s

Paso 2282
    Set Location    -33.4906286    -70.5146161
    Sleep    5s

Paso 2283
    Set Location    -33.4906316    -70.5146134
    Sleep    5s

Paso 2284
    Set Location    -33.4906317    -70.5146133
    Sleep    5s

Paso 2285
    Set Location    -33.4906317    -70.5146133
    Sleep    5s

Paso 2286
    Set Location    -33.4902894    -70.515586
    Sleep    5s

Paso 2287
    Set Location    -33.4902263    -70.5157856
    Sleep    5s

Paso 2288
    Set Location    -33.4890574    -70.5164641
    Sleep    5s

Paso 2289
    Set Location    -33.4890899    -70.5169677
    Sleep    5s

Paso 2290
    Set Location    -33.489243    -70.5175209
    Sleep    5s

Paso 2291
    Set Location    -33.487883    -70.519255
    Sleep    5s

Paso 2292
    Set Location    -33.4864078    -70.5186434
    Sleep    5s

Paso 2293
    Set Location    -33.4863861    -70.5186472
    Sleep    5s

Paso 2294
    Set Location    -33.4863898    -70.5186467
    Sleep    5s

Paso 2295
    Set Location    -33.48639    -70.5186467
    Sleep    5s

Paso 2296
    Set Location    -33.48639    -70.5186467
    Sleep    5s

Paso 2297
    Set Location    -33.486398    -70.5187441
    Sleep    5s

Paso 2298
    Set Location    -33.486503    -70.5188169
    Sleep    5s

Paso 2299
    Set Location    -33.4867129    -70.5189344
    Sleep    5s

Paso 2300
    Set Location    -33.4869578    -70.5190815
    Sleep    5s

Paso 2301
    Set Location    -33.4883568    -70.5191734
    Sleep    5s

Paso 2302
    Set Location    -33.4886886    -70.5189795
    Sleep    5s

Paso 2303
    Set Location    -33.4890134    -70.5187098
    Sleep    5s

Paso 2304
    Set Location    -33.4890133    -70.51871
    Sleep    5s

Paso 2305
    Set Location    -33.4892603    -70.5177391
    Sleep    5s

Paso 2306
    Set Location    -33.4891993    -70.5173716
    Sleep    5s

Paso 2307
    Set Location    -33.4890961    -70.5169703
    Sleep    5s

Paso 2308
    Set Location    -33.4890402    -70.5165871
    Sleep    5s

Paso 2309
    Set Location    -33.4890983    -70.5162831
    Sleep    5s

Paso 2310
    Set Location    -33.4893297    -70.5161566
    Sleep    5s

Paso 2311
    Set Location    -33.4897467    -70.5161199
    Sleep    5s

Paso 2312
    Set Location    -33.4905076    -70.5153869
    Sleep    5s

Paso 2313
    Set Location    -33.4907426    -70.5141332
    Sleep    5s

Paso 2314
    Set Location    -33.4908499    -70.5138344
    Sleep    5s

Paso 2315
    Set Location    -33.4910614    -70.5136474
    Sleep    5s

Paso 2316
    Set Location    -33.4913985    -70.5134811
    Sleep    5s

Paso 2317
    Set Location    -33.4917437    -70.5133571
    Sleep    5s

Paso 2318
    Set Location    -33.4925539    -70.51327
    Sleep    5s

Paso 2319
    Set Location    -33.4931934    -70.5126416
    Sleep    5s

Paso 2320
    Set Location    -33.4934334    -70.5124431
    Sleep    5s

Paso 2321
    Set Location    -33.4935464    -70.5123561
    Sleep    5s

Paso 2322
    Set Location    -33.4935435    -70.512363
    Sleep    5s

Paso 2323
    Set Location    -33.4935433    -70.5123633
    Sleep    5s

Paso 2324
    Set Location    -33.4935433    -70.5123633
    Sleep    5s

Paso 2325
    Set Location    -33.4934617    -70.5123937
    Sleep    5s

Paso 2326
    Set Location    -33.4934283    -70.5124136
    Sleep    5s

Paso 2327
    Set Location    -33.4934299    -70.5124118
    Sleep    5s

Paso 2328
    Set Location    -33.49343    -70.5124117
    Sleep    5s

Paso 2329
    Set Location    -33.49343    -70.5124117
    Sleep    5s

Paso 2330
    Set Location    -33.4933724    -70.5124708
    Sleep    5s

Paso 2331
    Set Location    -33.493106    -70.5126919
    Sleep    5s

Paso 2332
    Set Location    -33.4927674    -70.5129629
    Sleep    5s

Paso 2333
    Set Location    -33.4924676    -70.5133666
    Sleep    5s

Paso 2334
    Set Location    -33.4921037    -70.5135601
    Sleep    5s

Paso 2335
    Set Location    -33.4917563    -70.5133546
    Sleep    5s

Paso 2336
    Set Location    -33.4913647    -70.5134505
    Sleep    5s

Paso 2337
    Set Location    -33.4909954    -70.5136682
    Sleep    5s

Paso 2338
    Set Location    -33.4906428    -70.5145281
    Sleep    5s

Paso 2339
    Set Location    -33.4905987    -70.5145849
    Sleep    5s

Paso 2340
    Set Location    -33.4906017    -70.514585
    Sleep    5s

Paso 2341
    Set Location    -33.4903584    -70.515336
    Sleep    5s

Paso 2342
    Set Location    -33.4902542    -70.5156535
    Sleep    5s

Paso 2343
    Set Location    -33.4902585    -70.5156679
    Sleep    5s

Paso 2344
    Set Location    -33.4902328    -70.5157402
    Sleep    5s

Paso 2345
    Set Location    -33.4890456    -70.5168585
    Sleep    5s

Paso 2346
    Set Location    -33.4891711    -70.5173105
    Sleep    5s

Paso 2347
    Set Location    -33.4891181    -70.518497
    Sleep    5s

Paso 2348
    Set Location    -33.4889071    -70.5187526
    Sleep    5s

Paso 2349
    Set Location    -33.4877947    -70.5191855
    Sleep    5s

Paso 2350
    Set Location    -33.4873793    -70.5189807
    Sleep    5s

Paso 2351
    Set Location    -33.4866661    -70.5185628
    Sleep    5s

Paso 2352
    Set Location    -33.4863884    -70.5186109
    Sleep    5s

Paso 2353
    Set Location    -33.4863899    -70.51861
    Sleep    5s

Paso 2354
    Set Location    -33.48639    -70.51861
    Sleep    5s

Paso 2355
    Set Location    -33.48639    -70.51861
    Sleep    5s

Paso 2356
    Set Location    -33.4863595    -70.5187379
    Sleep    5s

Paso 2357
    Set Location    -33.4864777    -70.5188465
    Sleep    5s

Paso 2358
    Set Location    -33.4866553    -70.5189584
    Sleep    5s

Paso 2359
    Set Location    -33.4868879    -70.5191046
    Sleep    5s

Paso 2360
    Set Location    -33.4873318    -70.5193468
    Sleep    5s

Paso 2361
    Set Location    -33.4873317    -70.5193467
    Sleep    5s

Paso 2362
    Set Location    -33.4873317    -70.5193467
    Sleep    5s

Paso 2363
    Set Location    -33.4873941    -70.519377
    Sleep    5s

Paso 2364
    Set Location    -33.4877157    -70.5194365
    Sleep    5s

Paso 2365
    Set Location    -33.4879921    -70.5193768
    Sleep    5s

Paso 2366
    Set Location    -33.4882224    -70.519256
    Sleep    5s

Paso 2367
    Set Location    -33.4891721    -70.5186462
    Sleep    5s

Paso 2368
    Set Location    -33.4891528    -70.5183646
    Sleep    5s

Paso 2369
    Set Location    -33.4891723    -70.5180725
    Sleep    5s

Paso 2370
    Set Location    -33.4893057    -70.5177414
    Sleep    5s

Paso 2371
    Set Location    -33.4892279    -70.5173553
    Sleep    5s

Paso 2372
    Set Location    -33.4891151    -70.516969
    Sleep    5s

Paso 2373
    Set Location    -33.4890616    -70.516575
    Sleep    5s

Paso 2374
    Set Location    -33.4891274    -70.5162563
    Sleep    5s

Paso 2375
    Set Location    -33.4894105    -70.5161739
    Sleep    5s

Paso 2376
    Set Location    -33.4898327    -70.5161219
    Sleep    5s

Paso 2377
    Set Location    -33.4900495    -70.5162074
    Sleep    5s

Paso 2378
    Set Location    -33.4902192    -70.5160608
    Sleep    5s

Paso 2379
    Set Location    -33.490411    -70.5156738
    Sleep    5s

Paso 2380
    Set Location    -33.4905617    -70.5153328
    Sleep    5s

Paso 2381
    Set Location    -33.4908259    -70.5139981
    Sleep    5s

Paso 2382
    Set Location    -33.4909773    -70.5137364
    Sleep    5s

Paso 2383
    Set Location    -33.491294    -70.5135992
    Sleep    5s

Paso 2384
    Set Location    -33.4916575    -70.5133711
    Sleep    5s

Paso 2385
    Set Location    -33.4920613    -70.5135685
    Sleep    5s

Paso 2386
    Set Location    -33.4923986    -70.5135446
    Sleep    5s

Paso 2387
    Set Location    -33.4925195    -70.5134074
    Sleep    5s

Paso 2388
    Set Location    -33.4926157    -70.5132099
    Sleep    5s

Paso 2389
    Set Location    -33.4927552    -70.5130474
    Sleep    5s

Paso 2390
    Set Location    -33.49332    -70.5125778
    Sleep    5s

Paso 2391
    Set Location    -33.4935439    -70.5123824
    Sleep    5s

Paso 2392
    Set Location    -33.4937515    -70.5121428
    Sleep    5s

Paso 2393
    Set Location    -33.4939989    -70.511742
    Sleep    5s

Paso 2394
    Set Location    -33.493997    -70.5118162
    Sleep    5s

Paso 2395
    Set Location    -33.4939551    -70.5118182
    Sleep    5s

Paso 2396
    Set Location    -33.4938354    -70.5119504
    Sleep    5s

Paso 2397
    Set Location    -33.4937024    -70.512133
    Sleep    5s

Paso 2398
    Set Location    -33.4935485    -70.5122976
    Sleep    5s

Paso 2399
    Set Location    -33.4934996    -70.5123354
    Sleep    5s

Paso 2400
    Set Location    -33.4935031    -70.5123319
    Sleep    5s

Paso 2401
    Set Location    -33.4935033    -70.5123317
    Sleep    5s

Paso 2402
    Set Location    -33.4935033    -70.5123317
    Sleep    5s

Paso 2403
    Set Location    -33.4934696    -70.5123942
    Sleep    5s

Paso 2404
    Set Location    -33.4934062    -70.5124768
    Sleep    5s

Paso 2405
    Set Location    -33.4931763    -70.5126843
    Sleep    5s

Paso 2406
    Set Location    -33.4927975    -70.5129472
    Sleep    5s

Paso 2407
    Set Location    -33.4925206    -70.5132831
    Sleep    5s

Paso 2408
    Set Location    -33.4921911    -70.513557
    Sleep    5s

Paso 2409
    Set Location    -33.4918239    -70.5133991
    Sleep    5s

Paso 2410
    Set Location    -33.4914648    -70.5134057
    Sleep    5s

Paso 2411
    Set Location    -33.4910605    -70.5136561
    Sleep    5s

Paso 2412
    Set Location    -33.4908014    -70.5139157
    Sleep    5s

Paso 2413
    Set Location    -33.4907013    -70.5143216
    Sleep    5s

Paso 2414
    Set Location    -33.4907095    -70.5144949
    Sleep    5s

Paso 2415
    Set Location    -33.4907116    -70.5144902
    Sleep    5s

Paso 2416
    Set Location    -33.4907117    -70.51449
    Sleep    5s

Paso 2417
    Set Location    -33.4907117    -70.51449
    Sleep    5s

Paso 2418
    Set Location    -33.4907228    -70.5146133
    Sleep    5s

Paso 2419
    Set Location    -33.4906727    -70.5149572
    Sleep    5s

Paso 2420
    Set Location    -33.4904738    -70.5154042
    Sleep    5s

Paso 2421
    Set Location    -33.4901952    -70.5158085
    Sleep    5s

Paso 2422
    Set Location    -33.4898676    -70.5160198
    Sleep    5s

Paso 2423
    Set Location    -33.4893954    -70.5161144
    Sleep    5s

Paso 2424
    Set Location    -33.4890692    -70.5161844
    Sleep    5s

Paso 2425
    Set Location    -33.489008    -70.5166262
    Sleep    5s

Paso 2426
    Set Location    -33.4892217    -70.5179169
    Sleep    5s

Paso 2427
    Set Location    -33.4891171    -70.5183179
    Sleep    5s

Paso 2428
    Set Location    -33.4867572    -70.5190191
    Sleep    5s

Paso 2429
    Set Location    -33.4891651    -70.5185184
    Sleep    5s

Paso 2430
    Set Location    -33.4902773    -70.5158565
    Sleep    5s

Paso 2431
    Set Location    -33.4873311    -70.519367
    Sleep    5s

Paso 2432
    Set Location    -33.4891067    -70.5161187
    Sleep    5s

Paso 2433
    Set Location    -33.488121    -70.5192387
    Sleep    5s

Paso 2434
    Set Location    -33.4869548    -70.518776
    Sleep    5s

Paso 2435
    Set Location    -33.4891595    -70.5181166
    Sleep    5s

Paso 2436
    Set Location    -33.4904067    -70.5156513
    Sleep    5s

Paso 2437
    Set Location    -33.4874133    -70.5189933
    Sleep    5s

Paso 2438
    Set Location    -33.4874133    -70.5189933
    Sleep    5s

Paso 2439
    Set Location    -33.4874133    -70.5189933
    Sleep    5s

Paso 2440
    Set Location    -33.4873349    -70.5189401
    Sleep    5s

Paso 2441
    Set Location    -33.4872167    -70.5188693
    Sleep    5s

Paso 2442
    Set Location    -33.4870779    -70.5187876
    Sleep    5s

Paso 2443
    Set Location    -33.4868789    -70.518668
    Sleep    5s

Paso 2444
    Set Location    -33.4867172    -70.5185741
    Sleep    5s

Paso 2445
    Set Location    -33.4865956    -70.5185719
    Sleep    5s

Paso 2446
    Set Location    -33.4865701    -70.5185951
    Sleep    5s

Paso 2447
    Set Location    -33.4865716    -70.518595
    Sleep    5s

Paso 2448
    Set Location    -33.4865717    -70.518595
    Sleep    5s

Paso 2449
    Set Location    -33.4865237    -70.5186094
    Sleep    5s

Paso 2450
    Set Location    -33.4864418    -70.5185923
    Sleep    5s

Paso 2451
    Set Location    -33.4863905    -70.5186106
    Sleep    5s

Paso 2452
    Set Location    -33.4863917    -70.5186117
    Sleep    5s

Paso 2453
    Set Location    -33.4863917    -70.5186117
    Sleep    5s

Paso 2454
    Set Location    -33.48635    -70.5187235
    Sleep    5s

Paso 2455
    Set Location    -33.4864453    -70.5188198
    Sleep    5s

Paso 2456
    Set Location    -33.4865239    -70.5188805
    Sleep    5s

Paso 2457
    Set Location    -33.4865266    -70.5188817
    Sleep    5s

Paso 2458
    Set Location    -33.4865267    -70.5188817
    Sleep    5s

Paso 2459
    Set Location    -33.4867267    -70.518984
    Sleep    5s

Paso 2460
    Set Location    -33.4874082    -70.5194
    Sleep    5s

Paso 2461
    Set Location    -33.4874083    -70.5194
    Sleep    5s

Paso 2462
    Set Location    -33.4874083    -70.5194
    Sleep    5s

Paso 2463
    Set Location    -33.4874467    -70.519392
    Sleep    5s

Paso 2464
    Set Location    -33.4876285    -70.5194318
    Sleep    5s

Paso 2465
    Set Location    -33.4879047    -70.5194135
    Sleep    5s

Paso 2466
    Set Location    -33.4880782    -70.5193267
    Sleep    5s

Paso 2467
    Set Location    -33.488366    -70.5192203
    Sleep    5s

Paso 2468
    Set Location    -33.4886893    -70.5190219
    Sleep    5s

Paso 2469
    Set Location    -33.4889267    -70.5187801
    Sleep    5s

Paso 2470
    Set Location    -33.4890849    -70.5187166
    Sleep    5s

Paso 2471
    Set Location    -33.4891397    -70.5186906
    Sleep    5s

Paso 2472
    Set Location    -33.489161    -70.5184417
    Sleep    5s

Paso 2473
    Set Location    -33.4891507    -70.5181707
    Sleep    5s

Paso 2474
    Set Location    -33.4892656    -70.5178597
    Sleep    5s

Paso 2475
    Set Location    -33.4892671    -70.5175232
    Sleep    5s

Paso 2476
    Set Location    -33.4891657    -70.517154
    Sleep    5s

Paso 2477
    Set Location    -33.4890537    -70.5167686
    Sleep    5s

Paso 2478
    Set Location    -33.4890832    -70.5164124
    Sleep    5s

Paso 2479
    Set Location    -33.4892161    -70.5162028
    Sleep    5s

Paso 2480
    Set Location    -33.4895933    -70.516128
    Sleep    5s

Paso 2481
    Set Location    -33.4899303    -70.5161459
    Sleep    5s

Paso 2482
    Set Location    -33.489948    -70.5161617
    Sleep    5s

Paso 2483
    Set Location    -33.4900507    -70.5162032
    Sleep    5s

Paso 2484
    Set Location    -33.4901754    -70.5161181
    Sleep    5s

Paso 2485
    Set Location    -33.4903203    -70.515807
    Sleep    5s

Paso 2486
    Set Location    -33.4904885    -70.5154791
    Sleep    5s

Paso 2487
    Set Location    -33.4906249    -70.5151894
    Sleep    5s

Paso 2488
    Set Location    -33.4907341    -70.5148857
    Sleep    5s

Paso 2489
    Set Location    -33.490765    -70.5145194
    Sleep    5s

Paso 2490
    Set Location    -33.490779    -70.5141448
    Sleep    5s

Paso 2491
    Set Location    -33.490884    -70.5138454
    Sleep    5s

Paso 2492
    Set Location    -33.4911314    -70.5136548
    Sleep    5s

Paso 2493
    Set Location    -33.4914882    -70.513451
    Sleep    5s

Paso 2494
    Set Location    -33.4918988    -70.5134633
    Sleep    5s

Paso 2495
    Set Location    -33.4922694    -70.5135921
    Sleep    5s

Paso 2496
    Set Location    -33.4924601    -70.5134626
    Sleep    5s

Paso 2497
    Set Location    -33.4925545    -70.5133189
    Sleep    5s

Paso 2498
    Set Location    -33.4926434    -70.5131536
    Sleep    5s

Paso 2499
    Set Location    -33.4927335    -70.5130601
    Sleep    5s

Paso 2500
    Set Location    -33.492806    -70.5130102
    Sleep    5s

Paso 2501
    Set Location    -33.4928818    -70.5129412
    Sleep    5s

Paso 2502
    Set Location    -33.4929731    -70.512856
    Sleep    5s

Paso 2503
    Set Location    -33.4930748    -70.5127849
    Sleep    5s

Paso 2504
    Set Location    -33.4931863    -70.5127014
    Sleep    5s

Paso 2505
    Set Location    -33.4932901    -70.5126146
    Sleep    5s

Paso 2506
    Set Location    -33.4934004    -70.5125124
    Sleep    5s

Paso 2507
    Set Location    -33.4935147    -70.5124215
    Sleep    5s

Paso 2508
    Set Location    -33.4936219    -70.5123086
    Sleep    5s

Paso 2509
    Set Location    -33.4937366    -70.5121629
    Sleep    5s

Paso 2510
    Set Location    -33.4938489    -70.5120136
    Sleep    5s

Paso 2511
    Set Location    -33.4939661    -70.5118378
    Sleep    5s

Paso 2512
    Set Location    -33.4939956    -70.511708
    Sleep    5s

Paso 2513
    Set Location    -33.4939838    -70.5117533
    Sleep    5s

Paso 2514
    Set Location    -33.49398    -70.5118235
    Sleep    5s

Paso 2515
    Set Location    -33.4939529    -70.5118346
    Sleep    5s

Paso 2516
    Set Location    -33.4938175    -70.5119847
    Sleep    5s

Paso 2517
    Set Location    -33.4936496    -70.5121779
    Sleep    5s

Paso 2518
    Set Location    -33.4935149    -70.5123292
    Sleep    5s

Paso 2519
    Set Location    -33.4935211    -70.5123388
    Sleep    5s

Paso 2520
    Set Location    -33.4935232    -70.5123368
    Sleep    5s

Paso 2521
    Set Location    -33.4934784    -70.5122997
    Sleep    5s

Paso 2522
    Set Location    -33.4934671    -70.5122904
    Sleep    5s
