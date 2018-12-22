//
//  SurveyTypeViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyTypeViewController: UIViewController {
    
    // MARK: - VARS
    
    let surveys = SurveyType.allCases
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var tableView: UITableView!
    
    @objc func pressCancel(_ barButton: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create a New Survey!"
        
        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(pressCancel(_:))
        )
        navigationItem.setLeftBarButton(cancelButton, animated: false)
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationItem.backBarButtonItem = backButton
        
        tableView.register(SurveyTypeTableViewCell.self)
    }
}

extension SurveyTypeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return surveys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SurveyTypeTableViewCell.identifier,
            for: indexPath
            ) as! SurveyTypeTableViewCell
        
        let surveyType = surveys[indexPath.section]
        cell.configure(surveyType)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSurveyType = surveys[indexPath.section]
        let surveyOptionsVc = SurveyOptionsViewController()
        
        //create new manager with blank survey
        surveyOptionsVc.manager = CreateSurveyManager(surveyType: selectedSurveyType)
        navigationController?.pushViewController(surveyOptionsVc, animated: true)
    }
}
