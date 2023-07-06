//
//  PrePurchaseHelper+AnalyticsDelegate.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterFoundation
import TicketmasterPrePurchase

extension PrePurchaseHelper: TMPrePurchaseAnalyticsDelegate {
    
    func prePurchaseViewController(_ viewController: TMPrePurchaseViewController, didShare pageTitle: String, and pageURL: URL, to activityType: UIActivity.ActivityType) {
        print("prePurchaseViewController:didSharePageTitle: \(pageTitle)")
    }
    
    func prePurchaseViewController(_ viewController: TMPrePurchaseViewController, didFirePageView pageView: UALPageView) {
        print("prePurchaseViewController:didFirePageView: \(pageView.name)")
    }
}
