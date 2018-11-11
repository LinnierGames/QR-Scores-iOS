//
//  ViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class LoginRegisterViewController: UIViewController, Interfacable {

    // MARK: - VARS
    
    var viewModel = LoginViewModel()
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func presentMainView() {
        if let mainVc = self.presentingViewController {
            mainVc.dismiss(animated: true)
        } else {
            
            //TODO: DRY
            let tabController = UITabBarController()
            
            // User Surveys Tab
            let surveyVc = SurveysViewController.initFromXib()
            let surveyNavVc = UINavigationController(rootViewController: surveyVc)
            tabController.viewControllers = [surveyNavVc]
            
            self.present(tabController, animated: true)
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBAction func pressSignUp(_ sender: Any) {
        viewModel.signUp(name: textFieldName.text!, email: textFieldEmail.text!, password: textFieldPassword.text!) { [weak self] (result) in
            
            switch result {
            case .accountCreated:
                self?.presentMainView()
            case .duplicateAccount:
                self?.labelMessage.text = "email taken"
            case .unexpectedError:
                self?.labelMessage.text = "something was wrong"
            }
        }
    }
    
    @IBAction func pressLogin(_ sender: Any) {
        viewModel.login(email: textFieldEmail.text!, password: textFieldPassword.text!) { [weak self] (validLogin) in
            
            if validLogin {
                self?.presentMainView()
            } else {
                self?.labelMessage.text = "invalid login"
            }
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

