//
//  PurchaseHelper+NavigationDelegate.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import StoreKit // for RateMyApp
import TicketmasterFoundation
import TicketmasterDiscoveryAPI
import TicketmasterPurchase

/// The navigation delegate of a `TMPurchaseNavigationController`
///
/// Set an object as the navigation Delegate if your application is interested in knowing when the user navigates out of the `TMPurchaseNavigationController`
extension PurchaseHelper: TMPurchaseNavigationDelegate {
        
    /// Tells the delegate that the user dismissed `purchaseNavigationController`.
    ///
    /// - Note: This method will be called exactly once, at the end of a `TMPurchaseNavigationController`'s lifetime because the user has completed or aborted purchase.
    ///
    /// - Important: Instances of `TMPurchaseNavigationController` attempt to dismiss themselves automatically by default. This behavior can be disabled by `TMPurchase.dismissUponCompletion`.
    /// If your code does not present instances of `TMPurchaseNavigationController` in a standard way (i.e. your code implements custom presentation logic), add your custom dismissal logic to this method.
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that has completed purchase operations and has been dismissed (or needs to be dismissed).
    func purchaseNavigationControllerDidFinish(_ purchaseNavigationController: TMPurchaseNavigationController) {
        // Task: If your code does not present instances of `TMPurchaseNavigationController` in a standard way (i.e. your code implements custom presentation logic), add your custom dismissal logic to this method.
        
        /// Instances of `TMPurchaseNavigationController` attempt to dismiss themselves automatically by default.
        /// This behavior can be disabled by `TMPurchase.dismissUponCompletion`.
        
        // If your code does not present instances of `TMPurchaseNavigationController` in a standard way (i.e. your code implements custom presentation logic), add your custom dismissal logic here:
        //dismissPurchaseViaCustomCode()
        
        // log to some analytics
        print("TMPurchaseNavigationDelegate: PurchaseNavController was dismissed (user either completed or canceled purchase flow)")

        /// You may want to show the user their Orders page (part of the Tickets framework) upon a completed purchase.
        /// If so, let check if `purchaseOrder` was set via `TMPurchaseUserAnalyticsDelegate.didMakePurchaseForEvent`
        
        let someOrder: TMPurchaseOrder? = TMPurchaseOrder(identifier: "4500")
        
        // did the user make a purchase?
        if let order = someOrder { //purchasedOrder {
            // yes, let's display the user's Orders
            presentTickets(forOrder: order)

            // Since the user just completed a purchase, this may be a good place to prompt the user to "Rate Your App".
            // A happy user is more likely to give your App a good rating on the AppStore!
            // give Tickets SDK a chance to render the user's tickets
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.rateMyAppIfEnabled()
            })
        }
    }
    
    /// Tells the delegate that the Purchase EDP could not be loaded due to an error
    ///
    /// - Parameters:
    ///   - purchaseNavigationController: The `TMPurchaseNavigationController` that the ticket selection process ended in
    ///   - error: the Error that prevented the Purchase EDP from loading
    func purchaseNavigationController(_ purchaseNavigationController: TMPurchaseNavigationController,
                                      didFailToLoadWith error: Error) {
        // Task: No specific action is required here

        // This error is informational, and usually is due to Purchase's internal DiscoveryAPI service returning an error when looking up the event information.
        print("Error: \(error.localizedDescription)")
    }
}



extension PurchaseHelper {
    
    func rateMyAppIfEnabled() {
        if rateMyAppAfterPurchase {
            print("Rate My App")
            SKStoreReviewController.requestReviewInCurrentScene()
        }
    }
}

extension SKStoreReviewController {
    
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
