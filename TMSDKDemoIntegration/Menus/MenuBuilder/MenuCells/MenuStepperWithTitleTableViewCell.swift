//
//  MenuStepperWithTitleTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

protocol MenuTextWithValueStepperTableViewCellDelegate: AnyObject {
    func valueSelected(_ cell: MenuStepperWithTitleTableViewCell, value: String)
    func buttonPressed(_ cell: MenuStepperWithTitleTableViewCell, title: String)
}

class MenuStepperWithTitleTableViewCell: MenuBuilderTableViewCell {

    var stepperValues: [String] = []
    var stepperUsesValueArray: Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueButton: UIButton!
    @IBOutlet weak var valueStepper: UIStepper!
    
    weak var delegate: MenuTextWithValueStepperTableViewCellDelegate?
    
    // MARK: Constructors
    func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .stepperWithTitle else { return }
        self.cellInfo = cellInfo
        self.accessoryType = cellInfo.accessoryType

        titleLabel.text = cellInfo.titleText
        
        if let valueArray = cellInfo.valueArray, cellInfo.stepperUsesValueArray {
            stepperUsesValueArray = true
            stepperValues = valueArray
        } else {
            stepperUsesValueArray = false
            stepperValues = []
        }
        valueStepper.stepValue = cellInfo.stepperStepValue
        valueStepper.wraps = cellInfo.stepperWraps
        setupDefaultValues(string: cellInfo.valueText ?? "")
        
        titleLabel.textColor = cellInfo.titleColor ?? .label
        valueStepper.tintColor = cellInfo.valueColor ?? contentView.tintColor
        contentView.backgroundColor = cellInfo.backgroundColor
    }
    
    private func setupDefaultValues(string: String) {
        if stepperUsesValueArray, let index = stepperValues.firstIndex(of: string) {
            setupDefaultValues(value: Double(index))
            
        } else {
            setupDefaultValues(value: 0.0)
        }
    }
    
    private func setupDefaultValues(value: Double) {
        if stepperUsesValueArray {
            valueStepper.minimumValue = 0
            valueStepper.maximumValue = Double(stepperValues.count - 1)
            valueStepper.stepValue = 1
        }

        if value >= valueStepper.minimumValue && value <= valueStepper.maximumValue {
            valueStepper.value = value
        } else {
            valueStepper.value = 0
        }

        let newValue = getButtonText()
        valueButton.setTitle(newValue, for: .normal)
    }
    
    // MARK: Updates
    func update(title: String) {
        titleLabel.text = title
    }
    
    func update(value: String) {
        if stepperUsesValueArray,
           let index = stepperValues.firstIndex(of: value) {
            update(value: Double(index))
        }
    }
    
    private func update(value: Double) {
        if value >= valueStepper.minimumValue && value <= valueStepper.maximumValue {
            valueStepper.value = value
            let newValue = getButtonText()
            valueButton.setTitle(newValue, for: .normal)
        }
    }
    
    private func getButtonText() -> String {
        let newValue: String
        if stepperUsesValueArray {
            newValue = stepperValues[Int(valueStepper.value)]
        } else {
            newValue = "\(valueStepper.value)"
        }
        return newValue
    }
    
    // MARK: Actions
    @IBAction func valueChanged(_ sender: UIStepper) {
        let value = getButtonText()
        valueButton.setTitle(value, for: .normal)
        // store value in the data model
        cellInfo.valueText = value
        // notify delegate
        delegate?.valueSelected(self, value: value)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let title = getButtonText()
        delegate?.buttonPressed(self, title: title)
    }
}
