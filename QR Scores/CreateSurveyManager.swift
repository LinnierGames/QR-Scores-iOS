//
//  CreateSurveyManager.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/4/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

//TODO: remove after mocking
import UIKit.UIViewController

class CreateSurveyManager {
    
    // MARK: - VARS
    
    let availableTypes = SurveyType.allCases
    
    var survey: DescriptorSurvey
    
    init(surveyType: SurveyType) {
        survey = surveyType.associatedSurveyType.createBlankSurvey()
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func updateAdditional(infoKey: String, to newValue: ValueType) {
        survey.additionalInfo[infoKey] = newValue
    }
    
    func updateUserTitle(with newTitle: String) {
        survey.userTitle = newTitle
    }
    
    func updateUserDescription(with newDescription: String) {
        survey.userDescription = newDescription
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    func pickSurvey() {
        for aSurvey in availableTypes {
            let labelTitle = aSurvey.title
            let labelSubtitle = aSurvey.description
        }
    }
    
    func collectInfoFromUser() {
        let additionalInfo = survey.additionalInfo
        
        //poulate the form
        for (title, type) in additionalInfo {
            
            //create uilabel
            let labelText = title
            
            //create input component
            if let string = type.string {
                //create textfield
            } else if let bool = type.boolean {
                //create switch
            } else if let number = type.number {
                //create number pickers
            } else {
                
            }
        }
    }
    
    func uploadToDB() {
        
        let title = survey.userTitle
        let description = survey.userDescription
        
        let stack = InternalAPI()
        switch survey.type {
        case .scanToVote:
            guard
                let allowsDuplicateVotes = self.survey.additionalInfo["Allows Duplicate Votes"]?.boolean else {
                    return assertionFailure("additional info not set up correctly")
            }
            
            let survey = CreateScanToVoteSurvey(
                title: title,
                description: description,
                options: .init(allowsDuplicateVotes: allowsDuplicateVotes))
            
            stack.createSurvey(survey) { (result) in
                
            }
        case .likeDislike:
            let survey = CreateLikeOrDislikeSurvey(title: title, description: description, options: .init(allowsDuplicateVotes: false))
            
            stack.createSurvey(survey) { (result) in
                
            }
        case .sliderAverage:
            guard
                let leftTitle = self.survey.additionalInfo["Left Title"]?.string,
                let leftColor = self.survey.additionalInfo["Left Color"]?.string,
                let rightTitle = self.survey.additionalInfo["Right Title"]?.string,
                let rightColor = self.survey.additionalInfo["Right Color"]?.string,
                let allowsDuplicateVotes = self.survey.additionalInfo["Allows Duplicate Votes"]?.boolean else {
                    return assertionFailure("additional info not set up correctly")
            }
            
            let survey = CreateSliderAverageSurvey(
                title: title,
                description: description,
                leftTitle: leftTitle,
                leftColor: leftColor,
                rightTitle: rightTitle,
                rightColor: rightColor,
                options: .init(allowsDuplicateVotes: allowsDuplicateVotes))
            
            stack.createSurvey(survey) { (result) in
                
            }
        case .sliderHistogram:
            guard
                let min = self.survey.additionalInfo["Min"]?.number?.intValue,
                let max = self.survey.additionalInfo["Max"]?.number?.intValue,
                let allowsDuplicateVotes = self.survey.additionalInfo["Allows Duplicate Votes"]?.boolean else {
                    return assertionFailure("additional info not set up correctly")
            }
            
            let survey = CreateSliderHistogramSurvey(
                title: title,
                description: description,
                min: min,
                max: max,
                options: .init(allowsDuplicateVotes: allowsDuplicateVotes))
            
            stack.createSurvey(survey) { (result) in
                
            }
        }
        
        //donwload from DB
        func responseFromDB() -> Survey {
            let dataFromResponse = Data()
            
            guard let survey = try? SurveyDecoder.decode(from: dataFromResponse, using: survey.type) else {
                fatalError("failed to decode into survey type")
            }
            
            return survey
        }
    }
    
    func downloadFromDB() -> [Survey] {
        let dataFromResponse = Data() //contains array of surveys
        
        guard let surveyDatas = try? JSONDecoder().decode([Data].self, from: dataFromResponse) else {
            return []
        }
        
        var result: [Survey] = []
        
        for aSurveyData in surveyDatas {
            
            guard let survey = try? SurveyDecoder.decode(from: aSurveyData) else {
                continue
            }
            
            result.append(survey)
        }
        
        return result
    }
    
    class SurveyVc: UIViewController {
        
        private var survey: Survey!
        
        private func updateUI() {
            //layout basic info
            
            //layout nParticipants
            
            //layout custom views
            
        }
        
        func surveyInfo() {
            print(self.survey)
        }
    }
    
    class ScanToVoteVc: SurveyVc {
        var survey: ScanToVoteSurvey!
        
        override func surveyInfo() {
            super.surveyInfo()
        }
    }
    
    class SurveysVc: UIViewController {
        
        func presentCorrectVC() {
            let surveys: [Survey] = []
            let indexPath = IndexPath(row: 0, section: 0)
            let selectedSurvey = surveys[indexPath.row]
            
            check(survey: selectedSurvey,
                  scanToVote: { (survey) in
                    let vc = ScanToVoteVc()
                    vc.survey = survey
                    self.present(vc, animated: true)
            }, likeOrDislike: { (survey) in
                
            }, sliderAverage: { (survey) in
                
            }, sliderHistogram: { (survey) in
                
            })
        }
    }
}
