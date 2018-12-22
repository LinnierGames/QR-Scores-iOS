//
//  SurveyDescriptionViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyDescriptionViewController: UIViewController {
    
    // MARK: - VARS
    
    var manager: CreateSurveyManager!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    private func updateUI() {
        if manager.survey.userDescription == "No description" {
            textViewDescription.text = ""
        } else {
            textViewDescription.text = manager.survey.userDescription
        }
    }
    
    private func updateInput() {
        let description = textViewDescription.text.ifEmptyOrNil(use: "No description")
        manager.updateUserDescription(with: description)
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var textViewDescription: UITextView!
    @objc func pressFinish(_ barButton: UIBarButtonItem) {
        
        updateInput()
        
        let reviewSurveyVc = ReviewSurveyViewController()
        reviewSurveyVc.manager = self.manager
        navigationController?.pushViewController(reviewSurveyVc, animated: true)
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let finishButton = UIBarButtonItem(
            title: "Next",
            style: .done,
            target: self,
            action: #selector(pressFinish(_:))
        )
        navigationItem.setRightBarButton(finishButton, animated: false)
        
        updateUI()
        
        textViewDescription.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        updateInput()
    }
}
