//
//  PrePurchaseHelper.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import CoreLocation
import TicketmasterFoundation // for MarketLocation
import TicketmasterPrePurchase // for TMPrePurchase and TMPrePurchaseViewController

/// a class to wrap helpful methods
class PrePurchaseHelper: NSObject {
    
    weak var prePurchaseMenuVC: PrePurchaseViewController?

    var homepageMarketLocation: MarketLocation = MarketLocation.California_LosAngeles()
    
    lazy var clLocationManager: CLLocationManager = {
        let result = CLLocationManager()
        result.delegate = self
        return result
    }()
    
    weak var locationRequestingViewController: TMPrePurchaseViewController?
    
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
