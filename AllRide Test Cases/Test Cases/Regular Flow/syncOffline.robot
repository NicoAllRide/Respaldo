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




*** Test Cases ***

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
    ...    data={"departures":[{"token":"","active":true,"boardings":0,"unboardings":0,"busCode":"OFF4","canResume":false,"capacity":3,"comments":"","communities":["653fd601f90509541a748683"],"communityId":"653fd601f90509541a748683","createdAt":"2024-06-21T00:00:02.000Z","customParams":[],"customParamsAtTheEnd":[],"direction":"","driverCode":"1712","driverId":"658b4c89f6f903bbee966467","driverName":"","enabledSeats":[{"available":false,"_id":"6674fac640e5ca0e494f041e","seat":"1"},{"available":true,"_id":"6674fac240e5ca0e494f03dd","seat":"2"},{"available":true,"_id":"6674fac240e5ca0e494f03de","seat":"3"}],"estimatedDistance":0,"_id":"","legs":[{"customParamsAtStart":[],"customParamsAtTheEnd":[],"driverId":"658b4c89f6f903bbee966467","endedAt":"2024-06-20T23:58:56.000Z","preTripChecklist":[],"realEndLocation":{"_id":"6674fac640e5ca0e494f041a","internalId":"6674fac640e5ca0e494f041a","lat":-34.39412,"lon":-70.78145},"realStartLocation":{"_id":"6674fac640e5ca0e494f0419","internalId":"6674fac640e5ca0e494f0419","lat":-34.39412,"lon":-70.781334},"startedAt":"2024-06-20T23:58:18.000Z","type":"service"}],"name":"","odd":false,"oddType":"","offlineSync":{"historical":["2024-06-21T00:00:06.000Z"],"internalId":"8a18f615-ba51-4cbd-b82c-9c05a9a4a7b2","synced":false},"passengersLinked":[],"passengersToLink":[],"preTripChecklist":[],"previouslyActive":false,"realStartLocation":{"_id":"6674fac240e5ca0e494f03df","lat":-34.39411,"lon":-70.78142},"reservations":[{},{}],"rounds":0,"routeId":"65faf386137abd9662f15a45","routeName":"","scheduled":false,"serviceDate":"2024-06-21T00:00:02.000Z","startCapacity":3,"startLocation":{"_id":"6674fac240e5ca0e494f03df","lat":-34.39411,"lon":-70.78142},"startedAt":"2024-06-21T00:00:02.000Z","state":"","superCommunityId":"653fd68233d83952fafcd4be","tickets":0,"validations":[],"vehicleId":"65b8f0f820443b7f47d682f5","vehiclePlate":""}],"validations":[{"assignedSeat":"1","barCode":"","cardId":"","communityId":"653fd601f90509541a748683","createdAt":"2024-06-21T15:22:48.956-03:00","customQRValidation":"","departureId":"653fd68233d83952fafcd4be","token":"","_id":"653fd68233d83952fafcd4be","isDNI":false,"latitude":-33.454567,"loc":[-70.5933,-33.454567],"longitude":-70.5933,"qrCode":"cbbd65681c343f912f57f7ac4283a7326fd4e07a8788dd6ce8db3760761120d70368401e0a631bb4608edfbd0a9394586918af6bc8110e9202f30c17ff99195965e8e076337a90a35ba6e8dd","reason":[],"remainingTickets":0,"routeId":"65faf386137abd9662f15a45","synced":true,"updatedAt":"2024-06-21T15:22:48.956-03:00","userId":"65e8e076337a90a35ba6e8dd","validated":true}],"events":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Sync Only Validations Offline
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/validations/sync/653fd601f90509541a748683
    ...    data={"validations":[{"assignedSeat":"1","barCode":"","cardId":"","communityId":"653fd601f90509541a748683","createdAt":"2024-06-21T04:31:00.161Z","departureId":"6675c3fbf2d60804ca6eca0f","token":"","_id":"65e8e076337a90a35ba6e8dd","isDNI":false,"latitude":-38.765217,"loc":[-38.765217,-72.60713],"longitude":-72.60713,"qrCode":"cbbd65681c343f912f57f7ac4283a7326fd4e07a8788dd6ce8db3760761120d7447c5e717c38f78750510844ef81b99ad455535806506e25b576df52b46454db65e8e076337a90a35ba6e8dd","reason":[],"remainingTickets":0,"routeId":"65e8827b110e5655e1583a45","synced":false,"updatedAt":"2024-06-21T04:31:00.161Z","userId":null,"validated":true}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
