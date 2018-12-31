//
//  UniversalExtentions.swift
//  iLogs - Swift
//
//  Created by Erick Sanchez on 9/26/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    /**
     checks if self is empty. If so, return the given default string.
     
     - parameter defaultString: return this if self is empty or nil
     
     - returns: either return self if not an empty string or return the given default value
     */
    func ifEmpty(use defaultString: String) -> String {
        if self.isEmpty {
            return defaultString
        } else {
            return self
        }
    }
    
    func joinIfNotEmptyOrNil(_ otherString: String?, by joiner: String) -> String {
        if let other = otherString, other.isNotEmpty {
            return self + joiner + other
        } else {
            return self
        }
    }
}

extension Optional where Wrapped == String {
    
    /**
     unwraps and checks if the string is empty. If so, return the given default string.
     
     This is similar to using the nil-colicent but also checks `.isEmpty`
     
     - parameter defaultString: return this if self is empty or nil
     
     - returns: either return self if not nil and not an empty string or return the given default value
     */
    func ifEmptyOrNil(use defaultString: String) -> String {
        if let unwrappedSelf = self, unwrappedSelf.isEmpty == false {
            return unwrappedSelf
        } else {
            return defaultString
        }
    }
    
    var isNotEmpty: Bool {
        return self?.isEmpty ?? false == false
    }
}
