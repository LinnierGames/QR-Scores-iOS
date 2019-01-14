//
//  UIViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 1/13/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private var rootVc: UIViewController? {
        let rootVc = AppDelegate.shared.window!.rootViewController
        
        if let navRoot = rootVc as? UINavigationController {
            return navRoot.viewControllers.first
        }
        
        return rootVc
    }
    func presentSplash() {
        let rootVc = self.rootVc!
        
        if rootVc is SplashViewController {
            AppDelegate.shared.window!.rootViewController!.dismiss(animated: true)
        } else {
            let loginSb = UIStoryboard(name: "Splash", bundle: nil)
            guard let loginVc = loginSb.instantiateInitialViewController() else {
                fatalError("storyboard not set up correctly")
            }
            
            self.present(loginVc, animated: true) { [weak self] in
                self?.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    func presentHome() {
        if rootVc is SurveysViewController {
            AppDelegate.shared.window!.rootViewController!.dismiss(animated: true)
        } else {
            self.present(NavigationController(), animated: true) { [unowned self] in
                self.navigationController?.popViewController(animated: false)
            }
        }
    }
}
