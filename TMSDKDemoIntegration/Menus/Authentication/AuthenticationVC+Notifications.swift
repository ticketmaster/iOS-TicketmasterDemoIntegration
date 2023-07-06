//
//  AuthenticationVC+Notifications.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import TicketmasterAuthentication

extension AuthenticationViewController {
    
    func registerForAuthNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stateChanged),
                                               name: TMAuthentication.AuthNotification.loginCompleted, object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stateChanged),
                                               name: TMAuthentication.AuthNotification.logoutCompleted, object: nil)
    }
    
    func deregisterForAuthNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: TMAuthentication.AuthNotification.loginCompleted,
                                                  object: nil)

        NotificationCenter.default.removeObserver(self,
                                                  name: TMAuthentication.AuthNotification.logoutCompleted,
                                                  object: nil)
    }
    
    @objc func stateChanged(_ notification: Notification) {
        buildRefreshMenu()
    }
}
