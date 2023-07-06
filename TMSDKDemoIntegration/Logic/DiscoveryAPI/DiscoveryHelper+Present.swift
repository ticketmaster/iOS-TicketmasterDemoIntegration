//
//  DiscoveryHelper+Present.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterFoundation

extension DiscoveryHelper {
    
    // Discovery API does not contain any UI to present
    //  it only returns RESTful JSON from Ticketmaster's Discovery service.
    //
    // For the purposes of this demo app, the JSON is shown to the User using these methods
    //  but they are not part of Discovery API.
    
    // MARK: Present Details
    
    func searchResultsTableViewController() -> SearchResultsTableViewController {
        return SearchResultsTableViewController(style: .plain)
    }
    
    func dictionaryExplorerViewController() -> DictionaryExplorerViewController {
        return DictionaryExplorerViewController()
    }
    
    // MARK: Present Errors
    
    func present(title: String, error: Error, onNavigationController navigationController: UINavigationController) {
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
