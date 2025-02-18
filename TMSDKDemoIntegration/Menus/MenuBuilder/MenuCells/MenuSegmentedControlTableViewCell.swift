//
//  MenuSegmentedControlTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit
import TicketmasterFoundation

protocol MenuSegmentedControlTableViewCellDelegate: AnyObject {
    func segmentSelected(_ cell: MenuSegmentedControlTableViewCell, value: String)
}

class MenuSegmentedControlTableViewCell: MenuBuilderTableViewCell {
    
    @IBOutlet weak var valueSegmentedControl: MappedSegmentedControl!

    weak var delegate: MenuSegmentedControlTableViewCellDelegate?
    
    // MARK: Constructors
    override func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .segmentedControl else { return }
        super.configure(withCellInfo: cellInfo)
        
        guard let valueArray = cellInfo.valueArray,
              let segmentTextArray = cellInfo.segmentTextArray ?? cellInfo.valueArray else {
                  logMessage("Please check the contents of segments for MenuSegmentedControlTableViewCell", level: .warning)
                  return
              }

        valueSegmentedControl.removeAllSegments()
        valueSegmentedControl.setValues(valueArray, displayTexts: segmentTextArray)
        if let selected = cellInfo.valueText {
            valueSegmentedControl.selectValue(selected)
        }
        if let color = cellInfo.titleColor {
            valueSegmentedControl.setTitleTextAttributes([.foregroundColor: color as Any], for: .normal)
        } else {
            valueSegmentedControl.setTitleTextAttributes(nil, for: .normal)
        }
        valueSegmentedControl.selectedSegmentTintColor = cellInfo.valueColor
    }
    
    // MARK: Updates
    func update(value: String) {
        valueSegmentedControl.selectValue(value)
    }
    
    // MARK: Actions
    @IBAction func segmentSelected(_ sender: MappedSegmentedControl) {
        let value = valueSegmentedControl.selectedValue ?? "(unknown)"
        // store value in the data model
        cellInfo.valueText = value
        // notify delegate
        delegate?.segmentSelected(self, value: value)
    }
}

// A simple UISegmentedControl subclass that allows for the segment
// to display text different from the value

class MappedSegmentedControl: UISegmentedControl {
    private var displayTexts: [String] = []
    private var values: [String] = []

    func setValues(_ values: [String], displayTexts: [String]) {
        guard values.count == displayTexts.count else {
            logMessage("The number of values should be equal to display texts", level: .warning)
            return
        }

        self.values = values
        self.displayTexts = displayTexts

        self.removeAllSegments()
        for text in displayTexts.reversed() {
            self.insertSegment(withTitle: text, at: 0, animated: false)
        }
    }

    func selectValue(_ value: String) {
        guard let index = values.firstIndex(of: value) else {
            return
        }

        self.selectedSegmentIndex = index
    }

    var selectedValue: String? {
        guard selectedSegmentIndex >= 0,
              selectedSegmentIndex < values.count else {
                  return nil
              }

        return values[selectedSegmentIndex]
    }
}
