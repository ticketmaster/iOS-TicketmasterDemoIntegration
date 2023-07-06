//
//  TicketsViewController.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit

class TicketsViewController: UITableViewController {
    
    var menuDataSource = MenuBuilderDataSource()
    var didBuildMenu: Bool = false
    
    var displayIdentifier: String? {
        get {
            return UserDefaultsManager.shared.string(.ticketsDisplayID)
        }
        set {
            if let value = newValue {
                return UserDefaultsManager.shared.set(value, forKey: .ticketsDisplayID)
            } else {
                UserDefaultsManager.shared.remove(.ticketsDisplayID)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tickets"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildRefreshMenu()
    }
}
