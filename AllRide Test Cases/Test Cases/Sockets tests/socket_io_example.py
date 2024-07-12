# socket_io_example.py

import socketio

# Crear una instancia de cliente Socket.IO
sio = socketio.Client()

# Definir el evento de conexión
@sio.event
def connect():
    print('Conectado al servidor')
    # Emitir un evento de prueba después de conectarse
    sio.emit('test_message', {'data': 'Hola, servidor'})

# Definir el evento de desconexión
@sio.event
def disconnect():
    print('Desconectado del servidor')

# Definir el evento para recibir mensajes
@sio.on('response_message')
def on_message(data):
    print('Mensaje recibido:', data)
    # Comprobar si el mensaje es el esperado
    if data == {'response': 'Hola, cliente'}:
        print('Mensaje correcto recibido, desconectando...')
        sio.disconnect()

# Conectarse al servidor Socket.IO
sio.connect('http://localhost:5000')

# Esperar a que se reciban los mensajes
sio.wait()
