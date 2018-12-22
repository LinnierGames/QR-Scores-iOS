//
//  ReviewSurveyViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ReviewSurveyViewController: UIViewController {
    /**
     make note, this vc removes the back button of its naviagtion
     */
    
    // MARK: - VARS
    
    var manager: CreateSurveyManager!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    private func updateUI() {
        
        //TODO: display the survey details
    }
    
    // MARK: - IBACTIONS
    
    @objc func pressSubmit(_ barButton: UIBarButtonItem) {
        manager.submitSurvey { [weak self] (successful) in
            guard let unwrappedSelf = self else { return }
            
            if successful {
                unwrappedSelf.presentingViewController?.dismiss(animated: true)
            } else {
                UIAlertController(title: "Uploading a Survey", message: "Something went wrong", preferredStyle: .alert)
                    .addDismissButton()
                    .present(in: unwrappedSelf)
            }
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let submitButton = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(pressSubmit(_:))
        )
        navigationItem.setRightBarButton(submitButton, animated: false)
        
        updateUI()
    }
}
