# server.py

import socketio

# Crear una instancia de servidor Socket.IO
sio = socketio.Server()

# Crear una aplicación WSGI
app = socketio.WSGIApp(sio)

# Definir el evento de conexión
@sio.event
def connect(sid, environ):
    print('Cliente conectado:', sid)

# Definir el evento para manejar mensajes de prueba
@sio.event
def test_message(sid, data):
    print('Mensaje recibido:', data)
    # Enviar una respuesta al cliente
    sio.emit('response_message', {'response': 'Hola, cliente'}, to=sid)

# Definir el evento de desconexión
@sio.event
def disconnect(sid):
    print('Cliente desconectado:', sid)

if __name__ == '__main__':
    import eventlet
    import eventlet.wsgi
    import os

    port = int(os.environ.get('PORT', 5000))
    eventlet.wsgi.server(eventlet.listen(('', port)), app)
