//
//  TabBarViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 1/11/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    // MARK: - VARS
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    private func configure() {
        let surveyVc = SurveysViewController.initFromXib()
        self.pushViewController(surveyVc, animated: false)
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}
