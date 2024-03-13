//
//  DictionaryExplorerTextView.swift
//  SwiftNetworkingFrameworkTest
//
//  Created by Jonathan Backer on 7/21/17.
//  Copyright © 2017 Ticketmaster. All rights reserved.
//

import UIKit
import TicketmasterFoundation

class DictionaryExplorerTextView: UITextView {
    
    fileprivate var outputText: NSMutableAttributedString = NSMutableAttributedString()
    fileprivate var sourceDictionary: JSONDictionary = [:]
    fileprivate var openKeyPaths: [String] = []
    
    func setup(withDictionary dictionary: JSONDictionary) {
        // just in case someone else tries to assign the delegate
        delegate = self
        
        sourceDictionary = dictionary
        openKeyPaths = []
        
        render()
    }
    
    func closeAllOpenPaths() {
        openKeyPaths = []
        render()
    }
}

extension DictionaryExplorerTextView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        let keyPath = URL.absoluteString
        
        if keyPath.hasPrefix("http://") || keyPath.hasPrefix("https://") {
            return true
            
        } else {
            if let index = openKeyPaths.firstIndex(of: keyPath) {
                openKeyPaths.remove(at: index)
            } else {
                openKeyPaths.append(keyPath)
            }
            
            self.render()
            
            return false
        }
    }
}

private extension DictionaryExplorerTextView {
    
    func render() {
        outputText = NSMutableAttributedString()
        
        render(dictionary: sourceDictionary, currentPath: "root")
        
        if let font = UIFont(name: "Courier", size: 12.0) {
            outputText.addAttribute(NSAttributedString.Key.font,
                                    value: font,
                                    range: NSMakeRange(0, outputText.string.count))
        }
        
        let originalOffset = contentOffset
        
        // this command may scroll the text to the end
        attributedText = outputText
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            // so put the scrolling back to where it was originally
            self.contentOffset = originalOffset
        })
    }
    
    func render(dictionary: JSONDictionary, currentPath: String) {
        let keys = dictionary.keys.sorted()
        for key in keys {
            if let value = dictionary[key] {
                render(keyPath: "\(currentPath).\(key)", value: value)
            }
        }
    }

    func render(array: [Any], currentPath: String) {
        var index = 0
        for value in array {
            render(keyPath: "\(currentPath).\(index)", value: value)
            index += 1
        }
    }
    
    func render(keyPath: String, value: Any) {
        let (key, padding) = endOfPath(string: keyPath)
        
        if let subDict = value as? JSONDictionary {
            if openKeyPaths.contains(keyPath) {
                append(string: "\(key): {", padding: padding, keyPath: keyPath)
                render(dictionary: subDict, currentPath: keyPath)
            } else {
                append(string: "\(key): { \(subDict.keys.count) }", padding: padding, keyPath: keyPath)
            }
            
        } else if let subArray = value as? [Any] {
            if openKeyPaths.contains(keyPath) {
                append(string: "\(key): [", padding: padding, keyPath: keyPath)
                render(array: subArray, currentPath: keyPath)
            } else {
                append(string: "\(key): [ \(subArray.count) ]", padding: padding, keyPath: keyPath)
            }
            
        } else if let string = value as? String {
            append(string: "\(key): \"\(string)\"", padding: padding)
            
        } else if let bool = value as? Bool, let number = value as? NSNumber {
            if number == 0 || number == 1 {
                append(string: "\(key): \(bool) (\(number))", padding: padding)
            } else {
                append(string: "\(key): \(number)", padding: padding)
            }

        } else {
            append(string: "\(key): \(value)", padding: padding)
        }
        
    }
    
    func endOfPath(string: String, level: Int? = 0) -> (String, Int) {
        let level = level ?? 0
        if let lastDot = string.range(of: ".") {
            return endOfPath(string: String(string[lastDot.upperBound..<string.endIndex]), level: level + 1)
        } else {
            return (string, level)
        }
    }
    
    func append(string: String, padding: Int, keyPath: String? = nil) {
        var paddedString: String = ""
        for _ in 0 ..< padding - 1 {
            paddedString += "  "
        }
        paddedString += string
        
        let attributedTextString = NSMutableAttributedString(string: "\(paddedString)\n")
        
        if let keyPath = keyPath {
            attributedTextString.addAttribute(NSAttributedString.Key.link,
                                              value: keyPath,
                                              range: NSMakeRange(0, paddedString.count))
        }
        
        outputText.append(attributedTextString)
    }
}
