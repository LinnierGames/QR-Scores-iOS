//
//  SurveyDetailedTabBarViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyDetailedTabBarViewController: UITabBarController {
    
    // MARK: - VARS
    
    var manager: DetailedSurveyManager!
    
    // MARK: - RETURN VALUES
    
    static func instantiate(with survey: Survey) -> SurveyDetailedTabBarViewController {
        let tabVc = SurveyDetailedTabBarViewController()
        let detailedSurveyManager = DetailedSurveyManager(survey: survey)
        
        // info tab
        let infoVc = SurveyInfoViewController(manager: detailedSurveyManager)
        tabVc.addChild(infoVc)
        
        // participants tab
        var particpantsVc: SurveyParticipationViewController! = nil
        check(survey: survey,
              scanToVote: { (scan) in
                particpantsVc = SurveyParticipantsForScanToVoteViewController(manager: detailedSurveyManager)
        },
              likeOrDislike: { (likeDislike) in
                
        },
              sliderAverage: { (sliderAverage) in
                
        },
              sliderHistogram: { (sliderHistogram) in
                
        })
        
        particpantsVc.title = "Participants"
        tabVc.addChild(particpantsVc)
        
        
        // share tab
        
        // survey settings tab
        
        // setup tabBarController
        tabVc.manager = detailedSurveyManager
        
        return tabVc
    }
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}

extension UINavigationController {
    convenience init(rootViewController: UIViewController, withBackButton: Bool) {
        self.init(rootViewController: rootViewController)
        
//        self.navigationItem.
    }
}
