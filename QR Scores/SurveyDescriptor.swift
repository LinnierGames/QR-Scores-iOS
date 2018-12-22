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
    case likeDislike
    case sliderAverage
    case sliderHistogram
    
    var title: String {
        switch self {
        case .scanToVote:
            return "Scan to Vote"
        case .likeDislike:
            return "Like or Dislike"
        case .sliderAverage:
            return "Slider (Average)"
        case .sliderHistogram:
            return "Slider (Histogram)"
        }
    }
    
    var description: String {
        
        //TODO: write survey descriptions
        switch self {
        case .scanToVote:
            return "something about this survey"
        case .likeDislike:
            return "something about this survey"
        case .sliderAverage:
            return "something about this survey"
        case .sliderHistogram:
            return "something about this survey"
        }
    }
    
    var associatedSurveyType: DescriptorSurvey.Type {
        switch self {
        case .scanToVote:
            return DescriptorScanToVoteSurvey.self
        case .likeDislike:
            return DescriptorLikeDislikeSurvey.self
        case .sliderAverage:
            return DescriptorSliderAverageSurvey.self
        case .sliderHistogram:
            return DescriptorSliderHistogramSurvey.self
        }
    }
}

protocol DescriptorSurvey {
    
    var type: SurveyType { get }
    
    var userTitle: String { get set }
    var userDescription: String { get set }
    
    //create a blank survey
    static func createBlankSurvey() -> Self
    
    var additionalInfo: [String: ValueType] { get set }
    
    //TODO: validations-computed var that validates the additional info
//    func isSurveyValid: Bool { get }
}

enum ValueType {
    case string(value: String)
    case boolean(value: Bool)
    case number(value: NSNumber)
    
    var string: String? {
        switch self {
        case .string(let value):
            return value
        default:
            return nil
        }
    }
    
    var boolean: Bool? {
        switch self {
        case .boolean(let value):
            return value
        default:
            return nil
        }
    }
    
    var number: NSNumber? {
        switch self {
        case .number(let value):
            return value
        default:
            return nil
        }
    }
}

struct DescriptorAdditionalInfo {
    
//    let title: String
    var userValue: ValueType
    
//    init(title: String, string: String) {
//        self.title = title
//        self.userValue = .string(value: string)
//    }
//
//    init(title: String, boolean: Bool) {
//        self.title = title
//        self.userValue = .boolean(value: boolean)
//    }
//
//    init(title: String, number: Int) {
//        self.title = title
//        self.userValue = .number(value: NSNumber(value: number))
//    }
//
//    static var allowsDuplicateVotes = DescriptorAdditionalInfo(
//        title: "Allows Duplicate Votes",
//        boolean: false
//    )
}

//extension DescriptorAdditionalInfo: Hashable {
//    static func == (lhs: DescriptorAdditionalInfo, rhs: DescriptorAdditionalInfo) -> Bool {
//        return lhs.title == rhs.title
//    }
//
//    var hashValue: Int {
//        return title.hashValue
//    }
//}

struct DescriptorScanToVoteSurvey: DescriptorSurvey {
    
    let type: SurveyType = .scanToVote
    
    static func createBlankSurvey() -> DescriptorScanToVoteSurvey {
        let survey = self.init(
            userTitle: "",
            userDescription: "",
            additionalInfo: [
                "Allows Duplicate Votes": .boolean(value: false)
            ]
        )
        
        return survey
    }
    
    var userTitle: String
    var userDescription: String
    var additionalInfo: [String: ValueType]
}

struct DescriptorLikeDislikeSurvey: DescriptorSurvey {
    
    let type: SurveyType = .scanToVote
    
    static func createBlankSurvey() -> DescriptorLikeDislikeSurvey {
        let survey = self.init(
            userTitle: "",
            userDescription: "",
            additionalInfo: [
                "Allows Duplicate Votes": .boolean(value: false)
            ]
        )
        
        return survey
    }
    
    var userTitle: String
    var userDescription: String
    var additionalInfo: [String: ValueType]
}

struct DescriptorSliderAverageSurvey: DescriptorSurvey {
    
    let type: SurveyType = .scanToVote
    
    static func createBlankSurvey() -> DescriptorSliderAverageSurvey {
        let survey = self.init(
            userTitle: "",
            userDescription: "",
            additionalInfo: [
                "Allows Duplicate Votes": .boolean(value: false)
            ]
        )
        
        return survey
    }
    
    var userTitle: String
    var userDescription: String
    var additionalInfo: [String: ValueType]
}

struct DescriptorSliderHistogramSurvey: DescriptorSurvey {
    
    let type: SurveyType = .scanToVote
    
    static func createBlankSurvey() -> DescriptorSliderHistogramSurvey {
        let survey = self.init(
            userTitle: "",
            userDescription: "",
            additionalInfo: [
                "Allows Duplicate Votes": .boolean(value: false)
            ]
        )
        
        return survey
    }
    
    var userTitle: String
    var userDescription: String
    var additionalInfo: [String: ValueType]
}
