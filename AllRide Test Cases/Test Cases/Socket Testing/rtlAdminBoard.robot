*** Settings ***
Library  WebSocketClient

*** Variables ***
${WEBSOCKET_URL}  wss://stage.allrideapp.com/socket.io/cpDriver?token=1f7169231ec36bc77996f1f880649e9e0d6fded6955552bca71d1878fd51c868acfaa3295ad24bf58c230e165e43de1956930a7ec6d33d90623422b18b1df35f&EIO=3&transport=websocket

*** Test Cases ***
Join WebSocket
    # Conectar al WebSocket
    ${my_websocket}=  Connect  ${WEBSOCKET_URL}
    
    # Enviar mensaje de join
    Send  ${my_websocket}  42["join"]
    
    # Recibir respuesta del WebSocket
    ${result}=  Recv  ${my_websocket}
    Log  ${result}
    
    # Verificar más respuestas si es necesario
    FOR  ${i}  IN RANGE  5
        ${result}=  Recv  ${my_websocket}
        Log  ${result}
    END
    # Cerrar la conexión
    Close  ${my_websocket}

