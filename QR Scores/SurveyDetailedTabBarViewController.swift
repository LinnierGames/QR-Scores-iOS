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
        tabVc.manager = DetailedSurveyManager(survey: survey)
        
        // info tab
        var vc = UIViewController()
        vc.title = "Info"
        vc.view.backgroundColor = .red
        tabVc.addChild(vc)
        
        // participants tab
        var particpantsVc: SurveyParticipationViewController! = nil
        check(survey: survey,
              scanToVote: { (scan) in
                particpantsVc = SurveyParticipantsForScanToVoteViewController(manager: tabVc.manager)
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
        vc = UIViewController()
        vc.title = "Share"
        vc.view.backgroundColor = .blue
        tabVc.addChild(vc)
        
        // survey settings tab
        vc = UIViewController()
        vc.title = "Configure"
        vc.view.backgroundColor = .yellow
        tabVc.addChild(vc)
        
        // setup tabBarController
        
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
