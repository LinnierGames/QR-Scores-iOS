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
        infoVc.tabBarItem.image = #imageLiteral(resourceName: "tab-info")
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
        particpantsVc.tabBarItem.image = #imageLiteral(resourceName: "tab-people")
        tabVc.addChild(particpantsVc)
        
        // share tab
        let shareTableSb = UIStoryboard(name: String(describing: SurveyShareTableViewController.self), bundle: nil)
        guard let shareTableVc = shareTableSb.instantiateInitialViewController() as? SurveyShareTableViewController else {
            fatalError("storyboard not set up correctly")
        }
        
        shareTableVc.manager = detailedSurveyManager
        shareTableVc.tabBarItem.image = #imageLiteral(resourceName: "tab-share-qr-code")
        tabVc.addChild(shareTableVc)
        
        // survey settings tab
        var settingsTableVc: SurveySettingsViewController! = nil
        check(survey: survey,
              scanToVote: { (scan) in
                settingsTableVc = ScanToVoteSurveySettingsViewController()
        },
              likeOrDislike: { (likeDislike) in
                settingsTableVc = ScanToVoteSurveySettingsViewController()
        },
              sliderAverage: { (sliderAverage) in
                settingsTableVc = ScanToVoteSurveySettingsViewController()
        },
              sliderHistogram: { (sliderHistogram) in
                settingsTableVc = ScanToVoteSurveySettingsViewController()
        })
        settingsTableVc.manager = detailedSurveyManager
        settingsTableVc.title = "More"
        settingsTableVc.tabBarItem.image = #imageLiteral(resourceName: "tab-survey-settings")
        tabVc.addChild(settingsTableVc)
        
        // setup tabBarController
        tabVc.manager = detailedSurveyManager
        
        return tabVc
    }
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}
