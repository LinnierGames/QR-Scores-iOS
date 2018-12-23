//
//  SurveyParticipationViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyParticipationViewController: SurveyTabViewController {
    
    // MARK: - VARS
    
    var participantVisual: UIView? {
        get {
            return nil
        }
    }
    
    override var nibName: String? {
        return "SurveyParticipationViewController"
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func updateUI() {
        labelSurveyType.text = manager.surveyTypeTitle
        labelSurveyDescription.text = manager.surveyTypeDescription
    }
    
    override func loadView() {
        super.loadView()
        
        if let view = participantVisual {
            stackViewContent.addArrangedSubview(view)
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet private weak var stackViewContent: UIStackView!
    @IBOutlet private weak var labelSurveyType: UILabel!
    @IBOutlet private weak var labelSurveyDescription: UILabel!
    @IBOutlet weak var labelNumberOfParticipants: UILabel!
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
}
