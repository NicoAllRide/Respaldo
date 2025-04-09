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

Seat Reservation(User1-NicoEnd)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer 21ca20d30ed611d3f5a757fbe447dd72c388a8054922ac0d3a14f2936d9cc1e0b5165640a0184f0e070f13583dae1cabe296c420b464bed7ccdf50c049f66976    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"67b489b5ef78f17fad6f7323","stopId":"67506a5fc46fdbfcb4fa0202","departureId":"67cefed3a06b76d7f5be97f3","seat":"2"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200        Seat reservation not working statusCode ${code}
    Log    ${code}
    Sleep    5s

Seat Reservation(User2-Pedro Pascal Available Seat)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer 500e93d32abcaab6b2f9f7a6387b7bf460b6b1360efeb109f0b0081df99e8e2803ed23f57ed26e79132eb81703b4dc6eed902f94d40f7d696f855538db9453de   Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"67b489b5ef78f17fad6f7323","stopId":"67506a5fc46fdbfcb4fa0202","departureId":"67cefed3a06b76d7f5be97f3","seat":"1"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200  
    Log    ${code}
    Sleep    5s

Seat Reservation(User3-Kratos Available Seat)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer 340fcd5be3243b0a1e83ef111101616e4ded28c729c01847ab12127533876b128f3b980c9a25216a570d6b4be5816945a541d75e574213548675218170026d0a    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"67b489b5ef78f17fad6f7323","stopId":"67a0f40cb68d7ccc758d62c7","departureId":"67cefed3a06b76d7f5be97f3","seat":"3"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200      
    Log    ${code}
    Sleep    5s
Seat Reservation(User4-Kratos Available Seat)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer e610b49e3a9dc75a9e31f7e6a6043b566e356569860c798339478bf19be4becf098e6fef8d274e995cdc0a8e431f75c9cfe9cbbf6a85aafe3bc6aede1ec1a216   Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"67b489b5ef78f17fad6f7323","stopId":"674a2a59c656286155758241","departureId":"67cefed3a06b76d7f5be97f3","seat":"4"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200      
    Log    ${code}
    Sleep    5s
Seat Reservation(User5-Kratos Available Seat)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=Bearer 4d2eb08e9aa9ca6b82b6894c9fafd4e2d2f5f67bc20890afc619ae4d5c5718b679def80de932f6064758070d7b63e097576c71689ec14a8c3f24df69faf13073    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    ${seatReservation}
    ...    data={"serviceId":"67b489b5ef78f17fad6f7323","stopId":"674a2a59c656286155758241","departureId":"67cefed3a06b76d7f5be97f3","seat":"5"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200      
    Log    ${code}
    Sleep    5s