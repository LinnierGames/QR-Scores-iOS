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
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddSurvey(_:)))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let survey = viewModel.surveys.data[indexPath.row]
        cell.textLabel?.text = survey.title
        cell.detailTextLabel?.text = String(survey.numberOfParticipants)
        
        return cell
    }
}
