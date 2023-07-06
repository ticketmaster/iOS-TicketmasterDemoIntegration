//
//  MenuBuilderTableViewCell.swift
//  TicketmasterPurchaseDevApp
//
//  Created by Jonathan Backer on 10/20/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit

class MenuBuilderTableViewCell: UITableViewCell {

    // default (probably incorrect) values provided since we are usually building from a nib, ie init(coder:)
    var cellInfo: MenuBuilderCellInfo = MenuBuilderCellInfo(cellType: .blank, uniqueIdentifier: "")
    
}
