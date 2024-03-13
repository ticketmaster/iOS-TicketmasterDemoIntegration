//
//  MenuTextFieldWithTitleTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

protocol MenuTextWithTextFieldTableViewCellDelegate: AnyObject {
    func valueChanged(_ cell: MenuTextFieldWithTitleTableViewCell, value: String?)
    func returnPressed(_ cell: MenuTextFieldWithTitleTableViewCell, value: String?)
}

class MenuTextFieldWithTitleTableViewCell: MenuBuilderTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!

    weak var delegate: MenuTextWithTextFieldTableViewCellDelegate?

    private var returnPressedText: String?
    
    // MARK: Constructors
    func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .textFieldWithTitle else { return }
        self.cellInfo = cellInfo

        tintColor = cellInfo.titleColor ?? .label
        setupAccessoryType()
        
        titleLabel.text = cellInfo.titleText
        valueTextField.placeholder = cellInfo.placeholderText
        valueTextField.text = cellInfo.valueText
        valueTextField.returnKeyType = cellInfo.returnKeyType
        returnPressedText = nil
        
        titleLabel.textColor = cellInfo.titleColor ?? .label
        valueTextField.textColor = cellInfo.valueColor ?? .label
        backgroundColor = cellInfo.backgroundColor
    }
    
    // MARK: Updates
    func update(title: String) {
        titleLabel.text = title
    }
    
    func update(value: String?) {
        valueTextField.text = value
        returnPressedText = nil
    }
}

extension MenuTextFieldWithTitleTableViewCell: UITextFieldDelegate {
    // MARK: Actions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // store value in the data model
        cellInfo.valueText = textField.text
        returnPressedText = textField.text
        // notify delegate
        delegate?.returnPressed(self, value: textField.text)

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // store value in the data model
        cellInfo.valueText = textField.text
        // did we already send this update as .returnPressed?
        if textField.text != returnPressedText {
            // no, notify delegate
            delegate?.valueChanged(self, value: textField.text)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if cellInfo.valueChangedWhileEditing {
            // store value in the data model
            cellInfo.valueText = textField.text
            // notify delegate
            delegate?.valueChanged(self, value: textField.text)
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // store value in the data model
        cellInfo.valueText = nil

        // let return true process first
        DispatchQueue.main.async {
            if self.cellInfo.valueChangedWhileEditing {
                // notify delegate
                self.delegate?.valueChanged(self, value: nil)
            }
        }
        
        return true
    }
}
