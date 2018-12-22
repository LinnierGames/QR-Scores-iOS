//
//  SurveyTypeCoordinator.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyTypeCoordinator: Coordinator {
    
    let presenter: UINavigationController
    var surveyTypeViewController: SurveyTypeViewController?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let surveyTypeVc = SurveyTypeViewController()
        surveyTypeVc.vcDelegate = self
        presenter.pushViewController(surveyTypeVc, animated: true)
        surveyTypeViewController = surveyTypeVc
    }
}

extension SurveyTypeCoordinator: SurveyTypeViewControllerDelegate {
    func surveyType(_ surveyType: SurveyTypeViewController, didPressCancel button: UIBarButtonItem) {
        presenter.dismiss(animated: true)
    }
}
