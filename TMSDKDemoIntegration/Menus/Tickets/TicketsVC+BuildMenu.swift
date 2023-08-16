//
//  TicketsVC+BuildMenu.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation

extension TicketsViewController {
    
    enum CellIdentifier: String {
        case presentTicketsPush
        case presentTicketsModal
        case presentTicketsEmbeddedPush
        case presentTicketsEmbeddedModal

        case displayOrder
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
            buildSectionPresent(),
            buildSectionOptions(),
            MenuBuilderDataSource.buildSectionBlanksForKeyboard()
        ]
        menuDataSource.delegate = self
        tableView.reloadData()
    }
    
    private func buildSectionPresent() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
                
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.presentTicketsPush.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Push TicketsVC (on NavBar)")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.presentTicketsModal.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Present TicketsVC (Modal)")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.presentTicketsEmbeddedPush.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Push TicketsView (in EmbeddedVC)")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.presentTicketsEmbeddedModal.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Present TicketsView (in EmbeddedVC)")
        cellInfoArray.append(cellInfo)

        return MenuBuilderSectionInfo(title: "Tickets", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionOptions() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        cellInfo = MenuBuilderCellInfo(cellType: .textFieldWithTitle,
                                       uniqueIdentifier: CellIdentifier.displayOrder.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Display:",
                                       placeholderText: "Event or Order Identifier")
        cellInfoArray.append(cellInfo)
        
        return MenuBuilderSectionInfo(title: "Options", cellInfoRowArray: cellInfoArray)
    }
}
