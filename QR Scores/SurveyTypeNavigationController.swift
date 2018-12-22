//
//  SurveyTypeNavigationController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyTypeNavigationController: UINavigationController {
    
    // MARK: - VARS
    
    let manager = CreateSurveyManager.init(surveyType: .scanToVote)
    
    // MARK: - RETURN VALUES
    
    static func instantiate() -> SurveyTypeNavigationController {
        let surveyTypeVc = SurveyTypeViewController()
        
        return SurveyTypeNavigationController(rootViewController: surveyTypeVc)
    }
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE

}
