//
//  MenuBuilderDataSource+Action.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

enum MenuBuilderAction {
    /// Button, ButtonWithTitle, StepperWithTitle
    case buttonPressed(title: String)
    /// TextField, TextFieldWithTitle, SegmentedControl, StepperWithTitle
    case valueChanged(value: String?)
    /// TextField, TextFieldWithTitle
    case returnPressed(value: String?)
    /// SwitchWithTitle
    case switchChanged(isOn: Bool)
    /// Cell Tapped
    case backgroundTapped(value: String?)
    
    var debugString: String {
        switch self {
        case .buttonPressed(let title):
            return ".buttonPressed(title: \(title))"
        case .valueChanged(let value):
            return ".valueChanged(value: \(value ?? "<nil>"))"
        case .returnPressed(let value):
            return ".returnPressed(value: \(value ?? "<nil>"))"
        case .switchChanged(let isOn):
            return ".switchChanged(isOn: \(isOn ? "true" : "false"))"
        case .backgroundTapped:
            return ".backgroundTapped()"
        }
    }
}

extension MenuBuilderDataSource {
    
    func dismissKeyboard() {
        lastDismissKeyboardTime = Date()
        if let cellArray = tableView?.visibleCells as? [MenuBuilderTableViewCell] {
            for cell in cellArray {
                switch cell.cellInfo.cellType {
                case .textField:
                    if let tCell = cell as? MenuTextFieldTableViewCell {
                        tCell.valueTextField.resignFirstResponder()
                    }
                case .textFieldWithTitle:
                    if let tCell = cell as? MenuTextFieldWithTitleTableViewCell {
                        tCell.valueTextField.resignFirstResponder()
                    }
                default:
                    break
                }
            }
        }
    }
}

extension MenuBuilderDataSource: MenuButtonTableViewCellDelegate {
    func buttonPressed(_ cell: MenuButtonTableViewCell) {
        delegate?.menuBuilderDataSource(self, didAction: .buttonPressed(title: cell.titleButton.title(for: .normal) ?? ""), forCell: cell)
    }
}

extension MenuBuilderDataSource: PopupMenuTableviewCellDelegate {
    func valueChanged(_ cell: MenuButtonWithTitleAndPopupTableViewCell, value: String) {
        delegate?.menuBuilderDataSource(self, didAction: .valueChanged(value: value), forCell: cell)
    }
}

extension MenuBuilderDataSource: MenuTextWithButtonTableViewCellDelegate {
    func buttonPressed(_ cell: MenuButtonWithTitleTableViewCell) {
        delegate?.menuBuilderDataSource(self, didAction: .buttonPressed(title: cell.valueButton.title(for: .normal) ?? ""), forCell: cell)
    }
}

extension MenuBuilderDataSource: MenuTextFieldTableViewCellDelegate {
    func valueChanged(_ cell: MenuTextFieldTableViewCell, value: String?) {
        delegate?.menuBuilderDataSource(self, didAction: .valueChanged(value: value), forCell: cell)
    }
    
    func returnPressed(_ cell: MenuTextFieldTableViewCell, value: String?) {
        cell.valueTextField.resignFirstResponder()
        delegate?.menuBuilderDataSource(self, didAction: .returnPressed(value: value), forCell: cell)
    }
}

extension MenuBuilderDataSource: MenuTextWithTextFieldTableViewCellDelegate {
    func valueChanged(_ cell: MenuTextFieldWithTitleTableViewCell, value: String?) {
        delegate?.menuBuilderDataSource(self, didAction: .valueChanged(value: value), forCell: cell)
    }
    
    func returnPressed(_ cell: MenuTextFieldWithTitleTableViewCell, value: String?) {
        cell.valueTextField.resignFirstResponder()
        delegate?.menuBuilderDataSource(self, didAction: .returnPressed(value: value), forCell: cell)
    }
}

extension MenuBuilderDataSource: MenuSegmentedControlTableViewCellDelegate {
    func segmentSelected(_ cell: MenuSegmentedControlTableViewCell, value: String) {
        delegate?.menuBuilderDataSource(self, didAction: .valueChanged(value: value), forCell: cell)
    }
}

extension MenuBuilderDataSource: MenuTextWithSwitchTableViewCellDelegate {
    func switchChanged(_ cell: MenuSwitchWithTitleTableViewCell, value: Bool) {
        delegate?.menuBuilderDataSource(self, didAction: .switchChanged(isOn: value), forCell: cell)
    }
}

extension MenuBuilderDataSource: MenuTextWithValueStepperTableViewCellDelegate {
    func valueSelected(_ cell: MenuStepperWithTitleTableViewCell, value: String) {
        delegate?.menuBuilderDataSource(self, didAction: .valueChanged(value: value), forCell: cell)
    }
        
    func buttonPressed(_ cell: MenuStepperWithTitleTableViewCell, title: String) {
        delegate?.menuBuilderDataSource(self, didAction: .buttonPressed(title: title), forCell: cell)
    }
}
