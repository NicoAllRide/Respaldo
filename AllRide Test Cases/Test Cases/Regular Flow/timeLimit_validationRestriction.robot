*** Settings ***
Library     RequestsLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     RPA.JSON
Resource    ../Variables/variablesStage.robot


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
    ${start_date_today}=    Set Variable    ${fecha_hoy}T03:00:00.000Z
    Set Global Variable    ${start_date_today}
    ${today_date}=    Set Variable    ${fecha_hoy}
    Set Global Variable    ${today_date}
    ${end_date_tomorrow2}=    Set Variable    ${fecha_manana}T02:59:59.999Z
    Set Global Variable    ${end_date_tomorrow}
    ${expiration_date_qr}=    Set Variable    ${fecha_manana}T14:10:37.968Z
    Set Global Variable    ${expiration_date_qr}

Get Driver Token
    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)
    ${url}=    Set Variable
    ...    ${STAGE_URL}/api/v1/admin/pb/drivers/?community=67b879e99a2ba09f940ea7c5&driverId=67b884c5b5ebd5b87145e5c3

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

Activate time Limit validation on community(1 validation in 1 hours)
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/community/67b879e99a2ba09f940ea7c5
    ...    data={"_id":"67b879e99a2ba09f940ea7c5","config":{"general":{"hasSubsidy":{"active":false,"subsidizedUsers":[],"userAmount":null,"subsidizedAmount":null},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"enabled":true,"params":[{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"67ebf8cc4aa362511cdc4ba0","name":"Rut","description":"rut","dataType":"rut","isUserStop":false,"validationExpr":""},{"mandatory":false,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"67ebf8cc4aa362511cdc4ba1","name":"color","description":"color","dataType":"string","isUserStop":false,"validationExpr":""},{"mandatory":false,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"67ebf8cc4aa362511cdc4ba2","name":"animal","description":"animal","dataType":"string","isUserStop":false,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":["ANTUCOYA","ALLRIDE","CASERONES"],"_id":"67ebf8cc4aa362511cdc4ba3","name":"Empresa","description":"Empresa","dataType":"list","isUserStop":false,"validationExpr":""}]},"externalInfo":{"siga":{"enabled":false},"adcam":{"YNV":{"enabled":true},"Litio":{"enabled":true}}},"balance":{"enabled":true},"privacySettings":{"general":{"hidePersonalInfoForSC":false},"privateBus":{"hideSCDriverNames":false,"hideSCRouteParams":false,"restrictAdmins":{"serviceCost":{"enabled":false,"allowed":"admins","adminIds":[],"adminLevels":[],"roleIds":[]}}}},"products":{"enabled":true,"feePercentage":0,"stripe":{"connectedAccountId":null,"useProductConnectedAccountId":false}},"betaFeatures":[],"allowsManualUsers":true,"replacesManualUser":false,"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"allowsCustomJoinWithoutEmailCheck":false,"hasUserMessagingSystem":true,"public":true,"assocCommunities":null,"allowsValidationOptions":false,"isStudentsCommunity":false,"use24hFormat":true,"ui":{"design":{"isoType":"","logoType":"","color":""}}},"privateBus":{"oDDSettings":{"joinNewAdminODDs":true,"enableToNewUsers":{"enabled":true,"specificParams":{"enabled":false,"params":[]}},"latestUserStopsSearch":false},"scheduling":{"enabled":true,"allowSeatReservations":true,"autoAssignReservations":{"enabled":true},"dynamicResourceAssignment":{"enabled":false,"limitTime":null,"limitUnit":""},"reservation":{"restrictions":{"enabled":false,"amount":0,"time":1,"unit":"days","userSkip":[]}},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"minimumTimeToAccept":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToStart":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignDriver":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"admin":{"skipAllReservationsAssignedCheck":true},"apportioning":{"enabled":false,"type":"estimated"},"serviceCreationAnticipation":4,"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"serviceCreationLimit":{"enabled":false,"date":null}},"budgetSystem":{"enabled":false},"notifyPassBudgetPercentage":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"percentages":{"general":{"enabled":false,"amount":0,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}}},"notifyAdmins":{"notifyIdleTime":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"amount":5,"unit":"minutes"}},"restrictiveLabels":{"enabled":false,"labels":[]},"validation":{"timestamp":{"userSkip":[],"enabled":false,"allowsSkip":false},"dailyLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null},"timeLimit":{"userSkip":[],"enabled":true,"allowsSkip":false,"amount":1,"time":1,"unit":"hours"},"departureLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":1},"DNIValidation":{"enabled":true,"field":"Rut","allowsExternal":true},"bCValidation":{"enabled":true,"field":"rut"},"customQRValidation":{"enabled":true,"field":"rut"},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":true,"dataType":"text","options":[],"name":"rut","description":"rut"},"customValidationParams":{"driverParams":[],"passengerParams":[],"maxValidationTime":{"amount":1,"unit":"hours"}},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"enabled":true,"allowsStatic":false,"usesTickets":true,"usesPasses":true,"ticketPrice":10,"external":[],"internalNFCField":""},"assistant":{"entryTimes":[],"departureTimes":[],"enabled":false,"collecting":false,"description":""},"poll":{"active":false,"answeredBy":[]},"rateRoute":{"enabled":false,"withValidation":false},"snapshots":{"service":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}},"nonService":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}}},"harassmentAssistanceSettings":{"enabled":false,"showTextAbove":true,"aboveText":"","showInformation":true,"informationText":""},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"reports":{"visibleCode":"plate"},"driverApp":{"visibleCode":"plate"},"passengerApp":{"visibleCode":"plate"},"driverCustomParams":{"enabled":false,"params":[]},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":true},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"restrictRTL":{"enabled":false},"dashboardAssignation":{"asap":{"minutesTillNextDeparture":360}},"userApp":{"allowsMultipleReservations":{"enabled":true,"amountLimit":20},"exploreMode":"standard"},"speedAlert":{"enabled":true,"notify":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":true,"notify":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"fineManagementSystem":{"enabled":false,"types":[],"possibleOrigins":[],"stateNotifications":[]},"ETA":{"enabled":false,"update":{"amount":0,"unit":"minutes"},"visibility":"admin","notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"chatSystem":{"defaultMessages":{"user":[],"driver":[]}},"enabled":true,"visible":true,"apportionCategories":[],"labels":[],"allowsRating":false,"allowsSnapshots":false,"allowsScreenshots":false,"usesPin":false,"noPassengerInfo":false,"allowGenericVehicles":true,"continuousGpsAlwaysOn":false,"driverCanCreateRoutes":false,"startUnassignedDeparture":true,"oDDServices":[{"enabled":true,"name":"Taxis Automatización","icon":"https://s3.amazonaws.com/allride.odd.icons/odd_taxi_icon.jpg","allowsMultipleDrivers":true,"allowsDistance":false,"exclusive":false,"hideEstimatedTimes":false,"pastServicesApproval":{"enabled":true},"pricing":{"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[],"timeDistanceConfig":{"baseFare":0,"costPerKm":0,"costPerMinute":0,"tolls":[],"additionalCharges":[]}},"reasons":[],"approvers":[],"entryTimes":[],"exitTimes":[],"maximumReservationTime":{"amount":1,"unit":"hours"},"minimumReservationTime":{"amount":1,"unit":"hours"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"enabled":true,"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"minimumTimeToAccept":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToStart":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignDriver":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyNewODDRequest":{"enabled":true,"sendTo":{"destinataries":"specificEmails","emails":["nico.bustamantesolis@gmail.com"],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyNewODDCreated":{"enabled":true,"sendTo":{"destinataries":"specificEmails","emails":["nico.bustamantesolis@gmail.com"],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"serviceCanceled":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"notifications":[{"action":"oDDepartureAccepted","active":true},{"action":"oDDepartureStart","active":true},{"action":"oDDepartureEnd","active":true},{"action":"oDDepartureStopSkiped","active":true},{"action":"oDDepartureAssigned","active":true},{"action":"oDDepartureCanceled","active":true},{"action":"oDDepartureDriverAssigned","active":true},{"action":"oDDepartureDriverReAssigned","active":true},{"action":"oDDepartureApproved","active":true}],"userRequests":{"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"allowsSelectArrivalDate":true,"freeRequests":{"enabled":true,"asap":true},"limitedOptions":{"enabled":false},"joinDepartures":{"enabled":false,"maxCapacity":0,"distanceRatio":0},"defaultProvider":"653fd68233d83952fafcd4be","emergencyRequests":{"enabled":false},"straightToRequests":false,"straightToODD":{"enabled":false},"exclusiveRequests":{"enabled":false},"multipleRequests":{"enabled":false,"amountLimit":0},"reasons":{"enabled":false,"list":[]}},"restrictRequests":{"forService":{"enabled":false,"settings":{"reservationSchedule":{"enabled":false,"minimum":"","maximum":""},"userCustomParams":{"enabled":false,"params":[]},"geographical":{"enabled":false,"zones":[]}}},"forProviders":{"enabled":false,"settings":[]}},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false,"amount":null}},"legOptions":[{"legType":"pre","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}}},{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}}}],"allowsObservations":true,"allowsEdit":{"enabled":true,"settings":{"startLocation":true,"endLocation":true,"serviceDate":true,"state":""}},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"}}}],"fleetParams":[],"auxiliaryTrackers":[{"enabled":true,"_id":"67b882849a2ba09f940ea9b9","name":"viggoFleetPort"}],"showStandbyDrivers":true,"driverParams":[],"trackersVisibility":[],"odd":{"pricing":{"timeDistanceConfig":{"tolls":[],"additionalCharges":[]},"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[]},"maximumReservationTime":{"amount":1,"unit":"hours"},"minimumReservationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"amount":1,"unit":"hours"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"joinTimeLimit":{"amount":20,"unit":"minutes"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"notifyNewODDRequest":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyNewODDCreated":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyApprovedODD":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyUnboardedPassengers":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyPassengersWithoutReservation":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifySkippedStop":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyAdmins":{"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"driverReject":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"serviceCanceled":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false}},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"pastServicesApproval":{"enabled":false},"validateDeparture":{"enabled":false},"userRequests":{"reasons":{"list":[]}},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false}},"restrictRequests":{"forService":{"settings":{"userCustomParams":{"params":[]},"geographical":{"zones":[]},"providers":[]}},"forProviders":{"settings":[]}},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"enabled":false,"reasons":[],"hideEstimatedTimes":false,"allowsMultipleDrivers":false,"allowsDistance":false,"_id":"67b879eeb5ebd5b87145e312","entryTimes":[],"exitTimes":[],"legOptions":[],"notifications":[],"approvers":[]},"admin":{"icTable":{"startServiceButton":false}},"fleetCustomParams":{"enabled":false,"params":[]},"inactiveGPSAlert":{"notify":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[],"superCommunities":[]}}},"locationCacheDuration":360,"ui":{"admin":{"fulfillmentReport":{"hiddenRoutes":[]},"dashboard":{"markersLabel":"default"},"_id":"67f3e4c3e17213de3d9f08dd"}},"emergencyCall":{"enabled":true},"harassmentAssistance":false},"parking":{"enabled":false,"enableToAllUsers":false,"reservationByDay":false,"allowsScreenshots":false,"reservationModel":"priority","accessModel":"reservation","controlAccessAndExit":true,"usesCarpoolModel":false,"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hours"},"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"maxAvailableDays":5,"ranges":[],"terms":null,"specificLots":{"enabled":false,"lotIds":[]},"lotIdsAndKeysParams":[],"notifyInactiveUsers":{"enabled":false,"days":7},"chatWithoutReservation":false,"showPhoneNumber":false,"usesTickets":false,"usesPasses":false},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCall":{"enabled":true},"enabled":true,"visible":true,"communityOptions":true,"routePublishingOptions":["public","community","associated","private"],"routeSearchRestrictions":["public","community","associated","private"],"categories":{"perPassenger":true,"config":{"description":null,"subsidy":{"amount":0,"informationText":null,"companyText":null},"currency":"clp"}}},"cabpool":{"parameters":{"area":null,"originDistrict":null,"destinationDistrict":null,"folio":null,"line":null},"enabled":true,"visible":true,"hasSOS":true},"schoolBus":{"enabled":false,"visible":true},"publicBus":{"enabled":true,"visible":true}},"emailSuffixes":[],"admins":[],"timezone":"Chile/Continental","type":"normal","distance":0,"allowAds":false,"assocCommunities":[],"public":true,"name":"Pruebas Automatización 2.0","site":"http://admin-qa.allrideapp.com/","terms":null,"country":"cl","hasBusesSystem":true,"language":"es","avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_67b879e99a2ba09f940ea7c5_1740143082994.png","badge":"https://s3.amazonaws.com/allride.uploads/communityAvatar_67b879e99a2ba09f940ea7c5_1740143084660.png","createdAt":"2025-02-21T13:04:41.887Z","updatedAt":"2025-04-07T15:08:38.614Z","__v":13,"custom":{"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"allowsManualUsers":false,"balance":{"enabled":true},"betaFeatures":[],"hasSubsidy":{"active":false,"subsidizedUsers":[]},"hasUserMessagingSystem":false,"parkingLots":{"accessModel":"reservation","allowsScreenshots":true,"busIntegration":false,"enableToAllUsers":false,"enabled":false,"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"exitReminderTime":{"time":5,"unit":"minutes"},"fullName":{"enabled":false},"lotIdsAndKeysParams":[],"maxAvailableDays":5,"minAvailableDays":3,"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"noExitLimit":{"time":1,"unit":"hour"},"notifyInactiveUsers":{"days":7,"enabled":false},"ranges":[],"reservationByDay":false,"reservationLimit":{"time":1,"unit":"days"},"reservationModel":"priority","sections":false,"specificLots":{"enabled":false,"lotIds":[]}},"products":{"enabled":false},"realTimeTransportSystem":{"buses":{"allowGenericVehicles":false,"allowsRating":false,"allowsScreenshots":true,"allowsSnapshots":false,"apportionCategories":[],"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"assistant":{"departureTimes":[],"entryTimes":[]},"auxiliaryTrackers":[],"budgetSystem":{"enabled":false},"continuousGpsAlwaysOn":false,"custom":{"driverApp":{"visibleCode":"plate"},"passengerApp":{"visibleCode":"plate"},"reports":{"visibleCode":"plate"}},"departureHourFulfillment":{"enabled":false,"ranges":[]},"driverCustomParams":{"enabled":false,"params":[]},"driverParams":[],"emergencyCall":{"enabled":true},"fineManagementSystem":{"enabled":false,"possibleOrigins":[],"stateNotifications":[],"types":[]},"fleetParams":[],"harassmentAssistance":false,"harassmentAssistanceSettings":{"enabled":false,"showInformation":true,"showTextAbove":true},"healthPoll":{"askUser":false,"enabled":false},"internalLegs":{"enabled":false},"internalRoutes":{"enabled":false},"labels":[],"multipleUseQRCodes":{"amount":1,"enabled":false,"uncapped":false},"noPassengerInfo":false,"notifyPassBudgetPercentage":{"enabled":false,"percentages":{"byAccounts":{"accounts":[],"enabled":false},"general":{"criteriaToNotify":"oneTime","enabled":false}},"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]}},"oDDServices":[],"oDDSettings":{"enableToNewUsers":{"enabled":false,"specificParams":{"enabled":false,"params":[]}},"joinNewAdminODDs":false},"passengerList":{"data":{"community":false,"fullName":false,"phone":false,"validationParam":false},"enabled":false},"poll":{"active":false,"answeredBy":[]},"rateRoute":{"enabled":false,"withValidation":false},"restrictiveLabels":{"enabled":false,"labels":[]},"routeDeviation":{"enabled":false,"maxDistance":100,"maxTime":5,"notify":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[],"superCommunities":[]}}},"scheduling":{"admin":{"skipAllReservationsAssignedCheck":false},"allowSeatReservations":false,"apportioning":{"enabled":false,"type":"estimated"},"autoAssignReservations":{"enabled":false},"dynamicResourceAssignment":{"enabled":false,"limitTime":15,"limitUnit":"minutes"},"enabled":false,"exceedValidationLimit":{"enabled":false},"minimumConfirmationTime":{"amount":1,"enabled":false,"unit":"hours"},"minimumTimeToAccept":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"},"minimumTimeToAssignDriver":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"},"minimumTimeToConfirm":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"},"minimumTimeToStart":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"},"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]}},"fullService":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[],"superCommunities":[]}},"minimumTimeToAssignVehicle":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"}},"reservation":{"enabled":false,"restrictions":{"customParams":{"dataType":"text","enabled":false,"options":[]},"unit":"days","userSkip":[]}},"serviceCreationAnticipation":4,"startLimit":{"amount":1,"enabled":false,"unit":"hours"}},"snapshots":{"nonService":{"enabled":false},"service":{"enabled":false}},"tracker":{"enabled":false},"usesPin":false,"validateDeparture":{"enabled":false},"validation":{"DNIValidation":{"enabled":false,"failureMessage":"Solo puedes presentar el código de AllRideo o de tu cédula de identidad.","showRejected":true,"type":"qr","options":["qr"]},"bCValidation":{"enabled":false},"customQRValidation":{"enabled":false},"customValidation":{"dataType":"text","enabled":false,"options":[]},"customValidationParams":{"driverParams":[],"passengerParams":[]},"dailyLimit":{"userSkip":[]},"departureLimit":{"userSkip":[]},"external":[],"healthPoll":false,"secureNFCValidation":{"enabled":false},"timeLimit":{"userSkip":[]},"timestamp":{"userSkip":[]},"usesInternalNFC":false,"validationToken":""},"wfIntegration":{"enabled":false},"fleetCustomParams":{"enabled":false,"params":[]}},"cabpool":{"hasSOS":true},"carpool":{"boardingConditions":{"boardingQueryDelay":5,"boardingTimeWindow":30,"driverPassengerProximity":100,"enabled":false,"pickupLocationTolerance":200},"communityOptions":true,"emergencyCall":{"enabled":true},"enabled":true,"routePublishingOptions":[],"routeSearchRestrictions":[]},"schoolbus":{"enabled":true}},"replacesManualUser":true,"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"params":[]}}}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Status Should Be    200

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
    ...    url=/api/v2/pb/driver/departures
    ...    data={"communityId":"67b879e99a2ba09f940ea7c5","startLat":-33.3908833,"startLon":-70.54620129999999,"customParamsAtStart":[],"preTripChecklist":[],"routeId":"67ebf9082a86e3f7c1f98156","capacity":5,"busCode":"","vehicleId":"67ed2e71a45b6aa00234a2ff","shareToUsers":false,"customParams":[],"pin":null}
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
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=67b879e99a2ba09f940ea7c5
    ...    data={"ids":["67b886639a2ba09f940eab0a"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeNico}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeNico}
    Log    ${qrCodeNico}
    Log    ${code}
Get User QR(Morita)
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=/api/v1/admin/users/qrCodes?community=67b879e99a2ba09f940ea7c5
    ...    data={"ids":["6769bb1e460d85c5125f1545"]}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${code}=    convert to string    ${response.status_code}
    Status Should Be    200

    ${qrCodeMorita}=    Set Variable    ${response.json()}[0][qrCode]
    Set Global Variable    ${qrCodeMorita}
    Log    ${qrCodeMorita}
    Log    ${code}

Validate With QR Nico
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json

    ${status}    ${result}=    Run Keyword And Continue On Failure
    ...    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString": "${qrCodeNico}"}
    ...    headers=${headers}

    Status Should Be    403 
Validate With QR Morita
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    ${headers}=    Create Dictionary
    ...    Authorization=${departureToken}
    ...    Content-Type=application/json

      ${response}=  POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString": "${qrCodeMorita}"}
    ...    headers=${headers}


Check validation succeeded
        Skip
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/validations/list?community=67b879e99a2ba09f940ea7c5&page=1&pageSize=200
    ...    data={"advancedSearch":false,"startDate":"${fecha_hoy}T03:00:00.000Z","endDate":"${fecha_manana}T02:59:59.999Z","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"Rut","value":""},{"key":"color","value":""},{"key":"animal","value":""},{"key":"Empresa","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos las validaciones por createdAt
    ${sorted_validations}=    Evaluate    sorted(${responseJson}[validations], key=lambda x: x['createdAt'])    json

    # Obtenemos la última validación
    ${last_validation}=    Set Variable    ${sorted_validations[-1]}

    ${last_reason}=    Get From List    ${last_validation['reason']}    0
    ${validated}=    Set Variable    ${last_validation['validated']}



    Should Be Equal As Strings    ${validated}    False
    Should Be Equal As Strings    ${last_reason}    time_limit
    Status Should Be    200

    Log    Última validación: ${last_validation}

Validate With QR, second validation should fail Nico
    Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Run Keyword And Expect Error
    ...    HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v1/pb/provider/departures/validate
    ...    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeNico}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Status Should Be    403    msg=Second validation of the same user should fail but is not
Validate With QR, second validation should fail Morita
        Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${departureToken}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    Run Keyword And Expect Error
    ...    HTTPError: 403 Client Error: Forbidden for url: https://stage.allrideapp.com/api/v1/pb/provider/departures/validate
    ...    POST On Session
    ...    mysesion
    ...    url=/api/v1/pb/provider/departures/validate
    ...    data={"validationString":"${qrCodeMorita}"}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    Status Should Be    403    msg=Second validation of the same user should fail but is not

Check validation 2 Failed
    skip
    Set Log Level    TRACE
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary    Authorization=${tokenAdmin}    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    POST On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/pb/validations/list?community=67b879e99a2ba09f940ea7c5&page=1&pageSize=200
    ...    data={"advancedSearch":false,"startDate":"${fecha_hoy}T03:00:00.000Z","endDate":"${fecha_manana}T02:59:59.999Z","searchAll":"","route":"0","stop":"0","communityId":"0","validated":null,"reason":"","user":"","email":"","vehicleId":"","customParams":[{"key":"Rut","value":""},{"key":"color","value":""},{"key":"animal","value":""},{"key":"Empresa","value":""}],"driver":"0","startedAtAfter":null,"startedAtBefore":null,"endedAtAfter":null,"endedAtBefore":null}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)
    ${responseJson}=    Set Variable    ${response.json()}

    # Ordenamos las validaciones por createdAt
    ${sorted_validations}=    Evaluate    sorted(${responseJson}[validations], key=lambda x: x['createdAt'])    json

    # Obtenemos la última validación
    ${last_validation}=    Set Variable    ${sorted_validations[-1]}

    ${last_reason}=    Get From List    ${last_validation['reason']}    0
    ${validated}=    Set Variable    ${last_validation['validated']}

    Should Be Equal As Strings    ${validated}    False        Validation status should be false, but is not
    Should Be Equal As Strings    ${last_reason}    time_limit        
    Status Should Be    200

    Log    Última validación: ${last_validation}

Stop Post Leg Departure
        Skip
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

    Sleep    10s

DEActivate time Limit validation on community(1 validation in 44 hours) and activate QTY Validation
        Skip
    Create Session    mysesion    ${STAGE_URL}    verify=true

    # Define la URL del recurso que requiere autenticación (puedes ajustarla según tus necesidades)

    # Configura las opciones de la solicitud (headers, auth)
    ${headers}=    Create Dictionary
    ...    Authorization=${tokenAdmin}
    ...    Content-Type=application/json
    # Realiza la solicitud GET en la sesión por defecto
    ${response}=    PUT On Session
    ...    mysesion
    ...    url=https://stage.allrideapp.com/api/v1/admin/community/67b879e99a2ba09f940ea7c5
    ...    data={"_id":"67b879e99a2ba09f940ea7c5","config":{"general":{"hasSubsidy":{"active":false,"subsidizedUsers":[],"userAmount":null,"subsidizedAmount":null},"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"enabled":true,"params":[{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"67ebf8cc4aa362511cdc4ba0","name":"Rut","description":"rut","dataType":"rut","isUserStop":false,"validationExpr":""},{"mandatory":false,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"67ebf8cc4aa362511cdc4ba1","name":"color","description":"color","dataType":"string","isUserStop":false,"validationExpr":""},{"mandatory":false,"check":true,"show":true,"private":false,"internal":false,"options":[],"_id":"67ebf8cc4aa362511cdc4ba2","name":"animal","description":"animal","dataType":"string","isUserStop":false,"validationExpr":""},{"mandatory":true,"check":true,"show":true,"private":false,"internal":false,"options":["ANTUCOYA","ALLRIDE","CASERONES"],"_id":"67ebf8cc4aa362511cdc4ba3","name":"Empresa","description":"Empresa","dataType":"list","isUserStop":false,"validationExpr":""}]},"externalInfo":{"siga":{"enabled":false},"adcam":{"YNV":{"enabled":true},"Litio":{"enabled":true}}},"balance":{"enabled":true},"privacySettings":{"general":{"hidePersonalInfoForSC":false},"privateBus":{"hideSCDriverNames":false,"hideSCRouteParams":false,"restrictAdmins":{"serviceCost":{"enabled":false,"allowed":"admins","adminIds":[],"adminLevels":[],"roleIds":[]}}}},"products":{"enabled":true,"feePercentage":0,"stripe":{"connectedAccountId":null,"useProductConnectedAccountId":false}},"betaFeatures":[],"allowsManualUsers":true,"replacesManualUser":false,"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"allowsCustomJoinWithoutEmailCheck":false,"hasUserMessagingSystem":true,"public":true,"assocCommunities":null,"allowsValidationOptions":false,"isStudentsCommunity":false,"use24hFormat":true,"ui":{"design":{"isoType":"","logoType":"","color":""}}},"privateBus":{"oDDSettings":{"joinNewAdminODDs":true,"enableToNewUsers":{"enabled":true,"specificParams":{"enabled":false,"params":[]}},"latestUserStopsSearch":false},"scheduling":{"enabled":true,"allowSeatReservations":true,"autoAssignReservations":{"enabled":true},"dynamicResourceAssignment":{"enabled":false,"limitTime":null,"limitUnit":""},"reservation":{"restrictions":{"enabled":false,"amount":0,"time":1,"unit":"days","userSkip":[]}},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"minimumTimeToAccept":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToStart":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignDriver":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"admin":{"skipAllReservationsAssignedCheck":true},"apportioning":{"enabled":false,"type":"estimated"},"serviceCreationAnticipation":4,"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"serviceCreationLimit":{"enabled":false,"date":null}},"budgetSystem":{"enabled":false},"notifyPassBudgetPercentage":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"percentages":{"general":{"enabled":false,"amount":0,"criteriaToNotify":"oneTime"},"byAccounts":{"enabled":false,"accounts":[]}}},"notifyAdmins":{"notifyIdleTime":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"amount":5,"unit":"minutes"}},"restrictiveLabels":{"enabled":false,"labels":[]},"validation":{"timestamp":{"userSkip":[],"enabled":false,"allowsSkip":false},"dailyLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":null},"timeLimit":{"userSkip":[],"enabled":false,"allowsSkip":false,"amount":1,"time":44,"unit":"hours"},"departureLimit":{"userSkip":[],"enabled":true,"allowsSkip":false,"amount":1},"DNIValidation":{"enabled":true,"field":"Rut","allowsExternal":true},"bCValidation":{"enabled":true,"field":"rut"},"customQRValidation":{"enabled":true,"field":"rut"},"secureNFCValidation":{"enabled":false},"customValidation":{"enabled":true,"dataType":"text","options":[],"name":"rut","description":"rut"},"customValidationParams":{"driverParams":[],"passengerParams":[],"maxValidationTime":{"amount":1,"unit":"hours"}},"usesInternalNFC":false,"validationToken":"","healthPoll":false,"enabled":true,"allowsStatic":false,"usesTickets":true,"usesPasses":true,"ticketPrice":10,"external":[],"internalNFCField":""},"assistant":{"entryTimes":[],"departureTimes":[],"enabled":false,"collecting":false,"description":""},"poll":{"active":false,"answeredBy":[]},"rateRoute":{"enabled":false,"withValidation":false},"snapshots":{"service":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}},"nonService":{"enabled":false,"retentionTime":{"amount":0,"unit":"hours"}}},"harassmentAssistanceSettings":{"enabled":false,"showTextAbove":true,"aboveText":"","showInformation":true,"informationText":""},"healthPoll":{"enabled":false,"askUser":false},"passengerList":{"data":{"fullName":false,"validationParam":false,"phone":false,"community":false},"enabled":false},"reports":{"visibleCode":"plate"},"driverApp":{"visibleCode":"plate"},"passengerApp":{"visibleCode":"plate"},"driverCustomParams":{"enabled":false,"params":[]},"multipleUseQRCodes":{"enabled":false,"uncapped":false,"amount":1},"internalRoutes":{"enabled":false},"internalLegs":{"enabled":true},"departureHourFulfillment":{"enabled":false,"ranges":[]},"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"validateDeparture":{"enabled":true},"restrictRTL":{"enabled":false},"dashboardAssignation":{"asap":{"minutesTillNextDeparture":360}},"userApp":{"allowsMultipleReservations":{"enabled":true,"amountLimit":20},"exploreMode":"standard"},"speedAlert":{"enabled":true,"notify":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"routeDeviation":{"maxDistance":100,"maxTime":5,"enabled":true,"notify":{"enabled":true,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"fineManagementSystem":{"enabled":false,"types":[],"possibleOrigins":[],"stateNotifications":[]},"ETA":{"enabled":false,"update":{"amount":0,"unit":"minutes"},"visibility":"admin","notify":{"enabled":false,"amount":5,"unit":"minutes","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"chatSystem":{"defaultMessages":{"user":[],"driver":[]}},"enabled":true,"visible":true,"apportionCategories":[],"labels":[],"allowsRating":false,"allowsSnapshots":false,"allowsScreenshots":false,"usesPin":false,"noPassengerInfo":false,"allowGenericVehicles":true,"continuousGpsAlwaysOn":false,"driverCanCreateRoutes":false,"startUnassignedDeparture":true,"oDDServices":[{"enabled":true,"name":"Taxis Automatización","icon":"https://s3.amazonaws.com/allride.odd.icons/odd_taxi_icon.jpg","allowsMultipleDrivers":true,"allowsDistance":false,"exclusive":false,"hideEstimatedTimes":false,"pastServicesApproval":{"enabled":true},"pricing":{"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[],"timeDistanceConfig":{"baseFare":0,"costPerKm":0,"costPerMinute":0,"tolls":[],"additionalCharges":[]}},"reasons":[],"approvers":[],"entryTimes":[],"exitTimes":[],"maximumReservationTime":{"amount":1,"unit":"hours"},"minimumReservationTime":{"amount":1,"unit":"hours"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"enabled":true,"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":null,"unit":"hours"},"minimumTimeToAccept":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToStart":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToConfirm":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignDriver":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"minimumTimeToAssignVehicle":{"enabled":false,"amount":1,"unit":"hours","sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyNewODDRequest":{"enabled":true,"sendTo":{"destinataries":"specificEmails","emails":["nico.bustamantesolis@gmail.com"],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyNewODDCreated":{"enabled":true,"sendTo":{"destinataries":"specificEmails","emails":["nico.bustamantesolis@gmail.com"],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyUnboardedPassengers":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifyPassengersWithoutReservation":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]},"sendAt":"eachStop"},"notifySkippedStop":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}},"serviceCanceled":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"notifications":[{"action":"oDDepartureAccepted","active":true},{"action":"oDDepartureStart","active":true},{"action":"oDDepartureEnd","active":true},{"action":"oDDepartureStopSkiped","active":true},{"action":"oDDepartureAssigned","active":true},{"action":"oDDepartureCanceled","active":true},{"action":"oDDepartureDriverAssigned","active":true},{"action":"oDDepartureDriverReAssigned","active":true},{"action":"oDDepartureApproved","active":true}],"userRequests":{"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"destinataries":"admins","emails":[],"adminLevels":[],"roles":[],"roleIds":[]}}},"allowsSelectArrivalDate":true,"freeRequests":{"enabled":true,"asap":true},"limitedOptions":{"enabled":false},"joinDepartures":{"enabled":false,"maxCapacity":0,"distanceRatio":0},"defaultProvider":"653fd68233d83952fafcd4be","emergencyRequests":{"enabled":false},"straightToRequests":false,"straightToODD":{"enabled":false},"exclusiveRequests":{"enabled":false},"multipleRequests":{"enabled":false,"amountLimit":0},"reasons":{"enabled":false,"list":[]}},"restrictRequests":{"forService":{"enabled":false,"settings":{"reservationSchedule":{"enabled":false,"minimum":"","maximum":""},"userCustomParams":{"enabled":false,"params":[]},"geographical":{"enabled":false,"zones":[]}}},"forProviders":{"enabled":false,"settings":[]}},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false,"amount":null}},"legOptions":[{"legType":"pre","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}}},{"legType":"service","preTripChecklist":{"enabled":false,"params":[]},"customParamsAtStart":{"enabled":false,"params":[]},"customParamsAtTheEnd":{"enabled":false,"params":[]},"startConditions":{"location":{"enabled":false,"type":"near","stopIds":[]},"schedule":{"enabled":false,"amount":0,"unit":"minutes"}}}],"allowsObservations":true,"allowsEdit":{"enabled":true,"settings":{"startLocation":true,"endLocation":true,"serviceDate":true,"state":""}},"endServiceLegAutomatically":{"enabled":false,"stopId":null,"distance":100,"timer":{"amount":5,"unit":"minutes"}}}],"fleetParams":[],"auxiliaryTrackers":[{"enabled":true,"_id":"67b882849a2ba09f940ea9b9","name":"viggoFleetPort"}],"showStandbyDrivers":true,"driverParams":[],"trackersVisibility":[],"odd":{"pricing":{"timeDistanceConfig":{"tolls":[],"additionalCharges":[]},"model":"manual","useDistanceForApportioning":false,"zones":[],"costs":[]},"maximumReservationTime":{"amount":1,"unit":"hours"},"minimumReservationTime":{"amount":1,"unit":"hours"},"minimumApprovationAnticipationTime":{"amount":1,"unit":"hours"},"reservationExpirationTime":{"amount":1,"unit":"hours"},"minimumConfirmationTime":{"enabled":false,"amount":1,"unit":"hours"},"startLimit":{"enabled":false,"amount":1,"unit":"hours"},"joinTimeLimit":{"amount":20,"unit":"minutes"},"minimumTimeToAssignDriver":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToAccept":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToStart":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"minimumTimeToConfirm":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"notifyNewODDRequest":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyNewODDCreated":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyApprovedODD":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyUnboardedPassengers":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyPassengersWithoutReservation":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifySkippedStop":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"notifyAdmins":{"minimumTimeToAssignVehicle":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false,"amount":1,"unit":"hours"},"driverReject":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false},"serviceCanceled":{"sendTo":{"emails":[],"adminLevels":[],"roleIds":[]},"enabled":false}},"canResume":{"timeLimit":{"enabled":false,"amount":5,"unit":"minutes"},"enabled":false},"pastServicesApproval":{"enabled":false},"validateDeparture":{"enabled":false},"userRequests":{"reasons":{"list":[]}},"providers":{"restrictCreation":{"enabled":false,"allowed":[]},"restrictProviding":{"enabled":false,"allowed":[]}},"skipApproval":{"byBudgetPercentage":{"enabled":false}},"restrictRequests":{"forService":{"settings":{"userCustomParams":{"params":[]},"geographical":{"zones":[]},"providers":[]}},"forProviders":{"settings":[]}},"endServiceLegAutomatically":{"timer":{"amount":5,"unit":"minutes"},"distance":100},"enabled":false,"reasons":[],"hideEstimatedTimes":false,"allowsMultipleDrivers":false,"allowsDistance":false,"_id":"67b879eeb5ebd5b87145e312","entryTimes":[],"exitTimes":[],"legOptions":[],"notifications":[],"approvers":[]},"admin":{"icTable":{"startServiceButton":false}},"fleetCustomParams":{"enabled":false,"params":[]},"inactiveGPSAlert":{"notify":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[],"superCommunities":[]}}},"locationCacheDuration":360,"ui":{"admin":{"fulfillmentReport":{"hiddenRoutes":[]},"dashboard":{"markersLabel":"default"},"_id":"67f3e4c3e17213de3d9f08dd"}},"emergencyCall":{"enabled":true},"harassmentAssistance":false},"parking":{"enabled":false,"enableToAllUsers":false,"reservationByDay":false,"allowsScreenshots":false,"reservationModel":"priority","accessModel":"reservation","controlAccessAndExit":true,"usesCarpoolModel":false,"reservationLimit":{"time":1,"unit":"days"},"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"noExitLimit":{"time":1,"unit":"hours"},"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"minAvailableDays":3,"maxAvailableDays":5,"ranges":[],"terms":null,"specificLots":{"enabled":false,"lotIds":[]},"lotIdsAndKeysParams":[],"notifyInactiveUsers":{"enabled":false,"days":7},"chatWithoutReservation":false,"showPhoneNumber":false,"usesTickets":false,"usesPasses":false},"carpool":{"boardingConditions":{"enabled":false,"pickupLocationTolerance":200,"boardingTimeWindow":30,"driverPassengerProximity":100,"boardingQueryDelay":5},"emergencyCall":{"enabled":true},"enabled":true,"visible":true,"communityOptions":true,"routePublishingOptions":["public","community","associated","private"],"routeSearchRestrictions":["public","community","associated","private"],"categories":{"perPassenger":true,"config":{"description":null,"subsidy":{"amount":0,"informationText":null,"companyText":null},"currency":"clp"}}},"cabpool":{"parameters":{"area":null,"originDistrict":null,"destinationDistrict":null,"folio":null,"line":null},"enabled":true,"visible":true,"hasSOS":true},"schoolBus":{"enabled":false,"visible":true},"publicBus":{"enabled":true,"visible":true}},"emailSuffixes":[],"admins":[],"timezone":"Chile/Continental","type":"normal","distance":0,"allowAds":false,"assocCommunities":[],"public":true,"name":"Pruebas Automatización 2.0","site":"http://admin-qa.allrideapp.com/","terms":null,"country":"cl","hasBusesSystem":true,"language":"es","avatar":"https://s3.amazonaws.com/allride.uploads/communityAvatar_67b879e99a2ba09f940ea7c5_1740143082994.png","badge":"https://s3.amazonaws.com/allride.uploads/communityAvatar_67b879e99a2ba09f940ea7c5_1740143084660.png","createdAt":"2025-02-21T13:04:41.887Z","updatedAt":"2025-04-07T14:44:19.439Z","__v":8,"custom":{"allowAds":false,"allowCustomEmail":false,"allowCustomId":false,"allowsManualUsers":false,"balance":{"enabled":true},"betaFeatures":[],"hasSubsidy":{"active":false,"subsidizedUsers":[]},"hasUserMessagingSystem":false,"parkingLots":{"accessModel":"reservation","allowsScreenshots":true,"busIntegration":false,"enableToAllUsers":false,"enabled":false,"entryLimit":{"time":15,"unit":"minutes"},"exitLimit":{"time":15,"unit":"minutes"},"exitReminderTime":{"time":5,"unit":"minutes"},"fullName":{"enabled":false},"lotIdsAndKeysParams":[],"maxAvailableDays":5,"minAvailableDays":3,"necessaryTripsForAllDays":2,"necessaryTripsForMinDays":1,"noExitLimit":{"time":1,"unit":"hour"},"notifyInactiveUsers":{"days":7,"enabled":false},"ranges":[],"reservationByDay":false,"reservationLimit":{"time":1,"unit":"days"},"reservationModel":"priority","sections":false,"specificLots":{"enabled":false,"lotIds":[]}},"products":{"enabled":false},"realTimeTransportSystem":{"buses":{"allowGenericVehicles":false,"allowsRating":false,"allowsScreenshots":true,"allowsSnapshots":false,"apportionCategories":[],"arrivalHourFulfillment":{"enabled":false,"ranges":[]},"assistant":{"departureTimes":[],"entryTimes":[]},"auxiliaryTrackers":[],"budgetSystem":{"enabled":false},"continuousGpsAlwaysOn":false,"custom":{"driverApp":{"visibleCode":"plate"},"passengerApp":{"visibleCode":"plate"},"reports":{"visibleCode":"plate"}},"departureHourFulfillment":{"enabled":false,"ranges":[]},"driverCustomParams":{"enabled":false,"params":[]},"driverParams":[],"emergencyCall":{"enabled":true},"fineManagementSystem":{"enabled":false,"possibleOrigins":[],"stateNotifications":[],"types":[]},"fleetParams":[],"harassmentAssistance":false,"harassmentAssistanceSettings":{"enabled":false,"showInformation":true,"showTextAbove":true},"healthPoll":{"askUser":false,"enabled":false},"internalLegs":{"enabled":false},"internalRoutes":{"enabled":false},"labels":[],"multipleUseQRCodes":{"amount":1,"enabled":false,"uncapped":false},"noPassengerInfo":false,"notifyPassBudgetPercentage":{"enabled":false,"percentages":{"byAccounts":{"accounts":[],"enabled":false},"general":{"criteriaToNotify":"oneTime","enabled":false}},"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]}},"oDDServices":[],"oDDSettings":{"enableToNewUsers":{"enabled":false,"specificParams":{"enabled":false,"params":[]}},"joinNewAdminODDs":false},"passengerList":{"data":{"community":false,"fullName":false,"phone":false,"validationParam":false},"enabled":false},"poll":{"active":false,"answeredBy":[]},"rateRoute":{"enabled":false,"withValidation":false},"restrictiveLabels":{"enabled":false,"labels":[]},"routeDeviation":{"enabled":false,"maxDistance":100,"maxTime":5,"notify":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[],"superCommunities":[]}}},"scheduling":{"admin":{"skipAllReservationsAssignedCheck":false},"allowSeatReservations":false,"apportioning":{"enabled":false,"type":"estimated"},"autoAssignReservations":{"enabled":false},"dynamicResourceAssignment":{"enabled":false,"limitTime":15,"limitUnit":"minutes"},"enabled":false,"exceedValidationLimit":{"enabled":false},"minimumConfirmationTime":{"amount":1,"enabled":false,"unit":"hours"},"minimumTimeToAccept":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"},"minimumTimeToAssignDriver":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"},"minimumTimeToConfirm":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"},"minimumTimeToStart":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"},"notifyAdmins":{"driverReject":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]}},"fullService":{"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[],"superCommunities":[]}},"minimumTimeToAssignVehicle":{"amount":1,"enabled":false,"sendTo":{"adminLevels":[],"emails":[],"roleIds":[]},"unit":"hours"}},"reservation":{"enabled":false,"restrictions":{"customParams":{"dataType":"text","enabled":false,"options":[]},"unit":"days","userSkip":[]}},"serviceCreationAnticipation":4,"startLimit":{"amount":1,"enabled":false,"unit":"hours"}},"snapshots":{"nonService":{"enabled":false},"service":{"enabled":false}},"tracker":{"enabled":false},"usesPin":false,"validateDeparture":{"enabled":false},"validation":{"DNIValidation":{"enabled":false,"failureMessage":"Solo puedes presentar el código de AllRideo o de tu cédula de identidad.","showRejected":true,"type":"qr","options":["qr"]},"bCValidation":{"enabled":false},"customQRValidation":{"enabled":false},"customValidation":{"dataType":"text","enabled":false,"options":[]},"customValidationParams":{"driverParams":[],"passengerParams":[]},"dailyLimit":{"userSkip":[]},"departureLimit":{"userSkip":[]},"external":[],"healthPoll":false,"secureNFCValidation":{"enabled":false},"timeLimit":{"userSkip":[]},"timestamp":{"userSkip":[]},"usesInternalNFC":false,"validationToken":""},"wfIntegration":{"enabled":false},"fleetCustomParams":{"enabled":false,"params":[]}},"cabpool":{"hasSOS":true},"carpool":{"boardingConditions":{"boardingQueryDelay":5,"boardingTimeWindow":30,"driverPassengerProximity":100,"enabled":false,"pickupLocationTolerance":200},"communityOptions":true,"emergencyCall":{"enabled":true},"enabled":true,"routePublishingOptions":[],"routeSearchRestrictions":[]},"schoolbus":{"enabled":true}},"replacesManualUser":true,"validationParams":{"allowMultipleUseValidationCodes":false,"forceMandatoryParams":false,"params":[]}}}
    ...    headers=${headers}
    # Verifica el código de estado esperado (puedes ajustarlo según tus expectativas)

    Status Should Be    200