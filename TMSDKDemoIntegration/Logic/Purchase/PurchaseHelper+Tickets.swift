//
//  PurchaseHelper+Tickets.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/7/23.
//

import Foundation
import TicketmasterPurchase
import TicketmasterTickets

extension PurchaseHelper {
    
    func presentTickets(forOrder order: TMPurchaseOrder) {
        // yes, let's display the user's Orders on the presentingViewController (the same ViewController that presented Purchase)
        if let vc = presentingViewController {
            ConfigurationManager.shared.configureTicketsIfNeeded { success in
                if success {
                    guard let ticketsHelper = ConfigurationManager.shared.ticketsHelper else { return }
                    
                    // do we know exactly which Order?
                    if let orderID = order.identifier {
                        // yes, jump to that exact Order (open the Tickets: Tickets Listing page)
                        print("Show Tickets page for Order: \(orderID)")
                        // are we already presenting the Ticket VC?
                        if let existingVC = ticketsHelper.ticketsVC {
                            // yes, dismiss back to it, then display the new tickets
                            existingVC.dismissViewControllersOnTopOfSelf(animated: true) {
                                TMTickets.shared.display(orderOrEventId: orderID)
                            }
                        } else {
                            // no, present it
                            ticketsHelper.pushTickets(orderOrEventID: orderID, onViewController: vc)
                        }
                    } else {
                        // no, but we know if there is Purchase (open the Tickets: Events Listing page)
                        print("Show Events page")
                        // are we already presenting the Ticket VC?
                        if let existingVC = ConfigurationManager.shared.ticketsHelper?.ticketsVC {
                            // yes, dismiss back to it
                            existingVC.dismissViewControllersOnTopOfSelf(animated: true, completion: nil)
                        } else {
                            // no, present it
                            ticketsHelper.pushTickets(onViewController: vc)
                        }
                    }
                }
            }
        }
    }
}
