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
Generate random UUID2 (_id validations qrValidations)
    ${uuid_qr2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_qr2}
    Set Global Variable    ${uuid_qr2}
Generate random UUID2 Cédula (_id validations qrValidations)
    ${uuid_dni}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_dni}
    Set Global Variable    ${uuid_dni}
Generate random UUID (_id events1)
    ${uuid_events}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_events}
    Set Global Variable    ${uuid_events}
Generate random UUID (_id events2)
    ${uuid_events2}=    Evaluate    str(uuid.uuid4())
    Log    ${uuid_events2}
    Set Global Variable    ${uuid_events2}

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
Get User QR(Kratos)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad}
    ...    data={"ids":["${idKratos}"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeKratos}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeKratos}
    Log    ${qrCodeKratos}
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

Assing Tickets(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=${idNico}&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Sleep    10s

Assing Tickets(Pedro)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=${idPedro}&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Sleep    10s

Assing Tickets(Kratos)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=${idKratos}&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
Assing Tickets(dni)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/ticket/assign?community=${idComunidad}&userId=653ff52433d83952fafcf397&adminId=${idAdmin}&adminLevel=2&ticketsQuantityToAssign=${assignQty}
    ...    data={}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Sync Departures Offline(Create departure, sync as active false departure)
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=${CRIS_URL}/api/v2/pb/driver/departures/sync/${idSuperCommunity}
    ...    data=
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    
    Should Not Be Empty    ${response.json()}
    Status Should Be    200

    #--------------------DEPARTURE-------------------##
    ${departureId}=     Set Variable      ${response.json()}[departures][0][_id]
    Set Global Variable    ${departureId}
    ##${is int}=      Evaluate     isinstance(${departureId}, int) 
    ${departureToken}=     Set Variable     ${response.json()}[departures][0][token]
    Set Global Variable    ${departureToken}
    ${driverCodeResponse}=     Set Variable    ${response.json()}[departures][0][driverCode]
    Should Be Equal As Strings    ${driverCodeResponse}    1712
    ${superCommunityId}=     Set Variable    ${response.json()}[departures][0][superCommunityId]
    Should Be Equal As Strings    ${superCommunityId}    653fd68233d83952fafcd4be
    ${communityId}=     Set Variable    ${response.json()}[departures][0][communityId]
    Should Be Equal As Strings    ${communityId}    653fd601f90509541a748683
    ${boardings}=    Set Variable        ${response.json()}[departures][0][boardings]
    Should Be Equal As Numbers    ${boardings}    1
    ${unboardings}=    Set Variable        ${response.json()}[departures][0][unboardings]
    Should Be Equal As Numbers    ${unboardings}    1
    ${state_Active}=    Set Variable        ${response.json()}[departures][0][active]
    Should Be Equal As Strings    ${state_Active}    False
    ${superCommunities}=    Set Variable        ${response.json()}[departures][0][superCommunities][0]
    Should Be Equal As Strings    ${superCommunities}    653fd68233d83952fafcd4be
    ${communities}=    Set Variable        ${response.json()}[departures][0][communities][0]
    Should Be Equal As Strings    ${communities}    653fd601f90509541a748683
    ${driverId}=    Set Variable        ${response.json()}[departures][0][driverId]
    Should Be Equal As Strings    ${driverId}    658b4c89f6f903bbee966467
    ${routeId}=    Set Variable        ${response.json()}[departures][0][routeId]
    Should Be Equal As Strings    ${routeId}    670e7eee96855505c81c2e4d
    ${offlineSync}=    Set Variable        ${response.json()}[departures][0][offlineSync][historical]
    Length Should Be    ${offlineSync}    1
    ${offlineSyncId}=    Set Variable    ${response.json()}[departures][0][offlineSync][_id]
    ${offlineSync_synced}=    Set Variable        ${response.json()}[departures][0][offlineSync][synced]
    Should Be Equal As Strings    ${offlineSync_synced}    True
    ${offlineSync_internalId}=    Set Variable        ${response.json()}[departures][0][offlineSync][internalId] 
    ${legs}=    Set Variable        ${response.json()}[departures][0][legs][0]
    ${legs_startLocation}=    Set Variable        ${response.json()}[departures][0][legs][0][startLocation][_id]
    ${legs_endLocation}=    Set Variable        ${response.json()}[departures][0][legs][0][endLocation][_id]
    ${legs_preTripCheckList}=    Set Variable        ${response.json()}[departures][0][legs][0][preTripChecklist]
    #${legs_customParamsAtStart}=    Set Variable        ${response.json()}[departures][0][legs][0][customParamsAtStart]
   # ${legs_customParamsAtEnd}=    Set Variable        ${response.json()}[departures][0][legs][0][customParamsAtEnd]
    Should Be Equal As Strings    ${driverCodeResponse}    1712
    ${preTripCheckList}=    Set Variable        ${response.json()}[departures][0][preTripChecklist]
    ${customParams}=    Set Variable        ${response.json()}[departures][0][customParams]
    Length Should Be    ${customParams}      1
    ${customParams_Value}=    Set Variable        ${response.json()}[departures][0][customParams][0][value]
    Should Be Equal As Numbers    ${customParams_Value}    1
    ${customParamsAtEnd}=    Set Variable        ${response.json()}[departures][0][customParamsAtTheEnd]
    Length Should Be    ${customParamsAtEnd}    1
    ${customParamsAtEnd_Value}=    Set Variable        ${response.json()}[departures][0][customParamsAtTheEnd][0][value]
    Should Be Equal As Numbers    ${customParamsAtEnd_Value}    2 
    ${vehicleId}=    Set Variable        ${response.json()}[departures][0][vehicleId]
    Should Be Equal As Strings    ${vehicleId}      65b13780fd1711a264653aa1

    #--------------------EVENTS-------------------------------------------------##
    ${eventsLength}=    Set Variable    ${response.json()}[events]
    Length Should Be    ${eventsLength}    2
    ${eventsBoarding}=    Set Variable    ${response.json()}[events][0][type]
    Should Be Equal As Strings    ${eventsBoarding}    boarding
    ${eventsUnBoarding}=    Set Variable    ${response.json()}[events][1][type]
    Should Be Equal As Strings    ${eventsUnBoarding}    unboarding
    
    #--------------------Validations------------------------#

    ${validations}=    Set Variable    ${response.json()}[validations]
    FOR    ${validation}    IN    @{validations}
        Should Not Be Empty    ${validation}        Validations info is empty
        ${validated}=    Set Variable    ${validation}[validated]
        Should Be Equal As Strings    ${validated}    True    Expected validation to be true, but it was false.
        ${reasons}=    Set Variable    ${validation}[reason]
        Run Keyword If    'manual_validation' in ${reasons}    Should Contain    ${reasons}    offline_validation
        Run Keyword If    'custom' in ${reasons}    Should Contain    ${reasons}    offline_validation
        Run Keyword If    'manual_validation' not in ${reasons} and 'custom' not in ${reasons}    Should Be Equal As Strings    ${reasons}[0]    offline_validation
        ${synced}=    Set Variable    ${validation}[synced]
        Should Be Equal As Strings    ${synced}    True
    END

    Sleep    5s

Get Assigned Tickets After Validation(Nico)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyNico}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "${idNico}"    BREAK
        Set Global Variable    ${assignedQtyNico}
    END
    Convert To Integer    ${assignedQtyNico}
    ${assignQtyMinus}=    Evaluate    ${assignQty}-1
    Convert To Integer    ${assignQtyMinus}
    Should Be True    ${assignedQtyNico}==${assignQtyMinus}         Doesn't discounts tickets after validation with QR, Expected tickets: ${assignQtyMinus}, Actual Tickets ${assignedQtyNico}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyNico}

Get Assigned Tickets After Validation(Pedro)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyPedro}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "${idPedro}"    BREAK
        Set Global Variable    ${assignedQtyPedro}
    END
    Convert To Integer    ${assignedQtyPedro}
    Convert To Integer    ${assignQty}
    Should Be True    ${assignedQtyPedro}==(${assignQty}-1)        Assigned quantity Pedro is not correct, should be ${assignQty} but it is ${assignedQtyPedro}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyPedro}

Get Assigned Tickets After Validation(DNI)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/ticket/assigned/list?community=653fd601f90509541a748683&productId=6756633eaa9f4e162d084819
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}
    ${assignedQty}=    Set Variable    None

    # Obtenemos la cantidad de objetos de scheduledServices
    ${num_user_tickets}=    Get Length    ${responseJson}

    # Iteramos sobre los objetos de scheduledServices
    FOR    ${index}    IN RANGE    ${num_user_tickets}
        ${user}=    Set Variable    ${responseJson[${index}]}
        ${assignedQtyDNI}=    Set Variable    ${user}[availableTickets]
        IF    "${user}[id]" == "653ff52433d83952fafcf397"    BREAK
        Set Global Variable    ${assignedQtyDNI}
    END
    Convert To Integer    ${assignedQtyDNI}
    Convert To Integer    ${assignQty}
    Should Be True    ${assignedQtyDNI}==(${assignQty}-1)        Assigned quantity Pedro is not correct, should be ${assignQty} but it is ${assignedQtyDNI}

    # Si no se encuentra el service_id_tickets, registramos un mensaje
    Log    ${assignedQtyDNI}


Get Departure in admin, should be active false
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/departures/${departureId}?community=653fd601f90509541a748683


    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${responseJson}=    Set Variable    ${response.json()}
    ${activeDeparture}=    Set Variable    ${responseJson}[active]
    Should Be Equal As Strings    ${activeDeparture}    False
    ${boardings}=    Set Variable    ${responseJson}[boardings]
    Should Be Equal As Numbers    ${boardings}    1
    ${unboarding}=    Set Variable

    Log    ${response.content}

Sync Only Validations
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenDriver}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departures/sync/${idComunidad}
    ...    data={"validations":[{"assignedSeat":"3","communityId":"653fd601f90509541a748683","createdAt":"2024-06-28T15:48:27.139-04:00","departureId":"${departureId}","_id":"${uuid_qr2}","isCustom":false,"isDNI":false,"isManual":false,"latitude":-34.394115,"loc":[-70.78126,-34.394115],"longitude":-70.78126,"qrCode":"${qrCodeKratos}","reason":[],"remainingTickets":0,"routeId":"670e7eee96855505c81c2e4d","synced":false,"token":"","userId":"${idKratos}","validated":true}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Stop Departure With Post Leg
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${departureToken}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/stop
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":true,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Stop Post Leg Departure
    skip

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${departureToken}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/stop
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":false,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Check Payment Settlement (3 electronic tickets)

    ${url}=    Set Variable
    ...    https://stage.allrideapp.com/api/v1/admin/pb/paymentSettlement/list?community=653fd601f90509541a748683&search=&from=0

    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Extrae directamente el objeto que sea type == electronicTicket
    ${electronicTicket}=    Evaluate    [m for m in ${responseJson}[paymentSettlement][0][paymentMethods] if m['type'] == 'electronicTicket'][0]    json

# Ahora ya tienes el objeto electronicTicket y puedes trabajar directo
    ${ticketqty}=    Set Variable    ${electronicTicket}[quantity]
    ${settlementId}=    Set Variable    ${responseJson}[paymentSettlement][0][_id]

    #Should Be Equal As Strings    ${electronicTicket}[type]    electronicTicket
  #  Should Be Equal As Numbers    ${ticketqty}    3    There should be 3 electronic tickets, but there are ${ticketqty} in https://stage.allrideapp.com/api/v1/admin/pb/paymentSettlement/?community=653fd601f90509541a748683&settlementId=${settlementId}
   # Should Be Equal As Numbers    ${electronicTicket}[value]    10    msg=❌ 'electronicTicket.value' should be 10, but was ${electronicTicket}[value]

   # ${paymentSettlement}=    Set Variable    ${responseJson}[paymentSettlement][0]
   # ${driverCode}=    Set Variable    ${paymentSettlement}[driverCode]

  #  Should Contain    ${paymentSettlement}    driverCode    No driverCode found
  #  Should Be Equal As Strings    ${driverCode}    1712    driverCode should be 1712 but it is ${driverCode}

