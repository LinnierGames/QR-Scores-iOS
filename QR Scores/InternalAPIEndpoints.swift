//
//  ChallengeAPI.swift
//  Grocery Challenge
//
//  Created by Andrew Crookston on 5/14/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import Foundation
import Moya
import Result

enum InternalAPIEndpoints {
    case signUp(user: UserRegister)
    case login(user: UserLogin)
    case surveys
    case createSurvey(payload: Encodable)
    
    static func createSurvey<T: CreateSurveyProtocol>(survey: T) -> InternalAPIEndpoints {
        guard let encodableSurvey = survey as? Encodable else {
            fatalError("Survey needs to be encodable")
        }
        
        return .createSurvey(payload: encodableSurvey)
    }
}

extension InternalAPIEndpoints: TargetType {
    var baseURL: URL {
        return URL(string: InfoPlist.baseUrlString)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "signup"
        case .login:
            return "login"
        case .surveys, .createSurvey:
            return "surveys"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp, .login:
            return .post
        case .surveys:
            return .get
        case .createSurvey:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .signUp(let user):
            return .requestJSONEncodable(user)
        case .login(let user):
            return .requestJSONEncodable(user)
        case .surveys:
            return .requestPlain
        case .createSurvey(let payload):
            return .requestJSONEncodable(payload)
        }
    }
    
    var headers: [String : String]? {
        var defaultHeaders = [String : String]()
        
        // default header pairs
        switch self {
        case .surveys, .createSurvey:
            let token = UserPersistence.currentUser.token
            
            // Authorization
            defaultHeaders["Authorization"] = "Token \(token)"
        default:
            break
        }
        
        return defaultHeaders
    }
}

enum APIError: Error {
    
    case somethingWentWrong(message: String)
    
    case failedToDecode
    case duplicateAccount
    case invalidCredentials
    case unathorizedOrNeedsRelogin
    
    var localizedDescription: String {
        switch self {
        case .somethingWentWrong(let message):
            return message
        default:
            return String(describing: self)
        }
    }
}

func jsonResponse<T: Decodable>(
    expectedSuccessCode statusCode: Int = 200,
    next: @escaping (Result<T, APIError>) -> Void) -> Completion {
    
    return { (result) in
        switch result {
        case .success(let response):
            switch response.statusCode {
            case statusCode:
                guard let payload = try? JSONDecoder().decode(T.self, from: response.data) else {
                    return next(.failure(APIError.failedToDecode))
                }
                
                next(.success(payload))
            case 400:
                next(.failure(APIError.somethingWentWrong(message: "Bad Request")))
            case 401:
                next(.failure(APIError.unathorizedOrNeedsRelogin))
            case 409:
                next(.failure(APIError.duplicateAccount))
            default:
                next(.failure(APIError.somethingWentWrong(message: "")))
            }
        case .failure(let error):
            next(.failure(APIError.somethingWentWrong(message: error.localizedDescription)))
        }
    }
}
