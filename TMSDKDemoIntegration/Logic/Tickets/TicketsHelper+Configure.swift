//
//  TicketsHelper+Configure.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import TicketmasterTickets // for TMTickets

extension TicketsHelper {
    
    func configure(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        guard configuration.apiKey != ConfigurationManager.badAPIKey else {
            fatalError("Set your apiKey in Configuration.swift")
        }
        
        // make sure to configure Authentication first
        ConfigurationManager.shared.configureAuthenticationIfNeeded { success in
            if success {
                // then configure Tickets
                self.configureTickets(configuration: configuration, completion: completion)
            } else {
                completion(false)
            }
        }
    }
    
    private func configureTickets(configuration: Configuration, completion: @escaping (_ success: Bool) -> Void) {
        
        // set navBar button (optional)
        TMTickets.shared.navBarButtonTitle = "Help"
        
        // set delegates (optional)
        TMTickets.shared.orderDelegate = self // be informed about Tickets state
        TMTickets.shared.analyticsDelegate = self // be informed about User behavior
        TMTickets.shared.moduleDelegate = self // add prebuilt and customized modules to Tickets screen
        
        // TMTickets inherits it's configuration from TMAuthentication,
        //  so make sure to configure Authentication first
        print("Tickets Configuring...")
        TMTickets.shared.configure {
            // Tickets is configured, now we are ready to present TMTicketsViewController or TMTicketsView
            print(" - Tickets Configured")
            
            // set additional branding?
            // by default, Tickets SDK inherits basic branding from TMAuthentication
            // this is part of the TMTickets.shared.configure call
            // however Tickets SDK has additional advanced branding that you may optionally use:
            //
            // set AFTER TMTickets.shared.configure:
            
//            let branding = TMTickets.BrandingColors(navBarColor: .red,
//                                                    buttonColor: .orange,
//                                                    textColor: .yellow,
//                                                    ticketColor: .blue,
//                                                    theme: .light)
//            TMTickets.shared.brandingColorsOverride = branding // optional

//            TMTickets.shared.brandingColorNavBarOverride = true // optional
            
//            TMTickets.shared.brandingColorButtonOverride = true // optional
            
//            TMTickets.shared.brandingTeamLogoImage = UIImage(imageLiteralResourceName: "TeamLogo") // optional

            completion(true)
            
        } failure: { error in
            // something went wrong, probably TMAuthentication was not configured correctly
            print(" - Tickets Configuration Error: \(error.localizedDescription)")
            completion(false)
        }
    }
}
