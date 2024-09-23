//
//  MarketLocation+Extensions.swift
//  RetailDevApp
//
//  Created by Andrew Rennard on 12/02/2024.
//

import Foundation
import CoreLocation
import TicketmasterFoundation

extension MarketLocation {
    static func defaultLocationFor(market: MarketDomain) -> MarketLocation {
        switch market {
        case .CA: MarketLocation.Canada_BritishColumbia_Vancouver()
        case .AU: MarketLocation.Australia_Sydney()
        case .MX: MarketLocation.Mexico_MexicoCity()
        case .NZ: MarketLocation.NewZealand_Auckland()
        case .UK: MarketLocation.UK_London()
        case .IE: MarketLocation.IE_Dublin()
        default: MarketLocation.California_LosAngeles()
        }
    }
}

extension MarketLocation {
    
    static func Australia_Sydney() -> MarketLocation {
        let domain: MarketDomain = .AU
        let marketID: Int = 307
        let marketName: String = "Sydney"
        let description: String = "Sydney, AU"
        let clLocation: CLLocation = CLLocation(latitude: -33.87271, longitude: 151.20569)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
    
    static func Mexico_MexicoCity() -> MarketLocation {
        let domain: MarketDomain = .MX
        let marketID: Int = 402
        let marketName: String = "Mexico City"
        let description: String = "Mexico City, MX"
        let clLocation: CLLocation = CLLocation(latitude: 19.43011, longitude: 99.13361)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
    
    static func NewZealand_Auckland() -> MarketLocation {
        let domain: MarketDomain = .NZ
        let marketID: Int = 351
        let marketName: String = "Auckland"
        let description: String = "Auckland, NZ"
        let clLocation: CLLocation = CLLocation(latitude: -36.85307, longitude: 174.76358)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
    
    static func UK_London() -> MarketLocation {
        let domain: MarketDomain = .UK
        let marketID: Int = 202
        let marketName: String = "London"
        let description: String = "London, UK"
        let clLocation: CLLocation = CLLocation(latitude: 51.51, longitude: -0.12)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
    
    static func IE_Dublin() -> MarketLocation {
        let domain: MarketDomain = .IE
        let marketID: Int = 208
        let marketName: String = "Dublin"
        let description: String = "Dublin, IE"
        let clLocation: CLLocation = CLLocation(latitude: 53.35, longitude: -6.27)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
}
