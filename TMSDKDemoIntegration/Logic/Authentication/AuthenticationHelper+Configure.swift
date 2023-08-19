//
//  AuthenticationHelper+Configure.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import TicketmasterAuthentication // for TMAuthentication

extension AuthenticationHelper {
    
    func configure(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        guard configuration.apiKey != ConfigurationManager.badAPIKey else {
            fatalError("Set your apiKey in Configuration.swift")
        }
        
        // set delegates (optional)
        TMAuthentication.shared.delegate = self // be informed about Login state via delegate callbacks:
        
        // note that you can also register for a block to be called on Login state change
        //
        //        TMAuthentication.shared.registerStateChanged { backend, state, error in
        //            if let error = error {
        //                print("\(backend.description): \(state.rawValue): \(error.localizedDescription)")
        //            } else {
        //                print("\(backend.description): \(state.rawValue)")
        //            }
        //        }
        
        // note that you can also listen for notifications on Login state change:
        //
        //        NotificationCenter.default.addObserver(self,
        //                                               selector: #selector(loginCompleted),
        //                                               name: TMAuthentication.AuthNotification.loginCompleted,
        //                                               object: nil)
        
        // this shortcuts the user having to login twice for Host and Archtics accounts
        //
        // Best for: Apps that only use a SINGLE API key
        TMAuthentication.shared.useCombinedLogin = true

        // user has to login to each account separately, but avoids bugs when using multiple API keys
        //
        // Best for: Apps that use MULTIPLE API keys (user can switch between team/venue API keys)
        //TMAuthentication.shared.useCombinedLogin = false

        // build a combination of Settings and Branding
        let tmxServiceSettings = TMAuthentication.TMXSettings(apiKey: configuration.apiKey,
                                                              region: configuration.region)
        
        let branding = TMAuthentication.Branding(displayName: configuration.displayName,
                                                 backgroundColor: configuration.backgroundColor,
                                                 theme: configuration.textTheme)
        
        let brandedServiceSettings = TMAuthentication.BrandedServiceSettings(tmxSettings: tmxServiceSettings,
                                                                             branding: branding)
        
        // configure TMAuthentication with Settings and Branding
        print("Authentication Configuring...")
        TMAuthentication.shared.configure(brandedServiceSettings: brandedServiceSettings) { backendsConfigured in
            // your API key may contain configurations for multiple backend services
            // the details are not needed for most common use-cases
            print(" - Authentication Configured: \(backendsConfigured.count)")
            completion(true)

        } failure: { error in
            // something went wrong, probably the wrong apiKey+region combination
            print(" - Authentication Configuration Error: \(error.localizedDescription)")
            completion(false)
        }
    }
}
