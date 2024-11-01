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
    override func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .buttonWithTitle else { return }
        super.configure(withCellInfo: cellInfo)
        
        titleLabel.text = cellInfo.titleText
        titleLabel.font = cellInfo.titleFont
        titleLabel.textColor = cellInfo.titleColor
        
        valueButton.setTitle(cellInfo.valueText, for: .normal)
        valueButton.titleLabel?.font = cellInfo.valueFont
        valueButton.tintColor = cellInfo.valueColor
    }

    // MARK: Updates
    func update(title: String?) {
        titleLabel.text = title
    }
    
    func update(buttonTitle: String?) {
        valueButton.setTitle(buttonTitle, for: .normal)
    }

    // MARK: Actions
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(self)
    }
}
