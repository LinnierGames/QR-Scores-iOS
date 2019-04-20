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
    
    @objc private func pressSettings(_ sender: Any) {
        let settingsVc = SettingsTableViewController()
        self.present(
            UINavigationController(rootViewController: settingsVc),
            animated: true
        )
    }
    
    @IBAction func refreshSurveyData(_ sender: Any) {
        viewModel.fetchSurveys()
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(pressAddSurvey(_:))
        )
        
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "Icon-38"))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Settings",
            style: .plain,
            target: self,
            action: #selector(pressSettings(_:))
        )
        
        let noSurveysImageView = UIImageView(image: #imageLiteral(resourceName: "empty-surveys"))
        noSurveysImageView.contentMode = .top
        tableView.backgroundView = noSurveysImageView
        tableView.register(
            SurveyTableViewCell.nib,
            forCellReuseIdentifier: SurveyTableViewCell.identifier
        )
        
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshSurveyData(_:)), for: .valueChanged)
        tableView.refreshControl = control
        
        viewModel.surveys.subscribe { [weak self] (newSurveys) in
            self?.tableView.reloadData()
            self?.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.fetchSurveys()
    }
}

extension SurveysViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.surveys.data.count
        tableView.backgroundView?.isHidden = count != 0
        
        return count
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
}
