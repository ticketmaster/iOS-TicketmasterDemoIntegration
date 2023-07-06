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

extension PurchaseHelper: TMPurchaseUserAnalyticsDelegate {

    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didBeginTicketSelectionFor event: DiscoveryEvent) {
        print("didBeginTicketSelectionForEvent: \(event.eventIdentifier)")
    }
    
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didEndTicketSelectionFor event: DiscoveryEvent,
                                because reason: TMEndTicketSelectionReason) {
        print("didEndTicketSelectionForEvent: \(event.eventIdentifier) Reason: \(reason.rawValue)")
    }
    
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didBeginCheckoutFor event: DiscoveryEvent) {
        print("didBeginCheckoutForEvent: \(event.eventIdentifier)")
    }
    
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didEndCheckoutFor event: DiscoveryEvent,
                                because reason: TMEndCheckoutReason) {
        print("didEndCheckoutForEvent: \(event.eventIdentifier) Reason: \(reason.rawValue)")
    }
    
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                didViewSubPageFor event: DiscoveryEvent,
                                subPage: TMPurchaseSubPage) {
        print("didViewSubPage: \(subPage.rawValue) Event: \(event.eventIdentifier)")
    }
        
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                         didMakePurchaseFor event: DiscoveryEvent,
                                         order: TMPurchaseOrder) {
        print("didMakePurchaseForEvent: \(event.eventIdentifier) Order: \(order.identifier ?? "<nil>")")
    }
    
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController, didPressNavBarButtonFor event: DiscoveryEvent, button: TMPurchaseNavBarButton) {
        print("didPressNavBarButtonForEvent: \(event.eventIdentifier) Button: \(button.rawValue)")
    }
    
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController, didShare event: DiscoveryEvent, activityType: UIActivity.ActivityType) {
        print("didShareEvent: \(event.eventIdentifier) Activity: \(activityType.rawValue)")
    }

    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                      didMakeDecisionFor event: DiscoveryEvent,
                                      component: TMPurchaseComponent,
                                      decision: TMPurchaseDecision) {
        print("didMakeDecisionForEvent: \(event.eventIdentifier) Component: \(component.rawValue) Decision: \(decision.rawValue)")
    }
}
