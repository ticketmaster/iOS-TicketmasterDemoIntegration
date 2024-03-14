//
//  AuthenticationVC+Actions.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import UIKit
import TicketmasterAuthentication

extension AuthenticationViewController: MenuBuilderDataSourceDelegate {
    
    func menuBuilderDataSource(_: MenuBuilderDataSource, didAction action: MenuBuilderAction, forCell cell: MenuBuilderTableViewCell) {
        
        guard let authenticationHelper = ConfigurationManager.shared.authenticationHelper else { return }
        
        // try to determine which cell this is
        if let cellIdentifier = CellIdentifier(rawValue: cell.cellInfo.uniqueIdentifier) {
            print("\(cellIdentifier.rawValue): \(action.debugString)")
            switch cellIdentifier {
            case .currentUserText:
                // ignore
                break
                
            case .login:
                // login using external jwt token
                authenticationHelper.loginWithExternalToken(onViewController: self)
                
            case .loginExternal:
                break
                
            case .validToken:
                authenticationHelper.validToken { validToken, error in
                    if let validToken = validToken {
                        self.presentPopup(title: "Valid Token", message: "\(validToken.accessToken.prefix(20))...")
                    } else {
                        self.presentPopup(title: "No Token", message: error?.localizedDescription ?? "<unknown error>")
                    }
                }
                
            case .memberInfo:
                authenticationHelper.memberInfo { memberInfo, error in
                    if let memberInfo = memberInfo {
                        self.presentPopup(title: "Member Info", message: "\(memberInfo.email ?? memberInfo.localID ?? memberInfo.globalID ?? "<nil>")")
                    } else {
                        self.presentPopup(title: "Member Info", message: error?.localizedDescription ?? "<unknown error>")
                    }
                }
                
            case .logout:
                authenticationHelper.logout()
            }
        }
    }
}

extension AuthenticationViewController {
    
    func presentPopup(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
