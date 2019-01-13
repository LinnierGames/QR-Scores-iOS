//
//  SurveyTableViewCell.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/11/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyTableViewCell: UITableViewCell {
    
    // MARK: - VARS
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static let identifier = "survey cell"
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func configure(_ survey: Survey) {
        self.labelTitle.text = survey.title
        self.labelSubtitle.text = survey.description
        
        check(
            survey: survey,
            scanToVote: { (survey) in
                self.labelCount.text = "count: \(survey.numberOfParticipants)"
        },
            likeOrDislike: { (survey) in
                self.labelCount.text = "count: \(survey.numberOfParticipants)"
        },
            sliderAverage: { (survey) in
                self.labelCount.text = "count: \(survey.numberOfParticipants)"
        },
            sliderHistogram: { (survey) in
                self.labelCount.text = "count: \(survey.numberOfParticipants)"
        })
        
        self.accessoryType = .disclosureIndicator
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelCount: UILabel!
    
    // MARK: - LIFE CYCLE
}
