//
//  Survey.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/4/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

struct Survey: Decodable {
    let id: String
    let title: String
    let subtitle: String
    var numberOfParticipants: Int
    let generatedUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case subtitle
        case numberOfParticipants
        case generatedUrl
    }
}

struct SurveyType {
    let title: String
    let descriptionValue: String
    
    struct Option {
        let name: String //Allow Duplicate votes
        let type: String //String, Boolean, Number
    }
    let additionalOptions: [Option]
}
