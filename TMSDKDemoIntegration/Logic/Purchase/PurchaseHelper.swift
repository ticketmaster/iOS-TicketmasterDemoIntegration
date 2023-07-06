//
//  PurchaseHelper.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterPurchase // for TMPurchase

/// a class to wrap helpful methods
class PurchaseHelper: NSObject {
    
    weak var purchaseMenuVC: PurchaseViewController?

    /// show Apple's Rate My App after a successful purchase?
    var rateMyAppAfterPurchase: Bool = false
    
    // TODO: persist this favoritesStore somewhere, so the user's favorites are remembered
    /// storage of user's favorited Event IDs
    var eventFavoritesStore: [String] = []

    /// the resulting Order from a purchase (if any)
    var purchasedOrder: TMPurchaseOrder?
    
    /// which ViewController is presenting the Purchase SDK
    var presentingViewController: UIViewController?
    
    func configure(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        guard configuration.apiKey != "<your apiKey>" else {
            fatalError("Set your apiKey in Configuration.swift")
        }
        
        // make sure to configure Authentication first
        ConfigurationManager.shared.configureAuthenticationIfNeeded { success in
            if success {
                // then configure Purchase
                self.configurePurchase(configuration: configuration, completion: completion)
            } else {
                completion(false)
            }
        }
    }
    
    private func configurePurchase(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        print("Purchase Configuring...")
        
        TMPurchase.shared.apiKey = configuration.apiKey
        
        if let color = configuration.backgroundColor {
            TMPurchase.shared.brandColor = color
        }
        
        /// Automatically dismiss `TMPurchaseNavigationController` upon completion of purchase operations (purchase, cancel, etc)
        TMPurchase.shared.dismissUponCompletion = true
        
        print(" - Purchase Configured")
        
        completion(true)
    }
}
