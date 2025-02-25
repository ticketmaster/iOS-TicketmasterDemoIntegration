//
//  TicketsHelper+CustomModules.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import MapKit // for MKCoordinateRegion and CLLocationCoordinate2D
import TicketmasterTickets // for TMPurchasedEvent, TMTicketsModule and TMTicketsModuleHeaderView
import TicketmasterDiscoveryAPI // for DiscoveryEventSearchCriteria

extension TicketsHelper {
    
    /// see Documentation/Screenshots/CustomModules for examples
    func buildCustomModules(event: TMPurchasedEvent, completion: @escaping (_ customModules: [TMTicketsModule]) -> Void) {
        print(" - Adding Custom Modules")
        var output: [TMTicketsModule] = []
        
        // build a custom parking module
        // Tickets SDK knows how to handle opening a webpage,
        //  so handleModuleActionButton() will not be called
        if let module = parkingModule(event: event) {
            output.append(module)
        }
                
        // build a custom seating chart module
        // Tickets SDK knows how to handle opening a webpage,
        //  so handleModuleActionButton() will not be called
        if let module = venueInfoModule(event: event) {
            output.append(module)
        }
        
        // build a custom venue merch voucher module
        // Tickets SDK knows how to handle opening a webpage,
        //  so handleModuleActionButton() will not be called
        if let module = venueVoucherModule(event: event) {
            output.append(module)
        }
        
        // build a custom merch shop module
        // Tickets SDK knows how to handle opening a webpage,
        //  so handleModuleActionButton() will not be called
        if let module = merchShopModule(event: event) {
            output.append(module)
        }
        
        // build an upcoming events module
        // Tickets SDK does not know how to open an ADP, VDP, or EDP,
        //  so Tickets will call back into handleModuleActionButton()
        if let module = upcomingEventsModule(event: event) {
            output.append(module)
        }
        
        // build upcoming home games module (see Documentation/Screenshots/CustomModules for example)
        // this module uses a network call to Discovery API to find home games
        nextHomeGameModule(event: event) { nextEventModule in
            // this returns on the networking thread
            if let nextEventModule = nextEventModule {
                output.append(nextEventModule)
            }
            
            // use an async completion in case any of these custom modules need to make a network request
            // like nextHomeGameModule
            completion(output)
        }
    }
}



// MARK: build custom modules
extension TicketsHelper {
    
    func parkingModule(event: TMPurchasedEvent) -> TMTicketsModule? {
        // unfortunately the event object doesn't have info about particular parking lots
        // so we'll have to code the values manually
        
        // define map region and zoom (span)
        let mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 39.74885, longitude: -105.00761),
            span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
        
        // define map point of interest
        let mapAnnotation = TMTicketsModuleHeaderView.MapAnnotation(
            coordinate: CLLocationCoordinate2D(latitude: 39.74648, longitude: -105.00930),
            title: "Camry Lot South")
        
        // build a UIView with a text, gradient, and image
        let headerView = TMTicketsModuleHeaderView.build()
        headerView.configure(topLabelText: "Parking: Camry Lot South",
                             mapCoordinateRegion: mapRegion,
                             mapAnnotation: mapAnnotation)
        
        // build header with HeaderView (a UIView)
        let header = TMTicketsModule.HeaderDisplay(view: headerView)
        
        // build button that opens a webpage
        let parkingWebpageSettings = TMTicketsModule.WebpageSettings(
            pageTitle: "Parking",
            urlRequest: URLRequest(url: URL(string: "https://www.ballarena.com/plan-your-visit/parking-directions/")!))
        let parkingActionButton = TMTicketsModule.ActionButton(
            title: "Parking Directions",
            webpageSettings: parkingWebpageSettings)
        
        // build module with header and buttons
        return TMTicketsModule(identifier: "com.myDemoApp.parking",
                               headerDisplay: header,
                               actionButtons: [parkingActionButton])
    }
    
    func seatingChartModule(event: TMPurchasedEvent) -> TMTicketsModule? {
        // build action button that opens a webpage
        let seatingChartWebpageSettings = TMTicketsModule.WebpageSettings(
            pageTitle: "Seating Chart",
            urlRequest: URLRequest(url: URL(string: "https://www.ballarena.com/media/1109/hockey_pc-master-map-c_2018_r1.png")!))
        let seatingChartActionButton = TMTicketsModule.ActionButton(
            title: "Seating Chart", // what user will see, you should localize this text
            webpageSettings: seatingChartWebpageSettings)
        
        // Tickets SDK knows how to open a webpage, so handleModuleActionButton() will not be called
        
        // modules can have:
        // 1. header only (no buttons)
        // 2. buttons only (no header)
        // 3. both header and buttons
        
        // build module
        return TMTicketsModule(identifier: "com.myDemoApp.seatingChart", // a name unique to your app
                               headerDisplay: nil, // this module has buttons only (no header)
                               actionButtons: [seatingChartActionButton]) // you can show 0 to 3 buttons
    }
    
    func venueInfoModule(event: TMPurchasedEvent) -> TMTicketsModule? {
        // backgroundImage can be any size, but it will be aspectFilled to 24x15 (recommended: 480x300)
        let backgroundImage = UIImage(imageLiteralResourceName: "VenueInfo")
        
        // build any UIView here:
        //  actually, we have a handy method to build module UI easily, this includes:
        //   * text
        //   * images
        //   * maps
        //   * QR codes
        //   * 2D barcodes
        //   * videos
        let headerView = TMTicketsModuleHeaderView.build()
        headerView.configure(backgroundImage: backgroundImage)
        
        // build header display
        // any UIView will work here for headerView
        let headerDisplay = TMTicketsModule.HeaderDisplay(view: headerView as UIView)
        
        // build action buttons that open a webpage
        let venueInfoWebpageSettings = TMTicketsModule.WebpageSettings(
            pageTitle: "Venue Info",
            urlRequest: URLRequest(url: URL(string: "https://www.ballarena.com/arena-policies-faq")!))
        let venueInfoActionButton = TMTicketsModule.ActionButton(
            title: "Venue Info", // what user will see, you should localize this text
            callbackValue: "venueInfo", // non-localized value, for your own code/analytics
            webpageSettings: venueInfoWebpageSettings)
        
        let venue360WebpageSettings = TMTicketsModule.WebpageSettings(
            pageTitle: "360 View",
            urlRequest: URLRequest(url: URL(string: "https://avalanche.io-media.com/web/index.html")!))
        let venue360ActionButton = TMTicketsModule.ActionButton(
            title: "360 View", // what user will see, you should localize this text
            webpageSettings: venue360WebpageSettings)
        
        // Tickets SDK knows how to open a webpage, so handleModuleActionButton() will not be called
        
        // modules can have:
        // 1. header only (no buttons)
        // 2. buttons only (no header)
        // 3. both header and buttons
        
        // build module
        return TMTicketsModule(identifier: "com.myDemoApp.venueInfo", // a name unique to your app
                               headerDisplay: headerDisplay,
                               actionButtons: [venueInfoActionButton, venue360ActionButton]) // you can show 0 to 3 buttons
    }
    
    func venueVoucherModule(event: TMPurchasedEvent) -> TMTicketsModule? {
        // let's build a Venue Voucher module
        
        // show a QR code for $22.00 of merch at the venue
        let voucherCode = "12345MyCoolCode67890"
        let voucherAmount = "$22.00"
        
        // backgroundImage can be any size, but it will be aspectFilled to 24x15 (recommended: 480x300)
        let backgroundImage = UIImage(imageLiteralResourceName: "Breckenridge")
        
        // build any UIView here:
        //  actually, we have a handy method to build module UI easily, this includes:
        //   * text
        //   * images
        //   * maps
        //   * QR codes
        //   * 2D barcodes
        //   * videos
        let headerView = TMTicketsModuleHeaderView.build()
        headerView.configure(topLabelText: "Breckenridge Brewery Voucher",
                             topLabelTextAlignment: .center,
                             bottomLabelText: "Balance: \(voucherAmount)",
                             bottomLabelTextAlignment: .center,
                             gradientAlpha: 1.0,
                             backgroundImage: backgroundImage,
                             qrCodeValue: voucherCode)
        
        // build header display
        // any UIView will work here for headerView
        let headerDisplay = TMTicketsModule.HeaderDisplay(view: headerView as UIView)
        
        // show a button under the QR code
        let concessionsInfoWebpageSettings = TMTicketsModule.WebpageSettings(
            pageTitle: "Concessions Info",
            urlRequest: URLRequest(url: URL(string: "https://www.ballarena.com/food-drink/concessions/")!))
        let concessionsInfoActionButton = TMTicketsModule.ActionButton(
            title: "How to Use Vouchers", // what user will see, you should localize this text
            webpageSettings: concessionsInfoWebpageSettings)
        
        // Tickets SDK knows how to open a webpage, so handleModuleActionButton() will not be called
        
        // modules can have:
        // 1. header only (no buttons)
        // 2. buttons only (no header)
        // 3. both header and buttons
        
        // build module
        return TMTicketsModule(identifier: "com.myDemoApp.venueVoucher", // a name unique to your app
                               headerDisplay: headerDisplay,
                               actionButtons: [concessionsInfoActionButton]) // you can show 0 to 3 buttons
    }
    
    func merchShopModule(event: TMPurchasedEvent) -> TMTicketsModule? {
        // backgroundImage can be any size, but it will be aspectFilled to 24x15 (recommended: 480x300)
        let backgroundImage = UIImage(imageLiteralResourceName: "Merch")
        
        // build any UIView here:
        //  actually, we have a handy method to build module UI easily, this includes:
        //   * text
        //   * images
        //   * maps
        //   * QR codes
        //   * 2D barcodes
        //   * videos
        let headerView = TMTicketsModuleHeaderView.build()
        headerView.configure(backgroundImage: backgroundImage)
        
        // build header display
        // any UIView will work here for headerView
        let headerDisplay = TMTicketsModule.HeaderDisplay(view: headerView)
        
        // build action button that opens a webpage
        let fanCollectionWebpageSettings = TMTicketsModule.WebpageSettings(
            pageTitle: "Fan Collection",
            urlRequest: URLRequest(url: URL(string: "https://www.prochamp.jostens.com/catalogBrowse/3173533/Colorado-Avalanche-Fan/20220914162001593142")!))
        let fanCollectionActionButton = TMTicketsModule.ActionButton(
            title: "Fan Collection", // what user will see, you should localize this text
            webpageSettings: fanCollectionWebpageSettings)
        
        // you can have Tickets SDK automatically write a cookie into the webpage
        // this is most commonly used for transferring the user's login state to the webpage
        let cookieSettings = TMTicketsModule.OAuthCookieSettings(name: "cookieName",
                                                                 value: "merchOAuthToken",
                                                                 webDomains: [".fanatics.com"])
        // most other state info is typically transferred via URL parameters below
        
        // build action button that opens a webpage
        let merchShopWebpageSettings = TMTicketsModule.WebpageSettings(
            pageTitle: "Shopping",
            urlRequest: URLRequest(url: URL(string: "https://www.fanatics.com/nhl/colorado-avalanche/o-2428+t-47710691+z-91289-1682938200")!),
            oauthCookieSettings: cookieSettings)
        let merchShopActionButton = TMTicketsModule.ActionButton(
            title: "Shopping", // what user will see, you should localize this text
            webpageSettings: merchShopWebpageSettings)
        
        // modules can have:
        // 1. header only (no buttons)
        // 2. buttons only (no header)
        // 3. both header and buttons
        
        // build module
        return TMTicketsModule(identifier: "com.myDemoApp.merchShop", // a name unique to your app
                               headerDisplay: headerDisplay,
                               actionButtons: [fanCollectionActionButton, merchShopActionButton]) // you can show 0
    }
    
    func upcomingEventsModule(event: TMPurchasedEvent) -> TMTicketsModule? {
        // backgroundImage can be any size, but it will be aspectFilled to 24x15 (recommended: 480x300)
        let backgroundImage = UIImage(imageLiteralResourceName: "BallArenaHockey")
        
        // build any UIView here:
        //  actually, we have a handy method to build module UI easily, this includes:
        //   * text
        //   * images
        //   * maps
        //   * QR codes
        //   * 2D barcodes
        //   * videos
        let headerView = TMTicketsModuleHeaderView.build()
        headerView.configure(
            topLabelText: "More Games",
            bottomLabelText: "More Concerts",
            gradientAlpha: 1.0, // add a gradient to make the text easier to read
            backgroundImage: backgroundImage)
        
        // build header display
        // any UIView will work here for headerView
        let headerDisplay = TMTicketsModule.HeaderDisplay(view: headerView)
        
        // build action button that call back into this class
        let gamesActionButton = TMTicketsModule.ActionButton(
            title: "Games", // what user will see, you should localize this text
            callbackValue: "games") // what code will return in handleModuleActionButton(), unlocalized
        let concertsActionButton = TMTicketsModule.ActionButton(
            title: "Concerts", // what user will see, you should localize this text
            callbackValue: "concerts") // what code will return in handleModuleActionButton(), unlocalized
        
        // modules can have:
        // 1. header only (no buttons)
        // 2. buttons only (no header)
        // 3. both header and buttons
        
        // build module
        return TMTicketsModule(identifier: "com.myDemoApp.upcomingEvents", // a name unique to your app
                               headerDisplay: headerDisplay,
                               actionButtons: [gamesActionButton, concertsActionButton]) // you can show 0 to 3 buttons
    }
    
    func nextHomeGameModule(event: TMPurchasedEvent, completion: @escaping (_ module: TMTicketsModule?) -> Void) {
        ConfigurationManager.shared.configureDiscoveryAPIIfNeeded { _ in
            // have we configured the Discovery service?
            guard let discoveryHelper = ConfigurationManager.shared.discoveryHelper else {
                completion(nil)
                return
            }

            // does this event have a host id?
            guard let hostEventId = event.info.hostIdentifier else {
                completion(nil)
                return
            }
                        
            // can we determine the next event?
            discoveryHelper.lookupNextHostEvent(hostEventId: hostEventId) { event in
                if let event = event {
                    // load image for event (if possible)
                    discoveryHelper.loadImageForEvent(discoveryEvent: event, completion: { image in
                        // build module
                        let module = self.nextHomeGameModule(discoveryEvent: event, image: image)
                        completion(module)
                    })
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func nextHomeGameModule(discoveryEvent: DiscoveryEvent, image: UIImage?) -> TMTicketsModule? {
        // backgroundImage can be any size, but it will be aspectFilled to 24x15 (recommended: 480x300)
        let backgroundImage = image ?? UIImage(imageLiteralResourceName: "BallArenaHockey")
        
        let eventName = discoveryEvent.name.replacingOccurrences(of: "vs.", with: "vs.\n")
        
        // build any UIView here:
        //  actually, we have a handy method to build module UI easily, this includes:
        //   * text
        //   * images
        //   * maps
        //   * QR codes
        //   * 2D barcodes
        //   * videos
        let headerView = TMTicketsModuleHeaderView.build()
        headerView.configure(
            topLabelText: "Next Home Game",
            bottomLabelText: eventName,
            gradientAlpha: 1.0, // add a gradient to make the text easier to read
            backgroundImage: backgroundImage)
        
        // build header display
        // any UIView will work here for headerView
        let headerDisplay = TMTicketsModule.HeaderDisplay(view: headerView)
        
        // build action button that call back into this class
        let gamesActionButton = TMTicketsModule.ActionButton(
            title: "Get Tickets to next home game!", // what user will see, you should localize this text
            callbackValue: discoveryEvent.eventIdentifier.rawValue) // what code will return in handleModuleActionButton(), unlocalized
        
        // modules can have:
        // 1. header only (no buttons)
        // 2. buttons only (no header)
        // 3. both header and buttons
        
        // build module
        return TMTicketsModule(identifier: "com.myDemoApp.nextHomeGame", // a name unique to your app
                               headerDisplay: headerDisplay,
                               actionButtons: [gamesActionButton]) // you can show 0 to 3 buttons
    }
}
