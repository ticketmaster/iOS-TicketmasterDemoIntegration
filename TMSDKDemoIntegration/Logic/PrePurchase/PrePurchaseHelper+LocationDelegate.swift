//
//  PrePurchaseHelper+LocationDelegate.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import CoreLocation
import TicketmasterFoundation
import TicketmasterPrePurchase

/// Protocol for communicating interactions about location
extension PrePurchaseHelper: TMPrePurchaseLocationDelegate {
    
    /// Called when a user changes the location in the PrePurchase pages
    ///
    /// In various parts of the flow, the user is able to make selections to browse events closer to a geographical area for better filtered results. This location is not necessarily where the user physically is, but is a geographical area they want to browse, nevertheless. This function informs the delegate of the selection.
    func prePurchaseViewController(_ viewController: TMPrePurchaseViewController, didChangeLocationTo location: MarketLocation) {
        print("prePurchaseViewController:didChangeLocationTo: \(location.localizedName)")
    }
    
    /// Called when the user taps Use Current Location.
    ///
    /// The delegate, once receiving this callback, is expected to ask for device location, possibly triggering permission prompt in the process.
    /// If the user grants the permission, and the app receives a location from location services, the delegate is expected to call the view controller's `changeLocation(coordinate:)` to set the location.
    /// If the user declines the permission, or an error is encountered during the process (such as the device having no connection), the delegate is expected to call the view controller's `communicateLocationFetchError()` to indicate the error.
    /// The UI will show a loading spinner while the exchange takes place, as acquiring the location is an asynchronous operation.
    func prePurchaseViewControllerDidRequestCurrentLocation(_ viewController: TicketmasterPrePurchase.TMPrePurchaseViewController) {
        print("prePurchaseViewControllerDidRequestCurrentLocation")
        
        locationRequestingViewController = viewController
        
        let status = clLocationManager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            requestCLLocation()
        case .notDetermined:
            requestCLLocationAuthorization()
        default:
            communicateLocationFetchError()
        }
    }
    
    /// Called when the user wants to change location in home for some markets.
    ///
    func openLocationSelector(_ viewController: TicketmasterPrePurchase.TMPrePurchaseViewController) {
        print("prePurchaseViewControllerDidOpenLocationSelector")
    }
}
