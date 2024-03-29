//
//  PurchaseHelper+Present.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterFoundation
import TicketmasterDiscoveryAPI
import TicketmasterPurchase

extension PurchaseHelper {
    
    func presentPurchase(eventID: String, onViewController viewController: UIViewController) {
        // build purchase website configure (aka club-site configuration)
        let configuration = buildPurchaseWebsiteConfiguration(eventID: eventID)
        presentPurchase(configuration: configuration, onViewController: viewController)
    }
    
    func presentPurchase(configuration: TMPurchaseWebsiteConfiguration, onViewController viewController: UIViewController) {
        let purchaseNavController = TMPurchaseNavigationController(configuration: configuration)
                
        // MARK: this OPTIONAL delegate is useful for custom UI navigation:
        //  * present Tickets page after a completed purchase
        //  * prompt "Rate my App" (a happy user is more likely to give your App a good rating on the AppStore!)
        purchaseNavController.navigationDelegate = self
         
        // MARK: this OPTIONAL delegate will only be called if showShareToolbarButton is enabled in `TMPurchaseWebsiteConfiguration`
        purchaseNavController.sharingDelegate = self
                
        // MARK: this OPTIONAL delegate is useful for analytics about user actions within the Purchase SDK flow
        purchaseNavController.userAnalyticsDelegate = self
        
        // MARK: this OPTIONAL delegate is useful for tracking server/website performance
        //  This is mainly used for Ticketmaster's own internal analytics and is not needed for most parter App integrations.
        //  The typical user analytics that your App may want to report on can be found in the `userNavigationDelegate`, so there is no need to set it
        //purchaseNavController.webAnalyticsDelegate = self // see PurchaseSDKLogic+Delegate.swift
        
        // clear out any previously purchased order
        purchasedOrder = nil
        
        // store presenting ViewController
        presentingViewController = viewController
        
        // present configured TMPurchaseNavigationController
        viewController.present(purchaseNavController, animated: true, completion: nil)
    }
}
