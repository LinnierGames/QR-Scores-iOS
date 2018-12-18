//
//  ChallengeAPI.swift
//  Grocery Challenge
//
//  Created by Andrew Crookston on 5/14/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import Foundation
import Moya

//struct InternalAPIEndpointRequest: TargetType {
//
//    var baseURL: URL {
//        return URL(string: "http://qr-scores.herokuapp.com/")!
//    }
//
//    var path: String
//
//    var method: Moya.Method
//
//    var sampleData: Data
//
//    var task: Task
//
//    var headers: [String : String]?
//
//    // MARK: - Endpoints
//
//    static func signUp(user: UserRegister) -> InternalAPIEndpointRequest {
//        return InternalAPIEndpointRequest(
//            path: <#T##String#>,
//            method: <#T##Method#>,
//            sampleData: <#T##Data#>,
//            task: <#T##Task#>,
//            headers: <#T##[String : String]?#>
//        )
//    }
//
//    static func createSurvey<T: CreateSurveyProtocol>(survey: T) -> InternalAPIEndpointRequest {
//        return InternalAPIEndpointRequest(
//            path: <#T##String#>,
//            method: <#T##Method#>,
//            sampleData: <#T##Data#>,
//            task: <#T##Task#>,
//            headers: <#T##[String : String]?#>
//        )
//    }
//}

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
                return URL(string: "http://localhost:3000/")!
//        return URL(string: "http://qr-scores.herokuapp.com/")!
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
    
    // login and registering
    case failedToDecode
    case duplicateAccount
    case invalidCredentials
    case unathorizedOrNeedsRelogin
}
