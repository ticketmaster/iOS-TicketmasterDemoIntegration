//
//  Data+JSON.swift
//  TMSDKDemoIntegration
//
//  Created by Jonathan Backer on 3/13/24.
//

import Foundation

public extension Data {
    
    init?(object: Any, options: JSONSerialization.WritingOptions = []) {
        // make sure this is a valid JSON object first...
        if JSONSerialization.isValidJSONObject(object) {
            // ...because this crashes even with the try
            if let data = try? JSONSerialization.data(withJSONObject: object, options: options) {
                self = data
            } else {
                // still could not JSON serialize this object? wtf?!
                return nil
            }
        } else {
            // could not JSON serialize this object
            return nil
        }
    }
}
