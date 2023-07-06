//
//  ConfigurationManager.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation

import TicketmasterFoundation
import TicketmasterAuthentication
import TicketmasterDiscoveryAPI
import TicketmasterPrePurchase
import TicketmasterPurchase
import TicketmasterSecureEntry
import TicketmasterTickets

/// a class to manage configuration and logic instances
class ConfigurationManager: NSObject {
    
    static let shared = ConfigurationManager()
    
    var currentConfiguration: Configuration {
        get {
            if let config = _currentConfig {
                return config
            } else if let config = Configuration.load() {
                return config
            } else {
                return Configuration.defaultConfiguration()
            }
        }
        set {
            _currentConfig = newValue
            _currentConfig?.save()
            
            // reset all existing helpers
            authenticationHelper = nil
            discoveryHelper = nil
            prePurchaseHelper = nil
            purchaseHelper = nil
            ticketsHelper = nil
        }
    }
    private var _currentConfig: Configuration?
    
    private(set) var authenticationHelper: AuthenticationHelper?
    
    private(set) var discoveryHelper: DiscoveryHelper?
    
    private(set) var prePurchaseHelper: PrePurchaseHelper?
    
    private(set) var purchaseHelper: PurchaseHelper?
    
    private(set) var ticketsHelper: TicketsHelper?
}


// MARK: Authentication
extension ConfigurationManager {
    
    func configureAuthenticationIfNeeded(completion: @escaping (_ success: Bool) -> Void) {
        if authenticationHelper == nil {
            configureAuthentication(completion: completion)
        } else {
            completion(true)
        }
    }
    
    private func configureAuthentication(completion: @escaping (_ success: Bool) -> Void) {
        let authHelper = AuthenticationHelper()
        authHelper.configure(configuration: currentConfiguration) { success in
            if success {
                self.authenticationHelper = authHelper
            } else {
                self.authenticationHelper = nil
            }
            completion(success)
        }
    }
}
 

// MARK: DiscoveryAPI
extension ConfigurationManager {
    
    func configureDiscoveryAPIIfNeeded(completion: @escaping (_ success: Bool) -> Void) {
        if discoveryHelper == nil {
            configureDiscoveryAPI(completion: completion)
        } else {
            completion(true)
        }
    }
    
    private func configureDiscoveryAPI(completion: @escaping (_ success: Bool) -> Void) {
        let discoHelper = DiscoveryHelper()
        discoHelper.configure(configuration: currentConfiguration) { success in
            if success {
                self.discoveryHelper = discoHelper
            } else {
                self.discoveryHelper = nil
            }
            completion(success)
        }
    }
}


// MARK: PrePurchase
extension ConfigurationManager {
    
    func configurePrePurchaseIfNeeded(completion: @escaping (_ success: Bool) -> Void) {
        if prePurchaseHelper == nil {
            configurePrePurchase(completion: completion)
        } else {
            completion(true)
        }
    }
    
    private func configurePrePurchase(completion: @escaping (_ success: Bool) -> Void) {
        let prepHelper = PrePurchaseHelper()
        prepHelper.configure(configuration: currentConfiguration) { success in
            if success {
                self.prePurchaseHelper = prepHelper
            } else {
                self.prePurchaseHelper = nil
            }
            completion(success)
        }
    }
}


// MARK: Purchase
extension ConfigurationManager {
    
    func configurePurchaseIfNeeded(completion: @escaping (_ success: Bool) -> Void) {
        if purchaseHelper == nil {
            configurePurchase(completion: completion)
        } else {
            completion(true)
        }
    }
    
    private func configurePurchase(completion: @escaping (_ success: Bool) -> Void) {
        // always configure Authentication first
        configureAuthenticationIfNeeded { success in
            if success {
                // then  configure Purchase
                let purchHelper = PurchaseHelper()
                purchHelper.configure(configuration: self.currentConfiguration) { success in
                    if success {
                        self.purchaseHelper = purchHelper
                    } else {
                        self.purchaseHelper = nil
                    }
                    completion(success)
                }
            } else {
                completion(false)
            }
        }
    }
}
    

// MARK: Tickets
extension ConfigurationManager {
    
    func configureTicketsIfNeeded(completion: @escaping (_ success: Bool) -> Void) {
        if ticketsHelper == nil {
            configureTickets(completion: completion)
        } else {
            completion(true)
        }
    }
    
    private func configureTickets(completion: @escaping (_ success: Bool) -> Void) {
        // always configure Authentication first
        configureAuthenticationIfNeeded { success in
            if success {
                let tickHelper = TicketsHelper()
                tickHelper.configure(configuration: self.currentConfiguration) { success in
                    if success {
                        self.ticketsHelper = tickHelper
                    } else {
                        self.ticketsHelper = nil
                    }
                    completion(success)
                }
            } else {
                completion(false)
            }
        }
    }
}


// MARK: other
extension ConfigurationManager {
    
    func printVersions() {
        print("==========================================")
        print("TMFoundation      : v\(TMFoundation.shared.version)")
        print("TMAuthentication  : v\(TMAuthentication.shared.version)")
        print("TMDiscoveryAPI    : v\(TMDiscoveryAPI.shared.version)")
        print("TMPrePurchase     : v\(TMPrePurchase.shared.version)")
        print("TMPurchase        : v\(TMPurchase.shared.version)")
        print("TMTickets         : v\(TMTickets.shared.version)")
        print(" - SecureEntryView: v\(SecureEntryView.version)")
        print("==========================================")
    }
}
