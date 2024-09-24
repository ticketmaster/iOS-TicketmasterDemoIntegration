//
//  PrePurchaseVC+BuildMenu.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import Foundation
import TicketmasterFoundation
import TicketmasterDiscoveryAPI

extension PrePurchaseViewController {
    
    enum CellIdentifier: String {
        case settingsDomain
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
            if let prePurchaseHelper = ConfigurationManager.shared.prePurchaseHelper {
                menuDataSource.updateCell(value: prePurchaseHelper.forcedMarketDomain.stringValue.uppercased(),
                                          forUniqueIdentifier: CellIdentifier.settingsDomain.rawValue)
            }
        }
    }
    
    private func buildMenuDataSource() {
        menuDataSource.configure(tableView: tableView)
        menuDataSource.cellInfoSectionArray = [
            buildSectionSettings(),
            buildSectionPages(),
            MenuBuilderDataSource.buildSectionBlanksForKeyboard()
        ]
        menuDataSource.delegate = self
        tableView.reloadData()
    }
    
    private func buildSectionSettings() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        cellInfo = MenuBuilderCellInfo(cellType: .buttonWithTitleAndPopupMenu,
                                       uniqueIdentifier: CellIdentifier.settingsDomain.rawValue,
                                       titleText: "Domain:",
                                       valueText: ConfigurationManager.shared.prePurchaseHelper?.forcedMarketDomain.stringValue.uppercased(),
                                       valueArray: MarketDomain.sampleKeys,
                                       segmentTextArray: MarketDomain.sampleKeys.map({
                (NSLocale.current as NSLocale).displayName(forKey: .countryCode, value: $0) ?? $0
            })
        )

        cellInfoArray.append(cellInfo)
        
        return MenuBuilderSectionInfo(title: "Settings", cellInfoRowArray: cellInfoArray)
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

extension MarketDomain {
    
    static var sampleKeys: [String] {
        return [MarketDomain.US.stringValue.uppercased(),
                MarketDomain.CA.stringValue.uppercased(),
                MarketDomain.AU.stringValue.uppercased(),
                MarketDomain.NZ.stringValue.uppercased(),
                MarketDomain.UK.stringValue.uppercased(),
                MarketDomain.IE.stringValue.uppercased(),
                MarketDomain.MX.stringValue.uppercased()]
    }
    
    var defaultSampleLocale: DiscoveryLocale {
        switch self {
        case .US, .CA, .AU, .NZ:
            return .EN_US
        case .UK, .IE:
            return .EN_GB
        case .MX:
            return .EN_MX
        case .AT, .PL, .NO, .FI, .BE, .CZ, .SE, .ZA, .ES, .DE, .AE, .NL, .CH, .DK:
            return .EN_US
        @unknown default:
            return .EN_US
        }
    }
}
