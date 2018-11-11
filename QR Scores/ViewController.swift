//
//  ViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - VARS
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networking = InternalAPI()
        networking.signUpUser(name: "Erick Sannn", email: "e3@g.com", password: "test123") { (result) in
            switch result {
            case .success(let user):
                print(user)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
}

