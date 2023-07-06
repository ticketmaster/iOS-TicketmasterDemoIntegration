//
//  PurchaseHelper+AnalyticsDelegate.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterFoundation
import TicketmasterDiscoveryAPI
import TicketmasterPurchase

/// The user analytics delegate of a `TMPurchaseNavigationController`
///
/// Set an object as the user analytics delegate if your application is interested in knowing about the actions a user takes.
extension PurchaseHelper: TMPurchaseUserAnalyticsDelegate {

    /// Tells the delegate that the ticket selection portion of the purchase process began.
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the ticket selection process began in
    ///   - event: the Event that tickets are being sold to
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didBeginTicketSelectionFor event: DiscoveryEvent) {
        print("didBeginTicketSelectionForEvent: \(event.eventIdentifier)")
    }
    
    /// Tells the delegate that the ticket selection portion of the purchase process ended.
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the ticket selection process ended in
    ///   - event: the Event that tickets are being sold to
    ///   - reason: the Reason ticket selection ended
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didEndTicketSelectionFor event: DiscoveryEvent,
                                because reason: TMEndTicketSelectionReason) {
        print("didEndTicketSelectionForEvent: \(event.eventIdentifier) Reason: \(reason.rawValue)")
    }
    
    /// Tells the delegate that the checkout portion of the purchase process began.
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the checkout process began in
    ///   - event: the Event that tickets are being sold to
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didBeginCheckoutFor event: DiscoveryEvent) {
        print("didBeginCheckoutForEvent: \(event.eventIdentifier)")
    }
    
    /// Tells the delegate that the checkout portion of the purchase process ended.
    ///
    ///  - Note: `purchaseNavigationController(:didEndCheckoutForEvent)` is not immediately called upon the purchase being completed.
    ///  Once the user is finished viewing their Order Confirmation, the user presses the `Done` button on the navigation bar and then `purchaseNavigationController(:didEndCheckoutForEvent:)` is called.
    ///  If you want to update your UI (moving the user to the Orders Listing page, for example), wait for  `purchaseNavigationControllerDidFinish()` to be called.
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the checkout process ended in
    ///   - event: the Event that tickets are being sold to
    ///   - reason: the Reason checkout ended
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didEndCheckoutFor event: DiscoveryEvent,
                                because reason: TMEndCheckoutReason) {
        print("didEndCheckoutForEvent: \(event.eventIdentifier) Reason: \(reason.rawValue)")
    }
    
    /// Tells the delegate that the user made a purchase and is currently viewing the Order Confirmation page.
    ///
    /// - Note: `purchaseNavigationController(:didMakePurchaseForEvent)` is immediately called upon the purchase being completed, while the user is still viewing the Order Confirmation page.
    ///  Once the user is finished viewing their Order Confirmation, the user presses the `Done` button on the navigation bar and `purchaseNavigationController(:didEndCheckoutForEvent:)` is called.
    ///  If you want to update your UI (moving the user to the Orders Listing page, for example), wait for  `purchaseNavigationControllerDidFinish()` to be called.
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the user made a purchase in
    ///   - event: the Event that tickets were sold to
    ///   - order: the Order for the purchase
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                         didMakePurchaseFor event: DiscoveryEvent,
                                         order: TMPurchaseOrder) {
        print("didMakePurchaseForEvent: \(event.eventIdentifier) Order: \(order.identifier ?? "<nil>")")
    }
    
    /// Tells the delegate that the user pressed a button on the navigation header bar
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the user made a purchase in
    ///   - event: the Event that tickets are being sold to
    ///   - button: which button on the navigation bar has been pressed
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                      didPressNavBarButtonFor event: DiscoveryEvent,
                                      button: TMPurchaseNavBarButton) {
        print("didPressNavBarButtonForEvent: \(event.eventIdentifier) Button: \(button.rawValue)")
    }
    
    /// Tells the delegate that the user shared a link to this event
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the user made a purchase in
    ///   - event: the Event that tickets are being sold to
    ///   - activityType: which social activity the Event was shared to
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                      didShare event: DiscoveryEvent,
                                      activityType: UIActivity.ActivityType) {
        print("didShareEvent: \(event.eventIdentifier) Activity: \(activityType.rawValue)")
    }
    
    /// Tells the delegate that the user navigated to a sub-page with the EDP or Cart
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the user made a purchase in
    ///   - event: the Event that tickets are being sold to
    ///   - subPage: which sub-page with the EDP or Cart page has been viewed
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didViewSubPageFor event: DiscoveryEvent,
                                subPage: TMPurchaseSubPage) {
        print("didViewSubPage: \(subPage.rawValue) Event: \(event.eventIdentifier)")
    }

    /// Tells the delegate that the user has interacted with an UI component, resulting in a decision
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the user made a purchase in
    ///   - event: the Event that tickets are being sold to
    ///   - component: which component user interacted with
    ///   - decision: which choice the user went with
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                      didMakeDecisionFor event: DiscoveryEvent,
                                      component: TMPurchaseComponent,
                                      decision: TMPurchaseDecision) {
        print("didMakeDecisionForEvent: \(event.eventIdentifier) Component: \(component.rawValue) Decision: \(decision.rawValue)")
    }
}
