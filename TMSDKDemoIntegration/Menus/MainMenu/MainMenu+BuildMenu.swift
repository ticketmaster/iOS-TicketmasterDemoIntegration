//
//  MainMenu+BuildMenu.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterFoundation
import TicketmasterAuthentication
import TicketmasterDiscoveryAPI
import TicketmasterPrePurchase
import TicketmasterPurchase
import TicketmasterTickets

extension MainMenuViewController {
    
    enum CellIdentifier: String {
        case apiKeyText
        case apiKeyTextField
        case deploymentRegionText
        case deploymentRegionSegmentedControl

        case discoveryAPIMenu
        case prePurchaseMenu
        case purchaseMenu
        
        case ticketsMenu
        
        case authenticationMenu
        case currentUserText
    }
    
    func buildRefreshMenu() {
        if didBuildMenu == false {
            buildMenuDataSource()
            didBuildMenu = true
        }
        
        let apiKey = ConfigurationManager.shared.currentConfiguration.apiKey
        if apiKey != ConfigurationManager.badAPIKey {
            menuDataSource.updateCell(value: apiKey, forUniqueIdentifier: CellIdentifier.apiKeyTextField.rawValue)
            
            ConfigurationManager.shared.configureAuthenticationIfNeeded { success in
                if success {
                    if TMAuthentication.shared.hasToken() {
                        TMAuthentication.shared.memberInfo { memberInfo in
                            self.menuDataSource.updateCell(title: "Current User: \(memberInfo.email ?? memberInfo.localID ?? memberInfo.globalID ?? "<nil>")",
                                                           forUniqueIdentifier: CellIdentifier.currentUserText.rawValue)
                        } failure: { oldMemberInfo, error, backend in
                            if let memberInfo = oldMemberInfo {
                                self.menuDataSource.updateCell(title: "Current User: \(memberInfo.email ?? memberInfo.localID ?? memberInfo.globalID ?? "<nil>")",
                                                               forUniqueIdentifier: CellIdentifier.currentUserText.rawValue)
                            } else {
                                self.menuDataSource.updateCell(title: "Current User: <\(error.localizedDescription)>",
                                                               forUniqueIdentifier: CellIdentifier.currentUserText.rawValue)
                            }
                        }
                    } else {
                        self.menuDataSource.updateCell(title: "Current User: <logged out>",
                                                       forUniqueIdentifier: CellIdentifier.currentUserText.rawValue)
                    }
                }
            }
        }
    }
    
    private func buildMenuDataSource() {
        menuDataSource.configure(tableView: tableView)
        menuDataSource.cellInfoSectionArray = [
            buildSectionTop(), // hack for rootViewController oddness
            buildSectionConfiguration(),
            buildSectionRetail(),
            buildSectionTickets(),
            buildSectionAuthentication()
        ]
        menuDataSource.delegate = self
        tableView.reloadData()
    }
    
    private func buildSectionTop() -> MenuBuilderSectionInfo {
        return MenuBuilderSectionInfo(title: nil, cellInfoRowArray: [])
    }
    
    private func buildSectionConfiguration() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.apiKeyText.rawValue,
                                       titleText: "Developer API Key:")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.apiKeyTextField.rawValue,
                                       placeholderText: "Enter your Developer API Key")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.deploymentRegionText.rawValue,
                                       titleText: "TMX Deployment Region:")
        cellInfoArray.append(cellInfo)

        let regions: [TMAuthentication.TMXDeploymentRegion] = TMAuthentication.TMXDeploymentRegion.allCases
        let currentRegion = ConfigurationManager.shared.currentConfiguration.region
        cellInfo = MenuBuilderCellInfo(cellType: .segmentedControl,
                                       uniqueIdentifier: CellIdentifier.deploymentRegionSegmentedControl.rawValue,
                                       valueText: currentRegion.rawValue,
                                       valueArray: regions.map({ $0.rawValue }))
        cellInfoArray.append(cellInfo)
        
        return MenuBuilderSectionInfo(title: "Configuration", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionRetail() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        

        let discoTitle: String
        if let variant = TMDiscoveryAPI.shared.sdkBuildInfo?.stringNonEmpty("BuildVariant") {
            discoTitle = "DiscoveryAPI v\(TMDiscoveryAPI.shared.version)-\(variant)"
        } else {
            discoTitle = "DiscoveryAPI v\(TMDiscoveryAPI.shared.version)"
        }
        
        let prePurchTitle: String
        if let variant = TMPrePurchase.shared.sdkBuildInfo?.stringNonEmpty("BuildVariant") {
            prePurchTitle = "PrePurchase v\(TMPrePurchase.shared.version)-\(variant)"
        } else {
            prePurchTitle = "PrePurchase v\(TMPrePurchase.shared.version)"
        }
        
        let purchTitle: String
        if let variant = TMPurchase.shared.sdkBuildInfo?.stringNonEmpty("BuildVariant") {
            purchTitle = "Purchase v\(TMPurchase.shared.version)-\(variant)"
        } else {
            purchTitle = "Purchase v\(TMPurchase.shared.version)"
        }
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.discoveryAPIMenu.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: discoTitle)
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.prePurchaseMenu.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: prePurchTitle)
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.purchaseMenu.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: purchTitle)
        cellInfoArray.append(cellInfo)

        return MenuBuilderSectionInfo(title: "Retail Frameworks", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionTickets() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        let ticketTitle: String
        if let variant = TMTickets.shared.sdkBuildInfo?.stringNonEmpty("BuildVariant") {
            ticketTitle = "Tickets v\(TMTickets.shared.version)-\(variant)"
        } else {
            ticketTitle = "Tickets v\(TMTickets.shared.version)"
        }
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.ticketsMenu.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: ticketTitle)
        cellInfoArray.append(cellInfo)

        return MenuBuilderSectionInfo(title: "Tickets Framework", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionAuthentication() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        let authTitle: String
        if let variant = TMAuthentication.shared.sdkBuildInfo?.stringNonEmpty("BuildVariant") {
            authTitle = "Authentication v\(TMAuthentication.shared.version)-\(variant)"
        } else {
            authTitle = "Authentication v\(TMAuthentication.shared.version)"
        }
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.authenticationMenu.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: authTitle)
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.currentUserText.rawValue,
                                       titleText: "Current User: <logged out>")
        cellInfoArray.append(cellInfo)

        return MenuBuilderSectionInfo(title: "Authentication Framework", cellInfoRowArray: cellInfoArray)
    }
}
