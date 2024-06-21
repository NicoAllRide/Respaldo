const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server, {
    cors: {
        origin: "*",
    }
});

// Endpoint para iniciar la salida
app.post('/api/v1/cp/round', (req, res) => {
    const routeId = req.body.routeId;
    console.log(`Start route with ID: ${routeId}`);
    // Aquí puedes manejar la lógica para iniciar la salida
    res.status(200).send({ message: 'Route started', routeId });
});

// Conexión del socket
io.on('connection', (socket) => {
    console.log('A client connected: ', socket.id);

    socket.on('disconnect', () => {
        console.log('A client disconnected: ', socket.id);
    });

    // Listener para desconectar a todos los clientes
    socket.on('forceDisconnectAll', () => {
        console.log('Forcing disconnection of all clients');
        for (let [id, socket] of io.of("/").sockets) {
            socket.disconnect(true);
        }
    });
});

server.listen(3000, () => {
    console.log('Server is running on port 3000');
});
