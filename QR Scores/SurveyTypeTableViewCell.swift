//
//  SurveyTypeTableViewCell.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyTypeTableViewCell: UITableViewCell, RegisterableCell {
    
    // MARK: - VARS
    
    static var identifier: String = "survey type cell"
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func configure(_ survey: SurveyType) {
        
        //TODO: survey type icon
        labelTitle.text = survey.title
        labelDescription.text = survey.description
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    // MARK: - LIFE CYCLE
}
