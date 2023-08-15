//
//  TicketsHelper+PrePurchase.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import TicketmasterFoundation
import TicketmasterTickets

extension TicketsHelper {
    
    func handleModuleMoreTickets(event: TMPurchasedEvent, module: TMTicketsModule, button: TMTicketsModule.ActionButton) {
        
        // this one is a slightly special case:
        //  1. Tickets can present PrePurchase
        //  2. PrePurchase can present Purchase
        //  3. Purchase can present Tickets
        //
        // this creates an infinite loop, which is not recommended
        //
        // so we'll break the loop by dismissing everything on top of Tickets at step #3
        // see PurchaseHelper+Tickets.swift

        // give the dismiss animation a moment to process
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if button.callbackValue == "games" {
                print("handleModuleActionButton: Present More Games")
                // if the Tickets are from Archtics, the identifier may not be a HOST identifer
                // so we may have to hard-code the Attraction ID
                let attractionID = event.info.attraction?.identifier ?? "805924" // Colorado Avalanche
                let attractionName = event.info.attraction?.name
                
                // load Attraction Details Page
                ConfigurationManager.shared.configurePrePurchaseIfNeeded { success in
                    if success {
                        // present on whatever VC is on top
                        if let vc = UIApplication.shared.topViewController() {
                            ConfigurationManager.shared.prePurchaseHelper?.presentPrePurchase(page: .attraction(identifier: attractionID),
                                                                                              title: attractionName,
                                                                                              onViewController: vc)
                        }
                    }
                }
                
            } else if button.callbackValue == "concerts" {
                print("handleModuleActionButton: Present More Concerts")
                // if the Tickets are from Archtics, the identifier may not be a HOST identifer
                // so we may have to hard-code the Venue ID
                let venueID = event.info.venue?.identifier ?? "246112"
                //let venueID = "246112" // Colorado Ball Arena
                let venueName = event.info.venue?.name ?? "Ball Arena"
                //let venueName = "Ball Arena" // Colorado Ball Arena
                
                // load Venue Details page
                ConfigurationManager.shared.configurePrePurchaseIfNeeded { success in
                    if success {
                        // present on whatever VC is on top
                        if let vc = UIApplication.shared.topViewController() {
                            ConfigurationManager.shared.prePurchaseHelper?.presentPrePurchase(page: .venue(identifier: venueID),
                                                                                              title: venueName,
                                                                                              onViewController: vc)
                        }
                    }
                }
            }
        }
    }
}
