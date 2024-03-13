//
//  PurchaseHelper+WebsiteConfig.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/6/23.
//

import Foundation
import TicketmasterPurchase

extension PurchaseHelper {
    
    /// quickly create a `TMPurchaseWebsiteConfiguration` for a given `eventID` (Host or Discovery)
    ///
    /// also known as a "club-site configuration"
    ///
    /// - Note: This uses a default configuration that you should change for your App as needed
    ///
    /// - Parameters:
    ///   - eventID: Discovery or Host Event Identifier
    /// - Returns:
    ///   - a TMPurchaseWebsiteConfiguration
    func buildPurchaseWebsiteConfiguration(eventID: String) -> TMPurchaseWebsiteConfiguration {
        /// Discovery or Host Event Identifier (required)
        let purchaseConfig = TMPurchaseWebsiteConfiguration(eventID: eventID)
        
        // the following code is an example of how to build the TMPurchaseWebsiteConfiguration
        
        // TODO: feel free to modify the values here:
        
        // MARK: BRANDING
        // Discovery or Host Attraction/Attraction Identifier, used for branding
//        purchaseConfig.attractionID = "805969" // Milwaukee Bucks (TM Artist Host ID)
        // brand name (a special branding id) used to style web page content
//        purchaseConfig.brandName = "bucks" // Milwaukee Bucks
        // show special NFL branding on EDP
//        purchaseConfig.showNFLBranding = false

        // MARK: MARKETING
        // marketing campaign code used for tracking the success of a campaign
//        purchaseConfig.cameFromCode = "june2021emailCampaign"
        // special "password" used to expose hidden ticket types on the EDP
//        purchaseConfig.discreteID = "summerSale2021"

        // MARK: OPTIONAL NAVBAR BUTTONS
        // show Event "Info" button in NavBar, enables presentADP and presentVDP User Navigation delegate methods
        purchaseConfig.showInfoToolbarButton = true
        // show Event "Calendar" button in NavBar, button will only appear if Event has other performances at the same Venue
        purchaseConfig.showCalendarToolbarButton = true
        // show Event Social "Share" button in EDP NavBar enables Sharing delegate methods
        purchaseConfig.showShareToolbarButton = true
                
        // MARK: RESALE LISTINGS
        // hide resale ticket offerings of EDP behind a toggle/button
        purchaseConfig.showResaleSoftLanding = false
        // show resale message banner at the top of EDP
        purchaseConfig.showResaleMessageBanner = false
        
        // your own additional custom URL parameters to pass to the EDP, these string values will be URL-encoded by the Purchase SDK.
        purchaseConfig.additionalURLParameters = ["myCustomParamKey": "myCustomParamValue"]

        return purchaseConfig
    }
}
