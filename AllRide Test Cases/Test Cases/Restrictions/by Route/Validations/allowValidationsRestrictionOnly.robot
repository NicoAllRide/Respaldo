*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../../../Variables/variablesStage.robot

*** Variables ***

${current_time}=    Evaluate    time.time() + 360    time
${formatted_time}=    Evaluate    time.strftime('%a, %d %b %Y %H:%M:%S GMT', time.gmtime(${current_time}))    time



*** Test Cases ***
Set Date Variables
    ${fecha_hoy}=    Get Current Date    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_hoy}

    ${fecha_manana}=    Add Time To Date    ${fecha_hoy}    1 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_manana}

    ${fecha_pasado_manana}=    Add Time To Date    ${fecha_hoy}    2 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_pasado_manana}
    ${fecha_pasado_pasado_manana}=    Add Time To Date    ${fecha_hoy}    3 days    result_format=%Y-%m-%d
    Set Global Variable    ${fecha_pasado_pasado_manana}

    ${dia_actual}=    Convert Date    ${fecha_hoy}    result_format=%a
    ${dia_actual_lower}=    Set Variable    ${dia_actual.lower()}
    ${dia_manana}=    Convert Date    ${fecha_manana}    result_format=%a
    ${dia_manana_lower}=    Set Variable    ${dia_manana.lower()}

    ${arrival_date}=    Set Variable    ${fecha_manana}T01:00:00.000Z
    Set Global Variable    ${arrival_date}
    ${r_estimated_arrival1}=    Set Variable    ${fecha_manana}T14:45:57.000Z
    Set Global Variable    ${r_estimated_arrival1}
    ${service_date}=    Set Variable    ${fecha_manana}T00:25:29.000Z
    Set Global Variable    ${service_date}
    ${modified_arrival_date}=    Set Variable    ${fecha_manana}T01:00:00.000Z
    Set Global Variable    ${modified_arrival_date}
    ${r_modified_estimated_arrival}=    Set Variable    ${fecha_pasado_manana}T14:45:57.000Z
    Set Global Variable    ${r_modified_estimated_arrival}
    ${modified_service_date}=    Set Variable    ${fecha_manana}T00:25:29.000Z
    Set Global Variable    ${modified_service_date}
    ${service_date_20min}=    Set Variable    ${fecha_manana}T00:20:00.000Z
    Set Global Variable    ${service_date_20min}
    ${service_date_22min}=    Set Variable    ${fecha_manana}T00:47:00.000Z
    Set Global Variable    ${service_date_22min}
    ${start_date}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    Set Global Variable    ${start_date}
    ${end_date_4weeks}=    Set Variable    2023-12-30T02:59:59.999Z
    Set Global Variable    ${end_date_4weeks}
    ${end_date}=    Set Variable    ${fecha_pasado_pasado_manana}T03:00:00.000Z
    Set Global Variable    ${end_date}
    ${end_date_tomorrow}=    Set Variable    ${fecha_manana}T03:00:00.000Z
    Set Global Variable    ${end_date_tomorrow}
    ${schedule_day}=    Set Variable    ${dia_actual_lower}
    Set Global Variable    ${schedule_day}
    ${schedule_day_tomorrow}=    Set Variable    ${dia_manana_lower}
    Set Global Variable    ${schedule_day_tomorrow}
    ${start_date_today}=    Set Variable    ${fecha_hoy}T03:00:00.000Z
    Set Global Variable    ${start_date_today}
    ${today_date}=    Set Variable    ${fecha_hoy}
    Set Global Variable    ${today_date}
    ${end_date_tomorrow2}=    Set Variable    ${fecha_manana}T02:59:59.999Z
    Set Global Variable    ${end_date_tomorrow}
    ${expiration_date_qr}=    Set Variable    ${fecha_manana}T14:10:37.968Z
    Set Global Variable    ${expiration_date_qr}
    ${start_date_tickets}=     Set Variable     ${fecha_hoy}T04:00:00.000Z
        Set Global Variable    ${start_date_tickets}
    ${end_date_tickets}=     Set Variable     ${fecha_manana}T03:59:59.999Z
        Set Global Variable    ${end_date_tickets}

    ${start_date_tomorrow2}=    Set Variable    ${fecha_manana}T04:00:00.000Z
    Set Global Variable     ${start_date_tomorrow2}

    ${end_date_pastTomorrow}=    Set Variable    ${fecha_pasado_manana}T03:59:59.999Z
    Set Global Variable    ${end_date_pastTomorrow}


1 hours local
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    1 hour
    ${formatted_one_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_one_hour_later}
    Set Global Variable    ${formatted_one_hour_later}
2 hours local
    ${date}    Get Current Date    time_zone=local    exclude_millis=yes
    ${formatted_date}    Convert Date    ${date}    result_format=%H:%M:%S
    Log    Hora Actual: ${formatted_date}

    # Sumar una hora
    ${one_hour_later}    Add Time To Date    ${date}    2 hour
    ${formatted_two_hour_later}    Convert Date    ${one_hour_later}    result_format=%H:%M
    Log    Hora Actual + 1 hora: ${formatted_two_hour_later}
    Set Global Variable    ${formatted_two_hour_later}


## ----------------------------VISIBILIDAD-----------------------------------------------------##

Modify community (No external validation)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=api/v1/admin/community/6654ae4eba54fe502d4e4187
    ...    data={"_id":"6654ae4eba54fe502d4e4187","config":{"general":{"hasSubsidy":{"active":false,"subsidizedUsers":[],"userAmount":null,"subsidizedAmount":null},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"params":[{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a66","name":"rut","description":"rut","dataType":"rut","isUserStop":false,"validationExpr":""},{"mandatory":false,"check":false,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a67","name":"address","description":"Domicilio","dataType":"location","isUserStop":true,"validationExpr":""},{"mandatory":false,"check":false,"show":false,"private":true,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a68","name":"coordinates","description":"Coordenadas","dataType":"coordinates","isUserStop":true,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a69","name":"Color","description":"","dataType":"string","isUserStop":false,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a6a","name":"Animal","description":"","dataType":"string","isUserStop":false,"validationExpr":""}],"enabled":true},"balance":{"enabled":true},"betaFeatures":[],"allowsManualUsers":true,"replacesManualUser":false,"allowAds":true,"allowCustomEmail":false,"allowCustomId":false,"hasUserMessagingSystem":true,"public":true,"assocCommunities":[],"hidePersonalInfoForSC":false,"ui":{},"privacySettings":{"general":{"hidePersonalInfoForSC":false},"privateBus":{"hideSCDriverNames":false,"hideSCRouteParams":false,"restrictAdmins":{"serviceCost":{"enabled":false,"allowed":"admins","adminIds":[],"adminLevels":[],"roleIds":[]}}}},"products":{"enabled":true},"allowsValidationOptions":false,"allowsCustomJoinWithoutEmailCheck":false},"privateBus":{"userApp":{"allowsMultipleReservations":{"enabled":true,"amountLimit":0}},"oDDSettings":{"joinNewAdminODDs":true,"enableToNewUsers":{"enabled":true,"specificParams":{"enabled":false,"params":[]}}},"scheduling":{"enabled":true,"allowSeatReservations":true,"autoAssignReservations":{"enabled":false},"dynamicResourceAssignment":{"enabled":true,"limitTime":5,"limitUnit":"minutes"},"reservation":{"restrictions":{"enabled":false,"amount":1,"time":1,"unit":"days","userSkip":[]},"enabled":false},"minimumConfirmationTime":{"enabled":true,"amount":3,"unit":"minutes"},"minimumTimeToAccept":{"enabled":true,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]}},"minimumTimeToStart":{"enabled":false,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]}},"minimumTimeToAssignDriver":{"enabled":true,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]}},"admin":{"skipAllReservationsAssignedCheck":true},"apportioning":{"enabled":false,"type":"estimated"},"serviceCreationAnticipation":4},"budgetSystem":{"enabled":false},"restrictiveLabels":{"enabled":true,"labels":["etiqueta1"]},"validation":{"timestamp":{"userSkip":[],"enabled":true,"allowsSkip":true},"dailyLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":0},"timeLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":1,"time":1,"unit":"minutes"},"departureLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":0},"DNIValidation":{"enabled":true,"field":"rut","allowsExternal":true},"bCValidation":{"enabled":true,"field":""},"customQRValidation":{"enabled":true,"field":"Rut"},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":true,"dataType":"text","options":[],"name":"rut","description":"rut"},"customValidationParams":{"driverParams":[],"passengerParams":[]},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"enabled":true,"allowsStatic":false,"usesTickets":true,"ticketPrice":100,"usesPasses":true,"external":[]},"assistant":{"entryTimes":[],"departureTimes":[],"enabled":false,"collecting":false,"description":""},"poll":{"active":false,"answeredBy":[]},"snapshots":{"service":{"enabled":true,"retentionTime":{"amount":0,"unit":"hours"}},"nonService":{"enabled":false}},"harassmentAssistanceSettings":{"enabled":true,"showTextAbove":true,"aboveText":"","showInformation":true,"informationText":""},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"reports":{"visibleCode":"plate"},"driverApp":{"visibleCode":"plate","allowsReuseVehicles":true},"passengerApp":{"visibleCode":"plate"},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":false},"emergencyCall":{"enabled":true},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"restrictRTL":{"enabled":false},"emergencyCallSettings":{"enabled":true},"enabled":true,"apportionCategories":[],"labels":["etiqueta1"],"allowsRating":true,"allowsSnapshots":false,"allowsScreenshots":true,"usesPin":false,"noPassengerInfo":false,"allowGenericVehicles":true,"oDDServices":[{"pricing":{"timeDistanceConfig":{"baseFare":0,"costPerKm":0,"costPerMinute":0,"tolls":[],"additionalCharges":[]},"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[]},"maximumReservationTime":{"amount":1,"unit":"minutes"},"minimumReservationTime":{"amount":1,"unit":"minutes"},"minimumApprovationAnticipationTime":{"amount":1,"unit":"hours","enabled":false},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"joinTimeLimit":{"amount":20,"unit":"minutes"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"destinataries":"admins"},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"destinataries":"admins"},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"destinataries":"admins"},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"destinataries":"admins"},"enabled":false,"amount":1,"unit":"hours"},"notifyNewODDRequest":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false},"notifyNewODDCreated":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false},"notifyApprovedODD":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyUnboardedPassengers":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false,"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false,"sendAt":"eachStop"},"notifySkippedStop":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false},"notifyAdmins":{"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"}},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"pastServicesApproval":{"enabled":true},"validateDeparture":{"enabled":false},"userRequests":{"freeRequests":{"enabled":true,"asap":false},"emergencyRequests":{"enabled":false},"exclusiveRequests":{"enabled":false},"limitedOptions":{"enabled":false},"multipleRequests":{"enabled":false,"amountLimit":0},"joinDepartures":{"enabled":true,"maxCapacity":5,"distanceRatio":0},"reasons":{"list":[],"enabled":false},"defaultProvider":"653fd68233d83952fafcd4be"},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false,"amount":null}},"restrictRequests":{"forService":{"settings":{"reservationSchedule":{"enabled":false,"minimum":"","maximum":""},"userCustomParams":{"enabled":false,"params":[]},"geographical":{"enabled":false,"zones":[]},"providers":[]},"enabled":false},"forProviders":{"enabled":false,"settings":[]}},"allowsEdit":{"settings":{"startLocation":true,"endLocation":true,"serviceDate":true,"state":""},"enabled":true},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100,"enabled":false,"stopId":null},"enabled":true,"reasons":["Personal"],"hideEstimatedTimes":false,"allowsMultipleDrivers":true,"allowsDistance":true,"_id":"67486d74c789b3f78bf7639e","name":"Taxis Nico","icon":"https://s3.amazonaws.com/allride.odd.icons/odd_taxi_icon.jpg","approvers":[],"entryTimes":[],"exitTimes":[],"notifications":[{"active":true,"_id":"67486d74c789b3f78bf7639f","action":"oDDepartureAccepted"},{"active":true,"_id":"67486d74c789b3f78bf763a0","action":"oDDepartureStart"},{"active":true,"_id":"67486d74c789b3f78bf763a1","action":"oDDepartureEnd"},{"active":true,"_id":"67486d74c789b3f78bf763a2","action":"oDDepartureStopSkiped"},{"active":true,"_id":"67486d74c789b3f78bf763a3","action":"oDDepartureAssigned"},{"active":true,"_id":"67486d74c789b3f78bf763a4","action":"oDDepartureCanceled"},{"active":true,"_id":"67486d74c789b3f78bf763a5","action":"oDDepartureDriverAssigned"},{"active":true,"_id":"67486d74c789b3f78bf763a6","action":"oDDepartureDriverReAssigned"},{"active":true,"_id":"67486d74c789b3f78bf763a7","action":"oDDepartureApproved"}],"legOptions":[],"allowsObservations":true}],"fleetParams":[],"driverParams":[],"auxiliaryTrackers":[],"ui":{},"odd":{"pricing":{"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[]},"maximumReservationTime":{"amount":1,"unit":"hours"},"minimumReservationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"amount":1,"unit":"hours"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"joinTimeLimit":{"amount":20,"unit":"minutes"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false,"amount":1,"unit":"hours"},"notifyNewODDRequest":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyNewODDCreated":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyApprovedODD":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"pastServicesApproval":{"enabled":false},"validateDeparture":{"enabled":false},"userRequests":{"reasons":{"list":[]}},"providers":{"restrictCreation":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false}},"enabled":false,"reasons":[],"hideEstimatedTimes":false,"allowsMultipleDrivers":false,"allowsDistance":false,"exclusive":false,"_id":"6654cc38713b9a5184cfdf7f","entryTimes":[],"exitTimes":[],"legOptions":[],"notifications":[],"approvers":[]},"driverCanCreateRoutes":true,"hideSCDriverNames":false,"startUnassignedDeparture":false,"dashboardAssignation":{"asap":{"minutesTillNextDeparture":360}},"trackersVisibility":[],"visible":true,"continuousGpsAlwaysOn":false,"speedAlert":{"enabled":false,"notify":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roles":[]}}},"notifyPassBudgetPercentage":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"percentages":{"general":{"enabled":false,"amount":0,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}}},"rateRoute":{"enabled":false,"withValidation":false}},"parking":{"enabled":false,"enableToAllUsers":false,"reservationByDay":false,"allowsScreenshots":false,"reservationModel":"priority","accessModel":"reservation","controlAccessAndExit":true,"usesCarpoolModel":false,"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hours"},"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"maxAvailableDays":5,"ranges":[],"terms":null,"specificLots":{"enabled":false,"lotIds":[]},"lotIdsAndKeysParams":[],"notifyInactiveUsers":{"enabled":false,"days":7},"chatWithoutReservation":false,"showPhoneNumber":false,"usesTickets":false,"usesPasses":false},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCallSettings":{"enabled":true},"enabled":false,"communityOptions":false,"routePublishingOptions":[],"routeSearchRestrictions":[],"emergencyCall":{"enabled":true}},"cabpool":{"parameters":{"area":null,"originDistrict":null,"destinationDistrict":null,"folio":null,"line":null},"hasSOS":true},"schoolBus":{"enabled":false},"publicBus":{"enabled":true,"visible":true}},"custom":{"privacySettings":{"general":{"hidePersonalInfoForSC":false},"privateBus":{"hideSCDriverNames":false,"hideSCRouteParams":false,"restrictAdmins":{"serviceCost":{"enabled":false,"allowed":"admins","adminIds":[],"adminLevels":[],"roleIds":[]}}}},"hasSubsidy":{"active":false,"subsidizedUsers":[],"userAmount":null,"subsidizedAmount":null},"realTimeTransportSystem":{"buses":{"scheduling":{"enabled":true,"allowSeatReservations":true,"autoAssignReservations":{"enabled":false},"dynamicResourceAssignment":{"enabled":true,"limitTime":5,"limitUnit":"minutes"},"reservation":{"restrictions":{"enabled":false,"amount":1,"time":1,"unit":"days","userSkip":[]}},"minimumConfirmationTime":{"enabled":true,"amount":3,"unit":"minutes"},"minimumTimeToAccept":{"enabled":true,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToStart":{"enabled":false,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToAssignDriver":{"enabled":true,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"admin":{"skipAllReservationsAssignedCheck":true},"apportioning":{"enabled":false,"type":"estimated"},"serviceCreationAnticipation":4},"budgetSystem":{"enabled":false},"apportionCategories":[],"labels":["etiqueta1"],"restrictiveLabels":{"enabled":true,"labels":["etiqueta1"]},"oDDServices":[{"enabled":true,"name":"Taxis Nico","icon":"https://s3.amazonaws.com/allride.odd.icons/odd_taxi_icon.jpg","allowsMultipleDrivers":true,"allowsDistance":true,"exclusive":false,"hideEstimatedTimes":false,"pastServicesApproval":{"enabled":true},"pricing":{"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[],"timeDistanceConfig":{"baseFare":0,"costPerKm":0,"costPerMinute":0,"tolls":[],"additionalCharges":[]}},"reasons":["Personal"],"approvers":[],"entryTimes":[],"exitTimes":[],"maximumReservationTime":{"amount":1,"unit":"minutes"},"minimumReservationTime":{"amount":1,"unit":"minutes"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"minimumTimeToAccept":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToStart":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToAssignDriver":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifyNewODDRequest":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifyNewODDCreated":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifications":[{"action":"oDDepartureAccepted","active":true},{"action":"oDDepartureStart","active":true},{"action":"oDDepartureEnd","active":true},{"action":"oDDepartureStopSkiped","active":true},{"action":"oDDepartureAssigned","active":true},{"action":"oDDepartureCanceled","active":true},{"action":"oDDepartureDriverAssigned","active":true},{"action":"oDDepartureDriverReAssigned","active":true},{"action":"oDDepartureApproved","active":true}],"userRequests":{"freeRequests":{"enabled":true,"asap":false},"limitedOptions":{"enabled":false},"joinDepartures":{"enabled":true,"maxCapacity":5,"distanceRatio":0},"defaultProvider":"653fd68233d83952fafcd4be","emergencyRequests":{"enabled":false},"exclusiveRequests":{"enabled":false},"multipleRequests":{"enabled":false,"amountLimit":0},"reasons":{"enabled":false,"list":[]}},"restrictRequests":{"forService":{"enabled":false,"settings":{"reservationSchedule":{"enabled":false,"minimum":"","maximum":""},"userCustomParams":{"enabled":false,"params":[]},"geographical":{"enabled":false,"zones":[]}}},"forProviders":{"enabled":false,"settings":[]}},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false,"amount":null}},"legOptions":[],"allowsObservations":true,"allowsEdit":{"enabled":true,"settings":{"startLocation":true,"endLocation":true,"serviceDate":true,"state":""}},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"}}}],"oDDSettings":{"joinNewAdminODDs":true,"enableToNewUsers":{"enabled":true,"specificParams":{"enabled":false,"params":[]}}},"allowsRating":true,"allowsScreenshots":true,"snapshots":{"service":{"enabled":true,"retentionTime":{"amount":0,"unit":"hours"}},"nonService":{"enabled":true,"retentionTime":{"amount":0,"unit":"hours"}}},"allowGenericVehicles":true,"usesPin":false,"validation":{"enabled":true,"timestamp":{"enabled":true,"allowsSkip":true},"dailyLimit":{"enabled":false,"allowsSkip":false,"amount":0},"timeLimit":{"enabled":false,"allowsSkip":false,"amount":1,"time":1,"unit":"minutes"},"departureLimit":{"enabled":false,"allowsSkip":false,"amount":0},"allowsStatic":false,"usesTickets":true,"usesPasses":true,"ticketPrice":100,"customValidation":{"enabled":true,"name":"rut","description":"rut"},"customValidationParams":{"driverParams":[],"passengerParams":[],"maxValidationTime":{"amount":1,"unit":"hours"}},"validationToken":"","usesInternalNFC":false,"bCValidation":{"enabled":true,"field":""},"customQRValidation":{"enabled":true,"field":"Rut"},"DNIValidation":{"enabled":true,"field":"rut","allowsExternal":true},"external":[]},"assistant":{"enabled":false,"entryTimes":[],"departureTimes":[],"collecting":false,"description":""},"harassmentAssistanceSettings":{"enabled":true,"showTextAbove":true,"aboveText":"","showInformation":true,"informationText":""},"harassmentAssistance":true,"healthPoll":{"enabled":false,"askUser":false},"custom":{"driverApp":{"visibleCode":"plate"},"passengerApp":{"visibleCode":"plate"},"reports":{"visibleCode":"plate"}},"internalLegs":{"enabled":false},"fleetParams":[],"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"auxiliaryTrackers":[],"startUnassignedDeparture":false,"validateDeparture":{"enabled":true},"dashboardAssignation":{"asap":{"minutesTillNextDeparture":360}},"passengerList":{"enabled":false,"data":{"fullName":false,"validationParam":false,"phone":false,"community":false}},"notifyPassBudgetPercentage":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"percentages":{"general":{"enabled":false,"amount":0,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}}},"userApp":{"allowsMultipleReservations":{"enabled":true,"amountLimit":0}},"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false,"notify":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}}}},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCallSettings":{"enabled":true},"enabled":false,"communityOptions":false,"routePublishingOptions":[],"routeSearchRestrictions":[],"emergencyCall":{"enabled":true}},"cabpool":{"parameters":{"area":null,"originDistrict":null,"destinationDistrict":null,"folio":null,"line":null},"hasSOS":true},"schoolbus":{"enabled":false}},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"params":[{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a66","name":"rut","description":"rut","dataType":"rut","isUserStop":false,"validationExpr":""},{"mandatory":false,"check":false,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a67","name":"address","description":"Domicilio","dataType":"location","isUserStop":true,"validationExpr":""},{"mandatory":false,"check":false,"show":false,"private":true,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a68","name":"coordinates","description":"Coordenadas","dataType":"coordinates","isUserStop":true,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a69","name":"Color","description":"","dataType":"string","isUserStop":false,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a6a","name":"Animal","description":"","dataType":"string","isUserStop":false,"validationExpr":""}],"enabled":true},"parkingLots":{"enabled":false,"enableToAllUsers":false,"reservationByDay":false,"allowsScreenshots":false,"reservationModel":"priority","accessModel":"reservation","controlAccessAndExit":true,"usesCarpoolModel":false,"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hours"},"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"maxAvailableDays":5,"ranges":[],"terms":null,"specificLots":{"enabled":false,"lotIds":[]},"lotIdsAndKeysParams":[],"notifyInactiveUsers":{"enabled":false,"days":7},"chatWithoutReservation":false,"showPhoneNumber":false,"usesTickets":false,"usesPasses":false},"balance":{"enabled":true},"betaFeatures":[],"allowsManualUsers":true,"replacesManualUser":false,"allowAds":true,"allowCustomEmail":false,"allowCustomId":false,"hasUserMessagingSystem":true,"driverCanCreateRoutes":true,"products":{"enabled":true}},"emailSuffixes":[],"admins":[],"timezone":"Chile/Continental","type":"normal","distance":0,"allowAds":false,"assocCommunities":[],"public":true,"name":"Comunidad Automatización 2","site":"http://adminstage.allrideapp.com","terms":null,"country":"cl","isStudentsCommunity":false,"hasBusesSystem":true,"language":"es","avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_6654ae4eba54fe502d4e4187_1717603083265.png","badge":"https://s3.amazonaws.com/allride.uploads/communityAvatar_6654ae4eba54fe502d4e4187_1717603083787.png","createdAt":"2024-05-27T16:01:18.808Z","updatedAt":"2024-11-28T13:17:41.077Z","__v":391}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}


Modify Route (Validation Allow to User Only)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=api/v1/admin/pb/routes/66cc94821125fb1232f990a1?community=6654ae4eba54fe502d4e4187
    ...    data={"_id":"66cc94821125fb1232f990a1","trail":{"enabled":true,"adjustByRounds":false},"rounds":{"enabled":false,"anchorStops":[]},"notifyUsersByStop":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyUnboardedPassengers":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifySkippedStop":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"excludePassengers":{"active":false,"excludeType":"dontHide"},"scheduling":{"enabled":true,"limitUnit":"minutes","limitAmount":30,"lateNotification":{"enabled":false,"amount":0,"unit":"minutes"},"stopNotification":{"enabled":false,"amount":0,"unit":"minutes"},"startLimit":{"upperLimit":{"amount":60,"unit":"minutes"},"lowerLimit":{"amount":30,"unit":"minutes"}},"defaultServiceCost":null,"schedule":[{"enabled":true,"day":"mon","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":0},{"enabled":true,"day":"tue","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":1},{"enabled":true,"day":"wed","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":2},{"enabled":true,"day":"thu","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":3},{"enabled":true,"day":"fri","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":4},{"enabled":true,"day":"sat","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":5},{"enabled":true,"day":"sun","time":"16:00","estimatedArrival":null,"capped":{"enabled":false,"capacity":0},"vehicleCategoryId":null,"restrictPassengers":{"enabled":false,"visibility":{"enabled":false,"excludes":false,"parameters":[]},"reservation":{"enabled":false,"excludes":false,"parameters":[]},"validation":{"enabled":false,"excludes":false,"parameters":[]}},"serviceCost":0,"observations":"","reservations":{"enabled":false,"list":[]},"stopSchedule":[],"defaultResources":[],"_ogIndex":6}],"stopOnReservation":false,"restrictions":{"customParams":{"enabled":false,"params":[]}},"reservations":{"enabled":false,"list":[]}},"endDepartureNotice":{"enabled":false,"lastStop":null},"restrictPassengers":{"enabled":true,"allowed":["66cc94821125fb1232f990a1"],"visibility":{"enabled":false,"excludes":true,"parameters":[]},"reservation":{"enabled":false,"excludes":true,"parameters":[{"key":"Color","values":["Azul"]}]},"validation":{"enabled":true,"excludes":false,"parameters":[{"key":"Color","values":["Azul"]}]}},"snapshots":{"enabled":false},"validationParams":{"enabled":false,"driverParams":[],"passengerParams":[]},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"assistantIds":[],"superCommunities":["653fd68233d83952fafcd4be"],"communities":["6654ae4eba54fe502d4e4187"],"active":true,"visible":true,"internal":false,"anchorStops":[],"isStatic":false,"labels":[],"hasExternalGPS":false,"hasCapacity":false,"hasBeacons":false,"hasRounds":false,"hasBoardingCount":false,"hasUnboardingCount":false,"usesBusCode":false,"usesVehicleList":true,"dynamicSeatAssignment":true,"usesDriverCode":false,"usesDriverPin":false,"usesTickets":false,"usesPasses":false,"usesTextToSpeech":false,"allowsManualValidation":true,"allowsRating":true,"allowsOnlyExistingDrivers":false,"allowsMultipleDrivers":false,"allowsDebugging":false,"startsOnStop":false,"notNearStop":false,"allowsNonServiceSnapshots":false,"allowsServiceSnapshots":false,"allowsDistance":true,"usesOfflineCount":false,"hasBoardings":false,"hasUnboardings":false,"usesManualSeat":false,"noPassengerInfo":false,"showParable":false,"showStops":true,"allowGenericVehicles":true,"usesVehicleQRLink":false,"skipDeclaration":false,"skipQRValidation":false,"name":"Ruta Restricciones RF","shapeId":"6654d532713b9a5184cfe2e3","description":"Probar distintos casos de restricciones de manera automatizada","extraInfo":"","color":"712a2a","legOptions":[],"ownerIds":[{"_id":"66cc94821125fb1232f990a5","id":"6654ae4eba54fe502d4e4187","role":"community"}],"segments":[{"_id":"66ccd5c21125fb1232f9a968","position":1,"distance":290.2660419534011,"lat":-34.408530000000006,"lon":-70.85308,"loc":[-70.85308,-34.408530000000006]},{"_id":"66ccd5c21125fb1232f9a969","position":2,"distance":488.1040403831149,"lat":-34.40699,"lon":-70.852,"loc":[-70.852,-34.40699]},{"_id":"66ccd5c21125fb1232f9a96a","position":3,"distance":781.9113593811135,"lat":-34.40496,"lon":-70.84995,"loc":[-70.84995,-34.40496]},{"_id":"66ccd5c21125fb1232f9a96b","position":4,"distance":1104.6940260856932,"lat":-34.40296,"lon":-70.84740000000001,"loc":[-70.84740000000001,-34.40296]},{"_id":"66ccd5c21125fb1232f9a96c","position":5,"distance":1122.8597601245997,"lat":-34.402800000000006,"lon":-70.84736000000001,"loc":[-70.84736000000001,-34.402800000000006]},{"_id":"66ccd5c21125fb1232f9a96d","position":6,"distance":1292.2891375798047,"lat":-34.40267,"lon":-70.84552000000001,"loc":[-70.84552000000001,-34.40267]},{"_id":"66ccd5c21125fb1232f9a96e","position":7,"distance":1459.1985795046444,"lat":-34.40229,"lon":-70.84376,"loc":[-70.84376,-34.40229]},{"_id":"66ccd5c21125fb1232f9a96f","position":8,"distance":1583.0555768914546,"lat":-34.40229,"lon":-70.84241,"loc":[-70.84241,-34.40229]},{"_id":"66ccd5c21125fb1232f9a970","position":9,"distance":2238.7794491503846,"lat":-34.40344,"lon":-70.8354,"loc":[-70.8354,-34.40344]},{"_id":"66ccd5c21125fb1232f9a971","position":10,"distance":2367.730135581892,"lat":-34.40379,"lon":-70.83406000000001,"loc":[-70.83406000000001,-34.40379]},{"_id":"66ccd5c21125fb1232f9a972","position":11,"distance":2813.2702156190876,"lat":-34.40545,"lon":-70.82964000000001,"loc":[-70.82964000000001,-34.40545]},{"_id":"66ccd5c21125fb1232f9a973","position":12,"distance":2907.937653439918,"lat":-34.405660000000005,"lon":-70.82864000000001,"loc":[-70.82864000000001,-34.405660000000005]},{"_id":"66ccd5c21125fb1232f9a974","position":13,"distance":3103.8542952895764,"lat":-34.40598,"lon":-70.82654000000001,"loc":[-70.82654000000001,-34.40598]},{"_id":"66ccd5c21125fb1232f9a975","position":14,"distance":3399.7333701489256,"lat":-34.406130000000005,"lon":-70.82332000000001,"loc":[-70.82332000000001,-34.406130000000005]},{"_id":"66ccd5c21125fb1232f9a976","position":15,"distance":3777.3304160935245,"lat":-34.40782,"lon":-70.81975,"loc":[-70.81975,-34.40782]},{"_id":"66ccd5c21125fb1232f9a977","position":16,"distance":4027.852872329667,"lat":-34.409060000000004,"lon":-70.81747,"loc":[-70.81747,-34.409060000000004]},{"_id":"66ccd5c21125fb1232f9a978","position":17,"distance":4262.946941118368,"lat":-34.40968,"lon":-70.81502,"loc":[-70.81502,-34.40968]},{"_id":"66ccd5c21125fb1232f9a979","position":18,"distance":4331.54548643874,"lat":-34.40997,"lon":-70.81436000000001,"loc":[-70.81436000000001,-34.40997]},{"_id":"66ccd5c21125fb1232f9a97a","position":19,"distance":4470.011462521272,"lat":-34.41068,"lon":-70.81312000000001,"loc":[-70.81312000000001,-34.41068]},{"_id":"66ccd5c21125fb1232f9a97b","position":20,"distance":4569.730370049159,"lat":-34.41037,"lon":-70.8121,"loc":[-70.8121,-34.41037]},{"_id":"66ccd5c21125fb1232f9a97c","position":21,"distance":4885.998380967774,"lat":-34.40916,"lon":-70.80898,"loc":[-70.80898,-34.40916]},{"_id":"66ccd5c21125fb1232f9a97d","position":22,"distance":5117.696468148955,"lat":-34.40769,"lon":-70.80719,"loc":[-70.80719,-34.40769]},{"_id":"66ccd5c21125fb1232f9a97e","position":23,"distance":5264.734491572538,"lat":-34.406670000000005,"lon":-70.80617000000001,"loc":[-70.80617000000001,-34.406670000000005]},{"_id":"66ccd5c21125fb1232f9a97f","position":24,"distance":5425.207136314769,"lat":-34.405620000000006,"lon":-70.80497000000001,"loc":[-70.80497000000001,-34.405620000000006]},{"_id":"66ccd5c21125fb1232f9a980","position":25,"distance":5509.906626643151,"lat":-34.40527,"lon":-70.80415,"loc":[-70.80415,-34.40527]},{"_id":"66ccd5c21125fb1232f9a981","position":26,"distance":5600.221898860165,"lat":-34.40466,"lon":-70.8035,"loc":[-70.8035,-34.40466]},{"_id":"66ccd5c21125fb1232f9a982","position":27,"distance":5755.68153334114,"lat":-34.404250000000005,"lon":-70.80188000000001,"loc":[-70.80188000000001,-34.404250000000005]},{"_id":"66ccd5c21125fb1232f9a983","position":28,"distance":5915.319583664183,"lat":-34.40424,"lon":-70.80014,"loc":[-70.80014,-34.40424]},{"_id":"66ccd5c21125fb1232f9a984","position":29,"distance":6007.047842778099,"lat":-34.40404,"lon":-70.79917,"loc":[-70.79917,-34.40404]},{"_id":"66ccd5c21125fb1232f9a985","position":30,"distance":6182.3341417231395,"lat":-34.40551,"lon":-70.79848000000001,"loc":[-70.79848000000001,-34.40551]},{"_id":"66ccd5c21125fb1232f9a986","position":31,"distance":6367.330377715924,"lat":-34.40664,"lon":-70.79700000000001,"loc":[-70.79700000000001,-34.40664]},{"_id":"66ccd5c21125fb1232f9a987","position":32,"distance":6527.46821540092,"lat":-34.407920000000004,"lon":-70.7962,"loc":[-70.7962,-34.407920000000004]},{"_id":"66ccd5c21125fb1232f9a988","position":33,"distance":7287.353626388585,"lat":-34.404030000000006,"lon":-70.78939000000001,"loc":[-70.78939000000001,-34.404030000000006]},{"_id":"66ccd5c21125fb1232f9a989","position":34,"distance":7845.43322025191,"lat":-34.40109,"lon":-70.78446000000001,"loc":[-70.78446000000001,-34.40109]},{"_id":"66ccd5c21125fb1232f9a98a","position":35,"distance":7882.902565797689,"lat":-34.40119,"lon":-70.78407,"loc":[-70.78407,-34.40119]},{"_id":"66ccd5c21125fb1232f9a98b","position":36,"distance":8083.244366156947,"lat":-34.40008,"lon":-70.78235000000001,"loc":[-70.78235000000001,-34.40008]},{"_id":"66ccd5c21125fb1232f9a98c","position":37,"distance":8151.255642391474,"lat":-34.399550000000005,"lon":-70.78272000000001,"loc":[-70.78272000000001,-34.399550000000005]},{"_id":"66ccd5c21125fb1232f9a98d","position":38,"distance":8242.744317444498,"lat":-34.39882,"lon":-70.78226000000001,"loc":[-70.78226000000001,-34.39882]},{"_id":"66ccd5c21125fb1232f9a98e","position":39,"distance":8448.184416414158,"lat":-34.397040000000004,"lon":-70.78166,"loc":[-70.78166,-34.397040000000004]},{"_id":"66ccd5c21125fb1232f9a98f","position":40,"distance":8467.636269238845,"lat":-34.39687,"lon":-70.78171,"loc":[-70.78171,-34.39687]},{"_id":"66ccd5c21125fb1232f9a990","position":41,"distance":8609.810198718747,"lat":-34.39578,"lon":-70.78252,"loc":[-70.78252,-34.39578]},{"_id":"66ccd5c21125fb1232f9a991","position":42,"distance":8702.762775926865,"lat":-34.395430000000005,"lon":-70.78160000000001,"loc":[-70.78160000000001,-34.395430000000005]},{"_id":"66ccd5c21125fb1232f9a992","position":43,"distance":8729.30555711264,"lat":-34.395250000000004,"lon":-70.78141000000001,"loc":[-70.78141000000001,-34.395250000000004]},{"_id":"66ccd5c21125fb1232f9a993","position":44,"distance":8771.583165938728,"lat":-34.3949,"lon":-70.78123000000001,"loc":[-70.78123000000001,-34.3949]}],"roundOrder":[],"communityId":"6654ae4eba54fe502d4e4187","timeOnRoute":14,"distance":9,"distanceInMeters":8784,"originStop":"6654d4acba54fe502d4e6b6b","destinationStop":"6654d4c8713b9a5184cfe1df","customParams":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"createdAt":"2024-08-26T14:43:15.040Z","updatedAt":"2024-08-27T14:45:00.562Z","__v":39,"superCommunityId":"653fd68233d83952fafcd4be","routeCost":0,"ticketCost":0}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Login User With Email(Color Azul)
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+comunidad2@allrideapp.com","password":"Lolowerty21@"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${loginUserUrl}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenNico}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenNico}

Login User 2 (Sin color)
    

    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    # Configura las opciones de la solicitud (headers, auth)
    ${jsonBody}=    Set Variable    {"username":"nicolas+usuario2comunidad2@allrideapp.com","password":"Lolowerty21@"}
    ${parsed_json}=    Evaluate    json.loads($jsonBody)    json
    ${headers}=    Create Dictionary    Authorization=""    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Post On Session
    ...    mysesion
    ...    url=${loginUserUrl}
    ...    json=${parsed_json}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    ${accessToken}=    Set Variable    ${response.json()}[accessToken]
    ${accessTokenUser2}=    Evaluate    "Bearer ${accessToken}"
    Set Global Variable    ${accessTokenUser2}

##-------------------RUTA RESTRICCIONES RF VISTA EXPLORAR------------------------##

Get Routes and Check "Restricciones RF" Present Nico
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable    https://stage.allrideapp.com/api/v1/pb/user/routes/all/6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${accessTokenNico}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder trabajar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    # Extraemos los nombres de las rutas
    ${route_names}=    Evaluate    [route['name'] for route in ${responseJson}]    json

    # Verificamos que "Restricciones RF" no esté en la lista de rutas
    Should Contain    ${route_names}    Ruta Restricciones RF    Ruta Restricciones RF was not found despite the user allowed

    Log    "Verification passed: 'Ruta Restricciones RF' not found in routes"


Get Routes and Check "Restricciones RF" Present User2
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable    https://stage.allrideapp.com/api/v1/pb/user/routes/all/6654ae4eba54fe502d4e4187

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${accessTokenUser2}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder trabajar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    # Extraemos los nombres de las rutas
    ${route_names}=    Evaluate    [route['name'] for route in ${responseJson}]    json

    # Verificamos que "Restricciones RF" no esté en la lista de rutas
    Should Contain    ${route_names}    Ruta Restricciones RF    Ruta Restricciones RF was not found despite the user has not restrictions

#---Buscar un servicio con el id de la ruta para poder hacer una reservacion exitosa, servicio debe ser pasado----#

Get Tomorrow Service Id
    Skip
    [Tags]    test:retry(1)
    
    # Define la URL del recurso que requiere autenticación para la semana 1
    ${url}=    Set Variable    ${STAGE_URL}/api/v1/admin/pb/allServices?community=${idComunidad2}&startDate=${start_date_tomorrow2}&endDate=${end_date_pastTomorrow}&onlyODDs=false
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}
    ${response}=    GET    url=${url}    headers=${headers}
    ${responseJson}=    Set Variable    ${response.json()}

    # Filtramos los servicios para obtener solo aquellos con el routeId específico
    ${sorted_services}=    Evaluate    [service for service in ${responseJson}[scheduledServices] if service['routeId']['_id'] == '66cc94821125fb1232f990a1']    json

    # Verificamos que se encuentre exactamente un servicio para la semana 1
    Run Keyword If    ${sorted_services} == []    Fatal Error    "No services found in Week 1 with routeId._id = "66cc94821125fb1232f990a1". Stopping test"
    
    ${service}=    Set Variable    ${sorted_services[0]}
    ${service_id}=    Set Variable    ${service['_id']}

    Set Global Variable    ${service_id}

Assign Resources
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url= /api/v1/admin/pb/assignServiceResources/${service_id}?community=${idComunidad2}
    ...    data=[{"multipleDrivers":false,"driver":{"driverId":"${driverId2}"},"drivers":[],"vehicle":{"vehicleId":"${vehicleId2}","capacity":"46"},"passengers":[],"departure":null}]
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Should Be Equal As Numbers    ${code}    200
    Log    ${code}

    Sleep    2s

Get departureId And verify reservation on departure 0
    Skip
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/service/${service_id}?community=${idComunidad}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    Should Be Equal As Numbers    ${response.status_code}    200

    # Almacenamos la respuesta de json en una variable para poder jugar con ella
    ${responseJson}=    Set Variable    ${response.json()}

    ${departureId}=    Set Variable    ${response.json()}[resources][0][departure][departureId]
    Set Global Variable    ${departureId}

    Log    ${departureId}


Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=${idComunidad2}&driverId=${driverId2}

    # Configura las opciones de la solicitud (headers, auth)
    &{headers}=    Create Dictionary    Authorization=${tokenAdmin}

    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    GET    url=${url}    headers=${headers}

    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Should Be Equal As Numbers    ${response.status_code}    200

    ${access_token}=    Set Variable    ${response.json()['accessToken']}
    ${tokenDriver}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${tokenDriver}

    Log    ${tokenDriver}
    Log    ${response.content}

Start Departure Leg
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenDriver}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure
    ...    data={"communityId":"${idComunidad2}","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"customParamsAtTheEnd":[],"routeId":"${restrictionRoute}","capacity":46,"busCode":"171222","driverCode":"159159","vehicleId":"${vehicleId2}","shareToUsers":false,"customParams":[]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${access_token}=    Set Variable    ${response.json()}[token]
    ${departureToken}=    Evaluate    "Bearer " + "${access_token}"
    Set Global Variable    ${departureToken}
    Log    ${departureToken}
    Log    ${code}

Get User QR(Nico)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["666078059a5ece0ee6e95904"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}
Get User QR(User 2)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=${idComunidad2}
    ...    data={"ids":["6667489cb5433b5dc2fa94e9"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeUser2}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeUser2}
    Log    ${qrCodeUser2}
    Log    ${code}

Validate With QR(Nico Only this user can validate) AZUL
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeNico}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
    Sleep    10s
Validate With QR(user 2 Should Fail)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Run Keyword And Ignore Error    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeUser2}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Run Keyword If    '${response}[0]' == 'FAIL'    Log    Validation failed as expected with error: ${response}[1]
    ...    ELSE    Fail    Validation should have failed but returned status code: ${response}[1].status_code
    Sleep    10s

Stop Post Leg Departure
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v2/pb/driver/departure/stop
    ...    data={"customParamsAtEnd":[],"customParamsAtStart":null,"endLat":"-72.6071614","endLon":"-38.7651863","nextLeg":false,"post":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"pre":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"preTripChecklist":null,"service":{"customParamsAtEnd":null,"customParamsAtStart":null,"preTripChecklist":null},"shareToUsers":false}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}

Modify community (With External validation)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=api/v1/admin/community/6654ae4eba54fe502d4e4187
    ...    data={"_id":"6654ae4eba54fe502d4e4187","config":{"general":{"hasSubsidy":{"active":false,"subsidizedUsers":[],"userAmount":null,"subsidizedAmount":null},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"params":[{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a66","name":"rut","description":"rut","dataType":"rut","isUserStop":false,"validationExpr":""},{"mandatory":false,"check":false,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a67","name":"address","description":"Domicilio","dataType":"location","isUserStop":true,"validationExpr":""},{"mandatory":false,"check":false,"show":false,"private":true,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a68","name":"coordinates","description":"Coordenadas","dataType":"coordinates","isUserStop":true,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a69","name":"Color","description":"","dataType":"string","isUserStop":false,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a6a","name":"Animal","description":"","dataType":"string","isUserStop":false,"validationExpr":""}],"enabled":true},"balance":{"enabled":true},"betaFeatures":[],"allowsManualUsers":true,"replacesManualUser":false,"allowAds":true,"allowCustomEmail":false,"allowCustomId":false,"hasUserMessagingSystem":true,"public":true,"assocCommunities":[],"hidePersonalInfoForSC":false,"ui":{},"privacySettings":{"general":{"hidePersonalInfoForSC":false},"privateBus":{"hideSCDriverNames":false,"hideSCRouteParams":false,"restrictAdmins":{"serviceCost":{"enabled":false,"allowed":"admins","adminIds":[],"adminLevels":[],"roleIds":[]}}}},"products":{"enabled":true},"allowsValidationOptions":false,"allowsCustomJoinWithoutEmailCheck":false},"privateBus":{"userApp":{"allowsMultipleReservations":{"enabled":true,"amountLimit":0}},"oDDSettings":{"joinNewAdminODDs":true,"enableToNewUsers":{"enabled":true,"specificParams":{"enabled":false,"params":[]}}},"scheduling":{"enabled":true,"allowSeatReservations":true,"autoAssignReservations":{"enabled":false},"dynamicResourceAssignment":{"enabled":true,"limitTime":5,"limitUnit":"minutes"},"reservation":{"restrictions":{"enabled":false,"amount":1,"time":1,"unit":"days","userSkip":[]},"enabled":false},"minimumConfirmationTime":{"enabled":true,"amount":3,"unit":"minutes"},"minimumTimeToAccept":{"enabled":true,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]}},"minimumTimeToStart":{"enabled":false,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]}},"minimumTimeToAssignDriver":{"enabled":true,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[]}},"admin":{"skipAllReservationsAssignedCheck":true},"apportioning":{"enabled":false,"type":"estimated"},"serviceCreationAnticipation":4},"budgetSystem":{"enabled":false},"restrictiveLabels":{"enabled":true,"labels":["etiqueta1"]},"validation":{"timestamp":{"userSkip":[],"enabled":true,"allowsSkip":true},"dailyLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":0},"timeLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":1,"time":1,"unit":"minutes"},"departureLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":0},"DNIValidation":{"enabled":true,"field":"rut","allowsExternal":true},"bCValidation":{"enabled":true,"field":""},"customQRValidation":{"enabled":true,"field":"Rut"},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":true,"dataType":"text","options":[],"name":"rut","description":"rut"},"customValidationParams":{"driverParams":[],"passengerParams":[]},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"enabled":true,"allowsStatic":false,"usesTickets":true,"ticketPrice":100,"usesPasses":true,"external":[]},"assistant":{"entryTimes":[],"departureTimes":[],"enabled":false,"collecting":false,"description":""},"poll":{"active":false,"answeredBy":[]},"snapshots":{"service":{"enabled":true,"retentionTime":{"amount":0,"unit":"hours"}},"nonService":{"enabled":false}},"harassmentAssistanceSettings":{"enabled":true,"showTextAbove":true,"aboveText":"","showInformation":true,"informationText":""},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"reports":{"visibleCode":"plate"},"driverApp":{"visibleCode":"plate","allowsReuseVehicles":true},"passengerApp":{"visibleCode":"plate"},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":false},"emergencyCall":{"enabled":true},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"restrictRTL":{"enabled":false},"emergencyCallSettings":{"enabled":true},"enabled":true,"apportionCategories":[],"labels":["etiqueta1"],"allowsRating":true,"allowsSnapshots":false,"allowsScreenshots":true,"usesPin":false,"noPassengerInfo":false,"allowGenericVehicles":true,"oDDServices":[{"pricing":{"timeDistanceConfig":{"baseFare":0,"costPerKm":0,"costPerMinute":0,"tolls":[],"additionalCharges":[]},"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[]},"maximumReservationTime":{"amount":1,"unit":"minutes"},"minimumReservationTime":{"amount":1,"unit":"minutes"},"minimumApprovationAnticipationTime":{"amount":1,"unit":"hours","enabled":false},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"joinTimeLimit":{"amount":20,"unit":"minutes"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"destinataries":"admins"},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"destinataries":"admins"},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"destinataries":"admins"},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[],"destinataries":"admins"},"enabled":false,"amount":1,"unit":"hours"},"notifyNewODDRequest":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false},"notifyNewODDCreated":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false},"notifyApprovedODD":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyUnboardedPassengers":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false,"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false,"sendAt":"eachStop"},"notifySkippedStop":{"sendTo":{"emails":[],"adminLevels":[],"roles":[],"destinataries":"admins"},"enabled":false},"notifyAdmins":{"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"}},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"pastServicesApproval":{"enabled":true},"validateDeparture":{"enabled":false},"userRequests":{"freeRequests":{"enabled":true,"asap":false},"emergencyRequests":{"enabled":false},"exclusiveRequests":{"enabled":false},"limitedOptions":{"enabled":false},"multipleRequests":{"enabled":false,"amountLimit":0},"joinDepartures":{"enabled":true,"maxCapacity":5,"distanceRatio":0},"reasons":{"list":[],"enabled":false},"defaultProvider":"653fd68233d83952fafcd4be"},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false,"amount":null}},"restrictRequests":{"forService":{"settings":{"reservationSchedule":{"enabled":false,"minimum":"","maximum":""},"userCustomParams":{"enabled":false,"params":[]},"geographical":{"enabled":false,"zones":[]},"providers":[]},"enabled":false},"forProviders":{"enabled":false,"settings":[]}},"allowsEdit":{"settings":{"startLocation":true,"endLocation":true,"serviceDate":true,"state":""},"enabled":true},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100,"enabled":false,"stopId":null},"enabled":true,"reasons":["Personal"],"hideEstimatedTimes":false,"allowsMultipleDrivers":true,"allowsDistance":true,"_id":"67487c14f5f6ec8cacaaa645","name":"Taxis Nico","icon":"https://s3.amazonaws.com/allride.odd.icons/odd_taxi_icon.jpg","approvers":[],"entryTimes":[],"exitTimes":[],"notifications":[{"active":true,"_id":"67487c14f5f6ec8cacaaa646","action":"oDDepartureAccepted"},{"active":true,"_id":"67487c14f5f6ec8cacaaa647","action":"oDDepartureStart"},{"active":true,"_id":"67487c14f5f6ec8cacaaa648","action":"oDDepartureEnd"},{"active":true,"_id":"67487c14f5f6ec8cacaaa649","action":"oDDepartureStopSkiped"},{"active":true,"_id":"67487c14f5f6ec8cacaaa64a","action":"oDDepartureAssigned"},{"active":true,"_id":"67487c14f5f6ec8cacaaa64b","action":"oDDepartureCanceled"},{"active":true,"_id":"67487c14f5f6ec8cacaaa64c","action":"oDDepartureDriverAssigned"},{"active":true,"_id":"67487c14f5f6ec8cacaaa64d","action":"oDDepartureDriverReAssigned"},{"active":true,"_id":"67487c14f5f6ec8cacaaa64e","action":"oDDepartureApproved"}],"legOptions":[],"allowsObservations":true}],"fleetParams":[],"driverParams":[],"auxiliaryTrackers":[],"ui":{},"odd":{"pricing":{"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[]},"maximumReservationTime":{"amount":1,"unit":"hours"},"minimumReservationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"amount":1,"unit":"hours"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"joinTimeLimit":{"amount":20,"unit":"minutes"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false,"amount":1,"unit":"hours"},"notifyNewODDRequest":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyNewODDCreated":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"notifyApprovedODD":{"sendTo":{"emails":[],"adminLevels":[],"roles":[]},"enabled":false},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"pastServicesApproval":{"enabled":false},"validateDeparture":{"enabled":false},"userRequests":{"reasons":{"list":[]}},"providers":{"restrictCreation":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false}},"enabled":false,"reasons":[],"hideEstimatedTimes":false,"allowsMultipleDrivers":false,"allowsDistance":false,"exclusive":false,"_id":"6654cc38713b9a5184cfdf7f","entryTimes":[],"exitTimes":[],"legOptions":[],"notifications":[],"approvers":[]},"driverCanCreateRoutes":true,"hideSCDriverNames":false,"startUnassignedDeparture":false,"dashboardAssignation":{"asap":{"minutesTillNextDeparture":360}},"trackersVisibility":[],"visible":true,"continuousGpsAlwaysOn":false,"speedAlert":{"enabled":false,"notify":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roles":[]}}},"notifyPassBudgetPercentage":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"percentages":{"general":{"enabled":false,"amount":0,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}}},"rateRoute":{"enabled":false,"withValidation":false}},"parking":{"enabled":false,"enableToAllUsers":false,"reservationByDay":false,"allowsScreenshots":false,"reservationModel":"priority","accessModel":"reservation","controlAccessAndExit":true,"usesCarpoolModel":false,"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hours"},"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"maxAvailableDays":5,"ranges":[],"terms":null,"specificLots":{"enabled":false,"lotIds":[]},"lotIdsAndKeysParams":[],"notifyInactiveUsers":{"enabled":false,"days":7},"chatWithoutReservation":false,"showPhoneNumber":false,"usesTickets":false,"usesPasses":false},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCallSettings":{"enabled":true},"enabled":false,"communityOptions":false,"routePublishingOptions":[],"routeSearchRestrictions":[],"emergencyCall":{"enabled":true}},"cabpool":{"parameters":{"area":null,"originDistrict":null,"destinationDistrict":null,"folio":null,"line":null},"hasSOS":true},"schoolBus":{"enabled":false},"publicBus":{"enabled":true,"visible":true}},"custom":{"privacySettings":{"general":{"hidePersonalInfoForSC":false},"privateBus":{"hideSCDriverNames":false,"hideSCRouteParams":false,"restrictAdmins":{"serviceCost":{"enabled":false,"allowed":"admins","adminIds":[],"adminLevels":[],"roleIds":[]}}}},"hasSubsidy":{"active":false,"subsidizedUsers":[],"userAmount":null,"subsidizedAmount":null},"realTimeTransportSystem":{"buses":{"scheduling":{"enabled":true,"allowSeatReservations":true,"autoAssignReservations":{"enabled":false},"dynamicResourceAssignment":{"enabled":true,"limitTime":5,"limitUnit":"minutes"},"reservation":{"restrictions":{"enabled":false,"amount":1,"time":1,"unit":"days","userSkip":[]}},"minimumConfirmationTime":{"enabled":true,"amount":3,"unit":"minutes"},"minimumTimeToAccept":{"enabled":true,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToStart":{"enabled":false,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToAssignDriver":{"enabled":true,"amount":30,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"admin":{"skipAllReservationsAssignedCheck":true},"apportioning":{"enabled":false,"type":"estimated"},"serviceCreationAnticipation":4},"budgetSystem":{"enabled":false},"apportionCategories":[],"labels":["etiqueta1"],"restrictiveLabels":{"enabled":true,"labels":["etiqueta1"]},"oDDServices":[{"enabled":true,"name":"Taxis Nico","icon":"https://s3.amazonaws.com/allride.odd.icons/odd_taxi_icon.jpg","allowsMultipleDrivers":true,"allowsDistance":true,"exclusive":false,"hideEstimatedTimes":false,"pastServicesApproval":{"enabled":true},"pricing":{"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[],"timeDistanceConfig":{"baseFare":0,"costPerKm":0,"costPerMinute":0,"tolls":[],"additionalCharges":[]}},"reasons":["Personal"],"approvers":[],"entryTimes":[],"exitTimes":[],"maximumReservationTime":{"amount":1,"unit":"minutes"},"minimumReservationTime":{"amount":1,"unit":"minutes"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"enabled":false,"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"minimumTimeToAccept":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToStart":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToAssignDriver":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifyNewODDRequest":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifyNewODDCreated":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}},"notifications":[{"action":"oDDepartureAccepted","active":true},{"action":"oDDepartureStart","active":true},{"action":"oDDepartureEnd","active":true},{"action":"oDDepartureStopSkiped","active":true},{"action":"oDDepartureAssigned","active":true},{"action":"oDDepartureCanceled","active":true},{"action":"oDDepartureDriverAssigned","active":true},{"action":"oDDepartureDriverReAssigned","active":true},{"action":"oDDepartureApproved","active":true}],"userRequests":{"freeRequests":{"enabled":true,"asap":false},"limitedOptions":{"enabled":false},"joinDepartures":{"enabled":true,"maxCapacity":5,"distanceRatio":0},"defaultProvider":"653fd68233d83952fafcd4be","emergencyRequests":{"enabled":false},"exclusiveRequests":{"enabled":false},"multipleRequests":{"enabled":false,"amountLimit":0},"reasons":{"enabled":false,"list":[]}},"restrictRequests":{"forService":{"enabled":false,"settings":{"reservationSchedule":{"enabled":false,"minimum":"","maximum":""},"userCustomParams":{"enabled":false,"params":[]},"geographical":{"enabled":false,"zones":[]}}},"forProviders":{"enabled":false,"settings":[]}},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false,"amount":null}},"legOptions":[],"allowsObservations":true,"allowsEdit":{"enabled":true,"settings":{"startLocation":true,"endLocation":true,"serviceDate":true,"state":""}},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"}}}],"oDDSettings":{"joinNewAdminODDs":true,"enableToNewUsers":{"enabled":true,"specificParams":{"enabled":false,"params":[]}}},"allowsRating":true,"allowsScreenshots":true,"snapshots":{"service":{"enabled":true,"retentionTime":{"amount":0,"unit":"hours"}},"nonService":{"enabled":true,"retentionTime":{"amount":0,"unit":"hours"}}},"allowGenericVehicles":true,"usesPin":false,"validation":{"enabled":true,"timestamp":{"enabled":true,"allowsSkip":true},"dailyLimit":{"enabled":false,"allowsSkip":false,"amount":0},"timeLimit":{"enabled":false,"allowsSkip":false,"amount":1,"time":1,"unit":"minutes"},"departureLimit":{"enabled":false,"allowsSkip":false,"amount":0},"allowsStatic":false,"usesTickets":true,"usesPasses":true,"ticketPrice":100,"customValidation":{"enabled":true,"name":"rut","description":"rut"},"customValidationParams":{"driverParams":[],"passengerParams":[],"maxValidationTime":{"amount":1,"unit":"hours"}},"validationToken":"","usesInternalNFC":false,"bCValidation":{"enabled":true,"field":""},"customQRValidation":{"enabled":true,"field":"Rut"},"DNIValidation":{"enabled":true,"field":"rut","allowsExternal":true},"external":[{"enabled":true,"service":"webcontrol"}]},"assistant":{"enabled":false,"entryTimes":[],"departureTimes":[],"collecting":false,"description":""},"harassmentAssistanceSettings":{"enabled":true,"showTextAbove":true,"aboveText":"","showInformation":true,"informationText":""},"harassmentAssistance":true,"healthPoll":{"enabled":false,"askUser":false},"custom":{"driverApp":{"visibleCode":"plate"},"passengerApp":{"visibleCode":"plate"},"reports":{"visibleCode":"plate"}},"internalLegs":{"enabled":false},"fleetParams":[],"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"auxiliaryTrackers":[],"startUnassignedDeparture":false,"validateDeparture":{"enabled":true},"dashboardAssignation":{"asap":{"minutesTillNextDeparture":360}},"passengerList":{"enabled":false,"data":{"fullName":false,"validationParam":false,"phone":false,"community":false}},"notifyPassBudgetPercentage":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]},"percentages":{"general":{"enabled":false,"amount":0,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}}},"userApp":{"allowsMultipleReservations":{"enabled":true,"amountLimit":0}},"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":false,"notify":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[]}}}},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCallSettings":{"enabled":true},"enabled":false,"communityOptions":false,"routePublishingOptions":[],"routeSearchRestrictions":[],"emergencyCall":{"enabled":true}},"cabpool":{"parameters":{"area":null,"originDistrict":null,"destinationDistrict":null,"folio":null,"line":null},"hasSOS":true},"schoolbus":{"enabled":false}},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"params":[{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a66","name":"rut","description":"rut","dataType":"rut","isUserStop":false,"validationExpr":""},{"mandatory":false,"check":false,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a67","name":"address","description":"Domicilio","dataType":"location","isUserStop":true,"validationExpr":""},{"mandatory":false,"check":false,"show":false,"private":true,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a68","name":"coordinates","description":"Coordenadas","dataType":"coordinates","isUserStop":true,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a69","name":"Color","description":"","dataType":"string","isUserStop":false,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"66e1bbff79c01d88c09c4a6a","name":"Animal","description":"","dataType":"string","isUserStop":false,"validationExpr":""}],"enabled":true},"parkingLots":{"enabled":false,"enableToAllUsers":false,"reservationByDay":false,"allowsScreenshots":false,"reservationModel":"priority","accessModel":"reservation","controlAccessAndExit":true,"usesCarpoolModel":false,"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hours"},"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"maxAvailableDays":5,"ranges":[],"terms":null,"specificLots":{"enabled":false,"lotIds":[]},"lotIdsAndKeysParams":[],"notifyInactiveUsers":{"enabled":false,"days":7},"chatWithoutReservation":false,"showPhoneNumber":false,"usesTickets":false,"usesPasses":false},"balance":{"enabled":true},"betaFeatures":[],"allowsManualUsers":true,"replacesManualUser":false,"allowAds":true,"allowCustomEmail":false,"allowCustomId":false,"hasUserMessagingSystem":true,"driverCanCreateRoutes":true,"products":{"enabled":true}},"emailSuffixes":[],"admins":[],"timezone":"Chile/Continental","type":"normal","distance":0,"allowAds":false,"assocCommunities":[],"public":true,"name":"Comunidad Automatización 2","site":"http://adminstage.allrideapp.com","terms":null,"country":"cl","isStudentsCommunity":false,"hasBusesSystem":true,"language":"es","avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_6654ae4eba54fe502d4e4187_1717603083265.png","badge":"https://s3.amazonaws.com/allride.uploads/communityAvatar_6654ae4eba54fe502d4e4187_1717603083787.png","createdAt":"2024-05-27T16:01:18.808Z","updatedAt":"2024-11-28T14:20:04.318Z","__v":394}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200
    Log    ${code}
