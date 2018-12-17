//
//  Survey.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/4/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

//TODO: allow the user to make changes to survey
class Survey: Decodable {
    
    let id: String
    let title: String
    let userDescription: String
    let surveyType: SurveyType
    let surveyBody: [String: Decodable]
    
    //options
    var allowsDuplicateVotes: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case userDescription = "description"
        case surveyType
        case surveyBody
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.userDescription = try container.decode(String.self, forKey: .userDescription)
        self.surveyType = try container.decode(SurveyType.self, forKey: .surveyType)
        
        let dataFromContainer = try container.decode(Data.self, forKey: .surveyBody)
        let jsonFromData = try JSONSerialization.jsonObject(with: dataFromContainer, options: .allowFragments)
        guard let dictionary = jsonFromData as? [String: Decodable] else {
            throw DecodingError.typeMismatch([String: Decodable].self, .init(codingPath: [CodingKeys.surveyBody], debugDescription: "Failed to find a dictionary at coding key"))
        }
        
        self.surveyBody = dictionary
        
        if let options = self.surveyBody["options"] as! [String: Decodable]? {
            
            guard let allowsDuplicateVotes = options["adv"] as! Bool? else {
                throw DecodingError.typeMismatch([String: Decodable].self, .init(codingPath: [CodingKeys.surveyBody], debugDescription: "Failed to find value allowsDuplicateVotes"))
            }
            
            self.allowsDuplicateVotes = allowsDuplicateVotes
        }
    }
}

class ScanToVoteSurvey: Survey {
    
    var nParticipants: Int = 0
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        //TODO: decode from surveyBody dictionary
        if let value = self.surveyBody["participants"] as! Int? {
            self.nParticipants = value
        }
    }
}
