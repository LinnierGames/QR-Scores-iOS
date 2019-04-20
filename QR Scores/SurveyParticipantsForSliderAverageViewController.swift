//
//  SurveyParticipantsForSliderAverageViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyParticipantsForSliderAverageViewController: SurveyParticipationViewController {
    
    // MARK: - VARS
    
    //TODO: like and dislike counters
    override var participantVisual: UIView? {
        return UISegmentedControl(items: nil)
    }
    
    private var survey: SliderAverageSurvey {
        return manager.survey as! SliderAverageSurvey
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
