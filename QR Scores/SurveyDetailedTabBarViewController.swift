//
//  SurveyDetailedTabBarViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyDetailedTabBarViewController: UITabBarController {
    
    static func instantiate(with survey: Survey) -> SurveyDetailedTabBarViewController {
        let tabVc = SurveyDetailedTabBarViewController()
        
        
        // info tab
        var vc = UIViewController()
        vc.title = "Info"
        vc.view.backgroundColor = .red
        tabVc.addChild(vc)
        
        // participants tab
        vc = UIViewController()
        vc.title = "Participants"
        vc.view.backgroundColor = .green
        tabVc.addChild(vc)
        
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
}

extension UINavigationController {
    convenience init(rootViewController: UIViewController, withBackButton: Bool) {
        self.init(rootViewController: rootViewController)
        
//        self.navigationItem.
    }
}
