//
//  MainMenu+Actions.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import UIKit
import TicketmasterFoundation
import TicketmasterAuthentication

extension MainMenuViewController: MenuBuilderDataSourceDelegate {
    
    func menuBuilderDataSource(_: MenuBuilderDataSource, didAction action: MenuBuilderAction, forCell cell: MenuBuilderTableViewCell) {
        // try to determine which cell this is
        if let cellIdentifier = CellIdentifier(rawValue: cell.cellInfo.uniqueIdentifier) {
            print("\(cellIdentifier.rawValue): \(action.debugString)")
            switch cellIdentifier {
                
            case .apiKeyText:
                // ignore
                break
            
            case .apiKeyTextField:
                switch action {
                case .returnPressed(let value), .valueChanged(let value):
                    let oldConfig = ConfigurationManager.shared.currentConfiguration
                    if let apiKey = value, apiKey.count > 0 {
                        let newConfig = Configuration(apiKey: apiKey,
                                                      region: oldConfig.region,
                                                      displayName: oldConfig.displayName,
                                                      backgroundColor: oldConfig.backgroundColor,
                                                      textTheme: oldConfig.textTheme,
                                                      retailMarketDomain: oldConfig.retailMarketDomain)
                        ConfigurationManager.shared.currentConfiguration = newConfig
                    } else {
                        let newConfig = Configuration(apiKey: "<your apiKey>",
                                                      region: oldConfig.region,
                                                      displayName: oldConfig.displayName,
                                                      backgroundColor: oldConfig.backgroundColor,
                                                      textTheme: oldConfig.textTheme,
                                                      retailMarketDomain: oldConfig.retailMarketDomain)
                        ConfigurationManager.shared.currentConfiguration = newConfig
                    }
                    break
                default:
                    break
                }
                
            case .deploymentRegionText:
                // ignore
                break
                
            case .deploymentRegionSegmentedControl:
                switch action {
                case .valueChanged(let value):
                    let oldConfig = ConfigurationManager.shared.currentConfiguration
                    if let value = value,
                       let region = TMAuthentication.TMXDeploymentRegion(rawValue: value) {
                        let newConfig = Configuration(apiKey: oldConfig.apiKey,
                                                      region: region,
                                                      displayName: oldConfig.displayName,
                                                      backgroundColor: oldConfig.backgroundColor,
                                                      textTheme: oldConfig.textTheme,
                                                      retailMarketDomain: oldConfig.retailMarketDomain)
                        ConfigurationManager.shared.currentConfiguration = newConfig
                    }
                default:
                    break
                }
                
            case .marketDomainText:
                // ignore
                break
                
            case .marketDomainSegmentedControl:
                switch action {
                case .valueChanged(let value):
                    let oldConfig = ConfigurationManager.shared.currentConfiguration
                    if let value = value,
                       let market = MarketDomain(rawValue: value) {
                        let newConfig = Configuration(apiKey: oldConfig.apiKey,
                                                      region: oldConfig.region,
                                                      displayName: oldConfig.displayName,
                                                      backgroundColor: oldConfig.backgroundColor,
                                                      textTheme: oldConfig.textTheme,
                                                      retailMarketDomain: market)
                        ConfigurationManager.shared.currentConfiguration = newConfig
                    }
                default:
                    break
                }
                
            case .discoveryAPIMenu:
                verifyClientConfig { success in
                    if success {
                        ConfigurationManager.shared.configureDiscoveryAPIIfNeeded { success in
                            if success {
                                let vc = DiscoveryViewController(style: .grouped)
                                // weak store vc
                                ConfigurationManager.shared.discoveryHelper?.discoveryMenuVC = vc
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }
                
            case .prePurchaseMenu:
                verifyClientConfig { success in
                    if success {
                        ConfigurationManager.shared.configurePrePurchaseIfNeeded { success in
                            if success {
                                let vc = PrePurchaseViewController(style: .grouped)
                                // weak store vc
                                ConfigurationManager.shared.prePurchaseHelper?.prePurchaseMenuVC = vc
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }
                
            case .purchaseMenu:
                verifyClientConfig { success in
                    if success {
                        ConfigurationManager.shared.configurePurchaseIfNeeded { success in
                            if success {
                                let vc = PurchaseViewController(style: .grouped)
                                // weak store vc
                                ConfigurationManager.shared.purchaseHelper?.purchaseMenuVC = vc
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }
                
            case .ticketsMenu:
                verifyClientConfig { success in
                    if success {
                        ConfigurationManager.shared.configureTicketsIfNeeded { success in
                            if success {
                                let vc = TicketsViewController(style: .grouped)
                                // weak store vc
                                ConfigurationManager.shared.ticketsHelper?.ticketsMenuVC = vc
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }

            case .authenticationMenu:
                verifyClientConfig { success in
                    if success {
                        let vc = AuthenticationViewController(style: .grouped)
                        // weak store vc
                        ConfigurationManager.shared.authenticationHelper?.authenticationMenuVC = vc
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            case .currentUserText:
                // ignore
                break
            }
        }
    }
}



extension MainMenuViewController {
    
    func verifyClientConfig(completion: @escaping (_ success: Bool) ->  Void) {
        ConfigurationManager.shared.configureAuthenticationIfNeeded(completion: { success in
            if success == false {
                let vc = UIAlertController(title: "Error", message: "Enter a valid API Key", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                vc.addAction(action)
                self.present(vc, animated: true)
            }
            completion(success)
        })
    }
    
    func show(error: Error) {
        let vc = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        vc.addAction(action)
        present(vc, animated: true)
    }
}
