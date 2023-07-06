//
//  MenuBuilderDataSource+BuildCells.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

extension MenuBuilderDataSource {
    
    func buildAndConfigureCell(forTableView tableView: UITableView, withCellInfo cellInfo: MenuBuilderCellInfo) -> MenuBuilderTableViewCell {
        let cell: MenuBuilderTableViewCell
        
        switch cellInfo.cellType {
        case .blank:
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellType.rawValue) as! MenuBlankTableViewCell
            customCell.configure(withCellInfo: cellInfo)
            // no delegate since this cell is non-interactive
            cell = customCell

        case .title:
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellType.rawValue) as! MenuTitleTableViewCell
            customCell.configure(withCellInfo: cellInfo)
            // no delegate since this cell is non-interactive
            cell = customCell
            
        case .button:
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellType.rawValue) as! MenuButtonTableViewCell
            customCell.configure(withCellInfo: cellInfo)
            customCell.delegate = self
            cell = customCell
            
        case .buttonWithTitle:
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellType.rawValue) as! MenuButtonWithTitleTableViewCell
            customCell.configure(withCellInfo: cellInfo)
            customCell.delegate = self
            cell = customCell
            
        case .textField:
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellType.rawValue) as! MenuTextFieldTableViewCell
            customCell.configure(withCellInfo: cellInfo)
            customCell.delegate = self
            cell = customCell
            
        case .textFieldWithTitle:
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellType.rawValue) as! MenuTextFieldWithTitleTableViewCell
            customCell.configure(withCellInfo: cellInfo)
            customCell.delegate = self
            cell = customCell
            
        case .segmentedControl:
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellType.rawValue) as! MenuSegmentedControlTableViewCell
            customCell.configure(withCellInfo: cellInfo)
            customCell.delegate = self
            cell = customCell
            
        case .switchWithTitle:
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellType.rawValue) as! MenuSwitchWithTitleTableViewCell
            customCell.configure(withCellInfo: cellInfo)
            customCell.delegate = self
            cell = customCell
            
        case .stepperWithTitle:
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellInfo.cellType.rawValue) as! MenuStepperWithTitleTableViewCell
            customCell.configure(withCellInfo: cellInfo)
            customCell.delegate = self
            cell = customCell
        }
                
        return cell
    }
    
    static func buildSectionBlanksForKeyboard() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        
        let blank = MenuBuilderCellInfo(cellType: .blank,
                                        uniqueIdentifier: "")
        
        // add enough blank cells for keyboard (this is a guess)
        cellInfoArray.append(blank)
        cellInfoArray.append(blank)
        cellInfoArray.append(blank)
        cellInfoArray.append(blank)
        cellInfoArray.append(blank)
        cellInfoArray.append(blank)
        cellInfoArray.append(blank)

        return MenuBuilderSectionInfo(title: nil, cellInfoRowArray: cellInfoArray)
    }
}
