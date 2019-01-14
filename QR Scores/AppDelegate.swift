//
//  AppDelegate.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate! as! AppDelegate
    }

    var window: UIWindow?
    
    var alertWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        self.assignInitialRootViewController(for: window)
        
        return true
    }
    
    func assignInitialRootViewController(for window: UIWindow) {
        let rootViewController: UIViewController
        
        if UserPersistence.hasUserLoggedIn {
            rootViewController = NavigationController()
        } else {
            let loginSb = UIStoryboard(name: "Splash", bundle: nil)
            guard let loginVc = loginSb.instantiateInitialViewController() else {
                fatalError("storyboard not set up correctly")
            }
            
            rootViewController = loginVc
        }
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }


}

extension UIWindow {
    static var applicationAlertWindow: UIWindow {
        
        let appDelegate = AppDelegate.shared
        let alertWindow: UIWindow
        if let window = appDelegate.alertWindow {
            alertWindow = window
        } else {
            
            guard let appDelegateWindow = appDelegate.window else {
                fatalError("¯\\_(ツ)_/¯")
            }
            
            alertWindow = UIWindow(frame: appDelegateWindow.bounds)
            appDelegate.alertWindow = alertWindow
            alertWindow.windowLevel = UIWindow.Level.alert// + 1
        }
        
        return alertWindow
    }
}
