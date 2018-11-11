//
//  User.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
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

struct UserRegister: Codable {
    let email: String
    let name: String
    let password: String
}

struct UserLogin: Codable {
    let email: String
    let password: String
}
