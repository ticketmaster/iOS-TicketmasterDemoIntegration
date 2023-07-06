//
//  PurchaseHelper.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import TicketmasterPurchase // for TMPurchase

/// a class to wrap helpful methods
class PurchaseHelper: NSObject {
    
    func configure(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        guard configuration.apiKey != "<your apiKey>" else {
            fatalError("Set your apiKey in Configuration.swift")
        }
        
        // make sure to configure Authentication first
        ConfigurationManager.shared.configureAuthenticationIfNeeded { success in
            if success {
                self.configureTickets(configuration: configuration, completion: completion)
            } else {
                completion(false)
            }
        }
    }
    
    private func configureTickets(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
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
