//
//  SurveysViewModel.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

protocol SurveysViewModelDelegate: class {
    func userDidLogout()
}

class SurveysViewModel {
    
    // MARK: - VARS
    
    weak var delegate: SurveysViewModelDelegate?
    
    private(set) var surveys = ReactiveBox([Survey]())
    
    private let networkStack = InternalAPI()
    
    init() {
        self.fetchSurveys()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDidLogout(_:)), name: .userDidLogout, object: nil)
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func fetchSurveys() {        
        networkStack.fetchUserSurveys { [weak self] (result) in
            switch result {
            case .success(let surveys):
                self?.surveys.update(surveys)
            case .failure(let error):
                assertionFailure(error.localizedDescription)
                
                //TODO: handle 401
            }
        }
    }
    
    func createSurvey(title: String, subtitle: String) {
        fatalError("\(#function) not implemented, use the CreateSurveyManager instead")
//        
//        let surveyToUpload = SurveyUpload(title: title, subtitle: subtitle)
//        networkStack.createSurvey(surveyToUpload) { (result) in
//            switch result {
//            case .success(let createdSurvey):
//                self.surveys.append(createdSurvey)
//            case .failure(let error):
//                assertionFailure(error.localizedDescription)
//            }
//        }
    }
    
    @objc private func userDidLogout(_ notification: Notification) {
        delegate?.userDidLogout()
        
        self.surveys.update([])
    }
}
