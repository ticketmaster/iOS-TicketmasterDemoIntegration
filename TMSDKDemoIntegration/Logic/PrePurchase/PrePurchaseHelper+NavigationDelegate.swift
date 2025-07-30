//
//  PrePurchaseHelper+NavigationDelegate.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterFoundation
import TicketmasterPrePurchase

/// Protocol for communicating navigations happening in PrePurchase pages
extension PrePurchaseHelper: TMPrePurchaseNavigationDelegate {
    
    /// PrePurchase needs to open an EDP (Event Details Page) to possibly make a purchase.
    ///
    /// A typical implementation of this function would use TicketmasterPurchase SDK to display an Event Details Page.
    ///
    /// - Parameters:
    ///   - eventIdentifier: Event identifier
    func prePurchaseViewController(_ viewController: TMPrePurchaseViewController, navigateToEventDetailsPageWithIdentifier eventIdentifier: String,
                                   domain: MarketDomain?) {
        print("navigateToEventDetailsPageWithIdentifier: \(eventIdentifier)")
        // REQUIRED:
        // PrePurchase is asking us to present the Purchase SDK for this event
        presentPurchase(forEventID: eventIdentifier, onViewController: viewController)
    }
}
