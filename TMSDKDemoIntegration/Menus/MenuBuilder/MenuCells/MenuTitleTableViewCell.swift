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
    override func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .title else { return }
        super.configure(withCellInfo: cellInfo)
        
        titleLabel.text = cellInfo.titleText
        titleLabel.font = cellInfo.titleFont
        titleLabel.textColor = cellInfo.titleColor
    }
    
    // MARK: Updates
    func update(title: String?) {
        titleLabel.text = title
    }

    // MARK: Actions
    // this cell is non-interactive
}
