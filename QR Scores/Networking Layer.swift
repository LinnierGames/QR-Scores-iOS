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
    
    func signUp(_ registerUser: UserRegister, completion: @escaping (Result<User, APIError>) -> Void) {
        
        provider.request(InternalAPIEndpoints.signUp(user: registerUser)) { (result) in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    guard let user = try? JSONDecoder().decode(User.self, from: response.data) else {
                        assertionFailure("failed to convert user")
                        
                        return completion(.failure(APIError.failedToDecode))
                    }
                    
                    completion(.success(user))
                case 409:
                    completion(.failure(APIError.duplicateAccount))
                default:
                    assertionFailure("unhandled status code")
                    
                    completion(.failure(APIError.somethingWentWrong(message: "")))
                }
            case .failure(let error):
                assertionFailure(error.localizedDescription)
                
                completion(.failure(APIError.somethingWentWrong(message: error.localizedDescription)))
            }
        }
    }
    
    func login(_ loginUser: UserLogin, completion: @escaping (Result<User, APIError>) -> Void) {
        
        provider.request(InternalAPIEndpoints.login(user: loginUser)) { (result) in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    guard let user = try? JSONDecoder().decode(User.self, from: response.data) else {
                        assertionFailure("failed to convert user")
                        
                        return completion(.failure(APIError.failedToDecode))
                    }
                    
                    completion(.success(user))
                case 401:
                    completion(.failure(APIError.invalidCredentials))
                default:
                    completion(.failure(APIError.somethingWentWrong(message: "")))
                }
            case .failure(let error):
                assertionFailure(error.localizedDescription)
                
                completion(.failure(APIError.somethingWentWrong(message: error.localizedDescription)))
            }
        }
    }
    
    func fetchUserSurveys(completion: @escaping (Result<[Survey], APIError>) -> Void) {
        
        provider.request(InternalAPIEndpoints.surveys) { (result) in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    guard let surveys = try? JSONDecoder().decode([Survey].self, from: response.data) else {
                        assertionFailure("failed to convert surveys")
                        
                        return completion(.failure(APIError.failedToDecode))
                    }
                    
                    completion(.success(surveys))
                default:
                    completion(.failure(APIError.somethingWentWrong(message: "")))
                }
            case .failure(let error):
                assertionFailure(error.localizedDescription)
                
                completion(.failure(APIError.somethingWentWrong(message: error.localizedDescription)))
            }
        }
    }
    
    func createSurvey(_ survey: SurveyUploader, completion: @escaping (Result<Survey, APIError>) -> Void) {
        
        provider.request(InternalAPIEndpoints.createSurvey(survey: survey)) { (result) in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    guard let surveys = try? JSONDecoder().decode(Survey.self, from: response.data) else {
                        assertionFailure("failed to convert survey")
                        
                        return completion(.failure(APIError.failedToDecode))
                    }
                    
                    completion(.success(surveys))
                default:
                    completion(.failure(APIError.somethingWentWrong(message: "")))
                }
            case .failure(let error):
                assertionFailure(error.localizedDescription)
                
                completion(.failure(APIError.somethingWentWrong(message: error.localizedDescription)))
            }
        }
    }
}
