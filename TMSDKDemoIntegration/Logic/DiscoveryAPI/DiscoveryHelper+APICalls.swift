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
        discoveryService?.eventSearch(criteria) { response in
            switch response {
            case .success(let results):
                DispatchQueue.main.async {
                    let searchResultsVC = DiscoveryHelper.searchResultsTableViewController()
                    searchResultsVC.title = "Event Search"
                    searchResultsVC.discoveryResponse = .eventSearch(results: results, criteria: criteria)
                    navigationController.pushViewController(searchResultsVC, animated: true)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DiscoveryHelper.present(title: "Event Search", error: error, onNavigationController: navigationController)
            }
        }
    }
    
    func venueSearch(_ text: String, onNavigationController navigationController: UINavigationController) {
        var criteria = DiscoveryVenueSearchCriteria()
        criteria.keywordsFilter = [text]
        discoveryService?.venueSearch(criteria) { response in
            switch response {
            case .success(let results):
                DispatchQueue.main.async {
                    let searchResultsVC = DiscoveryHelper.searchResultsTableViewController()
                    searchResultsVC.title = "Venue Search"
                    searchResultsVC.discoveryResponse = .venueSearch(results: results, criteria: criteria)
                    navigationController.pushViewController(searchResultsVC, animated: true)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DiscoveryHelper.present(title: "Venue Search", error: error, onNavigationController: navigationController)
            }
        }
    }
    
    func attractionSearch(_ text: String, onNavigationController navigationController: UINavigationController) {
        var criteria = DiscoveryAttractionSearchCriteria()
        criteria.keywordsFilter = [text]
        discoveryService?.attractionSearch(criteria) { response in
            switch response {
            case .success(let results):
                DispatchQueue.main.async {
                    let searchResultsVC = DiscoveryHelper.searchResultsTableViewController()
                    searchResultsVC.title = "Attraction Search"
                    searchResultsVC.discoveryResponse = .attractionSearch(results: results, criteria: criteria)
                    navigationController.pushViewController(searchResultsVC, animated: true)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DiscoveryHelper.present(title: "Attraction Search", error: error, onNavigationController: navigationController)
            }
        }
    }
    
    func classificationSearch(_ text: String, onNavigationController navigationController: UINavigationController) {
        var criteria = DiscoveryClassificationSearchCriteria()
        criteria.keywordsFilter = [text]
        discoveryService?.classificationSearch(criteria) { response in
            switch response {
            case .success(let results):
                DispatchQueue.main.async {
                    let searchResultsVC = DiscoveryHelper.searchResultsTableViewController()
                    searchResultsVC.title = "Classification Search"
                    searchResultsVC.discoveryResponse = .classificationSearch(results: results, criteria: criteria)
                    navigationController.pushViewController(searchResultsVC, animated: true)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DiscoveryHelper.present(title: "Classification Search", error: error, onNavigationController: navigationController)
            }
        }
    }
    
    // MARK: EVA Details
    func eventDetails(_ text: String, type: DetailsIdentifierType, onNavigationController navigationController: UINavigationController) {
        
        let finish = { (response: APIResponse<DiscoveryEvent>) in
            switch response {
            case .success(let results):
                DispatchQueue.main.async {
                    let dictionaryVC = DiscoveryHelper.dictionaryExplorerViewController()
                    dictionaryVC.title = "Event Details"
                    dictionaryVC.jsonDictionary = results.rawJSON
                    navigationController.pushViewController(dictionaryVC, animated: true)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DiscoveryHelper.present(title: "Event Details", error: error, onNavigationController: navigationController)
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
        
        let finish = { (response: APIResponse<DiscoveryVenue>) in
            switch response {
            case .success(let results):
                DispatchQueue.main.async {
                    let dictionaryVC = DiscoveryHelper.dictionaryExplorerViewController()
                    dictionaryVC.title = "Venue Details"
                    dictionaryVC.jsonDictionary = results.rawJSON
                    navigationController.pushViewController(dictionaryVC, animated: true)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DiscoveryHelper.present(title: "Venue Details", error: error, onNavigationController: navigationController)
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
        
        let finish = { (response: APIResponse<DiscoveryAttraction>) in
            switch response {
            case .success(let results):
                DispatchQueue.main.async {
                    let dictionaryVC = DiscoveryHelper.dictionaryExplorerViewController()
                    dictionaryVC.title = "Attraction Details"
                    dictionaryVC.jsonDictionary = results.rawJSON
                    navigationController.pushViewController(dictionaryVC, animated: true)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DiscoveryHelper.present(title: "Attraction Details", error: error, onNavigationController: navigationController)
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
        
        let finish = { (response: APIResponse<DiscoveryClassification>) in
            switch response {
            case .success(let results):
                DispatchQueue.main.async {
                    let dictionaryVC = DiscoveryHelper.dictionaryExplorerViewController()
                    dictionaryVC.title = "Attraction Details"
                    dictionaryVC.jsonDictionary = results.rawJSON
                    navigationController.pushViewController(dictionaryVC, animated: true)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DiscoveryHelper.present(title: "Classification Details", error: error, onNavigationController: navigationController)
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
    
    
    // MARK: Present Details
    
    private static func searchResultsTableViewController() -> SearchResultsTableViewController {
        return SearchResultsTableViewController(style: .plain)
    }
    
    private static func dictionaryExplorerViewController() -> DictionaryExplorerViewController {
        return DictionaryExplorerViewController()
    }
    
    // MARK: Present Errors
    
    private static func present(title: String, error: Error, onNavigationController navigationController: UINavigationController) {
        if let connectionError = error as? ConnectionError {
            let decodedErrorString: String
            
            switch connectionError {
            case .unknown:
                decodedErrorString = "Unknown Error: \(connectionError.localizedDescription)"
            case .responseCode(let statusCode):
                decodedErrorString = "HTTP Code: \(statusCode.rawValue)"
            case .unknownResponse(let statusCode):
                decodedErrorString = "Unknown HTTP Code: \(statusCode)"
            case .server(let serverError):
                decodedErrorString = "Server Error: \(serverError.localizedDescription)"
            case .requestCanceled:
                decodedErrorString = "Request Canceled"
            case .malformedBody:
                decodedErrorString = "Malformed Body"
            case .badObjectSerialization:
                decodedErrorString = "Bad Object Serialization"
            case .badJSONFormat(let reason):
                decodedErrorString = "Bad JSON Format: \(reason)"
            case .badXMLFormat(let reason):
                decodedErrorString = "Bad XML Format: \(reason)"
            case .badURLFormat:
                decodedErrorString = "Bad URL Format"
            case .badCriteria:
                decodedErrorString = "Bad Criteria"
            case .badConfiguration(let reason):
                decodedErrorString = "Bad Configuration: \(reason)"
            @unknown default:
                decodedErrorString = "@Unknown Default: \(connectionError.localizedDescription)"
            }
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: decodedErrorString, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                navigationController.topViewController?.present(alert, animated: true, completion: nil)
            }

        } else {
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                navigationController.topViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
}
