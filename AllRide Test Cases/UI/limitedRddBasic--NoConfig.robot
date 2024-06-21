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

Select Service (Taxis Nico Should Not Exist In Limited RDD)
    Open Application    http://127.0.0.1:4723    appium:automationName=UiAutomator2    appium:platformName=Android    appium:newCommandTimeout=${3600}    appium:connectHardwareKeyboard=${True}
    Activate Application    com.allride.core
    Run Keyword And Expect Error    *    Get WebElements    xpath=//*[contains(@text, 'Taxis Nico')]