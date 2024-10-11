import asyncio
import websockets
import json
from datetime import datetime
import random

# Datos proporcionados
token = "7973fec7eb3f5144e8338f04f5d2e50746a0551f9f7fdf38b3fdb044237b45e151eb1c47de556c6a7901aa6748adbf58b682103ee416f2272ee195d114ad1803"
community_id = "653fd601f90509541a748683"
uri_receive_pbStandby = f"wss://stage.allrideapp.com/socket.io/pbStandby?token={token}&communityId={community_id}&EIO=3&transport=websocket"

async def update_position_periodically(websocket, interval=3):
    while True:
        latitude = -33.45222 + random.uniform(-0.001, 0.001)
        longitude = -70.66222 + random.uniform(-0.001, 0.001)
        speed = random.uniform(0, 100)  # Simulación de velocidad
        
        obj = {
            "latitude": latitude,
            "longitude": longitude,
            "speed": speed,
            "createdAt": datetime.now().isoformat()
        }
        message = f'42["stop",{json.dumps(obj)}]'
        await websocket.send(message)
        print(f"Sent data: {message}")

        await asyncio.sleep(interval)

async def listen_for_requests(uri_receive):
    try:
        async with websockets.connect(uri_receive, extra_headers={"version": "v2"}) as websocket_receive:
            print("Connected to the receive socket for pbStandby, listening for data...")

            # Handle initial handshake and send '40' to confirm connection
            initial_handshake = await websocket_receive.recv()
            print(f"Initial handshake: {initial_handshake}")
            await websocket_receive.send('40')  # Send "open" message to confirm connection

            async def send_ping():
                while True:
                    try:
                        await websocket_receive.send('2')  # Send ping
                        print("Sent ping")
                        await asyncio.sleep(25)  # Ping interval, adjust as needed
                    except websockets.ConnectionClosed:
                        break

            asyncio.create_task(send_ping())

            # Start receiving messages and updating position
            await asyncio.gather(
                update_position_periodically(websocket_receive, interval=3),
                receive_messages(websocket_receive)
            )

    except websockets.exceptions.InvalidURI as e:
        print(f"Receive socket invalid URI: {e}")
    except Exception as e:
        print(f"An error occurred on receive socket: {e}")

async def receive_messages(websocket_receive):
    while True:
        try:
            response = await websocket_receive.recv()
            print(f"Received response: {response}")
            if response.startswith('42["newRequest"'):
                handle_new_request(response)
        except websockets.exceptions.ConnectionClosedOK:
            print("Connection closed by the server")
            break
        except websockets.exceptions.ConnectionClosedError as e:
            print(f"Connection closed with error: {e}")
            break

def handle_new_request(response):
    print(f"Handling new request: {response}")
    try:
        data = json.loads(response[2:])[1]  # Parse JSON after '42'
        print(f"Parsed new request data: {data}")
        # Implement your logic here, e.g., store the request, log it, or take action based on its content
    except json.JSONDecodeError as e:
        print(f"Failed to parse new request data: {e}")

async def main():
    await listen_for_requests(uri_receive_pbStandby)

if __name__ == "__main__":
    asyncio.run(main())
