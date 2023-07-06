//
//  BrandedNavigationController.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import UIKit

class BrandedNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        let configuration = ConfigurationManager.shared.currentConfiguration
        switch configuration.textTheme {
        case .light:
            return .lightContent
        case .dark:
            return .darkContent
        }
    }
}
