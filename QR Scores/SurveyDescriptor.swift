//
//  SurveyDescriptor.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/6/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

enum SurveyType: Int, Codable, CaseIterable {
    
    //TODO: other survey types
    case scanToVote
//    case likeDislike
//    case sliderAverage
//    case sliderHistogram
    
    var title: String {
        switch self {
        case .scanToVote:
            return "Scan to Vote"
        }
    }
    
    var description: String {
        switch self {
        case .scanToVote:
            return "something about this survey"
        }
    }
    
    var associatedSurveyType: DescriptorSurvey.Type {
        switch self {
        case .scanToVote:
            return DescriptorScanToVoteSurvey.self
        }
    }
}

protocol DescriptorSurvey {
    
    var type: SurveyType { get }
    
    var userTitle: String { get set }
    var userDescription: String { get set }
    
    //create a blank survey
    static func createBlankSurvey() -> Self
    
    var additionalInfo: [DescriptorAdditionalInfo] { get }
    
    //TODO: validations-computed var that validates the additional info
//    func isSurveyValid: Bool { get }
}

struct DescriptorAdditionalInfo {
    
    enum ValueType {
        case string(value: String)
        case boolean(value: Bool)
        case number(value: NSNumber)
    }
    
    let title: String
    var userValue: ValueType
    
    var string: String? {
        switch self.userValue {
        case .string(let value):
            return value
        default:
            return nil
        }
    }
    
    var boolean: Bool? {
        switch self.userValue {
        case .boolean(let value):
            return value
        default:
            return nil
        }
    }
    
    var number: NSNumber? {
        switch self.userValue {
        case .number(let value):
            return value
        default:
            return nil
        }
    }
    
    init(title: String, string: String) {
        self.title = title
        self.userValue = .string(value: string)
    }
    
    init(title: String, boolean: Bool) {
        self.title = title
        self.userValue = .boolean(value: boolean)
    }
    
    init(title: String, number: Int) {
        self.title = title
        self.userValue = .number(value: NSNumber(value: number))
    }
    
    static var allowsDuplicateVotes = DescriptorAdditionalInfo(
        title: "Allows Duplicate Votes",
        boolean: false
    )
}

struct DescriptorScanToVoteSurvey: DescriptorSurvey {
    
    let type: SurveyType = .scanToVote
    
    static func createBlankSurvey() -> DescriptorScanToVoteSurvey {
        let survey = self.init(
            userTitle: "",
            userDescription: "",
            additionalInfo: [
                .allowsDuplicateVotes
            ]
        )
        
        return survey
    }
    
    var userTitle: String
    var userDescription: String
    var additionalInfo: [DescriptorAdditionalInfo]
}

//TODO: other survey types
//struct DescriptorLikeDislikeSurvey: DescriptorSurvey { ... }
//struct DescriptorSliderAverageSurvey: DescriptorSurvey { ... }
//struct DescriptorSliderHistogramSurvey: DescriptorSurvey { ... }
