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
        let createSurveyVc = SurveyTypeNavigationController.instantiate()
        present(createSurveyVc, animated: true)
    }
    
    @IBAction func refreshSurveyData(_ sender: Any) {
        viewModel.fetchSurveys()
    }
    
    @IBAction func pressLogout(_ sender: Any) {
        UserPersistence.logoutCurrentUser()
        
        if let loginVc = self.tabBarController?.presentingViewController {
            loginVc.dismiss(animated: true)
        } else {
            let loginSb = UIStoryboard(name: "Splash", bundle: nil)
            guard let loginVc = loginSb.instantiateInitialViewController() else {
                fatalError("storyboard not set up correctly")
            }
            
            self.present(loginVc, animated: true)
        }
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddSurvey(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(pressLogout(_:)))
        
        tableView.register(
            SurveyTableViewCell.nib,
            forCellReuseIdentifier: SurveyTableViewCell.identifier
        )
        
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshSurveyData(_:)), for: .valueChanged)
        tableView.refreshControl = control
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.surveys.subscribe { [weak self] (newSurveys) in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let survey = viewModel.surveys.data[indexPath.row]
        
        let detailedVc = SurveyDetailedTabBarViewController.instantiate(with: survey)
        detailedVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailedVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let survey = viewModel.surveys.data[indexPath.row]
        let activity = UIActivityViewController(surveyURL: survey)
        
        self.present(activity, animated: true)
    }
}
