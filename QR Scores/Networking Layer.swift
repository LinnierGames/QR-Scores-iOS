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
import SwiftyJSON

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
                case 400:
                    completion(.failure(APIError.somethingWentWrong(message: "Please enter the required info")))
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
                    guard let surveysData = try? JSONDecoder().decode([JSON].self, from: response.data) else {
                        assertionFailure("response did not contain array of data")
                        
                        return completion(.failure(APIError.somethingWentWrong(message: "")))
                    }
                    
                    let surveys = surveysData.compactMap({ try? SurveyDecoder.decode(from: $0) })
                    
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
    
    func createSurvey<T: CreateSurveyProtocol>(_ survey: T, completion: @escaping (Result<Survey, APIError>) -> Void) {
        
        provider.request(InternalAPIEndpoints.createSurvey(survey: survey)) { (result) in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 201:
                    guard let survey = try? SurveyDecoder.decode(from: response.data) else {
                        assertionFailure("failed to convert survey")
                        
                        return completion(.failure(APIError.failedToDecode))
                    }
                    
                    completion(.success(survey))
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
