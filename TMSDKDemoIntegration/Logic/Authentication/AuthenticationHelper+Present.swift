//
//  AuthenticationHelper+Present.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import UIKit
import TicketmasterAuthentication

extension AuthenticationHelper {
    
    func loginIfNeeded(onViewController viewController: UIViewController) {
        // build a login page
        if let vc = TMAuthentication.shared.loginSelectionPage() {
            // present login page
            viewController.navigationController?.pushViewController(vc, animated: true)
            // use the authDelegate to know when login is completed
            //  or authNotifcations or registered state block
        } else {
            // if authentication is not configured, loginSelectionPage() will not return a vc
        }
    }
    
    func validToken(forceRefresh: Bool, completion: @escaping (_ validToken: TMAuthToken?, _ error: Error?) -> Void) {
        // do not automatically login, we're just checking if we have a valid token
        TMAuthentication.shared.validToken(backend: nil,
                                           showLoginIfNeeded: false,
                                           fetchRule: forceRefresh ? .forceFetch : .fetchIfEmptyOrOld) { authToken in
            completion(authToken, nil)
            
        } aborted: { oldAuthToken, backend in
            // since we aren't displaying login, user cannot abort
            // so this case should never happen
            completion(oldAuthToken, nil)
            
        } failure: { oldAuthToken, error, backend in
            // we could have a network error AND a cached AuthToken
            completion(oldAuthToken, error)
        }
    }
    
    func memberInfo(completion: @escaping (_ memberInfo: TMMemberInfo?, _ error: Error?) -> Void) {
        // fetch member info
        TMAuthentication.shared.memberInfo { memberInfo in
            completion(memberInfo, nil)
        } failure: { oldMemberInfo, error, backend in
            // we could have a network error AND a cached MemberInfo
            completion(oldMemberInfo, error)
        }
    }
    
    func logout() {
        // logout of ALL backends
        TMAuthentication.shared.logout { backends in
            // all done
            // you can also use the authDelegate to know when logout is completed
            //  or authNotifcations or registered state block
        }
    }
}
