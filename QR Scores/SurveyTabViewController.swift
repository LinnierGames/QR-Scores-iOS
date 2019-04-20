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
    
    final var manager: DetailedSurveyManager
    
    final var tabBarControllerNavItem: UINavigationItem {
        return self.tabBarController!.navigationItem
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarControllerNavItem.title = self.title
    }

}
