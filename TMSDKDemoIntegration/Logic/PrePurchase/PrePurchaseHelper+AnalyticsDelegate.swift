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

/// Protocol for communicating analytics-related information
extension PrePurchaseHelper: TMPrePurchaseAnalyticsDelegate {
    
    /// User has just shared a Attraction Details Page (ADP) or Venue Details Page (VDP)
    func prePurchaseViewController(_ viewController: TMPrePurchaseViewController,
                                   didShare pageTitle: String,
                                   and pageURL: URL,
                                   to activityType: UIActivity.ActivityType) {
        print("prePurchaseViewController:didSharePageTitle: \(pageTitle)")
    }
    
    /// Communicates a page view, with some info about the page
    func prePurchaseViewController(_ viewController: TMPrePurchaseViewController,
                                   didFirePageView pageView: UALPageView) {
        print("prePurchaseViewController:didFirePageView: \(pageView.name)")
    }
}
