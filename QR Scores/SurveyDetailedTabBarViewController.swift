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
        infoVc.title = "Info"
        tabVc.addChild(infoVc)
        
        // participants tab
        var particpantsVc: SurveyParticipationViewController! = nil
        check(survey: survey,
              scanToVote: { (scan) in
                particpantsVc = SurveyParticipantsForScanToVoteViewController(manager: detailedSurveyManager)
        },
              likeOrDislike: { (likeDislike) in
                particpantsVc = SurveyParticipantsForLikeDislikeViewController(manager: detailedSurveyManager)
        },
              sliderAverage: { (sliderAverage) in
                particpantsVc = SurveyParticipantsForSliderAverageViewController(manager: detailedSurveyManager)
        },
              sliderHistogram: { (sliderHistogram) in
                particpantsVc = SurveyParticipantsForSliderHistogramViewController(manager: detailedSurveyManager)
        })
        
        particpantsVc.title = "Participants"
        tabVc.addChild(particpantsVc)
        
        
        // share tab
        let shareTableSb = UIStoryboard(name: String(describing: SurveyShareTableViewController.self), bundle: nil)
        guard let shareTableVc = shareTableSb.instantiateInitialViewController() as? SurveyShareTableViewController else {
            fatalError("storyboard not set up correctly")
        }
        
        shareTableVc.manager = detailedSurveyManager
        tabVc.addChild(shareTableVc)
        
        // survey settings tab
        let settingsTableSb = UIStoryboard(name: String(describing: SurveySettingsViewController.self), bundle: nil)
        guard let settingsTableVc = settingsTableSb.instantiateInitialViewController() as? SurveySettingsViewController else {
            fatalError("storyboard not set up correctly")
        }
        
        settingsTableVc.manager = detailedSurveyManager
        tabVc.addChild(settingsTableVc)
        
        // setup tabBarController
        tabVc.manager = detailedSurveyManager
        
        return tabVc
    }
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}
