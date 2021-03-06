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
        
        provider.request(
            .signUp(user: registerUser),
            completion: jsonResponse(next: completion)
        )
    }
    
    func login(_ loginUser: UserLogin, completion: @escaping (Result<User, APIError>) -> Void) {
        
        provider.request(
            .login(user: loginUser),
            completion: jsonResponse(next: completion)
        )
    }
    
    func fetchUserSurveys(completion: @escaping (Result<[Survey], APIError>) -> Void) {
        
        provider.request(
            .surveys,
            completion: jsonResponse(next: { (result: Result<[JSON], APIError>) in
                switch result {
                case .success(let jsonData):
                    let surveysData = jsonData.compactMap({ try? $0.rawData() })
                    
                    let surveys = surveysData.compactMap({ data -> Survey? in
                        guard let survey = try? SurveyDecoder.decode(from: data) else {
                            assertionFailure("failed to decode")
                            
                            return nil
                        }
                        
                        return survey
                    })
                    
                    completion(.success(surveys))
                case .failure(let err):
                    completion(.failure(err))
                }
            })
        )
    }
    
    func createSurvey<T: CreateSurveyProtocol>(_ survey: T, completion: @escaping (Result<Survey, APIError>) -> Void) {
        
        provider.request(
            .createSurvey(survey: survey),
            completion: jsonResponse(expectedSuccessCode: 201, next: completion)
        )
    }
    
    func update(_ survey: Survey, completion: @escaping (Result<Survey, APIError>) -> Void) {
        
        provider.request(
            .updateSurvey(survey),
            completion: jsonResponse(expectedSuccessCode: 201, successfulResponse: { response in
                guard let survey = try? SurveyDecoder.decode(from: response.data) else {
                    return completion(.failure(.failedToDecode))
                }
                
                completion(.success(survey))
            }, failureResponse: { err in
                completion(.failure(err))
            })
        )
    }
    
    func delete(_ survey: Survey, completion: @escaping (Result<Bool, APIError>) -> Void) {
        
        provider.request(
            .deleteSurvey(survey),
            completion: jsonResponse(
                expectedSuccessCode: 204,
                successfulResponse: { _ in
                    completion(.success(true))
                }, failureResponse: { (err) in
                    completion(.failure(err))
                }
            )
        )
    }
}
