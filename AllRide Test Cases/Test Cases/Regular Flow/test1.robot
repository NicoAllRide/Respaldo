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

Check Validations Movement
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/validations/list?community=${idComunidad}&from=0
    ...    data={"advancedSearch":false,"startDate":"${today_date}T04:00:00.000Z","endDate":"${fecha_manana}T03:59:59.999Z","searchAll":"","route":"0","driver":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"rut","value":""}],"startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    #------------------------Validations Status Pass---------------------------------#
    ${checkValidated_Manual}=     Set Variable    ${response.json()}[validations][0][validated]
    ${checkValidated_NFC}=     Set Variable    ${response.json()}[validations][1][validated]
    ${checkValidated_Custom}=     Set Variable    ${response.json()}[validations][2][validated]
    ${checkValidated_QR}=     Set Variable    ${response.json()}[validations][3][validated]
    #------------------------Route Name---------------------------------#
    ${routeName_Manual}=     Set Variable    ${response.json()}[validations][0][routeName]
    ${routeName_NFC}=     Set Variable    ${response.json()}[validations][1][routeName]
    ${routeName_Custom}=     Set Variable    ${response.json()}[validations][2][routeName]
    ${routeName_QR}=     Set Variable    ${response.json()}[validations][3][routeName]
    #------------------------Assigned Seat---------------------------------#
    ${seat_NFC}=     Set Variable    ${response.json()}[validations][1][routeName]
    ${seat_Custom}=     Set Variable    ${response.json()}[validations][2][routeName]
    ${seat_QR}=     Set Variable    ${response.json()}[validations][3][routeName]
    ${routeName}=    Evaluate     "Scheduled With Tickets" + "${today_date}"


    
    #------------------------Validations Status Pass---------------------------------#
    Should Be Equal As Strings    ${checkValidated_Manual}    True
    Should Be Equal As Strings    ${checkValidated_NFC}    True
    Should Be Equal As Strings    ${checkValidated_Custom}    True
    Should Be Equal As Strings    ${checkValidated_QR}    True
    #------------------------Route Name---------------------------------#
    Should Be Equal As Strings    ${routeName_Manual}    Scheduled With Tickets ${today_date}
    Should Be Equal As Strings    ${routeName_NFC}    Scheduled With Tickets ${today_date}
    Should Be Equal As Strings    ${routeName_Custom}    Scheduled With Tickets ${today_date}
    Should Be Equal As Strings    ${routeName_QR}    Scheduled With Tickets ${today_date}
    #------------------------Assigned Seat---------------------------------#
    Should Be Equal As Numbers    ${seat_NFC}    1
    Should Be Equal As Numbers    ${seat_Custom}    3
    Should Be Equal As Numbers    ${seat_QR}    2





    Log    ${code}




####################################################
##Get Routes As Driver Pendiente

#######################################################