//
//  PurchaseHelper+Configure.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import TicketmasterPurchase // for TMPurchase

extension PurchaseHelper {
    
    func configure(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        guard configuration.apiKey != ConfigurationManager.badAPIKey else {
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
        
        // was:
        //TMPurchase.shared.apiKey = configuration.apiKey
        
        // now:
        TMPurchase.shared.configure(apiKey: configuration.apiKey,
                                    region: configuration.region) { _ in
            
            if let color = configuration.backgroundColor {
                TMPurchase.shared.brandColor = color
            }
            
            /// Automatically dismiss `TMPurchaseNavigationController` upon completion of purchase operations (purchase, cancel, etc)
            TMPurchase.shared.dismissUponCompletion = true
            
            print(" - Purchase Configured")
            
            completion(true)
        }
    }
}
