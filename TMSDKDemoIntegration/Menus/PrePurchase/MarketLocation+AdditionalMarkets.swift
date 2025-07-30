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
        case .AU: MarketLocation.australia_Sydney()
        case .MX: MarketLocation.mexico_MexicoCity()
        case .NZ: MarketLocation.newZealand_Auckland()
        case .UK: MarketLocation.uk_London()
        case .IE: MarketLocation.ie_Dublin()
        case .AT: MarketLocation.austria_Vienna()
        case .PL: MarketLocation.poland_Warsaw()
        case .NO: MarketLocation.norway_Oslo()
        case .FI: MarketLocation.finland_Helsinki()
        case .BE: MarketLocation.belgium_Brussels()
        case .CZ: MarketLocation.czechRepublic_Prague()
        case .SE: MarketLocation.sweden_Stockholm()
        case .ZA: MarketLocation.southAfrica_Johannesburg()
        case .ES: MarketLocation.spain_Madrid()
        case .DE: MarketLocation.germany_Berlin()
        case .AE: MarketLocation.uae_Dubai()
        case .NL: MarketLocation.netherlands_Amsterdam()
        case .CH: MarketLocation.switzerland_Zurich()
        case .DK: MarketLocation.denmark_Copenhagen()
        default: MarketLocation.California_LosAngeles()
        }
    }
}

extension MarketLocation {
    
    static func australia_Sydney() -> MarketLocation {
        let domain: MarketDomain = .AU
        let marketID: Int = 307
        let marketName: String = "Sydney"
        let description: String = "Sydney, AU"
        let clLocation: CLLocation = CLLocation(latitude: -33.87271, longitude: 151.20569)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
    
    static func mexico_MexicoCity() -> MarketLocation {
        let domain: MarketDomain = .MX
        let marketID: Int = 402
        let marketName: String = "Mexico City"
        let description: String = "Mexico City, MX"
        let clLocation: CLLocation = CLLocation(latitude: 19.43011, longitude: 99.13361)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
    
    static func newZealand_Auckland() -> MarketLocation {
        let domain: MarketDomain = .NZ
        let marketID: Int = 351
        let marketName: String = "Auckland"
        let description: String = "Auckland, NZ"
        let clLocation: CLLocation = CLLocation(latitude: -36.85307, longitude: 174.76358)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
    
    static func uk_London() -> MarketLocation {
        let domain: MarketDomain = .UK
        let marketID: Int = 202
        let marketName: String = "London"
        let description: String = "London, UK"
        let clLocation: CLLocation = CLLocation(latitude: 51.51, longitude: -0.12)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
    
    static func ie_Dublin() -> MarketLocation {
        let domain: MarketDomain = .IE
        let marketID: Int = 208
        let marketName: String = "Dublin"
        let description: String = "Dublin, IE"
        let clLocation: CLLocation = CLLocation(latitude: 53.35, longitude: -6.27)
        
        return MarketLocation(domain: domain, identifier: "\(marketID)", name: marketName, localizedName: description, dmaId: nil, countryCode: domain.countryCode, userLocation: UserLocation(location: clLocation, source: .appMarketList), source: .appMarketList)
    }
    
    static func austria_Vienna() -> MarketLocation {
        let domain = MarketDomain.AT
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Vienna",
                       localizedName: "Vienna, AT",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 48.2082, longitude: 16.3738), source: .appMarketList),
                       source: .appMarketList)
    }

    static func poland_Warsaw() -> MarketLocation {
        let domain = MarketDomain.PL
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Warsaw",
                       localizedName: "Warsaw, PL",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 52.2297, longitude: 21.0122), source: .appMarketList),
                       source: .appMarketList)
    }

    static func norway_Oslo() -> MarketLocation {
        let domain = MarketDomain.NO
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Oslo",
                       localizedName: "Oslo, NO",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 59.9139, longitude: 10.7522), source: .appMarketList),
                       source: .appMarketList)
    }

    static func finland_Helsinki() -> MarketLocation {
        let domain = MarketDomain.FI
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Helsinki",
                       localizedName: "Helsinki, FI",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 60.1695, longitude: 24.9354), source: .appMarketList),
                       source: .appMarketList)
    }

    static func belgium_Brussels() -> MarketLocation {
        let domain = MarketDomain.BE
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Brussels",
                       localizedName: "Brussels, BE",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 50.8503, longitude: 4.3517), source: .appMarketList),
                       source: .appMarketList)
    }

    static func czechRepublic_Prague() -> MarketLocation {
        let domain = MarketDomain.CZ
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Prague",
                       localizedName: "Prague, CZ",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 50.0755, longitude: 14.4378), source: .appMarketList),
                       source: .appMarketList)
    }

    static func sweden_Stockholm() -> MarketLocation {
        let domain = MarketDomain.SE
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Stockholm",
                       localizedName: "Stockholm, SE",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 59.3293, longitude: 18.0686), source: .appMarketList),
                       source: .appMarketList)
    }

    static func southAfrica_Johannesburg() -> MarketLocation {
        let domain = MarketDomain.ZA
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Johannesburg",
                       localizedName: "Johannesburg, ZA",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: -26.2041, longitude: 28.0473), source: .appMarketList),
                       source: .appMarketList)
    }

    static func spain_Madrid() -> MarketLocation {
        let domain = MarketDomain.ES
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Madrid",
                       localizedName: "Madrid, ES",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 40.4168, longitude: -3.7038), source: .appMarketList),
                       source: .appMarketList)
    }

    static func germany_Berlin() -> MarketLocation {
        let domain = MarketDomain.DE
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Berlin",
                       localizedName: "Berlin, DE",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 52.5200, longitude: 13.4050), source: .appMarketList),
                       source: .appMarketList)
    }

    static func uae_Dubai() -> MarketLocation {
        let domain = MarketDomain.AE
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Dubai",
                       localizedName: "Dubai, AE",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 25.276987, longitude: 55.296249), source: .appMarketList),
                       source: .appMarketList)
    }

    static func netherlands_Amsterdam() -> MarketLocation {
        let domain = MarketDomain.NL
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Amsterdam",
                       localizedName: "Amsterdam, NL",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 52.3676, longitude: 4.9041), source: .appMarketList),
                       source: .appMarketList)
    }

    static func switzerland_Zurich() -> MarketLocation {
        let domain = MarketDomain.CH
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Zurich",
                       localizedName: "Zurich, CH",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 47.3769, longitude: 8.5417), source: .appMarketList),
                       source: .appMarketList)
    }

    static func denmark_Copenhagen() -> MarketLocation {
        let domain = MarketDomain.DK
        return MarketLocation(domain: domain,
                       identifier: "",
                       name: "Copenhagen",
                       localizedName: "Copenhagen, DK",
                       dmaId: nil,
                       countryCode: domain.countryCode,
                       userLocation: UserLocation(location: CLLocation(latitude: 55.6761, longitude: 12.5683), source: .appMarketList),
                       source: .appMarketList)
    }
}
