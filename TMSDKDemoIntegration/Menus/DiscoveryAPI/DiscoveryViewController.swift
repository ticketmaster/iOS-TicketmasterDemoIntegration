//
//  DiscoveryViewController.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import UIKit
import TicketmasterFoundation
import TicketmasterDiscoveryAPI

class DiscoveryViewController: UITableViewController {

    var menuDataSource = MenuBuilderDataSource()
    var didBuildMenu: Bool = false
    
    var selectedLanguage: DiscoveryLocale {
        get {
            if let languageString = UserDefaultsManager.shared.string(.discoveryLanguageString),
               let locale = DiscoveryLocale(rawValue: languageString) {
                return locale
            } else {
                return .EN_US
            }
        }
        set {
            UserDefaultsManager.shared.set(newValue.rawValue, forKey: .discoveryLanguageString)
        }
    }

    var selectedIdentifierType: DiscoveryHelper.DetailsIdentifierType {
        get {
            if let identifierString = UserDefaultsManager.shared.string(.discoveryIdentifierString),
               let identifier = DiscoveryHelper.DetailsIdentifierType(rawValue: identifierString) {
                return identifier
            } else {
                return .legacyHost
            }
        }
        set {
            UserDefaultsManager.shared.set(newValue.rawValue, forKey: .discoveryIdentifierString)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Discovery API"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildRefreshMenu()
    }
}
