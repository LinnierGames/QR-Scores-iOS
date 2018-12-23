//
//  SurveyInfoViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyInfoViewController: SurveyTabViewController {

    // MARK: - VARS
    
//    private let keyboard = KeyboardStack()
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    private func updateUI() {
        textFieldTitle.text = manager.survey.title
        textViewDescription.text = manager.survey.description
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var constraintBottomContenStackView: NSLayoutConstraint!
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        keyboard.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }

}
