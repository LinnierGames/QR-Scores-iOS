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
    @IBAction func pressNext(_ sender: Any) {
        if let title = textFieldTitle.text {
            manager.updateUserTitle(with: title)
            
            
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }

}
