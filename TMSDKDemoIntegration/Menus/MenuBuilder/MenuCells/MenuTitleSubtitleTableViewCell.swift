//
//  MenuTitleSubtitleTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Kelvin Kao on 03/01/24.
//  Copyright © 2024 Ticketmaster. All rights reserved.
//

import UIKit

class MenuTitleSubtitleTableViewCell: MenuBuilderTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
        
    // MARK: Constructors
    func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .titleSubtitle else { return }
        self.cellInfo = cellInfo
        self.accessoryType = cellInfo.accessoryType

        titleLabel.text = cellInfo.titleText
        titleLabel.textColor = cellInfo.titleColor ?? .label
        
        subtitleLabel.text = cellInfo.valueText
        subtitleLabel.textColor = cellInfo.valueColor ?? .gray
        
        contentView.backgroundColor = cellInfo.backgroundColor
    }
    
    // MARK: Updates
    func update(title: String) {
        titleLabel.text = title
    }
    
    func update(subtitle: String?) {
        subtitleLabel.text = subtitle
    }

    // MARK: Actions
    // this cell is non-interactive
}
