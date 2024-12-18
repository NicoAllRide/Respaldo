# This sample code supports Appium Robot client >=2
# pip install robotframework-appiumlibrary
# Then you can paste this into a file and simply run with Robot
#
# Find keywords at: http://serhatbolsu.github.io/robotframework-appiumlibrary/AppiumLibrary.html
#
# If your tests fails saying 'did not match any elements' consider using 'wait activity' or
# 'wait until page contains element' before a click command

*** Settings ***
Library    DateTime
Library    BuiltIn
Library    AppiumLibrary
Library    XML
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     RPA.JSON
Resource    ../Test Cases/Variables/variablesStage.robot




*** Test Cases ***
Get Tomorrow Date
    ${fecha_manana}=    Get Current Date    increment=1d    result_format=%d
    ${fecha_manana_number}=    Convert To Integer    ${fecha_manana}
    Set Global Variable    ${fecha_manana_number}

Get Last Day Of The Month
    ${year}=    Get Current Date     result_format=%Y
    ${month}=    Get Current Date     result_format=%m
    ${month}=    Convert To Integer    ${month}
    ${tupleContainingEndDate}=    Evaluate    calendar.monthrange(${year}, ${month})    modules=calendar
    ${lastDayOfTheMonth}=    Set Variable    ${tupleContainingEndDate}[1]
    Log    ${lastDayOfTheMonth}
    Set Global Variable    ${lastDayOfTheMonth}

Modify Hospital Rengo -- Entry, Description, Just Hours, No Agrupation, No Restrictions
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=/api/v1/admin/pb/stops/6654d4acba54fe502d4e6b6b?community=6654ae4eba54fe502d4e4187
    ...    data={"name":"Hospital Rengo","description":"","communities":["6654ae4eba54fe502d4e4187"],"superCommunities":["653fd68233d83952fafcd4be"],"ownerIds":[{"_id":"6654d533713b9a5184cfe31d","id":"6654ae4eba54fe502d4e4187","role":"community"}],"categories":["odd"],"lat":-34.4111,"lon":-70.8537,"config":{"options":[{"direction":"in","day":"fri","time":"02:00","description":"Descripcion1 Hola","grouping":{"byKey":{"enabled":false,"key":""},"byList":{"enabled":false,"list":["A","B"]}},"restricted":{"userLocation":{"enabled":false},"stops":{"enabled":false,"stopIds":["666728c8fea8eb2b26b20e82"]}}}],"restricted":false,"stopIds":[]}}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

RDD Free Flow Already Logged
    Open Application    http://127.0.0.1:4723    appium:automationName=UiAutomator2    appium:platformName=Android    appium:newCommandTimeout=${3600}    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.core

Tap on Search Bar (Origin)
    ${el12} =    Set Variable     id=com.allride.core:id/etSearch
    Wait Until Element Is Visible    ${el12}
    Click Element    ${el12}

    ${el13} =    Set Variable     id=com.allride.core:id/etOrigin
    Wait Until Element Is Visible    ${el13}
    Click Element    ${el13}

Search Ciudad Satelite As Origin
    ${el14} =    Set Variable     id=com.allride.core:id/etOrigin
    Wait Until Element Is Visible    ${el14}
    Click Element    ${el14}
    Input Text    ${el14}    Ciudad Satelite

Tap On Origin (Ciudad Satelite)
    ${el15} =    Set Variable     xpath=//android.widget.TextView[@resource-id="com.allride.core:id/tvAddress" and @text="Parque Central - Ciudad Satelite"]
    Wait Until Element Is Visible    ${el15}
    Click Element    ${el15}

Tap On Search Bar (Destination)
    ${el16} =    Set Variable     id=com.allride.core:id/etDestination
    Wait Until Element Is Visible    ${el16}
    Click Element    ${el16}

Verify Limited Icon Exists in Hospital Rengo
    ${limitedBus}=    Set Variable    id=com.allride.core:id/ivLimitedBus
    Wait Until Element Is Visible    ${limitedBus}
    Element Should Be Visible    ${limitedBus}

Tap on Hospital Rengo
    ${el17} =    Set Variable     xpath=//android.widget.TextView[@resource-id="com.allride.core:id/tvAddress" and @text="Hospital Rengo"]
    Wait Until Element Is Visible    ${el17}
    Click Element    ${el17}

Select Service (Taxis Nico Should Not Exist In Limited RDD)
    ${taxisNico}=     Set Variable     id=com.allride.core:id/tvRDDRouteName
    Wait Until Element Is Visible    ${taxisNico}
    Click Element    ${taxisNico}

Tap on Select Date
    Sleep    10s

Verify If Past Days Are Disabled And Future Fridays Enabled
    ${fecha_hoy}=    Get Current Date    result_format=%d
    ${fecha_hoy_number}=    Convert To Integer    ${fecha_hoy}

    ${year}=    Get Current Date    result_format=%Y
    ${month}=    Get Current Date    result_format=%m
    ${month}=    Convert To Integer    ${month}
    ${tupleContainingEndDate}=    Evaluate    calendar.monthrange(${year}, ${month})    modules=calendar
    ${lastDayOfTheMonth}=    Set Variable    ${tupleContainingEndDate}[1]
    Log    Last day of the month: ${lastDayOfTheMonth}

    ${fridays}=    Create List
    FOR    ${day}    IN RANGE    1    ${lastDayOfTheMonth + 1}
        ${day_of_week}=    Evaluate    datetime.date(${year}, ${month}, ${day}).weekday()    modules=datetime
        Run Keyword If    ${day_of_week} == 4    Append To List    ${fridays}    ${day}
    END
    Log    List of Fridays: ${fridays}

    FOR    ${day}    IN RANGE    1    ${lastDayOfTheMonth + 1}
        ${el}=    Set Variable    accessibility_id=${day}
        ${is_past_day}=    Evaluate    ${day} < ${fecha_hoy_number}
        ${is_friday}=    Evaluate    ${day} in ${fridays}

        IF    ${is_past_day}
            Element Should Be Disabled    ${el}
        ELSE IF    not ${is_past_day} and not ${is_friday}
            Element Should Be Disabled    ${el}
        ELSE IF    ${is_friday} and not ${is_past_day}
            Wait Until Element Is Visible    ${el}    timeout=5s
            Element Should Be Enabled    ${el}
        END
    END
Save First Friday
    ${fecha_hoy}=    Get Current Date    result_format=%d
    ${fecha_hoy_number}=    Convert To Integer    ${fecha_hoy}

    ${year}=    Get Current Date    result_format=%Y
    ${month}=    Get Current Date    result_format=%m
    ${month}=    Convert To Integer    ${month}
    ${tupleContainingEndDate}=    Evaluate    calendar.monthrange(${year}, ${month})    modules=calendar
    ${lastDayOfTheMonth}=    Set Variable    ${tupleContainingEndDate}[1]
    Log    Last day of the month: ${lastDayOfTheMonth}

    ${fridays}=    Create List
    FOR    ${day}    IN RANGE    1    ${lastDayOfTheMonth + 1}
        ${day_of_week}=    Evaluate    datetime.date(${year}, ${month}, ${day}).weekday()    modules=datetime
        Run Keyword If    ${day_of_week} == 4    Append To List    ${fridays}    ${day}
    END
    Log    List of Fridays: ${fridays}

    FOR    ${day}    IN RANGE    1    ${lastDayOfTheMonth + 1}
        ${el}=    Set Variable    accessibility_id=${day}
        ${is_past_day}=    Evaluate    ${day} < ${fecha_hoy_number}
        ${is_friday}=    Evaluate    ${day} in ${fridays}

        IF    ${is_past_day}
            Element Should Be Disabled    ${el}
        ELSE IF    not ${is_past_day} and not ${is_friday}
            Element Should Be Disabled    ${el}
        ELSE IF    ${is_friday} and not ${is_past_day}
            Wait Until Element Is Visible    ${el}    timeout=5s
            Element Should Be Enabled    ${el}
            ${firstFriday}=    Set Variable  ${el}
            BREAK
        END
    END
    Set Global Variable    ${firstFriday}
Click on first enabled Friday
    Click Element    ${firstFriday}

Tap On Ok
    ${el22} =    Set Variable     id=com.allride.core:id/btnYesSure
    Wait Until Element Is Visible    ${el22}
    Click Element    ${el22}

Tap On Select Time
    ${el23} =    Set Variable     id=com.allride.core:id/tvSelectedTime
    Wait Until Element Is Visible    ${el23}
    Click Element    ${el23}

Check Hour
    Element Text Should Be    com.allride.core:id/tvTime    02:00 a. m.

Tap On Description Btn
    ${descriptionBtn}=    Set Variable    id=com.allride.core:id/btnTimeDescription
    Wait Until Element Is Visible    ${descriptionBtn}
    Click Element    ${descriptionBtn}

Check Description Text
    Element Text Should Be    com.allride.core:id/tvTimeDescription    Descripcion1 Hola

Tap on Hour
    ${hourBtn}=    Set Variable    id=com.allride.core:id/cbTime
    Wait Until Element Is Visible    ${hourBtn}
    Click Element    ${hourBtn}

Tap on Ok
    ${okBtn}=    Set Variable    id=com.allride.core:id/btnYesSure
    Wait Until Element Is Visible    ${okBtn}
    Click Element    ${okBtn}

Tap on Continue
    ${continueBtn}=    Set Variable    id=com.allride.core:id/btnContinue
    Wait Until Element Is Visible    ${continueBtn}
    Click Element    ${continueBtn}

Reservation completed
    ${reservationSuccededEl}=    Set Variable    id=com.allride.core:id/tvYourReservationHasBeen
    Wait Until Element Is Visible    ${reservationSuccededEl}
    Element Text Should Be    ${reservationSuccededEl}    ¡Tu reserva ha sido creada!

Back to main screen
    ${backToMainBtn}=    Set Variable    id=com.allride.core:id/btnCreateReservationFinished
    Wait Until Element Is Visible    ${backToMainBtn}
    Click Element    ${backToMainBtn}

