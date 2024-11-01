//
//  MenuDemoViewController.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import UIKit
import TicketmasterFoundation

class MenuDemoViewController: UITableViewController {

    var menuDataSource = MenuBuilderDataSource()
    var didBuildMenu: Bool = false
    
    var popupTitle: String = "One"
    
    struct ColorScheme {
        let name: String
        
        let titleColor: UIColor?
        let valueColor: UIColor?
        let backgroundColor: UIColor?
    }

    lazy var colorScheme: ColorScheme = noScheme

    lazy var colorSchemes: [ColorScheme] = [noScheme, blueGreen, greenBlue, blueGreenRed, greenBlueRed]

    let noScheme = ColorScheme(name: "Default iOS", titleColor: nil, valueColor: nil, backgroundColor: nil)
    let blueGreen = ColorScheme(name: "Blue Green", titleColor: .blue, valueColor: .green, backgroundColor: nil)
    let greenBlue = ColorScheme(name: "Green Blue", titleColor: .green, valueColor: .blue, backgroundColor: nil)
    let blueGreenRed = ColorScheme(name: "Blue Green Red", titleColor: .blue, valueColor: .green, backgroundColor: .red)
    let greenBlueRed = ColorScheme(name: "Green Blue Red", titleColor: .green, valueColor: .blue, backgroundColor: .red)

    struct FontScheme {
        let name: String
        
        let font: UIFont?
    }
    
    lazy var titleFontScheme: FontScheme = noFont
    lazy var valueFontScheme: FontScheme = noFont
    
    lazy var fontSchemes: [FontScheme] = [noFont, font6, font10, font14, font18, fontAvenir, fontFutura]
    
    let noFont = FontScheme(name: "Default iOS", font: nil)
    let font6 = FontScheme(name: "System 6.0", font: UIFont.systemFont(ofSize: 6.0))
    let font10 = FontScheme(name: "System 10.0", font: UIFont.systemFont(ofSize: 10.0))
    let font14 = FontScheme(name: "System 14.0", font: UIFont.systemFont(ofSize: 14.0))
    let font18 = FontScheme(name: "System 18.0", font: UIFont.systemFont(ofSize: 18.0))
    let fontAvenir = FontScheme(name: "Avenir-Light", font: UIFont(name: "Avenir-Light", size: 16.0)!)
    let fontFutura = FontScheme(name: "Futura-Condensed", font: UIFont(name: "Futura-CondensedMedium", size: 16.0)!)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buildRefreshMenu()
    }
}

extension MenuDemoViewController {
    
    enum CellIdentifier: String {
        case colorThemes
        case titleFont
        case valueFont
        
        case blank
        case title
        case titleDisclosureIndicator
        case titleDetailDisclosureButton
        case titleCheckmark
        case titleDetailButton
        case subtitle
        case option
        case button
        case buttonTitle
        case buttonTitleWithPopup
        case textField
        case textFieldTitle
        case segmentedControl
        case switchTitle
        case stepperTitle
    }
    
    func buildRefreshMenu() {
        if didBuildMenu == false {
            buildMenuDataSource()
            didBuildMenu = true
        } else {
            buildMenuDataSource()
            didBuildMenu = true
        }
    }
    
    private func buildMenuDataSource() {
        menuDataSource.configure(tableView: tableView)
        menuDataSource.cellInfoSectionArray = [
            buildSectionAppearance(),
            buildSectionDemo(),
            MenuBuilderDataSource.buildSectionBlanksForKeyboard()
        ]
        menuDataSource.delegate = self
        tableView.reloadData()
    }
    
    private func buildSectionAppearance() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        cellInfo = MenuBuilderCellInfo(cellType: .buttonWithTitleAndPopupMenu,
                                       uniqueIdentifier: CellIdentifier.colorThemes.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Color Theme",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueText: colorScheme.name,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font,
                                       valueArray: colorSchemes.map({ $0.name }))
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .buttonWithTitleAndPopupMenu,
                                       uniqueIdentifier: CellIdentifier.titleFont.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Title Font",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueText: titleFontScheme.name,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font,
                                       valueArray: fontSchemes.map({ $0.name }))
        cellInfoArray.append(cellInfo)
        
        cellInfo = MenuBuilderCellInfo(cellType: .buttonWithTitleAndPopupMenu,
                                       uniqueIdentifier: CellIdentifier.valueFont.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Value Font",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueText: valueFontScheme.name,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font,
                                       valueArray: fontSchemes.map({ $0.name }))
        cellInfoArray.append(cellInfo)
        
        return MenuBuilderSectionInfo(title: "Appearance", cellInfoRowArray: cellInfoArray)
    }
    
    private func buildSectionDemo() -> MenuBuilderSectionInfo {
        var cellInfoArray: [MenuBuilderCellInfo] = []
        var cellInfo: MenuBuilderCellInfo
        
        // 1. MenuBlankTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .blank,
                                       uniqueIdentifier: CellIdentifier.blank.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Blank",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font)
        cellInfoArray.append(cellInfo)
        
        // 2. MenuTitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.title.rawValue,
                                       accessoryType: nil,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Title (no Accessory)",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font)
        cellInfoArray.append(cellInfo)
                
        // 2. MenuTitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.titleDisclosureIndicator.rawValue,
                                       accessoryType: .disclosureIndicator,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Title (Disclosure Accessory)",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font)
        cellInfoArray.append(cellInfo)
        
        // 2. MenuTitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.titleDetailDisclosureButton.rawValue,
                                       accessoryType: .detailDisclosureButton,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Title (Detail Disclosure Accessory)",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font)
        cellInfoArray.append(cellInfo)
        
        // 2. MenuTitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.titleCheckmark.rawValue,
                                       accessoryType: .checkmark,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Title (Checkmark Accessory)",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font)
        cellInfoArray.append(cellInfo)
        
        // 2. MenuTitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .title,
                                       uniqueIdentifier: CellIdentifier.titleDetailButton.rawValue,
                                       accessoryType: .detailButton,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Title (Detail Button Accessory)",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font)
        cellInfoArray.append(cellInfo)
        
        // 3. MenuSubtitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .titleSubtitle,
                                       uniqueIdentifier: CellIdentifier.subtitle.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Subtitle Title",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueText: "Subtitle Value",
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font)
        cellInfoArray.append(cellInfo)
        
        // 4. MenuButtonTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .button,
                                       uniqueIdentifier: CellIdentifier.button.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Button Title",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueText: "Button Value",
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font)
        cellInfoArray.append(cellInfo)
        
        // 5. MenuButtonWithTitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .buttonWithTitle,
                                       uniqueIdentifier: CellIdentifier.buttonTitle.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Button Title",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueText: "Button Value",
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font)
        cellInfoArray.append(cellInfo)
        
        // 6. MenuButtonWithTitleAndPopupMenuTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .buttonWithTitleAndPopupMenu,
                                       uniqueIdentifier: CellIdentifier.buttonTitleWithPopup.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Button w/Popup Menu Title",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueText: popupTitle,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font,
                                       valueArray: ["Zero", "One", "Two"])
        cellInfoArray.append(cellInfo)

        // 7. MenuTextFieldTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .textField,
                                       uniqueIdentifier: CellIdentifier.textField.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font,
                                       placeholderText: "TextField Placeholder")
        cellInfoArray.append(cellInfo)

        // 8. MenuTextFieldWithTitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .textFieldWithTitle,
                                       uniqueIdentifier: CellIdentifier.textFieldTitle.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "TextField Title",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font,
                                       placeholderText: "TextField Placeholder")
        cellInfoArray.append(cellInfo)
        
        // 9. MenuSwitchWithTitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .switchWithTitle,
                                       uniqueIdentifier: CellIdentifier.switchTitle.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Switch Title",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font,
                                       switchIsOn: false)
        cellInfoArray.append(cellInfo)

        // 10. MenuSegmentedControlTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .segmentedControl,
                                       uniqueIdentifier: CellIdentifier.segmentedControl.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueText: "1",
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font,
                                       valueArray: ["0", "1", "2"])
        cellInfoArray.append(cellInfo)
        
        // 11. MenuStepperWithTitleTableViewCell
        cellInfo = MenuBuilderCellInfo(cellType: .stepperWithTitle,
                                       uniqueIdentifier: CellIdentifier.stepperTitle.rawValue,
                                       backgroundColor: colorScheme.backgroundColor,
                                       titleText: "Stepper Title",
                                       titleColor: colorScheme.titleColor,
                                       titleFont: titleFontScheme.font,
                                       valueText: "one",
                                       valueColor: colorScheme.valueColor,
                                       valueFont: valueFontScheme.font,
                                       valueArray: ["zero", "one", "two"],
                                       stepperUsesValueArray: true,
                                       stepperWraps: true)
        cellInfoArray.append(cellInfo)
                
        return MenuBuilderSectionInfo(title: "Example Cells", cellInfoRowArray: cellInfoArray)
    }
}

extension MenuDemoViewController: MenuBuilderDataSourceDelegate {
    
    func menuBuilderDataSource(_: MenuBuilderDataSource, didAction action: MenuBuilderAction, forCell cell: MenuBuilderTableViewCell) {
        // try to determine which cell this is
        if let cellIdentifier = CellIdentifier(rawValue: cell.cellInfo.uniqueIdentifier) {
            logMessage("\(cellIdentifier.rawValue): \(action.debugString)", level: .debugPublic)
            switch cellIdentifier {
            case .colorThemes:
                switch action {
                case .valueChanged(let value):
                    for scheme in colorSchemes where scheme.name == value {
                        colorScheme = scheme
                    }
                    buildRefreshMenu()
                default:
                    break
                }
            case .titleFont:
                switch action {
                case .valueChanged(let value):
                    for scheme in fontSchemes where scheme.name == value {
                        titleFontScheme = scheme
                    }
                    buildRefreshMenu()
                default:
                    break
                }
            case .valueFont:
                switch action {
                case .valueChanged(let value):
                    for scheme in fontSchemes where scheme.name == value {
                        valueFontScheme = scheme
                    }
                    buildRefreshMenu()
                default:
                    break
                }
                
            case .title, .titleDisclosureIndicator, .titleDetailDisclosureButton, .titleCheckmark, .titleDetailButton:
                break
            case .subtitle:
                break
            case .option:
                break
            case .button:
                break
            case .buttonTitle:
                break
            case .buttonTitleWithPopup:
                switch action {
                case .valueChanged(let value):
                    if let value {
                        popupTitle = value
                        buildRefreshMenu()
                    }
                default:
                    break
                }
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
