//
//  PurchaseViewController.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import UIKit

class PurchaseViewController: UITableViewController {

    var menuDataSource = MenuBuilderDataSource()
    var didBuildMenu: Bool = false
        
    var customEventIdentifier: String? {
        get {
            return UserDefaultsManager.shared.string(.purchaseCustomEventIDString)
        }
        set {
            if let value = newValue {
                return UserDefaultsManager.shared.set(value, forKey: .purchaseCustomEventIDString)
            } else {
                UserDefaultsManager.shared.remove(.purchaseCustomEventIDString)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Purchase"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildRefreshMenu()
    }
}
