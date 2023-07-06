//
//  PrePurchaseHelper.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import TicketmasterPrePurchase // for TMPrePurchase

/// a class to wrap helpful methods
class PrePurchaseHelper: NSObject {
    
    func configure(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        guard configuration.apiKey != "<your apiKey>" else {
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
