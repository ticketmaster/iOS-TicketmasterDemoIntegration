//
//  EventConfigurationManager.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import Foundation
import TicketmasterFoundation

class EventConfigurationManager: NSObject {
    
    static let shared = EventConfigurationManager()
    
    private(set) var configurations: [EventConfiguration] = []
    
    override init() {
        super.init()
        
        populateConfigsFromPlist()
    }
}

extension EventConfigurationManager {
    func configuration(name: String) -> EventConfiguration? {
        if let config = configurations.filter({ $0.name  == name  }).first {
            return config
        } else if let config = configurations.filter({ $0.identifier == name }).first {
            return config
        }
        return nil
    }
}



fileprivate extension EventConfigurationManager {

    func populateConfigsFromPlist() {
        guard let path = Bundle.main.path(forResource: "Events", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else { return }

        configurations = parse(jsonDict: dict)
    }
    
    private func parse(jsonDict: JSONDictionary) -> [EventConfiguration] {
        var output: [EventConfiguration] = []
        
        for key in jsonDict.keys {
            if let dict = jsonDict.dictionaryNonEmpty(key),
               let identifier = dict.stringNonEmpty("identifier") {
                
                let config = EventConfiguration(identifier: identifier,
                                                name: key)
                output.append(config)
            }
        }
        
        return output.sorted()
    }
}
