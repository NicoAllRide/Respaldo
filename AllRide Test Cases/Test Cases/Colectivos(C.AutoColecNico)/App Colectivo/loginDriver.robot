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


*** Test Cases ***

Get Drivers List From admin
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/cp/drivers/list?community=${colectivoIdComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${driverIdAdmin}=    Set Variable    ${response.json()}[0][_id]
    Set Global Variable    ${driverIdAdmin}
    #---añadir si es necesario más info desde el admin--#
    

Login driver
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/cp/driver/login
    ...    data={"device":{"appVersion":"40","brand":"motorola","build":"40","lang":"es","manufacturer":"motorola","model":"moto g71 5G","token":""},"password":"Lolowerty21","phone":"56976493312","socialId":"mDhTxHGU7KNtCm2K0F2V6ShXsu23"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    ${responeJson}=    Set Variable    ${response.json()}

    # ------------------Agregar cuenta, Agregar Vehiculo y luego Login, estos deben ir en un solo archivo robot para mantener las variables------------------------------#

    # ------------Chekear Comunidad---------------#
    ${taxiCommunityId}=    Set Variable     ${responeJson}[auth][communities][0]
    Should Be Equal As Strings    ${taxiCommunityId}    ${colectivoIdComunidad}
    # ------------Chekear Ruta Obtener con el GET---------------#
    ${routeIdLogin}=    Set Variable    ${responeJson}[auth][routes][0]
    Should Be Equal As Strings    ${routeIdLogin}    666b2bd9bfaab8adfaf53f25
    # ------------Chekear ID Conductor Obtener y comprar con el GET---------------#
    ${driverId}=    Set Variable    ${responeJson}[auth][_id]
    Should Be Equal As Strings    ${driverId}    ${driverIdAdmin}

    # ------------Chekear Social ID x.auth.socialServices[0].socialId Que no esté vacío---------------#
    ${socialId}=    Set Variable    ${responeJson}[auth][socialServices][0][socialId]
    Should Not Be Empty    ${socialId}

    # ------------Chekear Numero De social services x.auth.socialServices[0].number Que sea igual a Phone---------------#
    ${socialNumber}=    Set Variable    ${responeJson}[auth][socialServices][0][number]
    Should Be Equal As Strings    ${socialNumber}    56976493312

    # ------------Chekear Identifier que debe ser igual al RUT del conductor(Get info driver desde admin y pasar variable global con info) x.auth.identifier---------------#
    ${driverIdentifier}=    Set Variable    ${responeJson}[auth][identifier]
    Should Be Equal As Strings    ${driverIdentifier}    123456755-8

    # ------------Chekear Phone que debe ser igual al Phone del conductor(Get info driver desde admin y pasar variable global con info) x.auth.phone---------------#
    ${driverPhone}=    Set Variable    ${responeJson}[auth][phone]
    Should Be Equal As Strings    ${driverPhone}    56976493312

    #------------------Access Token----------------------------------#
    ${tokenDriver}=    Set Variable    ${responeJson}[auth][accessToken]
    ${accessTokenDriver}=    Evaluate    "Bearer " + "${tokenDriver}"
    Set Global Variable    ${accessTokenDriver}


Add account
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer 431ebc745ef546652db88b752dbe79b2fff291c87db2d18b66b4b820649bdbfc2d23a1d9a5b5c82dc908173849af3111765c66b8fe47757b9e49ebf15bccac16     Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/cp/driver/bank
    ...    data={"accountNumber":"1591591598","accountType":"Cuenta Corriente","name":"Nicolas Bustamante","rut":"12345675582332"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    ${responeJson}=    Set Variable    ${response.json()}
    ${bankAccountId}=    Set Variable    ${responeJson}[bankAccount][_id]
    ${accountNumber}=    Set Variable    ${responeJson}[bankAccount][accountNumber]
    Should Be Equal As Integers    ${accountNumber}    1591591598
    ${accountType}=    Set Variable    ${responeJson}[bankAccount][accountType]
    Should Be Equal As Strings    ${accountType}    Cuenta Corriente
    ${accountRut}=    Set Variable    ${responeJson}[bankAccount][rut]
    Should Be Equal As Strings    ${accountRut}    12345675582332

Get Full Routes Info As Driver
    #---------------Va a ser necesario poner todos los pasos de creacion de colectivo para poder corroborar que se mantengan los datos-------------------------#
    # Define la URL 
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/cp/fullRoutes

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer 431ebc745ef546652db88b752dbe79b2fff291c87db2d18b66b4b820649bdbfc2d23a1d9a5b5c82dc908173849af3111765c66b8fe47757b9e49ebf15bccac16

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado
    Should Be Equal As Numbers    ${response.status_code}    200

    ${routeIdApp}=    Set Variable    ${response.json()}[0][_id]
    Set Global Variable    ${routeIdApp}
    Should Be Equal As Strings    ${routeIdApp}    666b2bd9bfaab8adfaf53f25

Start Route As Driver
        Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer 1f7169231ec36bc77996f1f880649e9e0d6fded6955552bca71d1878fd51c868acfaa3295ad24bf58c230e165e43de1956930a7ec6d33d90623422b18b1df35f     Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/cp/round
    ...    data={"routeId":"666b2bd9bfaab8adfaf53f25"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${routeIdActive}=    Set Variable    ${response.json()}[routeId]
    ##Should Be Equal As Strings    ${routeIdActive}    ${routeIdApp}

    ${driverIdActive}=    Set Variable    ${response.json()}[driverId]
   ## Should Be Equal As Strings    ${driverIdActive}    ${driverIdAdmin}

    ${sharedDepartureId}=    Set Variable    ${response.json()}[_id]
    ##Set Global Variable    ${sharedDepartureId}

    ${activeDepartureState}=     Set Variable    ${response.json()}[active]
    ##Should Be Equal As Strings    ${activeDepartureState}    True

Get Active Departures
    #---------------Va a ser necesario poner todos los pasos de creacion de colectivo para poder corroborar que se mantengan los datos-------------------------#
    # Define la URL 
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/cp/activeRound

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer 1f7169231ec36bc77996f1f880649e9e0d6fded6955552bca71d1878fd51c868acfaa3295ad24bf58c230e165e43de1956930a7ec6d33d90623422b18b1df35f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado
    Should Be Equal As Numbers    ${response.status_code}    200

    ${responseJson}=   Set Variable     ${response.json()}
    ${activeDepartureId}=    Set Variable    ${responseJson}[_id]
    ${activeDepartureRoute}=    Set Variable    ${responseJson}[routeId]
    Should Be Equal As Strings    ${activeDepartureRoute}    666b2bd9bfaab8adfaf53f25

Add Vehicle
    Skip

    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer 1f7169231ec36bc77996f1f880649e9e0d6fded6955552bca71d1878fd51c868acfaa3295ad24bf58c230e165e43de1956930a7ec6d33d90623422b18b1df35f     Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/cp/driver/car/66724cc4b34e9ee19093274e
    ...    data={"brand":"Toyota","model":"Yaris","year":"1995","plate":"NICO"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

Get Driver SelfInfo
        #---------------Va a ser necesario poner todos los pasos de creacion de colectivo para poder corroborar que se mantengan los datos-------------------------#
    # Define la URL 
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/cp/me

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=Bearer 1f7169231ec36bc77996f1f880649e9e0d6fded6955552bca71d1878fd51c868acfaa3295ad24bf58c230e165e43de1956930a7ec6d33d90623422b18b1df35f

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado
    Should Be Equal As Numbers    ${response.status_code}    200

#------------------------Crear salida para asociar
# Buscar ruta para asociar
# Asociar la ruta recien creada
# ---------------------------------------------#
