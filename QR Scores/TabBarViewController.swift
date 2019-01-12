//
//  TabBarViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 1/11/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        // User Surveys Tab
        let surveyVc = SurveysViewController.initFromXib()
        surveyVc.title = "My Surveys"
        surveyVc.tabBarItem.image = #imageLiteral(resourceName: "tab-surveys")
        surveyVc.tabBarItem.selectedImage = #imageLiteral(resourceName: "tab-surveys-highlighted")
        let surveyNavVc = UINavigationController(rootViewController: surveyVc)
        
        // Settings/Logout
        let settingsVc = SettingsTableViewController()
        settingsVc.title = "Settings"
        settingsVc.tabBarItem.image = #imageLiteral(resourceName: "tab-settings")
        settingsVc.tabBarItem.selectedImage = #imageLiteral(resourceName: "tab-settings-highlighted")
        let settingsNavVc = UINavigationController(rootViewController: settingsVc)
        
        self.viewControllers = [surveyNavVc, settingsNavVc]
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
