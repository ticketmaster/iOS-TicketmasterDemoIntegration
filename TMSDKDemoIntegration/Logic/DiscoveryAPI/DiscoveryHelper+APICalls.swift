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
        
        let finish = { [weak self] (response: APIResponse<DiscoveryEvent>) in
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
        
        let finish = { [weak self] (response: APIResponse<DiscoveryVenue>) in
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
        
        let finish = { [weak self] (response: APIResponse<DiscoveryAttraction>) in
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
        
        let finish = { [weak self] (response: APIResponse<DiscoveryClassification>) in
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
}
