//
//  PurchaseVC+Actions.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import Foundation
import TicketmasterFoundation
import TicketmasterPurchase

extension PurchaseViewController: MenuBuilderDataSourceDelegate {
    
    func menuBuilderDataSource(_: MenuBuilderDataSource, didAction action: MenuBuilderAction, forCell cell: MenuBuilderTableViewCell) {
        
        guard let purchaseHelper = ConfigurationManager.shared.purchaseHelper else { return }
        
        // try to determine which cell this is
        if let cellIdentifier = CellIdentifier(rawValue: cell.cellInfo.uniqueIdentifier) {
            print("\(cellIdentifier.rawValue): \(action.debugString)")
            switch cellIdentifier {
            case .purchaseOpenEvent:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    customEventIdentifier = value
                default:
                    break
                }
                if let eventID = customEventIdentifier {
                    purchaseHelper.presentPurchase(eventID: eventID, onViewController: self)
                }
                
            case .purchaseSampleEvent:
                if let text = cell.cellInfo.titleText,
                   let namedConfig = EventConfigurationManager.shared.configuration(name: text) {
                    purchaseHelper.presentPurchase(eventID: namedConfig.identifier, onViewController: self)
                }
            }
        }
    }
}
