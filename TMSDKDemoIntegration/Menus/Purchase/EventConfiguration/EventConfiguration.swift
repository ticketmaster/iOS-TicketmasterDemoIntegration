//
//  EventConfiguration.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import Foundation
import TicketmasterFoundation

struct EventConfiguration: Codable, Hashable, Comparable {
    
    let identifier: String

    let name: String
        
    init(identifier: String, name: String? = nil) {
        self.identifier = identifier
        self.name = name ?? identifier
    }
    
    static func < (lhs: EventConfiguration, rhs: EventConfiguration) -> Bool {
        return lhs.name < rhs.name
    }
}
