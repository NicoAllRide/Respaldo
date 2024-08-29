*** Settings ***
Library     WebSocketClient
Library     BuiltIn
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON


*** Variables ***
#------------------------DEBE SER RTL TOKEN DEL CONDUCTOR-----------------------------------------#
${TOKEN}            f8a9cfd98bf36aac0209af699ed4b5becee67ddddc1af1bca57e22847e00393a28d461fece011e97ea44464229832786d29f2bd19bc7c1c02cd5a23b9d210380
${URL}              ws://stage.allrideapp.com/socket.io/?token=${TOKEN}&communityId=653fd601f90509541a748683&EIO=3&transport=websocket
${LATITUDE}         -34.40274888966042
${LONGITUDE}        -70.85938591407319
${NEW_LATITUDE}     -34.40274888966042
${NEW_LONGITUDE}    -70.85938591407319
${IS_FULL}          false
${IS_PANICKING}     false
${CAPACITY}         4
${SPEED}            50.5
${STAGE_URL}            https://stage.allrideapp.com


*** Test Cases ***


Connect Socket CP
    [Documentation]    Test connecting to WebSocket and sending events
    ${my_websocket}=    Connect    ${URL}
    Set Global Variable    ${my_websocket}
    Log    Connected to WebSocket: ${URL}

    Send    ${my_websocket}    40/pbStandby?token=${TOKEN}
    Log    Sent: 40/pbStandby?token=${TOKEN}&communityId=653fd601f90509541a748683&EIO=3&transport=websocket
    Sleep    5s
    ${result}=    Recv Data    ${my_websocket}


Send Join
    # Enviar evento join
    Send    ${my_websocket}    42/pbStandby,["join"]
    Log    Sent: 42/pbStandby,["join"]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}


    # Enviar pings periódicos

Send Listening To Requests
    Skip
    # Enviar evento start con latitud y longitud fijos
    Send    ${my_websocket}    42/pbStandby,["newRequest"]
    Log    Sent: 42/pbStandby,["newRequest"]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}



    # Enviar evento updatePosition con nuevas coordenadas y otros datos
Send updatePosition
    Send
    ...    ${my_websocket}
    ...    42/pbStandby,["updatePosition",{"latitude":-34.3941093,"longitude":-70.7813055}]
    Log
    ...    Sent: 42/pbStandby,["updatePosition",{"latitude":-34.3941093,"longitude":-70.7813055}]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

Send Listening To Requests ESTE NO APLICA
    Skip
    # Enviar evento start con latitud y longitud fijos
    Send    ${my_websocket}    42/pbStandby,["newRequest"]
    Log    Sent: 42/pbStandby,["newRequest"]
    Sleep    3s
    ${result}=    Recv Data    ${my_websocket}
    Log    Received: ${result}

##Realizar una RDD inmediata, captarla con el conductor con 
# 


# /
# 
# 
# 
# 
# 
# #
