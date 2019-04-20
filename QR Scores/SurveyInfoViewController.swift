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
        
        viewAlert.isHidden = manager.survey.isClosed.inverse
    }
    
    @objc private func dismissKeyboard() {
        tabBarControllerNavItem.setHidesBackButton(false, animated: true)
        tabBarControllerNavItem.setRightBarButton(nil, animated: true)
        
        textFieldTitle.resignFirstResponder()
        textViewDescription.resignFirstResponder()
        
        uploadSurvey()
    }
    
    private func keyboardWillAppear() {
        tabBarControllerNavItem.setHidesBackButton(true, animated: true)
        tabBarControllerNavItem.setRightBarButton(
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard)),
            animated: true
        )
    }
    
    private func uploadSurvey() {
        manager.updateSurvey { (isSuccessful) in
            if isSuccessful {
                //TODO: update ui
            } else {
                UIAlertController(errorMessage: nil)
                    .present(in: self)
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var labelViewAlert: UILabel!
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

extension SurveyInfoViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardWillAppear()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newTitle = textField.text else {
            return
        }
        
        manager.survey.title = newTitle
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        keyboardWillAppear()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let newDescription = textView.text else {
            return
        }
        
        manager.survey.description = newDescription
    }
}
