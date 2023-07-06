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
        //case presentTicketsEmbedded

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
                                       titleText: "Present Tickets (Push)")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.presentTicketsModal.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Present Tickets (Modal)")
        cellInfoArray.append(cellInfo)
        
//        cellInfo = MenuBuilderCellInfo(cellType: .title,
//                                       uniqueIdentifier: CellIdentifier.presentTicketsEmbedded.rawValue,
//                                       accessoryType: .disclosureIndicator,
//                                       titleText: "Present Tickets (Embedded)")
//        cellInfoArray.append(cellInfo)

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
