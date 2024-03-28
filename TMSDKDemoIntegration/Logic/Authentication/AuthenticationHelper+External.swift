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
                let nsError = error as NSError
                switch nsError as NSError {
                case TMAuthentication.AuthError.externalTokenExchangeDisabled:
                    // external token exchange is disabled in your Apigee Config
                    break
                case TMAuthentication.AuthError.externalTokenProviderNil:
                    // external token needs to be refreshed, but your code did not set
                    // TMAuthentication.shared.externalTokenProviderDelegate = self
                    break
                case TMAuthentication.AuthError.externalTokenAlreadyLoggedIn:
                    // External token login operation requires user to be logged out
                    //  If your intent was to refresh the external token, see TMAuthenticationExternalTokenProvider delegate protocol.
                    break
                default:
                    // some other networking or TM backend error
                    // example backend error and values
                    if nsError.code == 400,
                       nsError.localizedDescription == "Invalid Request: Invalid Client Id token",
                       // the "errorCode" is the TMX correlationID, that we can use to help debug certain issues
                       nsError.userInfo["errorCode"] as? String == "psdk-ios_v3.2.5-541f9f5a-6c9a-48e2-9cc0-6ef443e6e241",
                       nsError.userInfo["responseCode"] as? Int == 400,
                       nsError.userInfo["errorType"] as? String == "Invalid Request",
                       nsError.userInfo["message"] as? String == "Invalid Client Id token" {
                        // the jwt token was minted incorrectly
                        // maybe the format is wrong? or the client secret it wrong?
                    }
                }
            }

        } failure: { error in
            // your non-TM login failed!
        
        }
    }
            
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
                                      message: "Select Login:",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "User1", style: .default, handler: { _ in
            // once login is completed, return uniqueUserId and email
            success(AuthenticationHelper.fakeUniqueID, AuthenticationHelper.fakeEmail)
        }))
//        alert.addAction(UIAlertAction(title: "Bill Smith", style: .default, handler: { _ in
//            // once login is completed, return uniqueUserId and email
//            success("uniqueUserIdForBillSmith", "bill@smith.com")
//        }))
        alert.addAction(UIAlertAction(title: "None", style: .cancel, handler: { _ in
            // return error
            failure(AuthenticationHelper.fakeError)
        }))
        
        viewController.present(alert, animated: true)
    }
    
    static let fakeUniqueID = "someCoolId"
    static let fakeEmail = "name@email.com"
    static let fakeError = NSError(domain: "AuthenticationHelper", code: -1)
    
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
    
    private func getJWTToken(oldJwtToken: String,
                             success: @escaping (_ jwtToken: String) -> Void,
                             failure: @escaping (_ error: Error) -> Void) {
                
        // TODO: decide how to send oldJwtToken
        // we could parse these fields out of the oldJwtToken directly,
        // or send oldJwtToken to the backend to parse out directly (recommended),
        // or just remember these fields somewhere ourselves
        var body: [String: Any] = [:]
        body["old_jwt"] = oldJwtToken
        
        // TODO: replace this logic with your real refreshLogic
        // FOR DEMO PURPOSES:
        body["id"] = AuthenticationHelper.fakeUniqueID
        body["email"] = AuthenticationHelper.fakeEmail
        
        // present a UI asking for permission to fresh
        let alert = UIAlertController(title: "Auth SDK",
                                      message: "Asking for fresh jwt:",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Allow", style: .default, handler: { _ in
            self.fetchJWTTokenFromNetwork(body: body,
                                          success: success,
                                          failure: failure)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            // return error
            failure(AuthenticationHelper.fakeError)
        }))
        
        self.authenticationMenuVC?.present(alert, animated: true)
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
            
            print("\(url.absoluteString)")
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                // return response on main
                DispatchQueue.main.async {
                    // parse JWT string out of data
                    if let data = data, let string = String(data: data, encoding: .utf8) {
                        print(" - success: \(string)")
                        success(string)
                    } else if let error = error {
                        print(" - error: \(error.localizedDescription)")
                        failure(error)
                    } else {
                        // unknown error
                        print(" - error: <unknown>")
                        failure(AuthenticationHelper.fakeError)
                    }
                }
            }.resume()
        }
    }
    
    func showYourNonTMLogin(success: @escaping () -> Void,
                            aborted: @escaping () -> Void,
                            failure: @escaping (_ error: Error) -> Void) {
        // TODO: show your login UI here
        success()
    }
    
    func systemNeedsReLogin() -> Bool {
        // TODO: determine if you need to show Login UI in order to refresh the JWT?
        false
    }
}



// MARK: ExternalTokenProvider

// TODO: make sure to set TMAuthentication.shared.externalTokenProviderDelegate = self
extension AuthenticationHelper: TMAuthenticationExternalTokenProvider {
    
    /// - Task: return fresh External Token
    ///
    /// assign on ``TMAuthentication/externalTokenProviderDelegate``
    ///
    ///  - Important: `showLoginIfNeeded = false` is used to try and refresh an external token without presenting any UI. This is important for certain networking calls and UI states where returning an error is actually preferrable to presenting UI that could break design flows or cause issues. The error returned should be ``TMAuthentication/AuthError/externalTokenRefreshRequiresUI``.
    ///
    /// - Parameters:
    ///   - backend: specific ``TMAuthentication/BackendService`` that needs a fresh external token (``TMAuthentication/BackendService/TeamModernAccounts`` may also be used for ``TMAuthentication/BackendService/HostModernAccounts``)
    ///   - oldExternalToken: previous, old external token that has expired
    ///   - showLoginIfNeeded: `true` = show user login/refresh UI if needed, `false` = do not show login/refresh UI, return ``TMAuthentication/AuthError/externalTokenRefreshRequiresUI`` error in the `failure` block if external token cannot be refreshed without presenting login UI to the user
    ///   - success: refresh success block
    ///     - refreshedExternalToken: a fresh external token, must match same backend and user account as provided `oldExternalToken`
    ///   - aborted: user aborted refresh block, call if login/refresh UI was presented to the user and the user aborted the login/refresh process
    ///   - failure: refresh failure block
    ///     - error: refresh/login error
    func refresh(backend: TMAuthentication.BackendService,
                 oldExternalToken: String,
                 showLoginIfNeeded: Bool,
                 success: @escaping (String) -> Void,
                 aborted: @escaping () -> Void,
                 failure: @escaping (Error) -> Void) {
        // determine if you need to show your Login UI in order to refresh the JWT?
        let yourLoginSystemNeedsToShowUI: Bool = systemNeedsReLogin()
        
        if yourLoginSystemNeedsToShowUI {
            // is it a good time to show login UI?
            if showLoginIfNeeded {
                // yes! show your login UI first, before refreshing the JWT
                showYourNonTMLogin {
                    // success! user re-logged into your UI
                    self.getJWTToken(oldJwtToken: oldExternalToken,
                                     success: success,
                                     failure: failure)
                } aborted: {
                    // user aborted your login UI
                    aborted()
                } failure: { error in
                    // error from your login UI
                    failure(error)
                }
            } else {
                // no! Ignite is in a state where it doesn't want login shown
                // just return this error
                failure(TMAuthentication.AuthError.externalTokenRefreshRequiresUI)
            }
        } else {
            // no need to show your login UI
            // go ahead and try to refresh the JWT
            getJWTToken(oldJwtToken: oldExternalToken,
                        success: success,
                        failure: failure)
        }
    }
}
