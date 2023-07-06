//
//  PurchaseHelper+SharingDelegate.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import TicketmasterDiscoveryAPI
import TicketmasterPurchase

extension PurchaseHelper: TMPurchaseSharingDelegate {
    
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                      sharingMessageFor event: DiscoveryEvent,
                                      completion: @escaping (String) -> Void) {
        
        // TODO: customize the message the user is sharing
        let shareMessage = "Sharing this cool event!"
        
        print("Event: \(event.eventIdentifier) => \"\(shareMessage)\"")
        
        completion(shareMessage)
    }
}
