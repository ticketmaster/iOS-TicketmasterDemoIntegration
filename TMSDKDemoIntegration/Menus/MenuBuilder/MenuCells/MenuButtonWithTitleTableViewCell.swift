//
//  MenuButtonWithTitleTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

protocol MenuTextWithButtonTableViewCellDelegate: AnyObject {
    func buttonPressed(_ cell: MenuButtonWithTitleTableViewCell)
}

class MenuButtonWithTitleTableViewCell: MenuBuilderTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueButton: UIButton!

    weak var delegate: MenuTextWithButtonTableViewCellDelegate?
    
    // MARK: Constructors
    func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .buttonWithTitle else { return }
        self.cellInfo = cellInfo
        self.accessoryType = cellInfo.accessoryType

        titleLabel.text = cellInfo.titleText
        valueButton.setTitle(cellInfo.valueText, for: .normal)
        
        titleLabel.textColor = cellInfo.titleColor ?? .label
        valueButton.tintColor = cellInfo.valueColor ?? contentView.tintColor
        contentView.backgroundColor = cellInfo.backgroundColor
    }

    // MARK: Updates
    func update(title: String) {
        titleLabel.text = title
    }
    
    func update(buttonTitle: String) {
        valueButton.setTitle(buttonTitle, for: .normal)
    }

    // MARK: Actions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(self)
    }
}
