import socketio
import time
import threading

class SocketLibrary:
    def __init__(self):
        self.sio = socketio.Client(reconnection=True, reconnection_attempts=5, reconnection_delay=1, reconnection_delay_max=5)
        self.location_thread = None

    def connect(self, url):
        try:
            self.sio.connect(url, transports=['websocket'])
            print('Conectado al servidor')
            self.sio.emit('join', {})
            print('Emitiendo join')
            self.sio.emit('start', {})
            print('Emitiendo start')
            self.sio.emit('newPosition', {"nameValuePairs":{"full":False,"panicking":False,"capacity":0,"latitude":-34.3940887,"longitude":-70.7813181,"speed":0.0}})
            print('Emitiendo newPosition')
        except Exception as e:
            print(f'Error de conexión: {e}')
            raise

    def emit_event(self, event, data):
        self.sio.emit(event, data)
        print(f'Emitiendo {event}')

    def close_connection(self):
        self.sio.disconnect()
        print('Desconectado del servidor')

    def start_sending_location(self):
        def send_location():
            while True:
                if not self.sio.connected:
                    break
                print('Enviando Localizacion')
                self.sio.emit('newPosition', {"nameValuePairs":{"full":False,"panicking":False,"capacity":0,"latitude":-34.3940887,"longitude":-70.7813181,"speed":0.0}})
                time.sleep(5)
        self.location_thread = threading.Thread(target=send_location)
        self.location_thread.start()

    def wait_for_response(self, event, timeout=10):
        self.sio.wait_for(event, timeout)
