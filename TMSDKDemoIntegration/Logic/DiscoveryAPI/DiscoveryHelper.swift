//
//  DiscoveryHelper.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import TicketmasterDiscoveryAPI // for DiscoveryService and TMDiscoveryAPI

/// a class to wrap helpful methods
class DiscoveryHelper: NSObject {

    weak var discoveryMenuVC: DiscoveryViewController?

    var discoveryService: DiscoveryService?
            
    enum DetailsIdentifierType: String, CaseIterable {
        case discovery
        case legacyHost
        
        var keyName: String {
            switch self {
            case .discovery:
                return "Discovery"
            case .legacyHost:
                return "Legacy Host"
            }
        }
    }
}
