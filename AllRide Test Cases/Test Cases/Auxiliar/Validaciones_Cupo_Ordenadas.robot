
Login Parking
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/device/register
    ...    data={"build":"3","communityId":"6654ae4eba54fe502d4e4187","deviceId":"15af83c4-0603-437e-aeb3-f758fd492a9d","model":"SM-G780G","notificationToken":"fQNNDHrkTFmguYGm5NZ3B1:APA91bEhltZ9FwPhnPs5S1X-E-BqY0r9KPgosqXp0Fjo6Ns8cjx_DQWfMyP2Q0zBkQBR0mirNW0dS3QVb96GE7d8rZCNO9Z37Ls1EP48DyqxQlMolEPHr0k"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessTokenParking}=    Set Variable    ${json}[accessToken]
    Set Global Variable    ${accessTokenParking}

Get User QR(User2 carpool)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["68b7576fc6280f9b167a25c8"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUserCarpool2}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUserCarpool2}
    Log    ${qrCodeUserCarpool2}
    Log    ${code}
Get User QR(User1 carpool)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["68a75a4e7811f4c78b962442"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUserCarpool1}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUserCarpool1}
    Log    ${qrCodeUserCarpool1}
    Log    ${code}
Get User QR(User No Carpool)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["66e30a06e2b22c7d017bb492"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUserNoCarpool}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUserNoCarpool}
    Log    ${qrCodeUserNoCarpool}
    Log    ${code}
Validate parking(user carpool1 should be able to validate)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/entry
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserCarpool1}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}
Validate parking(user carpool2 should not able to validate No space left)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/entry
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserCarpool2}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}

Validate parking(no carpool should not be able to validate no precondition no space left)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/entry
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserNoCarpool}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}

Exit parking(user carpool1 should be able to validate)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/exit
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserCarpool1}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}

Validate parking(no carpool should not be able to validate no precondition only)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/entry
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserNoCarpool}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}

Validate parking(user carpool2 should be able, 1 space after exit)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${accessTokenParking}
    ...    Content-Type=application/json; charset=utf-8
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/prk/lot/validate/entry
    ...    data={"lotId":"68d40ed87afe768e987b2a64","validationString":"${qrCodeUserCarpool2}"}
    ...    headers=${headers}
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    ${response}=    Set Variable    ${response.json()}