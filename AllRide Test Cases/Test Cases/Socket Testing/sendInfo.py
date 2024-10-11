import socketio

# Crea un cliente de socket
sio = socketio.Client()

# Conéctate al socket
sio.connect('wss://stage.allrideapp.com/socket.io/pbDriver?token=95957f7f0f04435a29a851a1c4b50c35e0b3975a342086f61c1ba575896ad1549c1bf13fafaf4b21d482378dc6b34325357b3327aede2b5189ed1d43db3d32c5&EIO=3&transport=websocket')

# Mantén la conexión activa
sio.wait()
