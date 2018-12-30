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
    
    case updateSurvey(Survey)
    case deleteSurvey(Survey)
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
        case .updateSurvey(let survey), .deleteSurvey(let survey):
            return "surveys/\(survey.id)"
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
        case .updateSurvey:
            return .put
        case .deleteSurvey:
            return .delete
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
        case .updateSurvey(let survey), .deleteSurvey(let survey):
            return .requestJSONEncodable(survey)
        }
    }
    
    var headers: [String : String]? {
        var defaultHeaders = [String : String]()
        
        switch self {
        case .login, .signUp:
            break
        default:
            let token = UserPersistence.currentUser.token
            
            // Authorization
            defaultHeaders["Authorization"] = "Token \(token)"
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
    decoder: JSONDecoder = JSONDecoder.init(),
    next: @escaping (Result<T, APIError>) -> Void) -> Completion {
    return { (result) in
        handleStatus(result, statusCode, { (response) in
            guard let payload = try? decoder.decode(T.self, from: response.data) else {
                return next(.failure(APIError.somethingWentWrong(message: "")))
            }
            
            next(.success(payload))
        }, { (err) in
            next(.failure(err))
        })
    }
}

func jsonResponse(
    expectedSuccessCode statusCode: Int = 200,
    decoder: JSONDecoder = JSONDecoder.init(),
    successfulResponse succHandler: @escaping (Response) -> Void,
    failureResponse failHandler: @escaping (APIError) -> Void) -> Completion {
    return { (result) in
        handleStatus(result, statusCode, succHandler, failHandler)
    }
}

fileprivate func handleStatus(_ result: Result<Response, MoyaError>, _ statusCode: Int, _ success: @escaping (Response) -> Void, _ fail: @escaping (APIError) -> Void) {
    switch result {
    case .success(let response):
        switch response.statusCode {
        case statusCode:
            success(response)
        case 400:
            fail(APIError.somethingWentWrong(message: "Bad Request"))
        case 401:
            fail(APIError.unathorizedOrNeedsRelogin)
        case 409:
            fail(APIError.duplicateAccount)
        default:
            fail(APIError.somethingWentWrong(message: ""))
        }
    case .failure(let error):
        fail(APIError.somethingWentWrong(message: error.localizedDescription))
    }
}
