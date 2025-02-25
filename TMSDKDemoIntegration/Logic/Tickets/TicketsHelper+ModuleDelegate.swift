//
//  TicketsHelper+ModuleDelegate.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 7/5/23.
//

import Foundation
import TicketmasterTickets // for TMTicketsModuleDelegate

extension TicketsHelper: TMTicketsModuleDelegate {
    
    /**
     Method is invoked when the user is viewing a specific Event. Client app needs to define an array of custom modules (if any) and return them to the Tickets SDK.
          
     - Parameters:
       - event: current Event and purchased Orders being viewed (includes Event and Venue IDs)
       - completion: an ordered array of custom modules to be rendered (if any)
     */
    func addCustomModules(event: TMPurchasedEvent, completion: @escaping ([TMTicketsModule]?) -> Void) {
        print("Add Modules...")
        var modules: [TMTicketsModule] = []
        
        buildPreBuiltModules(event: event) { prebuiltModules in
            // add prebuilt modules (optional)
            modules.append(contentsOf: prebuiltModules)
            
            self.buildCustomModules(event: event) { customModules in
                // add custom modules (optional)
                modules.append(contentsOf: customModules)
                
                // return list of modules (in the order you want them displayed)
                completion(modules)
            }
        }
    }
    
    /**
     Method is invoked if user has pressed a button on a custom module, and unique handling is required.
          
     - Parameters:
       - event: current Event and purchased Orders being viewed, including the selected Order, if ``TMTicketsModule/ActionButton/requiresSpecificOrder`` is `true`
       - module: ``TMTicketsModule`` containing button
       - button: ``TMTicketsModule/ActionButton`` pressed
       - completion: build and return webpage settings to be opened by Tickets SDK (if any)
     */
    func handleModuleActionButton(event: TMPurchasedEvent, module: TMTicketsModule, button: TMTicketsModule.ActionButton, completion: @escaping (TMTicketsModule.WebpageSettings?) -> Void) {
        // Tickets SDK won't call this method unless it is not sure what to do with the given module
        // to get analytics about all modules, see userDidPerform(action:metadata:)
        print("\(module.identifier): \(button.callbackValue)")
        
        // these are just examples, they are not required
        if module.identifier == TMTicketsPrebuiltModule.ModuleName.venueConcessions.rawValue {
            completion(nil) // dismiss Tickets view
            // give a brief moment for the Tickets view to dismiss before presenting anything
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if button.callbackValue == TMTicketsPrebuiltModule.ButtonCallbackName.order.rawValue {
                    print("handleModuleActionButton: Present Venue Concessions: Order")
                    // TODO: present VenueNext SDK Order (or other Concession UI)
                    let concessionsVC = UIViewController()
                    self.ticketsVC?.navigationController?.pushViewController(concessionsVC, animated: true)

                } else if button.callbackValue == TMTicketsPrebuiltModule.ButtonCallbackName.wallet.rawValue {
                    print("handleModuleActionButton: Present Venue Concessions: Wallet")
                    // TODO: present VenueNext SDK Wallet (or other Concession UI)
                    let concessionsVC = UIViewController()
                    self.ticketsVC?.navigationController?.pushViewController(concessionsVC, animated: true)
                }
            }
            
        } else if module.identifier == "com.myDemoApp.upcomingEvents" {
            completion(nil) // dismiss Tickets view
            // give a brief moment for the Tickets view to dismiss before presenting anything
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.handleModuleMoreTickets(event: event, module: module, button: button)
            }
            
        } else if module.identifier == "com.myDemoApp.nextHomeGame" {
            completion(nil) // dismiss Tickets view
            // give a brief moment for the Tickets view to dismiss before presenting anything
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.handleModuleBuyEvent(event: event, module: module, button: button)
            }
        }
    }
}
