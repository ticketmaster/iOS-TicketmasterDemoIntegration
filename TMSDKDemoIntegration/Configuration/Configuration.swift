//
//  Configuration.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterFoundation
import TicketmasterAuthentication

struct Configuration: Codable, Hashable {
        
    /// get your own API key from developer.ticketmaster.com
    let apiKey: String
    
    /// UK, IE, and Sport XR should use .UK, all others should use .US
    let region: TMAuthentication.TMXDeploymentRegion
    
    /// name of your App/Team/Artist/Venue
    let displayName: String
    
    /// main branding color (optional)
    let backgroundColor: UIColor?
    
    /// text branding color (optional)
    let foregroundColor: UIColor?
    
    /// other text should be light (white) or dark (black)
    let textTheme: TMAuthentication.ColorTheme
    
    /// which TM Host country to use for Events, Purchase, etc.
    let retailMarketDomain: MarketDomain
    
    init(apiKey: String,
         region: TMAuthentication.TMXDeploymentRegion = .US,
         displayName: String,
         backgroundColor: UIColor? = nil,
         foregroundColor: UIColor? = nil,
         textTheme: TMAuthentication.ColorTheme = .light,
         retailMarketDomain: MarketDomain = .US) {
        self.apiKey = apiKey
        self.region = region
        self.displayName = displayName
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.textTheme = textTheme
        self.retailMarketDomain = retailMarketDomain
    }
}



extension Configuration {
    
    static func defaultConfiguration() -> Configuration {
        
        // TODO: set these values as your our defaults
        
        /// get your own API key from developer.ticketmaster.com
        let apiKey: String = "<your apiKey>"
        
        /// UK, IE, and Sport XR should use .UK, all others should use .US
        let region: TMAuthentication.TMXDeploymentRegion = .US
        
        /// name of your App/Team/Artist/Venue
        let displayName: String = "Arizona Diamondbacks"
        
        /// main branding color (optional)
        let backgroundColor: UIColor = UIColor(red: 35/255.0, green: 97/255.0, blue: 146/255.0, alpha: 1.0)
        
        /// other text should be light (white) or dark (black)
        let textTheme: TMAuthentication.ColorTheme = .light
        
        return Configuration(apiKey: apiKey,
                             region: region,
                             displayName: displayName,
                             backgroundColor: backgroundColor,
                             textTheme: textTheme)
    }
    
    func save() {
        UserDefaultsManager.shared.set(apiKey, forKey: .configurationAPIKeyString)
        UserDefaultsManager.shared.set(region.rawValue, forKey: .configurationRegionString)
    }
    
    static func load() -> Configuration? {
        guard let apiKey = UserDefaultsManager.shared.string(.configurationAPIKeyString) else { return nil }
        
        guard let regionString = UserDefaultsManager.shared.string(.configurationRegionString),
              let region = TMAuthentication.TMXDeploymentRegion(rawValue: regionString) else { return nil }
        
        MessageLogger.currentLogLevel = .network
        
        let oldConfig = Configuration.defaultConfiguration()
        return Configuration(apiKey: apiKey,
                             region: region,
                             displayName: oldConfig.displayName,
                             backgroundColor: oldConfig.backgroundColor,
                             textTheme: oldConfig.textTheme)
    }
}
