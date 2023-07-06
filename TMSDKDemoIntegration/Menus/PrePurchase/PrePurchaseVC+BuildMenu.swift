//
//  PrePurchaseVC+BuildMenu.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import Foundation
import TicketmasterFoundation

extension PrePurchaseViewController {
    
    enum CellIdentifier: String {
        case pageHome
        case pageSearch
        case pageVenue
        case pageAttraction
    }
        
    func buildRefreshMenu() {
        if didBuildMenu == false {
            buildMenuDataSource()
            didBuildMenu = true
        } else {
            menuDataSource.updateCell(value: selectedVenueIdentifier,
                                      forUniqueIdentifier: CellIdentifier.pageVenue.rawValue)
            menuDataSource.updateCell(value: selectedAttractionIdentifier,
                                      forUniqueIdentifier: CellIdentifier.pageAttraction.rawValue)
        }
    }
    
    private func buildMenuDataSource() {
        menuDataSource.configure(tableView: tableView)
        menuDataSource.cellInfoSectionArray = [
            buildSectionPages(),
            MenuBuilderDataSource.buildSectionBlanksForKeyboard()
        ]
        menuDataSource.delegate = self
        tableView.reloadData()
    }
    
    private func buildSectionPages() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.pageHome.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Home Page")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.pageSearch.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Search Page")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .textFieldWithTitle,
                                       uniqueIdentifier: CellIdentifier.pageVenue.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Venue Page",
                                       valueText: selectedVenueIdentifier,
                                       placeholderText: "Venue Identifier")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .textFieldWithTitle,
                                       uniqueIdentifier: CellIdentifier.pageAttraction.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Attraction Page",
                                       valueText: selectedAttractionIdentifier,
                                       placeholderText: "Attraction Identifier")
        cellInfoArray.append(cellInfo)
        
        
        return MenuBuilderSectionInfo(title: "PrePurchase", cellInfoRowArray: cellInfoArray)
    }
}
