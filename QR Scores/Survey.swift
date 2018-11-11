//
//  Survey.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

struct Survey: Codable {
    let id: String
    let title: String
    let subtitle: String
    var numberOfParticipants: Int
    let generatedUrl: URL
    
//    init(title: String, subtitle: String) {
//        self.title = title
//        self.subtitle = subtitle
//        self.numberOfParticipants = 0
//    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case subtitle
        case numberOfParticipants
        case generatedUrl
    }
}

struct SurveyUpload: Codable {
    let id: String?
    let title: String
    let subtitle: String
    var numberOfParticipants: Int
    let generatedUrl: URL?
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.numberOfParticipants = 0

        self.id = nil
        self.generatedUrl = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case subtitle
        case numberOfParticipants
        case generatedUrl
    }
}
