//
//  SurveysViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveysViewController: UIViewController, Interfacable {
    
    // MARK: - VARS
    
    let viewModel = SurveysViewModel()
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func pressAddSurvey(_ sender: Any) {
        let surveyAlert = UIAlertController(title: "New Survey", message: "enter the details of your new survey", preferredStyle: .alert)
        
        surveyAlert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        surveyAlert.addTextField { (textField) in
            textField.placeholder = "Subtitle"
        }
        
        surveyAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] _ in
            guard
                let title = surveyAlert.textFields?[0].text,
                let subtitle = surveyAlert.textFields?[1].text else {
                    return
            }
            
            self?.viewModel.createSurvey(title: title, subtitle: subtitle)
        }))
        
        surveyAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(surveyAlert, animated: true)
    }
    
    @IBAction func pressLogout(_ sender: Any) {
        UserPersistence.logoutCurrentUser()
        
        if let loginVc = self.tabBarController?.presentingViewController {
            loginVc.dismiss(animated: true)
        } else {
            let loginVc = LoginRegisterViewController.initFromXib()
            self.present(loginVc, animated: true)
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.viewModel.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddSurvey(_:)))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(pressLogout(_:)))
        
        tableView.register(
            SurveyTableViewCell.nib,
            forCellReuseIdentifier: SurveyTableViewCell.identifier
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.surveys.subscribe { [weak self] (newSurveys) in
            self?.tableView.reloadData()
        }
    }
}

extension SurveysViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.surveys.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SurveyTableViewCell.identifier, for: indexPath) as! SurveyTableViewCell
        
        let survey = viewModel.surveys.data[indexPath.row]
        cell.configure(survey)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let survey = viewModel.surveys.data[indexPath.row]
        
        guard let qrImage = QRCoeGenerator(url: survey.generatedUrl).generateImage() else {
            return
        }
        
        guard let pdfData = PDFGenerator().pdf(from: qrImage) else {
            return
        }
        
        let shareVc = UIActivityViewController(activityItems: [pdfData], applicationActivities: [])
        self.present(shareVc, animated: true)
    }
}
