//
//  PrePurchaseHelper+Configure.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import TicketmasterPrePurchase // for TMPrePurchase and TMPrePurchaseViewController

extension PrePurchaseHelper {
    
    func configure(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        guard configuration.apiKey != ConfigurationManager.badAPIKey else {
            fatalError("Set your apiKey in Configuration.swift")
        }
        
        // PrePurchase does NOT use TicketmasterAuthentication,
        //  so no need to configure TicketmasterAuthentication first

        print("PrePurchase Configuring...")
        
        TMPrePurchase.shared.apiKey = configuration.apiKey
        TMPrePurchase.shared.domain = configuration.retailMarketDomain
        
        if let color = configuration.backgroundColor {
            TMPrePurchase.shared.brandColor = color
        }
        
        print(" - PrePurchase Configured")

        completion(true)
    }
}
