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
    
    private(set) var survey: Survey
    
    var surveyTypeTitle: String {
        return survey.surveyType.title
    }
    
    var surveyTypeDescription: String {
        return survey.surveyType.description
    }
    
    private let networking = InternalAPI()
    
    init(survey: Survey) {
        self.survey = survey
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func updateSurvey(completion: @escaping (Bool) -> Void) {
        networking.update(self.survey) { (result) in
            switch result {
            case .success(let updatedSurvey):
                self.survey = updatedSurvey
                
                completion(true)
            case .failure(let err):
                assertionFailure(err.localizedDescription)
                
                completion(false)
            }
        }
    }
    
    func toggleClosedSurvey(completion: @escaping (Bool) -> Void) {
        
        survey.isClosed.invert()
        updateSurvey(completion: completion)
    }
    
    func deleteSurvey(completion: @escaping (Bool) -> Void) {
        networking.delete(self.survey) { (result) in
            switch result {
            case .success:
                completion(true)
            case .failure(let err):
                assertionFailure(err.localizedDescription)
                
                completion(false)
            }
        }
    }
}
