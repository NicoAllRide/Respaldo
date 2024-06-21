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

Search Plaza Oeste As Destination
    ${el17} =    Set Variable     id=com.allride.core:id/etOrigin
    Wait Until Element Is Visible    ${el17}
    Click Element    ${el17}
    Input Text    ${el17}    plaza oeste

Tap On Destination(Plaza Oeste)
    ${el18} =    Set Variable     xpath=//android.widget.TextView[@resource-id="com.allride.core:id/tvAddress" and @text="Plaza oeste"]
    Wait Until Element Is Visible    ${el18}
    Click Element    ${el18}

Select Service (Taxis Coni y Nico)
    ${el19} =    Set Variable     id=com.allride.core:id/tvRDDRouteName
    Wait Until Element Is Visible    ${el19}
    Click Element    ${el19}

Tap on Select Date
    ${el20} =    Set Variable     id=com.allride.core:id/tvSelectedDate
    Wait Until Element Is Visible    ${el20}
    Click Element    ${el20}

Verify If Past Days Are Disabled And Future Days Enabled
    ${fecha_hoy}=    Get Current Date    result_format=%d
    ${fecha_hoy_number}=    Convert To Integer    ${fecha_hoy}

    ${fecha_manana}=    Get Current Date    increment=1d    result_format=%d
    ${fecha_manana_number}=    Convert To Integer    ${fecha_manana}
    Set Global Variable    ${fecha_manana_number}

    ${year}=    Get Current Date     result_format=%Y
    ${month}=    Get Current Date     result_format=%m
    ${month}=    Convert To Integer    ${month}
    ${tupleContainingEndDate}=    Evaluate    calendar.monthrange(${year}, ${month})    modules=calendar
    ${lastDayOfTheMonth}=    Set Variable    ${tupleContainingEndDate}[1]
    Log    ${lastDayOfTheMonth}
    Set Global Variable    ${lastDayOfTheMonth}

    FOR    ${day}    IN RANGE    1    ${lastDayOfTheMonth}
        ${el}=    Set Variable    accessibility_id=${day}
        ${is_past_day}=    Evaluate    ${day} < ${fecha_hoy_number}
        Run Keyword If    ${is_past_day}    Element Should Be Disabled    ${el}
        Run Keyword If    not ${is_past_day}    Wait Until Element Is Visible    ${el}    timeout=5s
        Run Keyword If    not ${is_past_day}    Element Should Be Enabled    ${el}
    END

Select Tomorrow Day 

    ${el21} =    Set Variable     accessibility_id=${fecha_manana_number}
    Wait Until Element Is Visible    ${el21}
    Element Should Be Enabled    ${el21}
    Click Element    ${el21}

Tap On Ok
    ${el22} =    Set Variable     id=com.allride.core:id/btnYesSure
    Wait Until Element Is Visible    ${el22}
    Click Element    ${el22}

Tap On Select Time
    ${el23} =    Set Variable     id=com.allride.core:id/tvSelectedTime
    Wait Until Element Is Visible    ${el23}
    Click Element    ${el23}

Select Hour (2)
    ${el24} =    Set Variable     accessibility_id=2
    Wait Until Element Is Visible    ${el24}
    Click Element    ${el24}

Select Minutes(00)
    ${el25} =    Set Variable     accessibility_id=0
    Wait Until Element Is Visible    ${el25}
    Click Element    ${el25}

Select PM
    ${el26} =    Set Variable     id=android:id/pm_label
    Wait Until Element Is Visible    ${el26}
    Click Element    ${el26}

Confirm Hour
    ${el27} =    Set Variable     id=com.allride.core:id/btnYesSure
    Wait Until Element Is Visible    ${el27}
    Click Element    ${el27}

Continue Reservation
    ${el28} =    Set Variable     id=com.allride.core:id/btnContinue
    Wait Until Element Is Visible    ${el28}
    Click Element    ${el28}

Verify that message appears (YourReservationHasBeen)
    ${el29} =    Set Variable     id=com.allride.core:id/tvYourReservationHasBeen
    Wait Until Element Is Visible    ${el29}

Finish Reservation
    ${el30} =    Set Variable     id=com.allride.core:id/btnCreateReservationFinished
    Wait Until Element Is Visible    ${el30}
    Click Element    ${el30}

RDD Free Flow With Login
    Skip
    Open Application    http://127.0.0.1:4723    appium:automationName=UiAutomator2    appium:platformName=Android    appium:newCommandTimeout=${3600}    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.core

    ${el1} =    Set Variable     id=com.allride.core:id/tvChile
    Wait Until Element Is Visible    ${el1}
    Click Element    ${el1}

    ${el2} =    Set Variable     id=com.allride.core:id/btnAccept
    Wait Until Element Is Visible    ${el2}
    Click Element    ${el2}

    ${el3} =    Set Variable     id=com.allride.core:id/btnNext
    Wait Until Element Is Visible    ${el3}
    Click Element    ${el3}

    ${el4} =    Set Variable     id=com.allride.core:id/btnNext
    Wait Until Element Is Visible    ${el4}
    Click Element    ${el4}

    ${el5} =    Set Variable     id=com.allride.core:id/btnNext
    Wait Until Element Is Visible    ${el5}
    Click Element    ${el5}

    ${el6} =    Set Variable     id=com.allride.core:id/btnNext
    Wait Until Element Is Visible    ${el6}
    Click Element    ${el6}

    ${el7} =    Set Variable     id=com.allride.core:id/btnLogin
    Wait Until Element Is Visible    ${el7}
    Click Element    ${el7}

    ${el8} =    Set Variable     id=com.allride.core:id/etEmail
    Wait Until Element Is Visible    ${el8}
    Input Text    ${el8}    nicolas+comunidad2@allrideapp.com

    ${el9} =    Set Variable     id=com.allride.core:id/btnLogin
    Wait Until Element Is Visible    ${el9}
    Click Element    ${el9}

    ${el10} =    Set Variable     id=com.allride.core:id/etPassword
    Wait Until Element Is Visible    ${el10}
    Input Text    ${el10}    Lolowerty21@

    ${el11} =    Set Variable     id=com.allride.core:id/btnLogin
    Wait Until Element Is Visible    ${el11}
    Click Element    ${el11}

    ${el12} =    Set Variable     id=com.allride.core:id/etSearch
    Wait Until Element Is Visible    ${el12}
    Click Element    ${el12}

    ${el13} =    Set Variable     id=com.allride.core:id/etOrigin
    Wait Until Element Is Visible    ${el13}
    Click Element    ${el13}

    ${el14} =    Set Variable     id=com.allride.core:id/etOrigin
    Wait Until Element Is Visible    ${el14}
    Click Element    ${el14}
    Input Text    ${el14}    Ciudad Satelite

    ${el15} =    Set Variable     xpath=//android.widget.TextView[@resource-id="com.allride.core:id/tvAddress" and @text="Parque Central - Ciudad Satelite"]
    Wait Until Element Is Visible    ${el15}
    Click Element    ${el15}

    ${el16} =    Set Variable     id=com.allride.core:id/etDestination
    Wait Until Element Is Visible    ${el16}
    Click Element    ${el16}

    ${el17} =    Set Variable     id=com.allride.core:id/etOrigin
    Wait Until Element Is Visible    ${el17}
    Click Element    ${el17}
    Input Text    ${el17}    plaza oeste

    ${el18} =    Set Variable     xpath=//android.widget.TextView[@resource-id="com.allride.core:id/tvAddress" and @text="Plaza oeste"]
    Wait Until Element Is Visible    ${el18}
    Click Element    ${el18}

    ${el19} =    Set Variable     id=com.allride.core:id/tvRDDRouteName
    Wait Until Element Is Visible    ${el19}
    Click Element    ${el19}

    ${el20} =    Set Variable     id=com.allride.core:id/tvSelectedDate
    Wait Until Element Is Visible    ${el20}
    Click Element    ${el20}

    ${el21} =    Set Variable     accessibility_id=${fecha_manana_number}
    Wait Until Element Is Visible    ${el21}
    Click Element    ${el21}

    ${el22} =    Set Variable     id=com.allride.core:id/btnYesSure
    Wait Until Element Is Visible    ${el22}
    Click Element    ${el22}

    ${el23} =    Set Variable     id=com.allride.core:id/tvSelectedTime
    Wait Until Element Is Visible    ${el23}
    Click Element    ${el23}

    ${el24} =    Set Variable     accessibility_id=2
    Wait Until Element Is Visible    ${el24}
    Click Element    ${el24}

    ${el25} =    Set Variable     accessibility_id=0
    Wait Until Element Is Visible    ${el25}
    Click Element    ${el25}

    ${el26} =    Set Variable     id=android:id/pm_label
    Wait Until Element Is Visible    ${el26}
    Click Element    ${el26}

    ${el27} =    Set Variable     id=com.allride.core:id/btnYesSure
    Wait Until Element Is Visible    ${el27}
    Click Element    ${el27}

    ${el28} =    Set Variable     id=com.allride.core:id/btnContinue
    Wait Until Element Is Visible    ${el28}
    Click Element    ${el28}

    ${el29} =    Set Variable     id=com.allride.core:id/tvYourReservationHasBeen
    Wait Until Element Is Visible    ${el29}
    
    ${el30} =    Set Variable     id=com.allride.core:id/btnCreateReservationFinished
    Wait Until Element Is Visible    ${el30}
    Click Element    ${el30}




