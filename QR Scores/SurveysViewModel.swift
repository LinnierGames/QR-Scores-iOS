//
//  SurveysViewModel.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

class SurveysViewModel {
    
    // MARK: - VARS
    
    private(set) var surveys = ReactiveBox([Survey]())
    
    private let networkStack = InternalAPI()
    
    init() {
        self.fetchSurveys()
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func fetchSurveys() {        
        networkStack.fetchUserSurveys { [weak self] (result) in
            switch result {
            case .success(let surveys):
                self?.surveys.update(surveys)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}
