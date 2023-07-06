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
            return UserDefaultsManager.shared.string(.prePurchaseVenueString) ?? "57843" // Fiserv Forum, Milwaukee, WI (TM Venue ID)
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
            return UserDefaultsManager.shared.string(.prePurchaseAttractionString) ?? "805969" // Milwaukee Bucks (TM Artist ID)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildRefreshMenu()
    }
}
