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
        case id
        case title
        case description
        case body
        case surveyType
    }
    
    let id: String?
    let title: String
    let description: String
    let surveyType: Int
    var body: [String: Encodable] = [:]
    
    init(title: String, description: String, type: Int) {
        self.id = nil
        self.title = title
        self.description = description
        self.surveyType = type
    }
    
    init(from survey: Survey) {
        self.id = survey.id
        self.title = survey.title
        self.description = survey.userDescription
        self.surveyType = survey.surveyType.rawValue
        self.body = survey.surveyBody as! [String : Encodable]
    }
    
    mutating func addProperty(_ info: DescriptorAdditionalInfo) {
        
        let camelCased = info.title.camelCased
        
        if let string = info.string {
            body[camelCased] = string
        } else if let bool = info.boolean {
            body[camelCased] = bool
        } else if let number = info.number {
            body[camelCased] = number.intValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.surveyType, forKey: .surveyType)
        
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
