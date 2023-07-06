//
//  DictionaryExplorerViewController.swift
//  DiscoveryTestApp
//
//  Created by Jonathan Backer on 11/3/20.
//  Copyright © 2020 Ticketmaster. All rights reserved.
//

import UIKit
import TicketmasterFoundation

class DictionaryExplorerViewController: UIViewController {
    
    var jsonDictionary: JSONDictionary?

    private let dictionaryTextView = DictionaryExplorerTextView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var buttonItems: [UIBarButtonItem] = []
        
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
}
