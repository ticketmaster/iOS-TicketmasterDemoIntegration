//
//  MainMenuViewController.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation

import TicketmasterFoundation
import TicketmasterAuthentication
import TicketmasterDiscoveryAPI
import TicketmasterPrePurchase
import TicketmasterPurchase
import TicketmasterSecureEntry
import TicketmasterTickets

class MainMenuViewController: UITableViewController {

    var menuDataSource = MenuBuilderDataSource()
    var didBuildMenu: Bool = false
    
    var currentUserEmail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // do any additional setup after loading the App's initial viewController
        ConfigurationManager.shared.printVersions()
        
        view.backgroundColor = .systemGroupedBackground
        
        title = "Main Menu"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        themeNavigationBar()
        buildRefreshMenu()
    }
}



extension MainMenuViewController {
    
    func themeNavigationBar() {
        let configuration = ConfigurationManager.shared.currentConfiguration
        // update the header color
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = configuration.backgroundColor
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: configuration.textTheme.color]
        navigationController?.navigationBar.standardAppearance = barAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
        navigationController?.navigationBar.tintColor = configuration.textTheme.color
        navigationController?.navigationBar.barTintColor = configuration.backgroundColor
    }
}
