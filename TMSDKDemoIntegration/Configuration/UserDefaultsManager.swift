//
//  UserDefaultsManager.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation

//
//  UserDefaultsManager.swift
//  TicketmasterAuthentication
//
//  Created by Jonathan Backer on 11/9/22.
//

import Foundation
import TicketmasterFoundation

/// add items to the iOS public UserDefaults
///
/// - Note: best used for device-specific, non-user specific data
///
/// data is not exactly public, but it's pretty close
class UserDefaultsManager: UserDefaultsStringEnum<UserDefaultsManager.Settings> {

    static let shared = UserDefaultsManager()
    
    enum Settings: String, CaseIterable {
        case configurationAPIKeyString
        case configurationRegionString
        
        case discoveryLanguageString
        case discoveryIdentifierString
        
        case prePurchaseVenueString
        case prePurchaseAttractionString
        case prePurchaseCustomString
        
        case purchaseCustomEventIDString
        
        case ticketsDisplayID
    }
}


class UserDefaultsStringEnum<E: RawRepresentable & CaseIterable> where E.RawValue == String {
    
    let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults(suiteName: "com.ticketmaster.demoIntegration") ?? UserDefaults.standard
    }
    
    // MARK: Remove
    
    func remove(_ key: E) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
    
    func removeAll() {
        for key in E.allCases {
            remove(key)
        }
    }
    
    // MARK: String
    
    func set(_ value: String, forKey key: E) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func string(_ key: E) -> String? {
        return userDefaults.string(forKey: key.rawValue)
    }
    
    // MARK: Bool
    
    func set(_ value: Bool, forKey key: E) {
        userDefaults.set(NSNumber(value: value), forKey: key.rawValue)
    }
    
    func bool(_ key: E) -> Bool? {
        if let number = userDefaults.object(forKey: key.rawValue) as? NSNumber {
            return number.boolValue
        } else {
            return nil
        }
    }
    
    // MARK: Int
    
    func set(_ value: Int, forKey key: E) {
        userDefaults.set(NSNumber(value: value), forKey: key.rawValue)
    }
    
    func int(_ key: E) -> Int? {
        if let number = userDefaults.object(forKey: key.rawValue) as? NSNumber {
            return number.intValue
        } else {
            return nil
        }
    }
    
    // MARK: Double
    
    func set(_ value: Double, forKey key: E) {
        userDefaults.set(NSNumber(value: value), forKey: key.rawValue)
    }
    
    func double(_ key: E) -> Double? {
        if let number = userDefaults.object(forKey: key.rawValue) as? NSNumber {
            return number.doubleValue
        } else {
            return nil
        }
    }
    
    // MARK: JSONDictionary, JSONDictionaryArray
    
    func set(_ value: JSONDictionary, forKey key: E) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func jsonDictionary(_ key: E) -> JSONDictionary? {
        return userDefaults.dictionary(forKey: key.rawValue)
    }
    
    func set(_ value: JSONDictionaryArray, forKey key: E) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func jsonDictionaryArray(_ key: E) -> JSONDictionaryArray? {
        return userDefaults.array(forKey: key.rawValue) as? JSONDictionaryArray
    }
    
    // MARK: Data
    
    func set(_ value: Data, forKey key: E) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func data(_ key: E) -> Data? {
        return userDefaults.data(forKey: key.rawValue)
    }
}
