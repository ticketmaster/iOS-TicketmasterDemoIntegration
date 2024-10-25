//
//  PrePurchaseViewController.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import UIKit
import CoreLocation
import TicketmasterFoundation
import TicketmasterPrePurchase

class PrePurchaseViewController: UITableViewController {

    var menuDataSource = MenuBuilderDataSource()
    var didBuildMenu: Bool = false
    
    var selectedVenueIdentifier: String? {
        get {
            return UserDefaultsManager.shared.string(.prePurchaseVenueString) ?? "205115" // Salt River Fields, Scottsdale, AZ (TM Venue ID)
        }
        set {
            if let value = newValue {
                return UserDefaultsManager.shared.set(value, forKey: .prePurchaseVenueString)
            } else {
                UserDefaultsManager.shared.remove(.prePurchaseVenueString)
            }
        }
    }
    
    var selectedAttractionIdentifier: String? {
        get {
            return UserDefaultsManager.shared.string(.prePurchaseAttractionString) ?? "805895" // Arizona Diamondbacks (TM Artist ID)
        }
        set {
            if let value = newValue {
                return UserDefaultsManager.shared.set(value, forKey: .prePurchaseAttractionString)
            } else {
                UserDefaultsManager.shared.remove(.prePurchaseAttractionString)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "PrePurchase"
        
        if let prePurchaseHelper = ConfigurationManager.shared.prePurchaseHelper {
            if let value = UserDefaultsManager.shared.string(.prePurchaseDomainString), let market = MarketDomain(rawValue: value.lowercased()) {
                prePurchaseHelper.forcedMarketDomain = market
                prePurchaseHelper.homepageMarketLocation = MarketLocation.defaultLocationFor(market: market)
            } else if let market = MarketDomain(rawValue: TMPrePurchase.shared.marketDomain.stringValue.lowercased()) {
                prePurchaseHelper.forcedMarketDomain = market
                prePurchaseHelper.homepageMarketLocation = MarketLocation.defaultLocationFor(market: market)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildRefreshMenu()
    }
}
