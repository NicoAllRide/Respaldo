
*** Test Cases ***
Validaciones Por Cupo Con Servicios Consecutivos

    # Parte 1: Primer conductor inicia servicio con vehículo de capacidad 3
    # Tiene 5 usuarios con reserva (U1 a U5) y 2 sin reserva (U6, U7)

    # Inicia servicio
    Iniciar Servicio    Conductor1    Vehiculo1

    # Usuario sin reserva intenta validar (U6) - Rechazado por cupo
    Validar Usuario Sin Reserva    U6    Rechazado Por Cupo

    # Usuarios con reserva se validan correctamente (U1, U2, U3)
    Validar Usuario Con Reserva    U1    Aceptado
    Validar Usuario Con Reserva    U2    Aceptado
    Validar Usuario Con Reserva    U3    Aceptado

    # Usuario con reserva intenta validar pero es rechazado por cupo (U4)
    Validar Usuario Con Reserva    U4    Rechazado Por Cupo

    # Parte 2: Segundo conductor inicia nuevo servicio con vehículo de capacidad 3
    Iniciar Servicio    Conductor2    Vehiculo2

    # U4 con reserva se valida correctamente
    Validar Usuario Con Reserva    U4    Aceptado

    # U5 sin reserva se valida correctamente
    Validar Usuario Sin Reserva    U5    Aceptado

    # U1 intenta validar pero ya fue validado en otro servicio
    Validar Usuario Con Reserva    U1    Ya Validado En Otro Servicio

    # U6 intenta validar sin reserva - Rechazado por cupo
    Validar Usuario Sin Reserva    U6    Rechazado Por Cupo

    # U7 con reserva se valida correctamente
    Validar Usuario Con Reserva    U7    Aceptado

    # U6 vuelve a intentar validar sin reserva - Rechazado por cupo
    Validar Usuario Sin Reserva    U6    Rechazado Por Cupo
