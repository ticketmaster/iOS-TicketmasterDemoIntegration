//
//  AuthenticationVC+BuildMenu.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import TicketmasterAuthentication

extension AuthenticationViewController {
    
    enum CellIdentifier: String {
        case currentUserText
        
        case login
        case validToken
        case memberInfo
        case logout
    }
    
    func buildRefreshMenu() {
        if didBuildMenu == false {
            buildMenuDataSource()
            didBuildMenu = true
        }
        
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
            menuDataSource.updateCell(title: "Current User: <logged out>",
                                      forUniqueIdentifier: CellIdentifier.currentUserText.rawValue)
        }
    }
    
    private func buildMenuDataSource() {
        menuDataSource.configure(tableView: tableView)
        menuDataSource.cellInfoSectionArray = [
            buildSectionInfo(),
            buildSectionPresent(),
            MenuBuilderDataSource.buildSectionBlanksForKeyboard()
        ]
        menuDataSource.delegate = self
        tableView.reloadData()
    }
    
    private func buildSectionInfo() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
                cellInfo = MenuBuilderCellInfo(cellType: .title,
                                               uniqueIdentifier: CellIdentifier.currentUserText.rawValue,
                                               titleText: "Current User: <logged out>")
                cellInfoArray.append(cellInfo)
        
        return MenuBuilderSectionInfo(title: "Current User", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionPresent() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
                
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.login.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Login")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.validToken.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Valid Token")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.memberInfo.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Member Info")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.logout.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       titleText: "Logout")
        cellInfoArray.append(cellInfo)

        return MenuBuilderSectionInfo(title: "Authentication", cellInfoRowArray: cellInfoArray)
    }
}
