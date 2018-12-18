//
//  Survey.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/4/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

protocol Survey: CreateSurveyProtocol {
    associatedtype Participants: SurveyParticipants
    
    var participants: Participants { get }
}

extension Survey {
    
    var count: Int {
        return self.participants.count
    }
}

protocol SurveyParticipants {
    var count: Int { get }
}

class BaseSurvey {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case surveyMetadata
        case participants
        case options
    }
    
    let id: String = {
        fatalError("this is an abstract class")
    }()
}

class ScanToVoteSurvey: BaseSurvey, Codable, Survey {
    
    var surveyMetadata: Metadata
    struct Metadata: SurveyMetadata, Codable {
        let type: Int
        var title: String
        var description: String
    }
    
    var options: Options
    struct Options: SurveyOptions, Codable {
        var allowsDuplicateVotes: Bool
    }
    
    var participants: Participants
    struct Participants: SurveyParticipants, Codable {
        let count: Int
    }
}

class LikeOrDislikeSurvey: BaseSurvey, Codable, Survey {
    
    var surveyMetadata: Metadata
    struct Metadata: SurveyMetadata, Codable {
        let type: Int
        var title: String
        var description: String
    }
    
    var options: Options
    struct Options: SurveyOptions, Codable {
        var allowsDuplicateVotes: Bool
    }
    
    var participants: Participants
    struct Participants: SurveyParticipants, Codable {
        let count: Int
        let likes: Int
        let dislikes: Int
    }
    
    var likes: Int {
        return participants.likes
    }
    
    var dislikes: Int {
        return participants.dislikes
    }
}

class SliderAverageSurvey: BaseSurvey, Codable, Survey {
    
    var surveyMetadata: Metadata
    struct Metadata: SurveyMetadata, Codable {
        let type: Int
        var title: String
        var description: String
        
        struct SliderData: Codable {
            var title: String
            var color: String
        }
        var left: SliderData
        var right: SliderData
    }
    
    var options: Options
    struct Options: SurveyOptions, Codable {
        var allowsDuplicateVotes: Bool
    }
    
    var participants: Participants
    struct Participants: SurveyParticipants, Codable {
        let count: Int
        let average: Float
    }
    
    var leftTitle: String {
        return surveyMetadata.left.title
    }
    
    var leftColor: String {
        return surveyMetadata.left.color
    }
    
    var rightTitle: String {
        return surveyMetadata.right.title
    }
    
    var rightColor: String {
        return surveyMetadata.right.color
    }
}

class SliderHistogramSurvey: BaseSurvey, Codable, Survey {
    
    var surveyMetadata: Metadata
    struct Metadata: SurveyMetadata, Codable {
        let type: Int
        var title: String
        var description: String
        
        var min: Int
        var max: Int
    }
    
    var options: Options
    struct Options: SurveyOptions, Codable {
        var allowsDuplicateVotes: Bool
    }
    
    var participants: Participants
    struct Participants: SurveyParticipants, Codable {
        let count: Int
        let histogram: [Int: Int]
    }
    
    var min: Int {
        return surveyMetadata.min
    }
    
    var max: Int {
        return surveyMetadata.max
    }
}
