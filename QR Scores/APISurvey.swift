//
//  Survey.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

//struct AnyEncodable: Encodable {
//    let value: Encodable
//
//    enum CodingKeys: String, CodingKey {
//        case value
//    }
//
//    func encode(to encoder: Encoder) throws {
//        try value.encode(to: encoder)
//    }
//
//    static func string(_ string: String) -> AnyEncodable {
//        return AnyEncodable(value: string)
//    }
//
//    static func boolean(_ boolean: Bool) -> AnyEncodable {
//        return AnyEncodable(value: boolean)
//    }
//
//    static func integer(_ integer: Int) -> AnyEncodable {
//        return AnyEncodable(value: integer)
//    }
//}

struct SurveyUploader: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case body
    }
    
    let title: String
    let description: String
    var body: [String: Encodable] = [:]
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    mutating func addProperty(_ info: DescriptorAdditionalInfo) {
        
        let kabobCase = info.title.kabbobCased
        
        if let string = info.string {
            body[kabobCase] = string
        } else if let bool = info.boolean {
            body[kabobCase] = bool
        } else if let number = info.number {
            body[kabobCase] = number.intValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.description, forKey: .description)
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) {
            try container.encode(jsonData, forKey: .body)
        }
    }
}

struct SurveyDecoder {
    
    private struct TypeChecker: Decodable {
        let surveyType: SurveyType
    }
    
    static func decode(from data: Data) -> Survey? {
        guard let type = try? JSONDecoder().decode(TypeChecker.self, from: data) else {
            return nil
        }

        return decode(from: data, using: type.surveyType)
    }
    
    static func decode(from data: Data, using type: SurveyType) -> Survey? {
        switch type {
        case .scanToVote:
            guard let survey = try? JSONDecoder().decode(ScanToVoteSurvey.self, from: data) else {
                return nil
            }

            return survey
        }
    }
}
