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

extension PrePurchaseHelper: TMPrePurchaseLocationDelegate {
    
    func prePurchaseViewController(_ viewController: TMPrePurchaseViewController, didChangeLocationTo location: MarketLocation) {
        print("prePurchaseViewController:didChangeLocationTo: \(location.localizedName)")
    }
    
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
}


extension PrePurchaseHelper: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:  // Location services are available.
            requestCLLocation()
        case .restricted, .denied:  // Location services currently unavailable.
            communicateLocationFetchError()
        case .notDetermined:        // Authorization not determined yet.
            requestCLLocationAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else {
            communicateLocationFetchError()
            return
        }
        
        communicateLocation(firstLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        communicateLocationFetchError()
    }
}


extension PrePurchaseHelper {
    func requestCLLocationAuthorization() {
        clLocationManager.requestWhenInUseAuthorization()
    }
    
    func requestCLLocation() {
        clLocationManager.requestLocation()
    }
    
    func communicateLocation(_ location: CLLocation) {
        guard let locationRequestingVC = locationRequestingViewController else {
            return
        }
        
        locationRequestingVC.changeLocation(coordinate: location.coordinate)
        locationRequestingViewController = nil
    }
    
    func communicateLocationFetchError() {
        guard let locationRequestingVC = locationRequestingViewController else {
            return
        }
        
        locationRequestingVC.communicateLocationFetchError()
        locationRequestingViewController = nil
    }
}
