//
//  DiscoveryVC+BuildMenu.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import Foundation
import TicketmasterFoundation
import TicketmasterDiscoveryAPI

extension DiscoveryViewController {
    
    enum CellIdentifier: String {
        case settingsLanguageTitle
        case settingsLanguage
        case settingsIdentifierTitle
        case settingsIdentifier

        case searchEvent
        case searchVenue
        case searchAttraction
        case searchClassification
        
        case detailsEvent
        case detailsVenue
        case detailsAttraction
        case detailsClassification
    }
    
    func buildRefreshMenu() {
        if didBuildMenu == false {
            buildMenuDataSource()
            didBuildMenu = true
        } else {
            menuDataSource.updateCell(value: selectedLanguage.rawValue.uppercased(),
                                      forUniqueIdentifier: CellIdentifier.settingsLanguage.rawValue)
            menuDataSource.updateCell(value: selectedIdentifierType.keyName,
                                      forUniqueIdentifier: CellIdentifier.settingsIdentifier.rawValue)
        }
    }
    
    private func buildMenuDataSource() {
        menuDataSource.configure(tableView: tableView)
        menuDataSource.cellInfoSectionArray = [
            buildSectionSettings(),
            buildSectionSearch(),
            buildSectionDetails(),
            MenuBuilderDataSource.buildSectionBlanksForKeyboard()
        ]
        menuDataSource.delegate = self
        tableView.reloadData()
    }
    
    private func buildSectionSettings() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.settingsLanguageTitle.rawValue,
                                       titleText: "Language:")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .segmentedControl,
                                       uniqueIdentifier: CellIdentifier.settingsLanguage.rawValue,
                                       valueText: selectedLanguage.rawValue.uppercased(),
                                       valueArray: DiscoveryLocale.sampleKeys)
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.settingsIdentifierTitle.rawValue,
                                       titleText: "Identifier Type:")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .segmentedControl,
                                       uniqueIdentifier: CellIdentifier.settingsIdentifier.rawValue,
                                       valueText: selectedIdentifierType.keyName,
                                       valueArray: DiscoveryHelper.DetailsIdentifierType.allCases.map({ $0.keyName }))
        cellInfoArray.append(cellInfo)

        return MenuBuilderSectionInfo(title: "Settings", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionSearch() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.searchEvent.rawValue,
                                       placeholderText: "Event Search String")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.searchVenue.rawValue,
                                       placeholderText: "Venue Search String")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.searchAttraction.rawValue,
                                       placeholderText: "Attraction Search String")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.searchClassification.rawValue,
                                       placeholderText: "Classification Search String")
        cellInfoArray.append(cellInfo)

        return MenuBuilderSectionInfo(title: "Search", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionDetails() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo

        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.detailsEvent.rawValue,
                                       placeholderText: "Event Identifier")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.detailsVenue.rawValue,
                                       placeholderText: "Venue Identifier")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.detailsAttraction.rawValue,
                                       placeholderText: "Attraction Identifier")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.detailsClassification.rawValue,
                                       placeholderText: "Classification Identifier")
        cellInfoArray.append(cellInfo)

        return MenuBuilderSectionInfo(title: "Details", cellInfoRowArray: cellInfoArray)
    }
}

extension MarketDomain {
    
    static var allKeys: [String] {
        return MarketDomain.allCases.map({ $0.stringValue.uppercased() })
    }
}

extension DiscoveryLocale {
    
    static var sampleKeys: [String] {
        return [DiscoveryLocale.EN_US.rawValue.uppercased(),
                DiscoveryLocale.EN_GB.rawValue.uppercased(),
                DiscoveryLocale.EN_MX.rawValue.uppercased(),
                DiscoveryLocale.FR_CA.rawValue.uppercased(),
                DiscoveryLocale.ES_MX.rawValue.uppercased()]
    }
}
