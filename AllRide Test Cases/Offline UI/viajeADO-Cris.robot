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

Round Full Online
    [Documentation]    Prueba ADO
    Open Application
    ...    http://127.0.0.1:4723
    ...    appium:automationName=UiAutomator2
    ...    appium:platformName=Android
    ...    appium:newCommandTimeout=${3600}
    ...    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.buses

Paso 1
  Set Location    -33.5419806     -70.6365104
  Sleep    6s
Paso 2
  Set Location    -33.5415068     -70.6400348
  Sleep    6s
Paso 3
  Set Location    -33.5407746     -70.6445854
  Sleep    6s
Paso 4
  Set Location    -33.5401846     -70.6479434
  Sleep    6s
Paso 5
  Set Location    -33.5391216     -70.6541088
  Sleep    6s
Paso 6
  Set Location    -33.5391772     -70.6582223
  Sleep    6s
Paso 7
  Set Location    -33.5379011     -70.6668797
  Sleep    6s
Paso 8
  Set Location    -33.5372447     -70.6636416
  Sleep    6s
Paso 9
  Set Location    -33.5371877     -70.6669292
  Sleep    6s
Paso 10
  Set Location    -33.5358918     -70.6706626
  Sleep    6s
Paso 11
  Set Location    -33.533905     -70.6744898
  Sleep    6s
Paso 12
  Set Location    -33.5337571     -70.6781034
  Sleep    6s
Paso 13
  Set Location    -33.5317468     -70.6836438
  Sleep    6s
Paso 14
  Set Location    -33.5275523     -70.6906966
  Sleep    6s
Paso 15
  Set Location    -33.5255276     -70.6940729
  Sleep    6s
Paso 16
  Set Location    -33.5236064     -70.6970903
  Sleep    6s
Paso 17
  Set Location    -33.5216761     -70.699452
  Sleep    6s
Paso 18
  Set Location    -33.5197221     -70.7020397
  Sleep    6s
Paso 19
  Set Location    -33.5181161     -70.7050812
  Sleep    6s
Paso 20
  Set Location    -33.5177476     -70.7114814
  Sleep    6s
Paso 21
  Set Location    -33.5150274     -70.70984
  Sleep    6s
Paso 22
  Set Location    -33.516051     -70.7173355
  Sleep    6s
Paso 23
  Set Location    -33.5126343     -70.7214115
  Sleep    6s
Paso 24
  Set Location    -33.508631     -70.7243634
  Sleep    6s
Paso 25
  Set Location    -33.5059531     -70.7298526
  Sleep    6s
Paso 26
  Set Location    -33.5049984     -70.7336691
  Sleep    6s
Paso 27
  Set Location    -33.5026257     -70.7409476
  Sleep    6s
Paso 28
  Set Location    -33.5002606     -70.7429961
  Sleep    6s
Paso 29
  Set Location    -33.4978409     -70.7449197
  Sleep    6s
Paso 30
  Set Location    -33.4949821     -70.7471267
  Sleep    6s
Paso 31
  Set Location    -33.4920378     -70.7474147
  Sleep    6s
Paso 32
  Set Location    -33.4947862     -70.7481053
  Sleep    6s
Paso 33
  Set Location    -33.4870298     -70.7519282
  Sleep    6s
Paso 34
  Set Location    -33.4836129     -70.7533852
  Sleep    6s
Paso 35
  Set Location    -33.4801364     -70.7554314
  Sleep    6s
Paso 36
  Set Location    -33.4775666     -70.7567809
  Sleep    6s
Paso 37
  Set Location    -33.4729691     -70.7581989
  Sleep    6s
Paso 38
  Set Location    -33.4696089     -70.7608517
  Sleep    6s
Paso 39
  Set Location    -33.4668956     -70.7618699
  Sleep    6s
Paso 40
  Set Location    -33.461875     -70.7636019
  Sleep    6s
Paso 41
  Set Location    -33.4582999     -70.7647198
  Sleep    6s
Paso 42
  Set Location    -33.4558972     -70.7671326
  Sleep    6s
Paso 43
  Set Location    -33.4535078     -70.7697041
  Sleep    6s
Paso 44
  Set Location    -33.4498016     -70.7761351
  Sleep    6s
Paso 45
  Set Location    -33.4461834     -70.7774349
  Sleep    6s
Paso 46
  Set Location    -33.4501366     -70.7761411
  Sleep    6s
Paso 47
  Set Location    -33.4461699     -70.777428
  Sleep    6s
Paso 48
  Set Location    -33.4506186     -70.7758777
  Sleep    6s
Paso 49
  Set Location    -33.4464708     -70.7787469
  Sleep    6s
Paso 50
  Set Location    -33.4447382     -70.7819207
  Sleep    6s
Paso 51
  Set Location    -33.4440548     -70.7854264
  Sleep    6s
Paso 52
  Set Location    -33.4448706     -70.7816552
  Sleep    6s
Paso 53
  Set Location    -33.4499905     -70.7764256
  Sleep    6s
Paso 54
  Set Location    -33.4514844     -70.7716662
  Sleep    6s
Paso 55
  Set Location    -33.4529688     -70.7744131
  Sleep    6s
Paso 56
  Set Location    -33.4560175     -70.7747225
  Sleep    6s
Paso 57
  Set Location    -33.4579061     -70.7783039
  Sleep    6s
Paso 58
  Set Location    -33.4581209     -70.7817282
  Sleep    6s
Paso 59
  Set Location    -33.4591961     -70.7862286
  Sleep    6s
