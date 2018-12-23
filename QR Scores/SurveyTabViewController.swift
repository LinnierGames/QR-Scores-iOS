//
//  SurveyTabViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyTabViewController: UIViewController {
    
    // MARK: - VARS
    
    final unowned var manager: DetailedSurveyManager
    
    init(manager: DetailedSurveyManager) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) not implemented")
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE

}
