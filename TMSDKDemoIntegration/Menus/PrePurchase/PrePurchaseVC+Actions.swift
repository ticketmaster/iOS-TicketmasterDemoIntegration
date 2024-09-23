//
//  PrePurchaseVC+Actions.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import Foundation
import TicketmasterFoundation
import TicketmasterPrePurchase

extension PrePurchaseViewController: MenuBuilderDataSourceDelegate {
    
    func menuBuilderDataSource(_: MenuBuilderDataSource, didAction action: MenuBuilderAction, forCell cell: MenuBuilderTableViewCell) {
        
        guard let prePurchaseHelper = ConfigurationManager.shared.prePurchaseHelper else { return }
        
        // try to determine which cell this is
        if let cellIdentifier = CellIdentifier(rawValue: cell.cellInfo.uniqueIdentifier) {
            print("\(cellIdentifier.rawValue): \(action.debugString)")
            switch cellIdentifier {
                
            case .pageHome:
                prePurchaseHelper.presentPrePurchase(page: .home,
                                                     onViewController: self)
                
            case .pageSearch:
                prePurchaseHelper.presentPrePurchase(page: .search,
                                                     onViewController: self)
                
            case .pageVenue:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    selectedVenueIdentifier = value
                default:
                    break
                }
                if let venueID = selectedVenueIdentifier, venueID.count > 0 {
                    prePurchaseHelper.presentPrePurchase(page: .venue(identifier: venueID),
                                                         onViewController: self)
                }
                
            case .pageAttraction:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    selectedAttractionIdentifier = value
                default:
                    break
                }
                if let attractionID = selectedAttractionIdentifier, attractionID.count > 0 {
                    prePurchaseHelper.presentPrePurchase(page: .attraction(identifier: attractionID),
                                                         onViewController: self)
                }
                
            case .settingsDomain:
                switch action {
                case .valueChanged(let value):
                    if let value = value, let market = MarketDomain(rawValue: value.lowercased()) {
                        prePurchaseHelper.forcedMarketDomain = market
                        prePurchaseHelper.homepageMarketLocation = MarketLocation.defaultLocationFor(market: market)
                    }
                    buildRefreshMenu()
                default:
                    break
                }
            }
        }
    }
}
