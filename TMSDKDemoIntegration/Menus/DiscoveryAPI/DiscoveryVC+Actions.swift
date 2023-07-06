//
//  DiscoveryVC+Actions.swift
//  RetailDevApp
//
//  Created by Jonathan Backer on 6/21/23.
//

import Foundation
import TicketmasterFoundation
import TicketmasterDiscoveryAPI

extension DiscoveryViewController: MenuBuilderDataSourceDelegate {
    
    func menuBuilderDataSource(_: MenuBuilderDataSource, didAction action: MenuBuilderAction, forCell cell: MenuBuilderTableViewCell) {
        
        guard let discoveryHelper = ConfigurationManager.shared.discoveryHelper else { return }
        
        // try to determine which cell this is
        if let cellIdentifier = CellIdentifier(rawValue: cell.cellInfo.uniqueIdentifier) {
            print("\(cellIdentifier.rawValue): \(action.debugString)")
            switch cellIdentifier {
            case .settingsLanguageTitle:
                // ignore
                break
            case .settingsLanguage:
                switch action {
                case .valueChanged(let value):
                    if let value = value, let language = DiscoveryLocale(rawValue: value.lowercased()) {
                        ConfigurationManager.shared.discoveryHelper?.discoveryService?.override_locale = language.rawValue
                        selectedLanguage = language
                        buildRefreshMenu()
                    }
                default:
                    break
                }
            case .settingsIdentifierTitle:
                // ignore
                break
            case .settingsIdentifier:
                switch action {
                case .valueChanged(let value):
                    if let value = value {
                        if value == DiscoveryHelper.DetailsIdentifierType.discovery.keyName {
                            selectedIdentifierType = .discovery
                        } else if value == DiscoveryHelper.DetailsIdentifierType.legacyHost.keyName {
                            selectedIdentifierType = .legacyHost
                        }
                        buildRefreshMenu()
                    }
                default:
                    break
                }
                
            case .searchEvent:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    guard let value = value, value.count > 0 else { return }
                    discoveryHelper.eventSearch(value, onNavigationController: navigationController!)
                default:
                    break
                }
            case .searchVenue:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    guard let value = value, value.count > 0 else { return }
                    discoveryHelper.venueSearch(value, onNavigationController: navigationController!)
                default:
                    break
                }
            case .searchAttraction:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    guard let value = value, value.count > 0 else { return }
                    discoveryHelper.attractionSearch(value, onNavigationController: navigationController!)
                default:
                    break
                }
            case .searchClassification:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    guard let value = value, value.count > 0 else { return }
                    discoveryHelper.classificationSearch(value, onNavigationController: navigationController!)
                default:
                    break
                }
                
            case .detailsEvent:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    guard let value = value, value.count > 0 else { return }
                    discoveryHelper.eventDetails(value, type: selectedIdentifierType, onNavigationController: navigationController!)
                default:
                    break
                }
            case .detailsVenue:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    guard let value = value, value.count > 0 else { return }
                    discoveryHelper.venueDetails(value, type: selectedIdentifierType, onNavigationController: navigationController!)
                default:
                    break
                }
            case .detailsAttraction:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    guard let value = value, value.count > 0 else { return }
                    discoveryHelper.attractionDetails(value, type: selectedIdentifierType, onNavigationController: navigationController!)
                default:
                    break
                }
            case .detailsClassification:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    guard let value = value, value.count > 0 else { return }
                    discoveryHelper.classificationDetails(value, type: selectedIdentifierType, onNavigationController: navigationController!)
                default:
                    break
                }
            }
        }
    }
}
