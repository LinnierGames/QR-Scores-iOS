//
//  Survey.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

protocol CreateSurveyProtocol {
    associatedtype Metadata: SurveyMetadata
    associatedtype Options: SurveyOptions
    
    var title: String { get }
    var description: String { get }
    var surveyType: SurveyType { get }
    
    var surveyMetadata: Metadata { get }
    var options: Options { get }
}

extension CreateSurveyProtocol {
    
    var allowsDuplicateVotes: Bool {
        return self.options.allowsDuplicateVotes
    }
}

protocol SurveyMetadata {
    
}

protocol SurveyOptions {
    var allowsDuplicateVotes: Bool { get }
}

struct CreateScanToVoteSurvey: CreateSurveyProtocol, Encodable {
    
    let title: String
    let description: String
    let surveyType: SurveyType
    
    struct Metadata: SurveyMetadata, Encodable {
        
    }
    let surveyMetadata: Metadata
    
    struct Options: SurveyOptions, Encodable {
        let allowsDuplicateVotes: Bool
    }
    let options: Options
    
    init(title: String, description: String, options: Options) {
        self.title = title
        self.description = description
        self.surveyType = .scanToVote
        
        let metadata = Metadata()
        self.surveyMetadata = metadata
        self.options = options
    }
}

struct CreateLikeOrDislikeSurvey: CreateSurveyProtocol, Encodable {
    
    let title: String
    let description: String
    let surveyType: SurveyType
    
    struct Metadata: SurveyMetadata, Encodable {
        
    }
    let surveyMetadata: Metadata
    
    struct Options: SurveyOptions, Encodable {
        let allowsDuplicateVotes: Bool
    }
    let options: Options
    
    init(title: String, description: String, options: Options) {
        self.title = title
        self.description = description
        
        #error ("replace with actual type")
        self.surveyType = .scanToVote
        
        let metadata = Metadata()
        self.surveyMetadata = metadata
        self.options = options
    }
}

struct CreateSliderAverageSurvey: CreateSurveyProtocol, Encodable {
    
    let title: String
    let description: String
    let surveyType: SurveyType
    
    struct Metadata: SurveyMetadata, Encodable {
        
        struct SliderMetadata: Encodable {
            let title: String
            let color: String // hex
        }
        let left: SliderMetadata
        let right: SliderMetadata
    }
    let surveyMetadata: Metadata
    
    struct Options: SurveyOptions, Encodable {
        let allowsDuplicateVotes: Bool
    }
    let options: Options
    
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
    
    init(title: String, description: String, leftTitle: String, leftColor: String, rightTitle: String, rightColor: String, options: Options) {
        self.title = title
        self.description = description
        
        #error ("replace with actual type")
        self.surveyType = .scanToVote
        
        let left = Metadata.SliderMetadata(title: leftTitle, color: leftColor)
        let right = Metadata.SliderMetadata(title: rightTitle, color: rightColor)
        
        let metadata = Metadata(
            left: left,
            right: right
        )
        self.surveyMetadata = metadata
        self.options = options
    }
}

//TODO: create CreateSliderHistogramSurvey

struct SurveyDecoder {
    
    private struct TypeChecker: Decodable {
        let surveyType: SurveyType
    }
    
    static func decode(from data: Data) throws -> Survey {
        let type = try JSONDecoder().decode(TypeChecker.self, from: data)

        return try decode(from: data, using: type.surveyType)
    }
    
    static func decode(from data: Data, using type: SurveyType) throws -> Survey {
        switch type {
        case .scanToVote:
            let survey = try JSONDecoder().decode(ScanToVoteSurvey.self, from: data)

            return survey
        }
    }
}
