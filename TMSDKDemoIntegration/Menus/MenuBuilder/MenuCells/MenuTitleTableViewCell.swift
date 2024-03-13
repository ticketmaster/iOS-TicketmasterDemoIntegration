//
//  MenuTitleTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

class MenuTitleTableViewCell: MenuBuilderTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
        
    // MARK: Constructors
    func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .title else { return }
        self.cellInfo = cellInfo
        
        tintColor = cellInfo.titleColor ?? .label
        setupAccessoryType()
        
        titleLabel.text = cellInfo.titleText
        titleLabel.textColor = cellInfo.titleColor ?? .label
        backgroundColor = cellInfo.backgroundColor
    }
    
    // MARK: Updates
    func update(title: String) {
        titleLabel.text = title
    }

    // MARK: Actions
    // this cell is non-interactive
}
