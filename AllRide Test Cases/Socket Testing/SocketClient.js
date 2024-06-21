const io = require('socket.io-client');

// URL del WebSocket de socket.io
const websocket_url = "https://stage.allrideapp.com/socket.io/cpDriver?token=1f7169231ec36bc77996f1f880649e9e0d6fded6955552bca71d1878fd51c868acfaa3295ad24bf58c230e165e43de1956930a7ec6d33d90623422b18b1df35f&EIO=4&transport=websocket";

// Conectar al servidor
const socket = io(websocket_url, {
    transports: ['websocket']
});

socket.on('connect', () => {
    console.log('WebSocket connection opened');

    // Emitir evento para desconectar a todos los clientes
    socket.emit('forceDisconnectAll');
    console.log('Emitting forceDisconnectAll');

    setTimeout(() => {
        socket.disconnect();
    }, 1000);
});

socket.on('disconnect', () => {
    console.log('Disconnected from server');
});

socket.on('connect_error', (error) => {
    console.error('Connection error:', error);
});
