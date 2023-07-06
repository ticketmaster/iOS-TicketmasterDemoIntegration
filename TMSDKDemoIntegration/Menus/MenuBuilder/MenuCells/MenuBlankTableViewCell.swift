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
    func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .blank else { return }
        self.cellInfo = cellInfo
        self.accessoryType = cellInfo.accessoryType
        
        if let color = cellInfo.backgroundColor {
            contentView.backgroundColor = color
        }
    }

    // MARK: Update
    // nothing to update
    
    // MARK: Action
    // this cell is non-interactive
}
