//
//  MenuDemoViewController.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import UIKit

class MenuDemoViewController: UITableViewController {

    var menuDataSource = MenuBuilderDataSource()
    var didBuildMenu: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu Demo"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildRefreshMenu()
    }
}

extension MenuDemoViewController {
    
    enum CellIdentifier: String {
        case title
        case option
        case button
        case buttonTitle
        case textField
        case textFieldTitle
        case segmentedControl
        case switchTitle
        case stepperTitle
        case blank
    }
    
    func buildRefreshMenu() {
        if didBuildMenu == false {
            buildMenuDataSource()
            didBuildMenu = true
        } else {
            
        }
    }
    
    private func buildMenuDataSource() {
        menuDataSource.configure(tableView: tableView)
        menuDataSource.cellInfoSectionArray = [
            buildSectionDemo(),
            MenuBuilderDataSource.buildSectionBlanksForKeyboard()
        ]
        menuDataSource.delegate = self
        tableView.reloadData()
    }
    
    private func buildSectionDemo() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.title.rawValue,
                                       titleText: "Title")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .button,
                                       uniqueIdentifier: CellIdentifier.button.rawValue,
                                       titleText: "Button Title")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .buttonWithTitle,
                                       uniqueIdentifier: CellIdentifier.buttonTitle.rawValue,
                                       titleText: "Button Title",
                                       valueText: "Button Value")
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.textField.rawValue,
                                       placeholderText: "TextField Placeholder")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .textFieldWithTitle,
                                       uniqueIdentifier: CellIdentifier.textFieldTitle.rawValue,
                                       titleText: "TextField Title",
                                       placeholderText: "TextField Placeholder")
        cellInfoArray.append(cellInfo)

        cellInfo = MenuBuilderCellInfo(cellType: .segmentedControl,
                                       uniqueIdentifier: CellIdentifier.segmentedControl.rawValue,
                                       valueText: "1",
                                       valueArray: ["0", "1", "2"])
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .switchWithTitle,
                                       uniqueIdentifier: CellIdentifier.switchTitle.rawValue,
                                       titleText: "Switch Title",
                                       switchIsOn: false)
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .stepperWithTitle,
                                       uniqueIdentifier: CellIdentifier.stepperTitle.rawValue,
                                       titleText: "Stepper Title",
                                       valueText: "one",
                                       valueArray: ["zero", "one", "two"],
                                       stepperUsesValueArray: true)
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .blank,
                                       uniqueIdentifier: CellIdentifier.blank.rawValue)
        cellInfoArray.append(cellInfo)
        
        return MenuBuilderSectionInfo(title: "Example Cells", cellInfoRowArray: cellInfoArray)
    }
}

extension MenuDemoViewController: MenuBuilderDataSourceDelegate {
    
    func menuBuilderDataSource(_: MenuBuilderDataSource, didAction action: MenuBuilderAction, forCell cell: MenuBuilderTableViewCell) {
        // try to determine which cell this is
        if let cellIdentifier = CellIdentifier(rawValue: cell.cellInfo.uniqueIdentifier) {
            print("\(cellIdentifier.rawValue): \(action.debugString)")
            switch cellIdentifier {
            case .title:
                break
            case .option:
                break
            case .button:
                break
            case .buttonTitle:
                break
            case .textField:
                break
            case .textFieldTitle:
                break
            case .segmentedControl:
                break
            case .switchTitle:
                break
            case .stepperTitle:
                break
            case .blank:
                break
            }
        }
    }
}
