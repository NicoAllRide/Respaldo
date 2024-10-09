*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../Variables/variablesStage.robot
Library     uuid


*** Test Cases ***
Generate random UUID (DepartureId)
    ${uuid}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid}
    Set Global Variable    ${uuid}

Generate random UUID (_id Manual validations)
    ${uuid_manual}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_manual}
    Set Global Variable    ${uuid_manual}

Generate random UUID (_id validations customValidations)
    ${uuid_custom}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_custom}
    Set Global Variable    ${uuid_custom}

Generate random UUID (_id validations qrValidations)
    ${uuid_qr}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr}
    Set Global Variable    ${uuid_qr}

Get User QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["${idNico}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}

Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad}&driverId=658b4c89f6f903bbee966467

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver}

    Log    ${tokenDriver}
    Log    ${response.content}

Sync Departures Offline(endPoint Test)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/sync/653fd601f90509541a748683
    ...    data={"departures":[{"active":true,"boardings":1,"busCode":"0602","canResume":false,"capacity":40,"communities":["653fd601f90509541a748683"],"communityId":"653fd601f90509541a748683","createdAt":"2024-10-08T15:47:32.216-04:00","customParams":[],"customParamsAtTheEnd":[],"direction":"","driverCode":"1712","driverId":"658b4c89f6f903bbee966467","drivers":[],"enabledSeats":[{"available":false,"_id":"667f244c738bca04e08a02e6","seat":"1","userId":"65e092afca7842b1032f12e2"},{"available":false,"_id":"667f244c738bca04e08a02e7","seat":"2","userId":"654a5148bf3e9410d0bcd39a"},{"available":false,"_id":"667f244c738bca04e08a02e8","seat":"3","userId":"663ccf399a0c214e3398f5cd"},{"available":false,"_id":"667f244c738bca04e08a02e9","seat":"4","userId":"661d508c72418a2e98cf7978"},{"available":true,"_id":"667f244c738bca04e08a02ea","seat":"5"},{"available":true,"_id":"667f244c738bca04e08a02eb","seat":"6"},{"available":true,"_id":"667f244c738bca04e08a02ec","seat":"7"},{"available":true,"_id":"667f244c738bca04e08a02ed","seat":"8"},{"available":true,"_id":"667f244c738bca04e08a02ee","seat":"9"},{"available":true,"_id":"667f244c738bca04e08a02ef","seat":"10"},{"available":true,"_id":"667f244c738bca04e08a02f0","seat":"11"},{"available":true,"_id":"667f244c738bca04e08a02f1","seat":"12"},{"available":true,"_id":"667f244c738bca04e08a02f2","seat":"13"},{"available":true,"_id":"667f244c738bca04e08a02f3","seat":"14"},{"available":true,"_id":"667f244c738bca04e08a02f4","seat":"15"},{"available":true,"_id":"667f244c738bca04e08a02f5","seat":"16"},{"available":true,"_id":"667f244c738bca04e08a02f6","seat":"17"},{"available":true,"_id":"667f244c738bca04e08a02f7","seat":"18"},{"available":true,"_id":"667f244c738bca04e08a02f8","seat":"19"},{"available":true,"_id":"667f244c738bca04e08a02f9","seat":"20"},{"available":true,"_id":"667f244c738bca04e08a02fa","seat":"21"},{"available":true,"_id":"667f244c738bca04e08a02fb","seat":"22"},{"available":true,"_id":"667f244c738bca04e08a02fc","seat":"23"},{"available":true,"_id":"667f244c738bca04e08a02fd","seat":"24"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"25"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"26"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"27"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"28"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"29"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"30"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"31"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"32"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"33"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"34"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"35"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"36"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"37"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"38"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"39"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"40"},{"available":true,"_id":"667f244c738bca04e08a02fe","seat":"41"},{"available":false,"_id":"667f244c738bca04e08a02fe","seat":"42"}],"estimatedDistance":0,"_id":"","internal":false,"legs":[{"startLocation":{"lat":-34.394115,"lon":-70.78126},"endLocation":{"lat":-34.395,"lon":-70.782}}],"name":"","odd":false,"oddType":"","offlineSync":{"historical":[],"internalId":"${uuid}","synced":false},"passengersLinked":[],"passengersToLink":[],"preTripChecklist":[],"previouslyActive":false,"realStartLocation":{"_id":"","internalId":"c60b8cb6-c269-49e1-a6bf-4d1d10598bADb","lat":-34.394115,"lon":-70.78126},"reason":"","reservations":[],"rounds":0,"routeId":"65e88349110e5655e1583ca6","scheduled":false,"startCapacity":42,"startLocation":{"_id":"","internalId":"448aac16-9362-4385-9b6f-110b174c7b60","lat":-34.394115,"lon":-70.78126},"startedAt":"2024-06-28T15:47:32.216-04:00","state":"","superCommunityId":"653fd68233d83952fafcd4be","tickets":0,"token":"","unboardings":1,"validations":[],"vehicleId":"65b13780fd1711a264653aa1"}],"validations":[{"assignedSeat":"","communityId":"653fd601f90509541a748683","createdAt":"2024-10-08T19:35:10.885Z","departureId":"${uuid}","_id":"${uuid_manual}","isCustom":false,"isDNI":false,"isManual":true,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"","reason":["manual_validation"],"remainingTickets":0,"routeId":"65e88349110e5655e1583ca6","synced":false,"token":"","userId":"","validated":true},{"assignedSeat":"2","communityId":"653fd601f90509541a748683","createdAt":"2024-10-08T19:35:10.885Z","departureId":"${uuid}","_id":"${uuid_custom}","isCustom":true,"isDNI":false,"isManual":false,"key":"rut","latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"","reason":["custom"],"remainingTickets":0,"routeId":"65e88349110e5655e1583ca6","synced":false,"token":"","userId":"654a5148bf3e9410d0bcd39a","validated":true,"value":"126278489"},{"assignedSeat":"3","communityId":"653fd601f90509541a748683","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${uuid}","_id":"${uuid_qr}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeNico}","reason":[],"remainingTickets":0,"routeId":"65e88349110e5655e1583ca6","synced":false,"token":"","userId":"${idNico}","validated":true}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
