//
//  SurveyTitleViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyTitleViewController: UIViewController {

    // MARK: - VARS
    
    var manager: CreateSurveyManager!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    private func updateUI() {
        textFieldTitle.text = manager.survey.userTitle
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @objc func pressNext(_ sender: UIBarButtonItem) {
        
        //TODO: validate input
        if let title = textFieldTitle.text {
            manager.updateUserTitle(with: title)
            
            let surveyDescriptionVc = SurveyDescriptionViewController()
            surveyDescriptionVc.manager = self.manager
            
            navigationController?.pushViewController(surveyDescriptionVc, animated: true)
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nextButton = UIBarButtonItem(
            title: "Next",
            style: .done,
            target: self,
            action: #selector(pressNext(_:))
        )
        navigationItem.setRightBarButton(nextButton, animated: false)
        
        updateUI()
    }

}
