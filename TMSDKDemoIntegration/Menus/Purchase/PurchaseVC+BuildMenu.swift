//
//  PurchaseVC+BuildMenu.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import Foundation
import TicketmasterFoundation

extension PurchaseViewController {
    
    enum CellIdentifier: String {
        case purchaseOpenEvent

        case purchaseConfiguration
        
        case purchaseSampleEvent
    }
    
    func buildRefreshMenu() {
        if didBuildMenu == false {
            buildMenuDataSource()
            didBuildMenu = true
        }
    }
    
    private func buildMenuDataSource() {
        menuDataSource.configure(tableView: tableView)
        menuDataSource.cellInfoSectionArray = [
            buildSectionOpen(),
            buildSectionSettings(),
            buildSectionSample(),
            MenuBuilderDataSource.buildSectionBlanksForKeyboard()
        ]
        menuDataSource.delegate = self
        tableView.reloadData()
    }
    
    private func buildSectionOpen() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
                
        cellInfo = MenuBuilderCellInfo(cellType: .textFieldWithTitle,
                                       uniqueIdentifier: CellIdentifier.purchaseOpenEvent.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Event Details Page",
                                       valueText: customEventIdentifier,
                                       placeholderText: "Event Identifier")
        cellInfoArray.append(cellInfo)

        return MenuBuilderSectionInfo(title: "Open EDP", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionSettings() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.purchaseConfiguration.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Custom Purchase Configuration")
        cellInfoArray.append(cellInfo)
        
        return MenuBuilderSectionInfo(title: "Settings", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionSample() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        for event in EventConfigurationManager.shared.configurations {
            cellInfo = MenuBuilderCellInfo(cellType: .title,
                                           uniqueIdentifier: CellIdentifier.purchaseSampleEvent.rawValue,
                                           accessoryType: .disclosureIndicator,
                                           titleText: event.name)
            cellInfoArray.append(cellInfo)
        }
        
        return MenuBuilderSectionInfo(title: "Sample Events", cellInfoRowArray: cellInfoArray)
    }
}
