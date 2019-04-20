//
//  UnversalExtensions+Bool.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/30/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

extension Bool {
    public mutating func invert() {
        if self == true {
            self = false
        } else {
            self = true
        }
    }
    
    public var inverse: Bool {
        if self == true {
            return false
        } else {
            return true
        }
    }
}
