//
//  MenuBlankTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/21/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

class MenuBlankTableViewCell: MenuBuilderTableViewCell {

    // MARK: Constructor
    override func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .blank else { return }
        super.configure(withCellInfo: cellInfo)
        
        tintColor = .clear
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    // MARK: Update
    // nothing to update
    
    // MARK: Action
    // this cell is non-interactive
}
