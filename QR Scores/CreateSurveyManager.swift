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
    
    let availableTypes = SurveyType.allCases
    
    var survey: DescriptorSurvey
    
    init(surveyType: SurveyType) {
        survey = surveyType.associatedSurveyType.createBlankSurvey()
    }
    
    func pickSurvey() {
        for aSurvey in availableTypes {
            let labelTitle = aSurvey.title
            let labelSubtitle = aSurvey.description
        }
    }
    
    func collectInfoFromUser() {
        let additionalInfo = survey.additionalInfo
        
        //poulate the form
        for infoToCollect in additionalInfo {
            
            //create uilabel
            let labelText = infoToCollect.title
            
            //create input component
            if let string = infoToCollect.string {
                //create textfield
            } else if let bool = infoToCollect.boolean {
                //create switch
            } else if let number = infoToCollect.number {
                //create number pickers
            } else {
                
            }
        }
    }
    
    func uploadToDB() {
        
        let title = survey.userTitle
        let description = survey.userDescription
        
        var uploader = SurveyUploader(title: title, description: description)
        
        survey.additionalInfo.forEach { uploader.addProperty($0) }
        
        let stack = InternalAPI()
        stack.createSurvey(uploader, completion: { _ in })
        
        //donwload from DB
        func responseFromDB() -> Survey {
            let dataFromResponse = Data()
            
            guard let survey = SurveyDecoder.decode(from: dataFromResponse, using: survey.type) else {
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
            
            guard let survey = SurveyDecoder.decode(from: aSurveyData) else {
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
            
            let surveyType = selectedSurvey.surveyType
            switch surveyType {
            case .scanToVote:
                let vc = ScanToVoteVc()
                vc.survey = (selectedSurvey as! ScanToVoteSurvey)
                self.present(vc, animated: true)
            }
        }
    }
}
