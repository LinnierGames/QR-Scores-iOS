//
//  Networking Layer.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation
import Moya
import Result

struct InternalAPI {
    private let provider = MoyaProvider<InternalAPIEndpoints>()
    
    func signUpUser(name: String, email: String, password: String, completion: @escaping (Result<User, APIError>) -> Void) {
        
        let registerUser = UserRegister(email: email, name: name, password: password)
        provider.request(InternalAPIEndpoints.signUp(user: registerUser)) { (result) in
            switch result {
            case .success(let response):
                guard let user = try? JSONDecoder().decode(User.self, from: response.data) else {
                    assertionFailure("failed to convert user")
                    
                    return completion(.failure(APIError.failedToDecodeUser))
                }
                
                completion(.success(user))
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
        }
    }
}
