//
//  SurveyParticipantsForScanToVoteViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyParticipantsForScanToVoteViewController: SurveyParticipationViewController {

    // MARK: - VARS
    
    private var survey: ScanToVoteSurvey {
        return manager.survey as! ScanToVoteSurvey
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    override func updateUI() {
        super.updateUI()
        
        labelNumberOfParticipants.text = String(survey.participants.count)
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}
