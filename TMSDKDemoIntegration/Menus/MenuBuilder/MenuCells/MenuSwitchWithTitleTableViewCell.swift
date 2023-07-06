//
//  MenuSwitchWithTitleTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

protocol MenuTextWithSwitchTableViewCellDelegate: AnyObject {
    func switchChanged(_ cell: MenuSwitchWithTitleTableViewCell, value: Bool)
}

class MenuSwitchWithTitleTableViewCell: MenuBuilderTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueSwitch: UISwitch!

    weak var delegate: MenuTextWithSwitchTableViewCellDelegate?
    
    // MARK: Constructors
    func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .switchWithTitle else { return }
        self.cellInfo = cellInfo
        self.accessoryType = cellInfo.accessoryType

        titleLabel.text = cellInfo.titleText
        valueSwitch.isOn = cellInfo.switchIsOn
        
        titleLabel.textColor = cellInfo.titleColor ?? .label
        valueSwitch.onTintColor = cellInfo.valueColor
        contentView.backgroundColor = cellInfo.backgroundColor
    }
    
    // MARK: Updates
    func update(title: String) {
        titleLabel.text = title
    }
    
    func update(value: Bool) {
        valueSwitch.isOn = value
    }

    // MARK: Actions
    @IBAction func switchChanged(_ sender: UISwitch) {
        // store value in the data model
        cellInfo.switchIsOn = sender.isOn
        // notify delegate
        delegate?.switchChanged(self, value: sender.isOn)
    }    
}
