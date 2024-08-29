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


{"_id":"66ba69a6e7323a17ad7625ef","trail":{"enabled":false,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"mon","time":"16:59","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"allowedOnValidation":[],"allowedOnReservation":[],"allowedOnVisibility":[],"passengersMustComply":true,"validation":{"enabled":false,"excludes":false,"parameter":[]},"reservation":{"enabled":false,"excludes":false,"parameter":[]},"visibility":{"enabled":false,"excludes":false,"parameter":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":true,"list":[{"userId":"653ff52433d83952fafcf397"}]},"stopSchedule":[{"stopId":"655d11d88a5a1a1ff0328466","scheduledDate":null},{"stopId":"655d11d88a5a1a1ff0328464","scheduledDate":null}],"defaultResources":[],"_ogIndex":0}],"stopOnReservation":true,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":true,"list":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":false,"allowed":["66ba69a6e7323a17ad7625ef"],"visibility":{"enabled":false,"excludes":false,"parameters":[]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":false},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"assistantIds":[],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["653fd601f90509541a748683"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":true,"hasBeacons":true,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":true,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":true,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":false,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":false,"usesOfflineCount":false,"hasBoardings":true,"hasUnboardings":true,"usesManualSeat":true,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"name":"Reserva Usuario Admin","shapeId":"65ef21aa6f1c17c2eeeb5f98","description":"templateRobotTickets","extraInfo":"","color":"502929","legOptions":[],"ownerIds":[{"_id":"66ba69a6e7323a17ad7625f4","id":"653fd601f90509541a748683","role":"community"}],"segments":[],"roundOrder":[{"stopId":"655d11d88a5a1a1ff0328466","notifyIfPassed":false},{"stopId":"655d11d88a5a1a1ff0328464","notifyIfPassed":false}],"superCommunityId":"653fd68233d83952fafcd4be","communityId":"653fd601f90509541a748683","routeCost":100,"ticketCost":10,"timeOnRoute":11,"distance":4,"distanceInMeters":3840,"originStop":"655d11d88a5a1a1ff0328466","destinationStop":"655d11d88a5a1a1ff0328464","customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-08-12T19:59:34.370Z","updatedAt":"2024-08-12T19:59:34.370Z","__v":0}