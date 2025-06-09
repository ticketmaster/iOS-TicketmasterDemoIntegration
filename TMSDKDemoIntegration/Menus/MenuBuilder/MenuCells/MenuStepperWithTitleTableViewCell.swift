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
    override func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .stepperWithTitle else { return }
        super.configure(withCellInfo: cellInfo)
        
        titleLabel.text = cellInfo.titleText
        titleLabel.font = cellInfo.titleFont
        titleLabel.textColor = cellInfo.titleColor

        if let valueArray = cellInfo.valueArray, cellInfo.stepperUsesValueArray {
            stepperUsesValueArray = true
            stepperValues = valueArray
        } else {
            stepperUsesValueArray = false
            stepperValues = []
            valueStepper.minimumValue = cellInfo.stepperMinValue
            valueStepper.maximumValue = cellInfo.stepperMaxValue
        }
        valueStepper.stepValue = cellInfo.stepperStepValue
        valueStepper.wraps = cellInfo.stepperWraps
        setupDefaultValues(string: cellInfo.valueText ?? "")
        valueStepper.tintColor = cellInfo.valueColor
        if cellInfo.valueColor != nil {
            valueStepper.setDecrementImage(valueStepper.decrementImage(for: .normal), for: .normal)
            valueStepper.setIncrementImage(valueStepper.incrementImage(for: .normal), for: .normal)
        } else {
            valueStepper.setDecrementImage(nil, for: .normal)
            valueStepper.setIncrementImage(nil, for: .normal)
        }
        
        valueButton.setTitleColor(cellInfo.valueColor, for: .normal)
        valueButton.titleLabel?.font = cellInfo.valueFont
    }
    
    private func setupDefaultValues(string: String) {
        if stepperUsesValueArray, let index = stepperValues.firstIndex(of: string) {
            setupDefaultValues(value: Double(index))
            
        } else {
            if let double = Double(string) {
                setupDefaultValues(value: double)
            } else {
                setupDefaultValues(value: 0.0)
            }
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
    func update(title: String?) {
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
