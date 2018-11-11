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
    case createSurvey(survey: SurveyUpload)
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
}















//
//enum APIRequests: Requests {
//    case home
//    case signUp(user: UserRegister)
//
//    var url: URL {
//        let baseUrl = URL(string: "http://localhost:3000/")!
//
//        switch self {
//        case .home:
//            return baseUrl
//        case .signUp:
//            return baseUrl.appendingPathComponent("signup")
//        }
//    }
//
//    var method: Method {
//        switch self {
//        case .signUp:
//            return .post
//        default:
//            return .get
//        }
//    }
//
//    var body: Data? {
//        switch self {
//        case .signUp(let user):
//            let userDict: [String: String] = [
//                "email": "LOL"
//            ]
//
//            guard let userData = try? JSONSerialization.data(withJSONObject: userDict, options: .prettyPrinted) else {
//                return nil
//            }
//
//            return userData
//        default:
//            return nil
//        }
//    }
//}
//
//
//final class InternalAPI {
//    let service = NetworkService()
//
//    func signUpUser(name: String, email: String, password: String, completion: @escaping (Result<User>) -> Void) {
//
//        let registerUser = UserRegister(email: email, name: name, password: password)
//        let request = APIRequests.signUp(user: registerUser)
//
//        service.get(request: request) { (result) in
//            switch result {
//            case .success(let data):
//                guard let user = try? JSONDecoder().decode(User.self, from: data) else {
//                    assertionFailure("failed to convert user")
//
//                    return completion(.error(APIError.failedToDecodeUser))
//                }
//
//                completion(.success(user))
//            case .error(let error):
//                assertionFailure(error.localizedDescription)
//            }
//        }
//    }
//}

//final class ChallengeAPI {
//    let service: Service
//
//    init(service: Service = NetworkService()) {
//        self.service = service
//    }
//
//    func randomQuestionAsync(request: Requests = APIRequests.questions, _ completion: @escaping (Result<Question>) -> Void) {
//        allQuestionsAsync(request: request) { result in
//            switch result {
//            case .success(let questions):
//                guard questions.count > 0 else {
//                    completion(.error(APIError.noQuestions))
//                    return
//                }
//                let index = Int(arc4random_uniform(UInt32(questions.count)))
//                completion(.success(questions[index]))
//            case .error(let error):
//                completion(.error(error))
//            }
//        }
//    }
//
//    func allQuestionsAsync(request: Requests = APIRequests.questions, _ completion: @escaping (Result<[Question]>) -> Void) {
//        service.get(request: request) { result in
//            switch result {
//            case .success(let data):
//                do {
//                    let questions: Questions = try JSONDecoder().decode(Questions.self, from: data)
//                    completion(.success(questions.questions))
//                } catch {
//                    completion(.error(error))
//                }
//            case .error(let error):
//                completion(.error(error))
//            }
//        }
//    }
//}
