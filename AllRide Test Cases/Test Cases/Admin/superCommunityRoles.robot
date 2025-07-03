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


*** Variables ***
${EXPECTED_USERNAME}                nicolas+adminscrf@allrideapp.com
${EXPECTED_NAME}                    Nico QA RF
${EXPECTED_COUNTRY}                 cl
${EXPECTED_AVATAR}                  https://s3.amazonaws.com/allride.uploads/communityAvatar_6654ae4eba54fe502d4e4187_1717603083265.png
${EXPECTED_SUPERCOMMUNITY_ID}       653fd68233d83952fafcd4be


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
    Set Global Variable    ${end_date_tomorrow}
    ${expiration_date_qr}=    Set Variable    ${fecha_manana}T14:10:37.968Z
    Set Global Variable    ${expiration_date_qr}
    ${start_date_tickets}=    Set Variable    ${fecha_hoy}T04:00:00.000Z
    Set Global Variable    ${start_date_tickets}
    ${end_date_tickets}=    Set Variable    ${fecha_manana}T03:59:59.999Z
    Set Global Variable    ${end_date_tickets}

    ${end_date_pasado_manana}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pasado_manana}

    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_pastTomorrow}

Generate Random 10 Digit Value
    ${random_value1}=    Evaluate    "".join([str(random.randint(0,9)) for _ in range(10)])    random
    Log    Valor aleatorio generado: ${random_value1}
    Set Global Variable    ${random_value1}

Find SuperCommunityRoles
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/roles/listAllSuperCommunityRoles?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Should not be empty    ${response.json()}    The response was empty, obtain supercommunityRoles is failing

Create superCommunity Role
    Skip
    ${ROLE_NAME}=    Set Variable    Administrador de Super Comunidad RF QA
    ${ROLE_LEVEL}=    Set Variable    1
    @{PERMISOS_COMPLETOS}=    Set Variable    read    create    edit    delete
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/roles/create?community=6654ae4eba54fe502d4e4187
    ...    data={"name":"Administrador de Super Comunidad RF QA 2","level":1,"fixed":false,"global":false,"superCommunityRole":true,"communities":[],"superCommunities":[],"sections":[{"name":"BusesSection"},{"name":"PrivateBusesSection"},{"name":"PrivateBusDashboard","permissions":["read","create","edit","delete"]},{"name":"PrivateBusRoutes","permissions":["read","create","edit","delete"]},{"name":"PrivateBusRouteAssistant","permissions":["read","create","edit","delete"]},{"name":"PrivateBusRouteCreator","permissions":["read","create","edit","delete"]},{"name":"PrivateBusShapes","permissions":["read","create","edit","delete"]},{"name":"PrivateBusStops","permissions":["read","create","edit","delete"]},{"name":"PrivateBusStopTimes","permissions":["read","create","edit","delete"]},{"name":"PrivateBusesVehicleFleetSection","permissions":["read","create","edit","delete"]},{"name":"PrivateBusesVehicle","permissions":["read","create","edit","delete"]},{"name":"PrivateBusesCategoryVehicle","permissions":["read","create","edit","delete"]},{"name":"PrivateBusScheduling","permissions":["read","create","edit","delete"]},{"name":"PrivateBusReportsSection","permissions":["read","create","edit","delete"]},{"name":"PrivateBusReports","permissions":["read","create","edit","delete"]},{"name":"PrivateBusLog","permissions":["read","create","edit","delete"]},{"name":"PrivateBusEvents","permissions":["read","create","edit","delete"]},{"name":"PrivateBusValidations","permissions":["read","create","edit","delete"]},{"name":"PrivateBusDrivers","permissions":["read","create","edit","delete"]},{"name":"PrivateBusAssistants","permissions":["read","create","edit","delete"]},{"name":"PrivateBusCards","permissions":["read","create","edit","delete"]},{"name":"PrivateBusRatings","permissions":["read","create","edit","delete"]},{"name":"PrivateBusStats","permissions":["read","create","edit","delete"]},{"name":"PrivateBusPanicButton","permissions":["read","create","edit","delete"]},{"name":"PrivateBusReservations","permissions":["read","create","edit","delete"]},{"name":"PrivateTransportSummary","permissions":["read","create","edit","delete"]},{"name":"BudgetSystem","permissions":["read","create","edit","delete"]},{"name":"ODDSection"},{"name":"ODDCreation","permissions":["read","create","edit","delete"]},{"name":"ODDRequests","permissions":["read","create","edit","delete"]},{"name":"ODDAsapReports","permissions":["read"]},{"name":"ODDReportsSection","permissions":["read"]},{"name":"ODDReportsSummary","permissions":["read"]},{"name":"ODDReportsPassengers","permissions":["read"]},{"name":"TicketSystemSection"},{"name":"TicketSystemSeller","permissions":["read","create","edit","delete"]},{"name":"TicketSystemTreasurer","permissions":["read","create","edit","delete"]},{"name":"TicketSystemCollector","permissions":["read","create","edit","delete"]},{"name":"TicketSystemOperationsManager","permissions":["read","create","edit","delete"]},{"name":"TicketSystemBlock","permissions":["read","create","edit","delete"]},{"name":"TicketSystemCollectorsReport","permissions":["read","create","edit","delete"]},{"name":"TicketSystemMovementHistory","permissions":["read","create","edit","delete"]},{"name":"TicketSystemTrimesterReport","permissions":["read","create","edit","delete"]},{"name":"TicketSystemAssignedTicketsReport","permissions":["read","create","edit","delete"]},{"name":"AdminSection"},{"name":"ListValidationUsers","permissions":["read","create","edit","delete"]},{"name":"Users","permissions":["read","create","edit","delete"]},{"name":"AppMessaging","permissions":["read","create","edit","delete"]},{"name":"AdminUsers","permissions":["read","create","edit","delete"]},{"name":"Places","permissions":["read","create","edit","delete"]},{"name":"ExternalPolls","permissions":["read","create","edit","delete"]},{"name":"AdminRoles","permissions":["read","create","edit","delete"]},{"name":"StatisticsSection"},{"name":"StatisticsTrips","permissions":["read","create","edit","delete"]},{"name":"StatisticsUsers","permissions":["read","create","edit","delete"]},{"name":"SCAdminSection"},{"name":"SCCommunities","permissions":["read","create","edit","delete"]}]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=    Set Variable    ${response.json()}
    ${roleId}=    Set Variable    ${response.json()}[_id]

    # Verificaciones generales del rol
    Should Be Equal As Strings    ${json}[name]    ${ROLE_NAME}    msg=❌ El nombre del rol no coincide con el esperado.
    Should Be Equal As Strings    ${json}[level]    ${ROLE_LEVEL}    msg=❌ El nivel del rol no es 1 como se esperaba.
    Should Be True    ${json}[superCommunityRole]    msg=❌ El flag 'superCommunityRole' debería ser true.
    Should Be Equal As Strings    ${json}[global]    False    msg=❌ El flag 'global' debería ser false.
    Should Be Equal As Strings    ${json}[fixed]    False    msg=❌ El flag 'fixed' debería ser false.
    Should Be Equal As Strings    ${json}[communities]    []    msg=❌ La lista 'communities' debería estar vacía.
    Should Be Equal As Strings
    ...    ${json}[superCommunities]
    ...    []
    ...    msg=❌ La lista 'superCommunities' debería estar vacía.

    # Validación de existencia y permisos completos en sección crítica
    ${sections}=    Set Variable    ${json}[sections]
    ${section_names}=    Evaluate    [s['name'] for s in ${sections}]
    Should Contain    ${section_names}    PrivateBusRoutes    msg=❌ La sección 'PrivateBusRoutes' no fue creada.

    FOR    ${section}    IN    @{sections}
        IF    '${section["name"]}' == 'PrivateBusRoutes'
            Should Be Equal As Strings
            ...    ${section["permissions"]}
            ...    ${PERMISOS_COMPLETOS}
            ...    msg=❌ La sección 'PrivateBusRoutes' no tiene todos los permisos esperados.
        END
    END
    # Validación de sección sin permisos
    FOR    ${section}    IN    @{sections}
        IF    '${section["name"]}' == 'BusesSection'
            Should Be Equal As Strings
            ...    ${section["permissions"]}
            ...    []
            ...    msg=❌ La sección 'BusesSection' debería no tener permisos asignados.
        END

        # Validar número total de secciones
        Length Should Be    ${sections}    58    msg=❌ El número de secciones creadas no es el esperado (58).
    END
    # Validación básica de formato de todas las secciones
    FOR    ${section}    IN    @{sections}
        Should Not Be Empty    ${section["name"]}    msg=❌ Se encontró una sección sin nombre.
        IF    '${section["permissions"]}' != []
            Should Contain
            ...    ${section["permissions"]}
            ...    read
            ...    msg=❌ La sección ${section["name"]} debería tener permiso de lectura si tiene permisos.
        END
    END

DELETE SuperCommunity Role
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/roles/delete/6840a3d956fc0d443d3a7d81?community=6654ae4eba54fe502d4e4187
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

Create SuperCommunity Admin
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/adminUsers/createSCAdmin?community=6654ae4eba54fe502d4e4187
    ...    data={"username":"nicolas+adminscrf@allrideapp.com","name":"Nico QA RF","roleId":"67c0d446981dcb5fcf55b643","adminLevel":null,"superCommunity":"653fd68233d83952fafcd4be","personalInfo":{"phoneNumber":null},"avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_6654ae4eba54fe502d4e4187_1717603083265.png","country":"cl"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    ${json}=    Set Variable    ${response.json()}
    ${adminId}=    Set Variable    ${response.json()}[_id]
    Set Global Variable    ${adminId}

    # Basic identity checks
    Should Be Equal As Strings
    ...    ${json}[username]
    ...    ${EXPECTED_USERNAME}
    ...    msg=❌ Username does not match the expected value.
    Should Be Equal As Strings    ${json}[name]    ${EXPECTED_NAME}    msg=❌ Name does not match the expected value.
    Should Be Equal As Strings    ${json}[country]    ${EXPECTED_COUNTRY}    msg=❌ Country should be 'cl' (Chile).
    Should Be Equal As Strings
    ...    ${json}[avatar]
    ...    ${EXPECTED_AVATAR}
    ...    msg=❌ Avatar URL does not match the expected value.

    # Super community and communities check
    Should Be Equal As Strings
    ...    ${json}[superCommunity]
    ...    ${EXPECTED_SUPERCOMMUNITY_ID}
    ...    msg=❌ SuperCommunity ID does not match.
    Should Be Equal As Strings    ${json}[communities]    []    msg=❌ User should not belong to standard communities.

    # Status and role flags
    Should Be True    ${json}[active]    msg=❌ User should be active.
    Should Be True    ${json}[superCommunityAdmin]    msg=❌ User should be marked as Super Community Admin.
    Should Be Equal As Strings    ${json}[setUserLimits]    False    msg=❌ 'setUserLimits' should be false.
    Should Be Equal As Strings
    ...    ${json}[cabpool][isVehicleOwner]
    ...    False
    ...    msg=❌ User should not be marked as vehicle owner.
    Should Be Equal As Strings
    ...    ${json}[cabpool][vehicles]
    ...    []
    ...    msg=❌ User should not have any associated vehicles.

    # Phone number validation
    Should Be Equal As Strings    ${json}[personalInfo][phoneNumber]    None    msg=❌ Phone number should be null.

    # Admin level check
    Should Be Equal As Strings    ${json}[adminLevel]    None    msg=❌ 'adminLevel' should be null.

    # Timestamps (informational)
    Should Not Be Empty    ${json}[createdAt]    msg=❌ 'createdAt' should not be empty.
    Should Not Be Empty    ${json}[updatedAt]    msg=❌ 'updatedAt' should not be empty.

DELETE AdminSC
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json; charset=utf-8
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    DELETE On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/adminUsers/superCommunityAdmin?userId=${adminId}&community=653fd68233d83952fafcd4be
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${json}=    Set Variable    ${response.json()}

    # Identity and basic fields
    Should Be Equal As Strings    ${json}[name]    ${EXPECTED_NAME}    msg=❌ Name does not match the expected value.
    Should Be Equal As Strings    ${json}[country]    ${EXPECTED_COUNTRY}    msg=❌ Country should be 'cl' (Chile).
    Should Be Equal As Strings
    ...    ${json}[avatar]
    ...    ${EXPECTED_AVATAR}
    ...    msg=❌ Avatar URL does not match the expected value.

    # Community-related fields
    Should Be Equal As Strings    ${json}[communities]    []    msg=❌ User should not belong to standard communities.

    # Status and role flags
    Should Be Equal As Strings    ${json}[active]    False    msg=❌ User should be inactive.
    Should Be True    ${json}[superCommunityAdmin]    msg=❌ User should be marked as Super Community Admin.
    Should Be Equal As Strings    ${json}[setUserLimits]    False    msg=❌ 'setUserLimits' should be false.
    Should Be Equal As Strings
    ...    ${json}[cabpool][isVehicleOwner]
    ...    False
    ...    msg=❌ User should not be marked as vehicle owner.
    Should Be Equal As Strings
    ...    ${json}[cabpool][vehicles]
    ...    []
    ...    msg=❌ User should not have any associated vehicles.

    # Phone number and admin level checks
    Should Be Equal As Strings    ${json}[personalInfo][phoneNumber]    None    msg=❌ Phone number should be null.
    Should Be Equal As Strings    ${json}[adminLevel]    None    msg=❌ 'adminLevel' should be null.

    # Timestamps
    Should Not Be Empty    ${json}[createdAt]    msg=❌ 'createdAt' should not be empty.
    Should Not Be Empty    ${json}[updatedAt]    msg=❌ 'updatedAt' should not be empty.
