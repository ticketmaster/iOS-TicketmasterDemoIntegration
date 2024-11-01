//
//  MenuButtonWithTitleAndPopupMenuTableViewCell.swift
//  RetailDevApp
//
//  Created by Andrew Rennard on 08/02/2024.
//

import UIKit
import TicketmasterFoundation

protocol PopupMenuTableviewCellDelegate: AnyObject {
    func valueChanged(_ cell: MenuButtonWithTitleAndPopupTableViewCell, value: String)
}

class MenuButtonWithTitleAndPopupTableViewCell: MenuBuilderTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueButton: UIButton!
    
    weak var delegate: PopupMenuTableviewCellDelegate?
    
    // MARK: Constructors
    override func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .buttonWithTitleAndPopupMenu else { return }
        super.configure(withCellInfo: cellInfo)

        titleLabel.text = cellInfo.titleText
        titleLabel.font = cellInfo.titleFont
        titleLabel.textColor = cellInfo.titleColor

        valueButton.setTitle(cellInfo.valueText, for: .normal)
        valueButton.titleLabel?.font = cellInfo.valueFont
        valueButton.tintColor = cellInfo.valueColor
        valueButton.menu = UIMenu(title: "", children: menuActions())
        valueButton.showsMenuAsPrimaryAction = true
    }

    // MARK: Updates
    func update(title: String?) {
        titleLabel.text = title
    }
    
    func update(buttonTitle: String?) {
        valueButton.setTitle(buttonTitle, for: .normal)
    }

}

extension MenuButtonWithTitleAndPopupTableViewCell {
    func menuActions() -> [UIMenuElement] {
        guard let valueArray = cellInfo.valueArray else {
            logMessage("Please check the contents of valueArray for MenuButtonWithTitleAndPopupTableViewCell", level: .warning)
            return []
        }
        
        var actions = [UIMenuElement]()
        for (index, value) in valueArray.enumerated() {
            var title: String
            if let titlesArray = cellInfo.segmentTextArray, index < titlesArray.count {
                title = titlesArray[index]
            } else {
                title = value
            }

            actions.append(
                UIAction(title: title) { [weak self] action in
                    guard let self else { return }
                    self.delegate?.valueChanged(self, value: value)
                }
            )
        }
        return actions
    }
}
