//
//  PurchaseHelper.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterPurchase // for TMPurchase

/// a class to wrap helpful methods
class PurchaseHelper: NSObject {
    
    weak var purchaseMenuVC: PurchaseViewController?

    /// show Apple's Rate My App after a successful purchase?
    var rateMyAppAfterPurchase: Bool = false
    
    // TODO: persist this favoritesStore somewhere, so the user's favorites are remembered
    /// storage of user's favorited Event IDs
    var eventFavoritesStore: [String] = []

    /// the resulting Order from a purchase (if any)
    var purchasedOrder: TMPurchaseOrder?
    
    /// which ViewController is presenting the Purchase SDK
    var presentingViewController: UIViewController?
    
}
