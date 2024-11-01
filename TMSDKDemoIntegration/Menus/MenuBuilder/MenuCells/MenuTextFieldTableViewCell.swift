//
//  MenuTextFieldTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

protocol MenuTextFieldTableViewCellDelegate: AnyObject {
    func valueChanged(_ cell: MenuTextFieldTableViewCell, value: String?)
    func returnPressed(_ cell: MenuTextFieldTableViewCell, value: String?)
}

class MenuTextFieldTableViewCell: MenuBuilderTableViewCell {

    @IBOutlet weak var valueTextField: UITextField!

    weak var delegate: MenuTextFieldTableViewCellDelegate?
    
    private var returnPressedText: String?
    
    // MARK: Constructors
    override func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .textField else { return }
        super.configure(withCellInfo: cellInfo)

        if let placeholderText = cellInfo.placeholderText {
            valueTextField.placeholder = placeholderText
        } else {
            // no title, but use it as the placeholder text
            valueTextField.placeholder = cellInfo.titleText
        }
        valueTextField.text = cellInfo.valueText
        valueTextField.font = cellInfo.valueFont
        valueTextField.returnKeyType = cellInfo.returnKeyType
        valueTextField.tintColor = cellInfo.valueColor

        returnPressedText = nil
    }
    
    // MARK: Updates
    func update(title: String?) {
        // no title, but use it as the placeholder text
        valueTextField.placeholder = title
    }
    
    func update(value: String?) {
        valueTextField.text = value
        returnPressedText = nil
    }
}

extension MenuTextFieldTableViewCell: UITextFieldDelegate {
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
            // notify delegate
            self.delegate?.valueChanged(self, value: nil)
        }
        
        return true
    }
}
