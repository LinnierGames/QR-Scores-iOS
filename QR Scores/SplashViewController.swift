//
//  SplashViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/30/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - VARS
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            guard let loginVc = segue.destination as? LoginRegisterViewController else {
                fatalError("storyboard not set up correctly")
            }
            
            switch identifier {
            case "show login":
                loginVc.screen = .login
            case "show register":
                loginVc.screen = .register
            default: break
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var buttonRegister: UIButton! {
        didSet {
            UIDesignable
                .applyPrimaryButton(to: buttonRegister)
        }
    }
    // MARK: - LIFE CYCLE

}
