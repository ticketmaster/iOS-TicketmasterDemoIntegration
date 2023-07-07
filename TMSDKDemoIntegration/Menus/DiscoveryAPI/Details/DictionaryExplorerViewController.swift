//
//  DictionaryExplorerViewController.swift
//  DiscoveryTestApp
//
//  Created by Jonathan Backer on 11/3/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit
import TicketmasterFoundation
import TicketmasterPrePurchase

class DictionaryExplorerViewController: UIViewController {
    
    var jsonDictionary: JSONDictionary?

    private let dictionaryTextView = DictionaryExplorerTextView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var buttonItems: [UIBarButtonItem] = []
        
        let goButton = UIBarButtonItem(barButtonSystemItem: .play,
                                       target: self,
                                       action: #selector(goButtonTapped))
        buttonItems.append(goButton)
        
        let clearButton = UIBarButtonItem(barButtonSystemItem: .refresh,
                                          target: self,
                                          action: #selector(clearButtonTapped))
        buttonItems.append(clearButton)
        
        navigationItem.setRightBarButtonItems(buttonItems, animated: false)
    }
    
    private var didSetup: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if didSetup == false {
            didSetup = true
            
            dictionaryTextView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(dictionaryTextView)
            dictionaryTextView.constrainToEdgesOfSuperview()
            view.setNeedsUpdateConstraints()
            
            if let jsonDictionary = jsonDictionary {
                dictionaryTextView.setup(withDictionary: jsonDictionary)
            }
        }
    }
    
    @objc func clearButtonTapped(_ sender: Any) {
        dictionaryTextView.closeAllOpenPaths()
    }
    
    @objc func goButtonTapped(_ sender: Any) {
        guard let identifier = jsonDictionary?.stringNonEmpty("id") else { return }
        
        guard let type = jsonDictionary?.stringNonEmpty("type") else { return }
        
        var prePurchasePage: TMPrePurchaseViewController.PrePurchasePage?
        var purchaseEventID: String?
                
        switch type {
        case "event":
            purchaseEventID = identifier
        case "venue":
            prePurchasePage = .venue(identifier: identifier)
        case "attraction":
            prePurchasePage = .attraction(identifier: identifier)
        default:
            // some unknown type, maybe classification?
            break
        }
        
        if let eventID = purchaseEventID {
            ConfigurationManager.shared.configurePurchaseIfNeeded { success in
                if success {
                    ConfigurationManager.shared.purchaseHelper?.presentPurchase(eventID: eventID, onViewController: self)
                }
            }
            
        } else if let page = prePurchasePage {
            ConfigurationManager.shared.configurePrePurchaseIfNeeded { success in
                if success {
                    ConfigurationManager.shared.prePurchaseHelper?.presentPrePurchase(page: page, onViewController: self)
                }
            }
        }
    }
}
