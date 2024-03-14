//
//  AuthenticationHelper+External.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 3/13/24.
//

import Foundation
import UIKit
import TicketmasterAuthentication

extension AuthenticationHelper {
    
    func loginWithExternalToken(onViewController viewController: UIViewController) {
        // present your own non-TM Login
        presentExternalLogin(onViewController: viewController) { jwtToken in
            // use jwt OpenID token to login to TM
            TMAuthentication.shared.login(externalToken: jwtToken) { authToken in
                // TM Login success!
                // this authToken has already been saved,
                // but it is provided here if you need it
                
                // you can configure and present Tickets or Purchase SDK now
                
            } aborted: { oldAuthToken, backend in
                // TM Login aborted by user
                // this happens if the user cancels the account binding login page
                
            } failure: { oldAuthToken, error, backend in
                // TM Login error
                // common errors:
                switch error as NSError {
                case TMAuthentication.AuthError.externalTokenExchangeDisabled:
                    // external token exchange is disabled in your Apigee Config
                    break
                case TMAuthentication.AuthError.externalTokenNotAllowed:
                    // external token provided has already expired and cannot be exchanged
                    break
                case TMAuthentication.AuthError.externalTokenInvalid:
                    // external token provided has an invalid format and cannot be exchanged
                    break
                case TMAuthentication.AuthError.externalTokenExpired:
                    // external token provided has already expired and cannot be exchanged
                    break
                case TMAuthentication.AuthError.externalTokenUserNotFound:
                    // external token provided has been bound by login, but user is still not found
                    break
                case TMAuthentication.AuthError.externalTokenAlreadyLoggedIn:
                    // External token login operation requires user to be logged out
                    //  If your intent was to refresh the external token, see TMAuthenticationExternalTokenProvider delegate protocol.
                    break
                default:
                    // some other networking or TM backend error
                    break
                }
            }

        } failure: { error in
            // your non-TM login failed!
            
        }
    }
        
    static let fakeUniqueID = "someCoolId721"
    static let fakeEmail = "jonbackertm@gmail.com"
    static let fakeError = NSError(domain: "AuthenticationHelper", code: -1)
    
    private func presentExternalLogin(onViewController viewController: UIViewController,
                              success: @escaping (_ jwtToken: String) -> Void,
                              failure: @escaping (_ error: Error) -> Void) {
        
        processExternalLogin(onViewController: viewController) { uniqueUserId, email in
            // get a JWT token
            self.getJWTToken(uniqueUserID: uniqueUserId,
                             email: email,
                             success: success,
                             failure: failure)
        } failure: { error in
            failure(error)
        }
    }
    
    private func processExternalLogin(onViewController viewController: UIViewController,
                                      success: @escaping (_ uniqueUserId: String, _ email: String) -> Void,
                                      failure: @escaping (_ error: Error) -> Void) {
        
        // TODO: replace this code with your login system getUserInfo here

        // FOR DEMO PURPOSES:
        // present a fake login UI using a UIAlertController
        let alert = UIAlertController(title: "Non-TM Login",
                                      message: "Allow User Login?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            // once login is completed, return uniqueUserId and email
            success(AuthenticationHelper.fakeUniqueID, AuthenticationHelper.fakeEmail)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
            // return error
            failure(AuthenticationHelper.fakeError)
        }))
        
        viewController.present(alert, animated: true)
    }
    
    private func getJWTToken(uniqueUserID: String, email: String,
                             success: @escaping (_ jwtToken: String) -> Void,
                             failure: @escaping (_ error: Error) -> Void) {
        var body: [String: Any] = [:]
        
        body["id"] = uniqueUserID
        body["email"] = email
        
        fetchJWTTokenFromNetwork(body: body,
                                 success: success,
                                 failure: failure)
    }
    
    private func getJWTToken(backend: TMAuthentication.BackendService,
                             oldJwtToken: String,
                             showLoginIfNeeded: Bool,
                             success: @escaping (_ jwtToken: String) -> Void,
                             aborted: @escaping () -> Void,
                             failure: @escaping (_ error: Error) -> Void) {
        
        // TODO: do you need to show Login UI in order to refresh the JWT?
        let yourLoginSystemNeedsToShowUI: Bool = false
        
        if yourLoginSystemNeedsToShowUI == true {
            if showLoginIfNeeded == true {
                // TODO: show your login UI first, before refreshing the JWT
                
            } else {
                // oh no, Ignite is in a state where it doesn't want login shown
                // just return this error
                failure(TMAuthentication.AuthError.externalTokenRefreshRequiresUI)
                return
            }
        } else {
            // no need to show your login UI
            // go ahead and try to refresh the JWT
        }
                
        // TODO: decide how to send oldJwtToken
        // we could parse these fields out of the oldJwtToken directly,
        // or send oldJwtToken to the backend to parse out directly (recommended),
        // or just remember these fields somewhere ourselves
        var body: [String: Any] = [:]
        body["old_jwt"] = oldJwtToken
        
        // FOR DEMO PURPOSES:
        body["id"] = AuthenticationHelper.fakeUniqueID
        body["email"] = AuthenticationHelper.fakeEmail

        self.fetchJWTTokenFromNetwork(body: body,
                                      success: success,
                                      failure: failure)
    }
    
    private func fetchJWTTokenFromNetwork(body: [String: Any],
                                          success: @escaping (_ jwtToken: String) -> Void,
                                          failure: @escaping (_ error: Error) -> Void) {
        
        // TODO: replace this code with your login system getJWT networking

        // THIS URL WON'T WORK OUTSIDE OF THE TM FIREWALL
        let apiKey = ConfigurationManager.shared.currentConfiguration.apiKey
        if let url = URL(string: "http://livenation-test.apigee.net/tmx-prod/v1/admin/token/generate?apikey=\(apiKey)") {
            var urlRequest = URLRequest(url: url)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            urlRequest.httpMethod = "POST"
            
            urlRequest.httpBody = Data(object: body, options: .sortedKeys)
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                // return response on main
                DispatchQueue.main.async {
                    // parse JWT string out of data
                    if let data = data, let string = String(data: data, encoding: .utf8) {
                        success(string)
                    } else if let error = error {
                        failure(error)
                    } else {
                        // unknown error
                        failure(AuthenticationHelper.fakeError)
                    }
                }
            }.resume()
        }
    }
}



// MARK: ExternalTokenProvider

// TODO: make sure to set TMAuthentication.shared.externalTokenProviderDelegate = self
extension AuthenticationHelper: TMAuthenticationExternalTokenProvider {
    
    func refresh(backend: TMAuthentication.BackendService,
                 oldExternalToken: String,
                 showLoginIfNeeded: Bool,
                 success: @escaping (String) -> Void,
                 aborted: @escaping () -> Void,
                 failure: @escaping (Error) -> Void) {
        // try to refresh JWT token
        getJWTToken(backend: backend,
                    oldJwtToken: oldExternalToken,
                    showLoginIfNeeded: showLoginIfNeeded,
                    success: success,
                    aborted: aborted,
                    failure: failure)
    }
    
}

