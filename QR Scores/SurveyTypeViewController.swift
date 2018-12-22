//
//  SurveyTypeViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

protocol SurveyTypeViewControllerDelegate: class {
    func surveyType(_ surveyType: SurveyTypeViewController, didPressCancel button: UIBarButtonItem)
}

class SurveyTypeViewController: UIViewController {
    
    // MARK: - VARS
    
    weak var vcDelegate: SurveyTypeViewControllerDelegate?
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    @objc func pressCancel(_ barButton: UIBarButtonItem) {
        vcDelegate?.surveyType(self, didPressCancel: barButton)
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create a New Survey!"
        
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(pressCancel(_:))
        )
        navigationItem.setLeftBarButton(cancelButton, animated: false)
    }

}
