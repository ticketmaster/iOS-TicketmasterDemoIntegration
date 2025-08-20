//
//  DiscoveryHelper+APICalls.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterFoundation
import TicketmasterDiscoveryAPI

// MARK: Service Calls -
extension DiscoveryHelper {
    
    // MARK: EVA Search
    
    func eventSearch(_ text: String, onNavigationController navigationController: UINavigationController) {
        var criteria = DiscoveryEventSearchCriteria()
        criteria.keywordsFilter = [text]
        
        discoveryService?.eventSearch(criteria) { [weak self] response in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                
                switch response {
                case .success(let results):
                    let searchResultsVC = strongSelf.searchResultsTableViewController()
                    searchResultsVC.title = "Event Search"
                    searchResultsVC.discoveryResponse = .eventSearch(results: results, criteria: criteria)
                    navigationController.pushViewController(searchResultsVC, animated: true)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    strongSelf.present(title: "Event Search", error: error, onNavigationController: navigationController)
                }
            }
        }
    }
    
    func venueSearch(_ text: String, onNavigationController navigationController: UINavigationController) {
        var criteria = DiscoveryVenueSearchCriteria()
        criteria.keywordsFilter = [text]
        
        discoveryService?.venueSearch(criteria) { [weak self] response in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }

                switch response {
                case .success(let results):
                    let searchResultsVC = strongSelf.searchResultsTableViewController()
                    searchResultsVC.title = "Venue Search"
                    searchResultsVC.discoveryResponse = .venueSearch(results: results, criteria: criteria)
                    navigationController.pushViewController(searchResultsVC, animated: true)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    strongSelf.present(title: "Venue Search", error: error, onNavigationController: navigationController)
                }
            }
        }
    }
    
    func attractionSearch(_ text: String, onNavigationController navigationController: UINavigationController) {
        var criteria = DiscoveryAttractionSearchCriteria()
        criteria.keywordsFilter = [text]
        
        discoveryService?.attractionSearch(criteria) { [weak self] response in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }

                switch response {
                case .success(let results):
                    let searchResultsVC = strongSelf.searchResultsTableViewController()
                    searchResultsVC.title = "Attraction Search"
                    searchResultsVC.discoveryResponse = .attractionSearch(results: results, criteria: criteria)
                    navigationController.pushViewController(searchResultsVC, animated: true)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    strongSelf.present(title: "Attraction Search", error: error, onNavigationController: navigationController)
                }
            }
        }
    }
    
    func classificationSearch(_ text: String, onNavigationController navigationController: UINavigationController) {
        var criteria = DiscoveryClassificationSearchCriteria()
        criteria.keywordsFilter = [text]
        
        discoveryService?.classificationSearch(criteria) { [weak self] response in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                
                switch response {
                case .success(let results):
                    let searchResultsVC = strongSelf.searchResultsTableViewController()
                    searchResultsVC.title = "Classification Search"
                    searchResultsVC.discoveryResponse = .classificationSearch(results: results, criteria: criteria)
                    navigationController.pushViewController(searchResultsVC, animated: true)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    strongSelf.present(title: "Classification Search", error: error, onNavigationController: navigationController)
                }
            }
        }
    }
    
    // MARK: EVA Details
    func eventDetails(_ text: String, type: DetailsIdentifierType, onNavigationController navigationController: UINavigationController) {
        
        let finish = { [weak self] (response: NetworkService.APIResponse<DiscoveryEvent>) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                
                switch response {
                case .success(let results):
                    let dictionaryVC = strongSelf.dictionaryExplorerViewController()
                    dictionaryVC.title = "Event Details"
                    dictionaryVC.jsonDictionary = results.rawJSON
                    navigationController.pushViewController(dictionaryVC, animated: true)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    strongSelf.present(title: "Event Details", error: error, onNavigationController: navigationController)
                }
            }
        }
        
        switch type {
        case .discovery:
            let criteria = DiscoveryIdentifier(rawValue: text)
            discoveryService?.eventDetails(criteria, completion: { response in
                finish(response)
            })
        case .legacyHost:
            let criteria = LegacyHostIdentifier(rawValue: text)
            discoveryService?.eventDetails(criteria, completion: { response in
                finish(response)
            })
        }
    }
    
    func venueDetails(_ text: String, type: DetailsIdentifierType, onNavigationController navigationController: UINavigationController) {
        
        let finish = { [weak self] (response: NetworkService.APIResponse<DiscoveryVenue>) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                
                switch response {
                case .success(let results):
                    let dictionaryVC = strongSelf.dictionaryExplorerViewController()
                    dictionaryVC.title = "Venue Details"
                    dictionaryVC.jsonDictionary = results.rawJSON
                    navigationController.pushViewController(dictionaryVC, animated: true)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    strongSelf.present(title: "Venue Details", error: error, onNavigationController: navigationController)
                }
            }
        }
        
        switch type {
        case .discovery:
            let criteria = DiscoveryIdentifier(text)
            discoveryService?.venueDetails(criteria) { response in
                finish(response)
            }
        case .legacyHost:
            let criteria = LegacyHostIdentifier(text)
            discoveryService?.venueDetails(criteria) { response in
                finish(response)
            }
        }
    }
    
    func attractionDetails(_ text: String, type: DetailsIdentifierType, onNavigationController navigationController: UINavigationController) {
        
        let finish = { [weak self] (response: NetworkService.APIResponse<DiscoveryAttraction>) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }

                switch response {
                case .success(let results):
                    let dictionaryVC = strongSelf.dictionaryExplorerViewController()
                    dictionaryVC.title = "Attraction Details"
                    dictionaryVC.jsonDictionary = results.rawJSON
                    navigationController.pushViewController(dictionaryVC, animated: true)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    strongSelf.present(title: "Attraction Details", error: error, onNavigationController: navigationController)
                }
            }
        }
        
        switch type {
        case .discovery:
            let criteria = DiscoveryIdentifier(text)
            discoveryService?.attractionDetails(criteria) { response in
                finish(response)
            }
        case .legacyHost:
            let criteria = LegacyHostIdentifier(text)
            discoveryService?.attractionDetails(criteria) { response in
                finish(response)
            }
        }
    }
    
    func classificationDetails(_ text: String, type: DetailsIdentifierType, onNavigationController navigationController: UINavigationController) {
        
        let finish = { [weak self] (response: NetworkService.APIResponse<DiscoveryClassification>) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }

                switch response {
                case .success(let results):
                    let dictionaryVC = strongSelf.dictionaryExplorerViewController()
                    dictionaryVC.title = "Classification Details"
                    dictionaryVC.jsonDictionary = results.rawJSON
                    navigationController.pushViewController(dictionaryVC, animated: true)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    strongSelf.present(title: "Classification Details", error: error, onNavigationController: navigationController)
                }
            }
        }
        
        switch type {
        case .discovery:
            let criteria = DiscoveryIdentifier(text)
            discoveryService?.classificationDetails(criteria) { response in
                finish(response)
            }
        case .legacyHost:
            // only type allowed is Discovery (classifications don't exist in Legacy Host)
            let criteria = DiscoveryIdentifier(text)
            discoveryService?.classificationDetails(criteria) { response in
                finish(response)
            }
        }
    }
    
    func lookupNextHostEvent(hostEventId: String, completion: @escaping (_ event: DiscoveryEvent?) -> Void) {
        // look up host event details
        discoveryService?.eventDetails(hostEventId) { [weak self] response1 in
            switch response1 {
            case .success(let discoveryEvent):
                guard let homeTeam = discoveryEvent.attractionArray.first else {
                    completion(nil)
                    return
                }
                
                guard let venue = discoveryEvent.venueArray.first else {
                    completion(nil)
                    return
                }
                
                var critiera = DiscoveryEventSearchCriteria()
                critiera.attractionIdentifiers = [homeTeam.attractionIdentifier]
                critiera.venueIdentifiers = [venue.venueIdentifier]
                critiera.sortMethod = .dateAscending
                critiera.includeTBAEvents = false
                critiera.includeTBDEvents = false
                critiera.includeTestEvents = false
                
                self?.discoveryService?.eventSearch(critiera) { response2 in
                    switch response2 {
                    case .success(let eventsPage):
                        // is this the source event?
                        for event in eventsPage.data where event.legacyEventIdentifier?.rawValue != hostEventId {
                            // no, this is a different event
                            
                            // this may be a multiple day event
                            for date in event.startDates {
                                // is that event later than now?
                                if date > Date() {
                                    // yes! this event is in the future
                                    completion(event)
                                    return
                                } else {
                                    // no, the day of this event has passed
                                }
                            }
                            // this event has no dates or has already passed
                            
                        }
                        completion(nil)
                    case .failure:
                        completion(nil)
                    }
                }
            case .failure:
                completion(nil)
            }
        }
    }
    
    func loadImageForEvent(discoveryEvent: DiscoveryEvent, completion: @escaping (_ image: UIImage?) -> Void) {
        // we want only 16x9 that is smaller than our screen
        let filteredImageMetadataArray = discoveryEvent.imageMetadataArray.filter({ $0.ratio == .ratio16x9 && CGFloat($0.width) >= UIScreen.main.bounds.width })

        guard var smallestImageMetadata = filteredImageMetadataArray.first else {
            // no image
            completion(nil)
            return
        }
        
        // we want the smallest image available
        for imageMetaData in filteredImageMetadataArray where imageMetaData.width < smallestImageMetadata.width {
            smallestImageMetadata = imageMetaData
        }
        
        let urlRequest = URLRequest(url: smallestImageMetadata.url)
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                // need to be on main thread
                let image = UIImage(data: data)
                completion(image)
            }
        }.resume()
    }
}
