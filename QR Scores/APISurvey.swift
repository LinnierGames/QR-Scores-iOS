//
//  Survey.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

protocol CreateSurvey {
    var surveyMetadata: SurveyMetadata { get }
    var options: SurveyOptions { get }
}

protocol CreateSurveyProtocol {
    associatedtype Metadata: SurveyMetadata
    associatedtype Options: SurveyOptions
    
    var surveyMetadata: Metadata { get }
    var options: Options { get }
}

extension CreateSurveyProtocol {
    
    var type: Int {
        return self.surveyMetadata.type
    }
    
    var title: String {
        return self.surveyMetadata.title
    }
    
    var description: String {
        return self.surveyMetadata.description
    }
    
    var allowsDuplicateVotes: Bool {
        return self.options.allowsDuplicateVotes
    }
}

protocol SurveyMetadata {
    var type: Int { get }
    var title: String { get }
    var description: String { get }
}

protocol SurveyOptions {
    var allowsDuplicateVotes: Bool { get }
}

struct CreateScanToVoteSurvey: CreateSurveyProtocol, Encodable {
    
    struct Metadata: SurveyMetadata, Encodable {
        let type: Int
        let title: String
        let description: String
    }
    let surveyMetadata: Metadata
    
    struct Options: SurveyOptions, Encodable {
        let allowsDuplicateVotes: Bool
    }
    let options: Options
    
    init(title: String, description: String, options: Options) {
        let metadata = Metadata(
            type: 0,
            title: title,
            description: description
        )
        self.surveyMetadata = metadata
        self.options = options
    }
}

struct CreateLikeOrDislikeSurvey: CreateSurveyProtocol, Encodable {
    
    struct Metadata: SurveyMetadata, Encodable {
        let type: Int
        let title: String
        let description: String
    }
    let surveyMetadata: Metadata
    
    struct Options: SurveyOptions, Encodable {
        let allowsDuplicateVotes: Bool
    }
    let options: Options
    
    init(title: String, description: String, options: Options) {
        let metadata = Metadata(
            type: 1,
            title: title,
            description: description
        )
        self.surveyMetadata = metadata
        self.options = options
    }
}

struct CreateSliderAverageSurvey: CreateSurveyProtocol, Encodable {
    
    struct Metadata: SurveyMetadata, Encodable {
        let type: Int
        let title: String
        let description: String
        
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
        let left = Metadata.SliderMetadata(title: leftTitle, color: leftColor)
        let right = Metadata.SliderMetadata(title: rightTitle, color: rightColor)
        
        let metadata = Metadata(
            type: 2,
            title: title,
            description: description,
            left: left,
            right: right
        )
        self.surveyMetadata = metadata
        self.options = options
    }
}

struct SurveyDecoder {
    
    private struct TypeChecker: Decodable {
        struct SurveyMetaData: Decodable {
            let type: SurveyType
        }
        let surveyMetadata: SurveyMetaData
    }
    
    static func decode(from data: Data) -> Survey? {
        guard let type = try? JSONDecoder().decode(TypeChecker.self, from: data) else {
            return nil
        }

        return decode(from: data, using: type.surveyMetadata.type)
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
