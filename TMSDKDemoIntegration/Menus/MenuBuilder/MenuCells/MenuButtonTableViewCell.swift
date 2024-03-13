//
//  MenuButtonTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

protocol MenuButtonTableViewCellDelegate: AnyObject {
    func buttonPressed(_ cell: MenuButtonTableViewCell)
}

class MenuButtonTableViewCell: MenuBuilderTableViewCell {
    
    @IBOutlet weak var titleButton: UIButton!
    
    weak var delegate: MenuButtonTableViewCellDelegate?
    
    // MARK: Constructors
    func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .button else { return }
        self.cellInfo = cellInfo

        tintColor = cellInfo.valueColor ?? .label
        setupAccessoryType()
        
        if let text = cellInfo.titleText {
            titleButton.setTitle(text, for: .normal)
        } else if let text = cellInfo.valueText {
            titleButton.setTitle(text, for: .normal)
        }
        titleButton.setTitleColor(cellInfo.titleColor, for: .normal)
        titleButton.tintColor = cellInfo.valueColor ?? contentView.tintColor
        backgroundColor = cellInfo.backgroundColor
    }
    
    // MARK: Updates
    func update(title: String) {
        titleButton.setTitle(title, for: .normal)
    }
    
    // MARK: Actions
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(self)
    }
}
