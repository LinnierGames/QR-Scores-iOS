//
//  CreateSurveyCoordinator.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class CreateSurveyCoordinator: Coordinator {
    
    unowned var presenter: UIViewController
    var surveyTypeCoordinator: SurveyTypeCoordinator?
    
    init(presenter: UIViewController) {
        self.presenter = presenter
    }
    
    func start() {
        let navVc = UINavigationController()
        let surveType = SurveyTypeCoordinator(presenter: navVc)
        surveType.start()
        
        self.surveyTypeCoordinator = surveType
        
        presenter.present(navVc, animated: true)
    }
}
