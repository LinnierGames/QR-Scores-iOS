//
//  ChallengeAPI.swift
//  Grocery Challenge
//
//  Created by Andrew Crookston on 5/14/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import Foundation
import Moya

enum InternalAPIEndpoints {
    case signUp(user: UserRegister)
    case login(user: UserLogin)
    case surveys
    case createSurvey(survey: SurveyHolder<<#T: CreateSurveyProtocol#>>)
}

struct SurveyHolder<T: CreateSurveyProtocol> {
    let survey: T
}

extension InternalAPIEndpoints: TargetType {
    var baseURL: URL {
        //        return URL(string: "http://localhost:3000/")!
        return URL(string: "http://qr-scores.herokuapp.com/")!
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
        case .createSurvey(let survey):
            return .requestJSONEncodable(survey)
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
