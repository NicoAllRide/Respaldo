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
    Should Be Equal As Strings    ${driverId}    666b2e04bd68f8d0735c8f9d

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
