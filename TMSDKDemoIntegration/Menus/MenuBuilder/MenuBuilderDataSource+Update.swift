//
//  MenuBuilderDataSource+Update.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/21/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import Foundation

extension MenuBuilderDataSource {
    
    func updateCell(title: String, forUniqueIdentifier uniqueIdentifier: String) {
        // cellInfo is the data model that is always in memory
        if let cellInfo = cellInfo(forUniqueIdentifier: uniqueIdentifier) {
            // we most likely have a cell in memory too
            // but it is possible that the cell may not be loaded (or have been unloaded) as the tableView scrolls
            // try to keep cellInfo (data model) and cell (view model) in sync
            let loadedCell = cell(forUniqueIdentifier: uniqueIdentifier)

            switch cellInfo.cellType {
            case .blank:
                // no title
                break
            case .title:
                cellInfo.titleText = title
                if let cell = loadedCell as? MenuTitleTableViewCell {
                    DispatchQueue.main.async {
                        cell.update(title: title)
                    }
                }
            case .button:
                cellInfo.titleText = title
                if let cell = loadedCell as? MenuButtonTableViewCell {
                    DispatchQueue.main.async {
                        cell.update(title: title)
                    }
                }
            case .buttonWithTitle:
                cellInfo.titleText = title
                if let cell = loadedCell as? MenuButtonWithTitleTableViewCell {
                    DispatchQueue.main.async {
                        cell.update(title: title)
                    }
                }
            case .textField:
                // no title, but update placeholder text
                cellInfo.placeholderText = title
                if let cell = loadedCell as? MenuTextFieldTableViewCell {
                    DispatchQueue.main.async {
                        cell.update(title: title)
                    }
                }
            case .textFieldWithTitle:
                cellInfo.titleText = title
                if let cell = loadedCell as? MenuTextFieldWithTitleTableViewCell {
                    DispatchQueue.main.async {
                        cell.update(title: title)
                    }
                }
            case .segmentedControl:
                // no title
                break
            case .switchWithTitle:
                cellInfo.titleText = title
                if let cell = loadedCell as? MenuSwitchWithTitleTableViewCell {
                    DispatchQueue.main.async {
                        cell.update(title: title)
                    }
                }
            case .stepperWithTitle:
                cellInfo.titleText = title
                if let cell = loadedCell as? MenuStepperWithTitleTableViewCell {
                    DispatchQueue.main.async {
                        cell.update(title: title)
                    }
                }
            }
        }
    }
    
    func updateCell(value: String?, forUniqueIdentifier uniqueIdentifier: String) {
        // cellInfo is the data model that is always in memory
        if let cellInfo = cellInfo(forUniqueIdentifier: uniqueIdentifier) {
            // we most likely have a cell in memory too
            // but it is possible that the cell may not be loaded (or have been unloaded) as the tableView scrolls
            // try to keep cellInfo (data model) and cell (view model) in sync
            let loadedCell = cell(forUniqueIdentifier: uniqueIdentifier)

            // we must have a cellInfo to continue
            switch cellInfo.cellType {
            case .blank:
                // no value
                break
            case .title:
                // no value
                break
            case .button:
                if let value = value {
                    // no value, but we'll update the title instead
                    cellInfo.titleText = value
                    if let cell = loadedCell as? MenuButtonTableViewCell {
                        DispatchQueue.main.async {
                            cell.update(title: value)
                        }
                    }
                }
            case .buttonWithTitle:
                if let value = value {
                    cellInfo.valueText = value
                    if let cell = loadedCell as? MenuButtonWithTitleTableViewCell {
                        DispatchQueue.main.async {
                            cell.update(buttonTitle: value)
                        }
                    }
                }
            case .textField:
                cellInfo.valueText = value
                if let cell = loadedCell as? MenuTextFieldTableViewCell {
                    DispatchQueue.main.async {
                        cell.update(value: value)
                    }
                }
            case .textFieldWithTitle:
                cellInfo.valueText = value
                if let cell = loadedCell as? MenuTextFieldWithTitleTableViewCell {
                    DispatchQueue.main.async {
                        cell.update(value: value)
                    }
                }
            case .segmentedControl:
                if let value = value {
                    cellInfo.valueText = value
                    if let cell = loadedCell as? MenuSegmentedControlTableViewCell {
                        DispatchQueue.main.async {
                            cell.update(value: value)
                        }
                    }
                }
            case .switchWithTitle:
                if let value = value?.lowercased() {
                    cellInfo.switchIsOn = (value == "true" || value == "t" || value == "yes" || value == "y" || value == "1" || value == "on")
                    if let cell = loadedCell as? MenuSwitchWithTitleTableViewCell {
                        DispatchQueue.main.async {
                            cell.update(value: cellInfo.switchIsOn)
                        }
                    }
                }
            case .stepperWithTitle:
                if let value = value {
                    cellInfo.valueText = value
                    if let cell = loadedCell as? MenuStepperWithTitleTableViewCell {
                        DispatchQueue.main.async {
                            cell.update(value: value)
                        }
                    }
                }
            }
        }
    }
    
    func cellInfo(forUniqueIdentifier uniqueIdentifier: String) -> MenuBuilderCellInfo? {
        for section in cellInfoSectionArray {
            for cell in section.cellInfoRowArray where cell.uniqueIdentifier == uniqueIdentifier {
                    return cell
                }
            }
        return nil
    }
    
    func cell(forUniqueIdentifier uniqueIdentifier: String) -> MenuBuilderTableViewCell? {
        if let cellArray = tableView?.visibleCells as? [MenuBuilderTableViewCell] {
            for cell in cellArray where cell.cellInfo.uniqueIdentifier == uniqueIdentifier {
                    return cell
                }
            }
        return nil
    }
}
