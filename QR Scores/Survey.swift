//
//  Survey.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
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

struct SurveyUpload: Encodable {
    let title: String
    let subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
    }
}
