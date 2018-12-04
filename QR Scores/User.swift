//
//  User.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/4/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var name: String {
        return local.name
    }
    
    var email: String {
        return local.email
    }
    
    var token: String {
        return local.token
    }
    
    private struct LocalProvider: Codable {
        let email: String
        let name: String
        let token: String
    }
    private let local: LocalProvider
    
    private init() {
        fatalError()
    }
}
