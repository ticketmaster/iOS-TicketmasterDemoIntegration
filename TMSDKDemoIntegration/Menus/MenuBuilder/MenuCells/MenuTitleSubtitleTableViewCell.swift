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
    override func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .titleSubtitle else { return }
        super.configure(withCellInfo: cellInfo)

        titleLabel.text = cellInfo.titleText
        titleLabel.font = cellInfo.titleFont
        titleLabel.textColor = cellInfo.titleColor
        
        subtitleLabel.text = cellInfo.valueText
        subtitleLabel.font = cellInfo.valueFont
        subtitleLabel.textColor = cellInfo.valueColor
    }
    
    // MARK: Updates
    func update(title: String?) {
        titleLabel.text = title
    }
    
    func update(subtitle: String?) {
        subtitleLabel.text = subtitle
    }

    // MARK: Actions
    // this cell is non-interactive
}
