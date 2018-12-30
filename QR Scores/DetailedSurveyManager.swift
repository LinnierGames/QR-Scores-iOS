//
//  DetailedSurveyManager.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

class DetailedSurveyManager {
    
    // MARK: - VARS
    
    let survey: Survey
    
    var surveyTypeTitle: String {
        return survey.surveyType.title
    }
    
    var surveyTypeDescription: String {
        return survey.surveyType.description
    }
    
    init(survey: Survey) {
        self.survey = survey
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func updateSurvey(completion: @escaping (Bool) -> Void) {
        
    }
    
    func closeSurvey(completion: @escaping (Bool) -> Void) {
        
    }
    
    func deleteSurvey(completion: @escaping (Bool) -> Void) {
        
    }
}
