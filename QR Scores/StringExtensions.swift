//
//  StringExtensions.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/6/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

fileprivate let badChars = CharacterSet.alphanumerics.inverted

extension String {
    var kabbobCased: String {
        return self.replacingOccurrences(of: " ", with: "-").lowercased()
    }
    
    var uppercasingFirst: String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    var lowercasingFirst: String {
        return prefix(1).lowercased() + dropFirst()
    }
    
    var camelCased: String {
        guard !isEmpty else {
            return ""
        }
        
        let parts = self.components(separatedBy: badChars)
        
        let first = String(describing: parts.first!).lowercasingFirst
        let rest = parts.dropFirst().map({String($0).uppercasingFirst})
        
        return ([first] + rest).joined(separator: "")
    }
}
