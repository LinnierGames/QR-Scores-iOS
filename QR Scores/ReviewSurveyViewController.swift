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
        let surey = manager.survey
        
        labelSurveyTypeTitle.text = surey.type.title
        labelSurveyTypeDescription.text = surey.type.description
        
        labelSurveyUserTitle.text = surey.userTitle
        labelSurveyUserDescription.text = surey.userDescription
        labelAllowDuplicateVotesValue.text = surey.additionalInfo["Allows Duplicate Votes"]!.boolean! ? "Yes" : "No"
    }
    
    private func discardSurvey() {
        presentingViewController!.dismiss(animated: true)
    }
    
    // MARK: - IBACTIONS
    
    //TODO: use a table view to populate survey values
    @IBOutlet weak var labelSurveyTypeTitle: UILabel!
    @IBOutlet weak var labelSurveyTypeDescription: UILabel!
    @IBOutlet weak var labelSurveyUserTitle: UILabel!
    @IBOutlet weak var labelSurveyUserDescription: UILabel!
    
    @IBOutlet weak var labelAllowDuplicateVotes: UILabel!
    @IBOutlet weak var labelAllowDuplicateVotesValue: UILabel!
    
    @IBOutlet weak var buttonSubmit: UIButton! {
        didSet {
            UIDesignable
                .applyPrimaryButton(to: buttonSubmit)
                .margin(UIEdgeInsets(top: 12, left: 64, bottom: 12, right: 64))
        }
    }
    
    @IBAction func pressSubmit(_ barButton: UIBarButtonItem) {
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
    
    @IBAction func pressDiscard(_ sender: Any) {
        UIAlertController(title: nil, message: "Are you sure you want to discard this survey?", preferredStyle: .actionSheet)
            .addButton(title: "Discard Survey", style: .destructive) { [weak self] _ in
                self?.discardSurvey()
            }
            .addCancelButton()
            .present(in: self)
    }
    
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Review Survey"
        
        updateUI()
    }
}
