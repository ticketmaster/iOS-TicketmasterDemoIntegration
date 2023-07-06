//
//  PurchaseHelper+SharingDelegate.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import TicketmasterDiscoveryAPI
import TicketmasterPurchase

/// The sharing delegate of a `TMPurchaseNavigationController`.
///
/// This protocol can be used to customize the message included in the social sharing feature by providing a new message to replace the default one used by the Purchase SDK.
///
/// Default Message:  eventTitle + " " + eventDate
///
/// - Note: If the delegate is not set or implemented, the default sharing message will be used.
extension PurchaseHelper: TMPurchaseSharingDelegate {
    
    /// Set a customized sharing message based on the Event being shared.
    ///
    /// Integrating App's Task: use the provided Event to create a customized social sharing message
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` requesting a sharing message.
    ///   - event: the Event being shared
    ///   - completion: returns a customized sharing message `String`
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                      sharingMessageFor event: DiscoveryEvent,
                                      completion: @escaping (String) -> Void) {
        
        // TODO: customize the message the user is sharing
        let shareMessage = "Sharing this cool event!"
        
        print("Event: \(event.eventIdentifier) => \"\(shareMessage)\"")
        
        completion(shareMessage)
    }
}
