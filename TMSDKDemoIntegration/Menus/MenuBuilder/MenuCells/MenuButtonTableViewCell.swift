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
    override func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .button else { return }
        super.configure(withCellInfo: cellInfo)
        
        titleButton.setTitle(cellInfo.valueText, for: .normal)
        titleButton.titleLabel?.font = cellInfo.valueFont
        titleButton.tintColor = cellInfo.valueColor
    }
    
    // MARK: Updates
    func update(title: String?) {
        titleButton.setTitle(title, for: .normal)
    }
    
    // MARK: Actions
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(self)
    }
}
