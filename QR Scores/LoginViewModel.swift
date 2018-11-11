//
//  LoginViewModel.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    let networking = InternalAPI()
    
    enum SignUpResults {
        case accountCreated
        case duplicateAccount
        case unexpectedError
    }
    
    func signUp(name: String, email: String, password: String, completion: @escaping (SignUpResults) -> Void) {
        let registerUser = UserRegister(email: email, name: name, password: password)
        
        networking.signUp(registerUser) { (result) in
            switch result {
            case .success(let user):
                UserPersistence.setCurrent(user, save: true)
                
                completion(.accountCreated)
            case .failure(let error):
                
                switch error {
                case .duplicateAccount:
                    completion(.duplicateAccount)
                default:
                    assertionFailure("unexepected error: \(error.localizedDescription)")
                    
                    completion(.unexpectedError)
                }
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let loginUser = UserLogin(email: email, password: password)
        
        networking.login(loginUser) { (result) in
            switch result {
            case .success(let user):
                UserPersistence.setCurrent(user, save: true)
                
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                
                completion(false)
            }
        }
    }
}
