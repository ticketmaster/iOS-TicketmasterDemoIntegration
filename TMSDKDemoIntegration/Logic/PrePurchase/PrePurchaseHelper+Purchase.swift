//
//  PrePurchaseHelper+Purchase.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/7/23.
//

import Foundation
import UIKit

extension PrePurchaseHelper {
    
    func presentPurchase(forEventID eventID: String, onViewController viewController: UIViewController) {
        ConfigurationManager.shared.configurePurchaseIfNeeded { success in
            if success {
                ConfigurationManager.shared.purchaseHelper?.presentPurchase(eventID: eventID, onViewController: viewController)
            }
        }
    }
}
