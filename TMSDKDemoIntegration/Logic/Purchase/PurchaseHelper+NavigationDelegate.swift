//
//  PurchaseHelper+NavigationDelegate.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import TicketmasterFoundation
import TicketmasterDiscoveryAPI
import TicketmasterPurchase

extension PurchaseHelper: TMPurchaseNavigationDelegate {
    
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                      didFailToLoadWith error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func purchaseNavigationControllerDidFinish(_ purchaseNavigationController: TMPurchaseNavigationController) {
        print("purchaseNavigationControllerDidFinish")
    }
}
