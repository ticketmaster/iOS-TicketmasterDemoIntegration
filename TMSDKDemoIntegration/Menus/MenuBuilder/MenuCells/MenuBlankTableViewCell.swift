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

        tintColor = cellInfo.titleColor ?? .label
        setupAccessoryType()
        
        if let color = cellInfo.backgroundColor {
            backgroundColor = color
        }
    }

    // MARK: Update
    // nothing to update
    
    // MARK: Action
    // this cell is non-interactive
}
