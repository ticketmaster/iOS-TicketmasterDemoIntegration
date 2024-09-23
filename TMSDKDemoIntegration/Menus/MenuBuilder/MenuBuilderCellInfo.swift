//
//  MenuBuilderTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

class MenuBuilderSectionInfo {
    
    var title: String?
    var cellInfoRowArray: [MenuBuilderCellInfo]
    
    init(title: String?, cellInfoRowArray: [MenuBuilderCellInfo]) {
        self.title = title
        self.cellInfoRowArray = cellInfoRowArray
        updateSectionTitles()
    }
    
    func updateSectionTitles() {
        for cellInfo in cellInfoRowArray {
            cellInfo.sectionTitle = title
        }
    }
}

class MenuBuilderCellInfo {
    var cellType: MenuBuilderCellType
    var uniqueIdentifier: String
    
    var sectionTitle: String?
    var accessoryType: UITableViewCell.AccessoryType

    var associatedItem: Any?
    
    var backgroundColor: UIColor?
    
    /// for Text
    var titleText: String?
    var titleColor: UIColor?
    /// for value of Button, TextField, selected Segment, or Subtitle
    var valueText: String?
    var valueColor: UIColor?
    /// for UITextField
    var placeholderText: String?
        
    /// for SegmentedControl and Stepper
    var valueArray: [String]?
    var segmentTextArray: [String]?     // displayed in SegmentControl if different from valueArray

    /// for UITextField
    var valueChangedWhileEditing: Bool = false
    var returnKeyType: UIReturnKeyType

    /// for UISwitch (true = on)
    var switchIsOn: Bool = false
    
    /// for UIStepper
    var stepperUsesValueArray: Bool = false
    var stepperMinValue: Double = 0.0
    var stepperMaxValue: Double = 0.0
    var stepperStepValue: Double = 1.0
    var stepperWraps: Bool = false
    
    init(cellType: MenuBuilderCellType,
         uniqueIdentifier: String,
         sectionTitle: String? = nil,
         accessoryType: UITableViewCell.AccessoryType? = nil,
         associatedItem: Any? = nil,
         backgroundColor: UIColor? = nil,
         titleText: String? = nil,
         titleColor: UIColor? = nil,
         valueText: String? = nil,
         valueColor: UIColor? = nil,
         placeholderText: String? = nil,
         valueArray: [String]? = nil,
         segmentTextArray: [String]? = nil,
         valueChangedWhileEditing: Bool = false,
         returnKeyType: UIReturnKeyType = .default,
         switchIsOn: Bool = false,
         stepperUsesValueArray: Bool = false,
         stepperMinValue: Double = 0.0,
         stepperMaxValue: Double = 0.9,
         stepperStepValue: Double = 1.0,
         stepperWraps: Bool = false) {
        self.cellType = cellType
        self.uniqueIdentifier = uniqueIdentifier
        self.sectionTitle = sectionTitle
        self.accessoryType = accessoryType ?? .none
        
        self.associatedItem = associatedItem
        
        self.backgroundColor = backgroundColor
        self.titleText = titleText
        self.titleColor = titleColor
        self.valueText = valueText
        self.valueColor = valueColor
        self.placeholderText = placeholderText

        self.valueArray = valueArray
        self.segmentTextArray = segmentTextArray
        
        self.valueChangedWhileEditing = valueChangedWhileEditing
        self.returnKeyType = returnKeyType
        
        self.switchIsOn = switchIsOn
        
        self.stepperUsesValueArray = stepperUsesValueArray
        self.stepperMinValue = stepperMinValue
        self.stepperMaxValue = stepperMaxValue
        self.stepperStepValue = stepperStepValue
        self.stepperWraps = stepperWraps
    }
}

enum MenuBuilderCellType: String, CaseIterable {
    case blank
    case title
    case titleSubtitle
    case button
    case buttonWithTitle
    case buttonWithTitleAndPopupMenu
    case textField
    case textFieldWithTitle
    case segmentedControl
    case switchWithTitle
    case stepperWithTitle
    
    var nibName: String {
        switch self {
        case .blank:
            return "MenuBlankTableViewCell"
        case .title:
            return "MenuTitleTableViewCell"
        case .titleSubtitle:
            return "MenuTitleSubtitleTableViewCell"
        case .button:
            return "MenuButtonTableViewCell"
        case .buttonWithTitle:
            return "MenuButtonWithTitleTableViewCell"
        case .buttonWithTitleAndPopupMenu:
            return "MenuButtonWithTitleAndPopupMenuTableViewCell"
        case .textField:
            return "MenuTextFieldTableViewCell"
        case .textFieldWithTitle:
            return "MenuTextFieldWithTitleTableViewCell"
        case .segmentedControl:
            return "MenuSegmentedControlTableViewCell"
        case .switchWithTitle:
            return "MenuSwitchWithTitleTableViewCell"
        case .stepperWithTitle:
            return "MenuStepperWithTitleTableViewCell"
        }
    }
}
