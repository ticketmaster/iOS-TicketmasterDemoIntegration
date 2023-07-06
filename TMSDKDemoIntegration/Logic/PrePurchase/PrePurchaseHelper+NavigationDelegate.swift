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

extension PrePurchaseHelper: TMPrePurchaseNavigationDelegate {
    
    func prePurchaseWebViewIsOnFirstPage(_ status: Bool) {
        print("isOnFirstPage: \(status ? "true" : "false")")
    }
    
    func prePurchaseViewController(_ viewController: TMPrePurchaseViewController, navigateToEventDetailsPageWithIdentifier eventIdentifier: String) {
        print("OPEN EDP: \(eventIdentifier)")
        // TODO: open EDP in purchase
    }
}
