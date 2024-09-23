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

    var forcedMarketDomain: MarketDomain = MarketDomain.US
    var homepageMarketLocation: MarketLocation = MarketLocation.California_LosAngeles()
    
    lazy var clLocationManager: CLLocationManager = {
        let result = CLLocationManager()
        result.delegate = self
        return result
    }()
    
    weak var locationRequestingViewController: TMPrePurchaseViewController?
    
}
