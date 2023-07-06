//
//  PrePurchaseHelper+Present.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterPrePurchase

extension PrePurchaseHelper {
        
    func viewControllerForCurrentConfiguration(page: TMPrePurchaseViewController.PrePurchasePage) -> TMPrePurchaseViewController {
        let prePurchaseVC = TMPrePurchaseViewController(initialPage: page,
                                           marketLocation: homepageMarketLocation, // if showing homepage
                                           queryParameters: nil,
                                           enclosingEnvironment: .navigationController,
                                           allowJavaScriptToBringUpKeyboard: false)
        
        prePurchaseVC.navigationDelegate = self
        prePurchaseVC.locationDelegate = self
        prePurchaseVC.analyticsDelegate = self

        return prePurchaseVC
    }
    
    func presentPrePurchase(page: TMPrePurchaseViewController.PrePurchasePage,
                            onViewController viewController: UIViewController) {
        let prePurchaseVC = viewControllerForCurrentConfiguration(page: page)
        
        if let navController = viewController.navigationController {
            navController.pushViewController(prePurchaseVC, animated: true)
        } else {
            viewController.present(prePurchaseVC, animated: true)
        }
    }
}
