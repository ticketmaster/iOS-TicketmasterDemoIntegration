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
    
    func setupAccessoryType() {
        self.accessoryType = .none
        self.accessoryView = nil
        
        let image: UIImage?
        switch cellInfo.accessoryType {
        case .disclosureIndicator:
            image = UIImage(systemName: "chevron.right")
        case .detailDisclosureButton:
            image = nil // full on button, don't bother since have set the color using self.tintColor
        case .checkmark:
            image = UIImage(systemName: "checkmark")
        case .detailButton:
            image = UIImage(systemName: "info.circle")
        case .none:
            image = nil
        @unknown default:
            image = nil
        }
        
        if let image = image {
            let accessory  = UIImageView(frame: CGRect(x: 0, y: 0,
                                                       width: (image.size.width), height: (image.size.height)))
            accessory.image = image
            accessory.tintColor = tintColor
            self.accessoryView = accessory
        } else {
            self.accessoryType = cellInfo.accessoryType
        }
    }
}
