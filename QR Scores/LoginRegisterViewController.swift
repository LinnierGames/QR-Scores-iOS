//
//  ViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class LoginRegisterViewController: UIViewController, Interfacable {
    
    enum Screen {
        case login
        case register
    }

    // MARK: - VARS
    
    var screen: Screen = .login
    
    private var viewModel = LoginViewModel()
    private var viewAlert: String? {
        set {
            labelMessage.text = newValue
        }
        get {
            return labelMessage.text
        }
    }
    
    // MARK: - RETURN VALUES
    
    private func validate() -> Bool {
        switch screen {
        case .login:
            return textFieldEmail.text.isNotEmpty && textFieldPassword.text.isNotEmpty
        case .register:
            let notEmpty = textFieldEmail.text.isNotEmpty && textFieldName.text.isNotEmpty && textFieldPassword.text.isNotEmpty && textFieldConfirmPassword.text.isNotEmpty
            
            guard notEmpty else {
                viewAlert = "please fill out all missing fields"
                
                return false
            }
            
            guard textFieldPassword.text == textFieldConfirmPassword.text else {
                viewAlert = "passwords do not match"
                
                return false
            }
            
            viewAlert = nil
            
            return true
        }
    }
    
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
            
            self.present(tabController, animated: true) { [unowned self] in
                self.navigationController?.popViewController(animated: false)
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var stackName: UIStackView!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBOutlet weak var stackConfirmPassword: UIStackView!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var buttonAction: UIButton!
    @IBAction func pressAction(_ sender: Any) {
        guard self.validate() else {
            return
        }
        
        //TODO: loading
        switch screen {
        case .login:
            viewModel.login(email: textFieldEmail.text!, password: textFieldPassword.text!) { [weak self] (validLogin) in
                
                if validLogin {
                    self?.presentMainView()
                } else {
                    self?.viewAlert = "invalid login"
                }
            }
        case .register:
            viewModel.signUp(name: textFieldName.text!, email: textFieldEmail.text!, password: textFieldPassword.text!) { [weak self] (result) in
                
                switch result {
                case .accountCreated:
                    self?.presentMainView()
                case .duplicateAccount:
                    self?.viewAlert = "email taken"
                case .unexpectedError:
                    self?.viewAlert = "something was wrong"
                }
            }
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up view based on screen
        switch screen {
        case .login:
            stackName.isHidden = true
            stackConfirmPassword.isHidden = true
            textFieldPassword.textContentType = .password
            buttonAction.setTitle("Login", for: .normal)
            title = "Login"
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

