//
//  MenuBuilderDataSource.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

protocol MenuBuilderDataSourceDelegate: AnyObject {
    func menuBuilderDataSource(_ :MenuBuilderDataSource, didAction action: MenuBuilderAction, forCell cell: MenuBuilderTableViewCell)
}

class MenuBuilderDataSource: NSObject {

    weak var delegate: MenuBuilderDataSourceDelegate?
    
    weak var tableView: UITableView? = nil
    
    var lastDismissKeyboardTime: Date = Date()
    
    var cellInfoSectionArray: [MenuBuilderSectionInfo] = []
}

extension MenuBuilderDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellInfoSectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfoSectionArray[section].cellInfoRowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get cellInfo for this section and row
        let cellInfo = cellInfoSectionArray[indexPath.section].cellInfoRowArray[indexPath.row]
        return buildAndConfigureCell(forTableView: tableView, withCellInfo: cellInfo)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cellInfoSectionArray[section].title
    }
}

extension MenuBuilderDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        dismissKeyboard()
        let cell = tableView.cellForRow(at: indexPath) as! MenuBuilderTableViewCell
        delegate?.menuBuilderDataSource(self, didAction: .backgroundTapped, forCell: cell)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // we get a lot of these didScroll callbacks,
        // so let's only try dismissing the keyboard once every second or so to improve performance
        if Date().timeIntervalSince(lastDismissKeyboardTime) > 1.0 { // seconds
            dismissKeyboard()
        }
    }
}
