//
//  MenuButtonWithTitleAndPopupMenuTableViewCell.swift
//  RetailDevApp
//
//  Created by Vishwak Reddy on 09/11/2024.
//

import UIKit

protocol PopupMenuTableviewCellDelegate: AnyObject {
    func valueChanged(_ cell: MenuButtonWithTitleAndPopupTableViewCell, value: String)
}

class MenuButtonWithTitleAndPopupTableViewCell: MenuBuilderTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueButton: UIButton!
    
    weak var delegate: PopupMenuTableviewCellDelegate?
    
    // MARK: Constructors
    func configure(withCellInfo cellInfo: MenuBuilderCellInfo) {
        guard cellInfo.cellType == .buttonWithTitleAndPopupMenu else { return }
        self.cellInfo = cellInfo
        self.accessoryType = cellInfo.accessoryType

        titleLabel.text = cellInfo.titleText
        valueButton.setTitle(cellInfo.valueText, for: .normal)
        
        titleLabel.textColor = cellInfo.titleColor ?? .label
        valueButton.tintColor = cellInfo.valueColor ?? contentView.tintColor
        contentView.backgroundColor = cellInfo.backgroundColor
       
        valueButton.menu = UIMenu(title: "", children: menuActions())
        valueButton.showsMenuAsPrimaryAction = true

    }

    // MARK: Updates
    func update(title: String) {
        titleLabel.text = title
    }
    
    func update(buttonTitle: String) {
        valueButton.setTitle(buttonTitle, for: .normal)
    }

}

extension MenuButtonWithTitleAndPopupTableViewCell {
    func menuActions() -> [UIMenuElement] {
        guard let valueArray = cellInfo.valueArray else { return []}
        var actions = [UIMenuElement]()
        for (index, value) in valueArray.enumerated() {
            var title: String
            if let titlesArray = cellInfo.segmentTextArray,
               index < titlesArray.count {
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
