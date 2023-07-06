//
//  MenuBuilderDataSource+Configure.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

extension MenuBuilderDataSource {
    func configure(tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        
        registerNibs(forTableView: tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView = tableView
    }
    
    private func registerNibs(forTableView tableView: UITableView) {
        for identifier in MenuBuilderCellType.allCases {
            let nib = UINib(nibName: identifier.nibName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: identifier.rawValue)
        }
    }
}
