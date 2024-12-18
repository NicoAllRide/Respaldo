*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON


*** Test Cases ***

App Messaging to Community Members
    Create Session    mysesion    https://stage.allrideapp.com/    verify=true

    ${headers}=    Create Dictionary    Authorization=Bearer token    Content-Type=application/json; charset=utf-8

    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/appMessaging/send/?community=idComunidad
    ...    data={"pushNotification":{"title":"Notificación Push Test RF","content":"Notificación Push Test RF"},"fullMessage":{"title":"Notificación Push Test RF","content":"Notificación Push Test RF","image":"","externalURL":"","cta":"pb_reservations","buttonText":"¡Vamos!"},"destinataries":"communityMembers"}
    ...    headers=${headers}

    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200        No se pueden enviar mensajes a la comunidad
    Log    ${code}


    ## Debes reemplazar el idComunidad por el id de tu comunidad, por lo que en tu comunidad debes tener habilitada la mensajería de la app. Debe ser en una comunidad que no sea ni Pruebas automatización ni Comunidad automatización2.

    ##Debes reemplazar lo que está en token por el token de tu admin, ya sabes esto, pero cómo recordatorio debes poner inspeccionar, cargar alguna vista, luego en network, entras a una solicitud, vas a headers---authorization: y está tu Bearer token

    ##En data aparece la información de la solicitud POST de base, si lo envías deberia llegarte al correo de tus administradores
    ## Hay distintas combinaciones, para poder tener todas estas combinaciones primero debes hacerlas de manera manual, con network abierto, creas el mensaje a la app y captas la solicitud post, dentro de la solicitud post debes revisar payload, el payload es lo que va en data, te recomiendo que utilices  https://jsonformatter.curiousconcept.com/#
    ##Pegas ahí el json que está en el payload, y lo dejas con modo compact, una vez en modo compact lo pegas en data

    ##No hay tanta información porque ya hemos visto esto en sesiones anteriores! 
    # Esta es una solicitud POST por lo que siempre debe tener un data o body
    # Son hartas combinaciones así que una vez que hagas algunas manuales,m puedes ir verificando cuales son los parámetros que se cambian en data, para después modificarlo directamente desde allí y no tener que hacer nada manual
    # Si tienes alguna duda me escribes! Buen finde!
