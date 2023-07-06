//
//  TicketsHelper+PrebuiltModules.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import TicketmasterTickets // for TMPurchasedEvent, TMTicketsModule and TMTicketsPrebuiltModule

extension TicketsHelper {
    
    func addPreBuiltModules(event: TMPurchasedEvent) -> [TMTicketsModule] {
        print(" - Adding Prebuilt Modules")
        var output: [TMTicketsModule] = []
        
        // show an Account Manager More Ticket Actions module
        // note that this module will only render if Event is an Account Manager Event, otherwise it will not be displayed
        // this is a standard "prebuilt" module that we provide to all our partners
        if let module = TMTicketsPrebuiltModule.accountManagerMoreTicketActions(event: event) {
            output.append(module)
        }
        
        // show a street-map around the Venue with a Directions button that opens Apple Maps
        // this is a standard "prebuilt" module that we provide to all our partners
        if let module = TMTicketsPrebuiltModule.venueDirectionsViaAppleMaps(event: event) {
            output.append(module)
        }
        
        // show an Account Manager Seat Upgrades module
        // note that this module will only render if Event is an Account Manager Event, otherwise it will not be displayed
        // this is a standard "prebuilt" module that we provide to all our partners
        if let module = TMTicketsPrebuiltModule.accountManagerSeatUpgrades(event: event) {
            output.append(module)
        }
        
        // show a Venue Concessions module
        // this is a standard "prebuilt" module that we provide to all our partners
        if let module = TMTicketsPrebuiltModule.venueConcessions(event: event, showWalletButton: true) {
            output.append(module)
        }
        
        return output
    }
}
