//
//  SurveySettingsViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/29/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

//class ScanToVoteSurveySettingsViewController: SurveySettingsViewController {
//
//    override func numberOfOptions(_ tableView: UITableView) -> Int {
//
//    }
//
//    override func tableView(_ tableView: UITableView, cellForOptionAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectOptionAt indexPath: IndexPath) {
//
//    }
//}

/**
 TODO: Remove static table view to populate the survey additional options
 */
class SurveySettingsViewController: UITableViewController {

    // MARK: - VARS
    
    var manager: DetailedSurveyManager!
    
    final var tabBarControllerNavItem: UINavigationItem {
        return self.tabBarController!.navigationItem
    }
    
    // MARK: - RETURN VALUES
    
    func numberOfOptions(_ tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForOptionAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("\(#function) not implemented")
    }
    
    func tableView(_ tableView: UITableView, didSelectOptionAt indexPath: IndexPath) { }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return numberOfOptions(tableView) + 1 // Allows Duplicate Votes
        case 1, 2:
            return 1 // close and delete
        default:
            fatalError("no sections greater than 3")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section != 0 {
            switch indexPath {
            case IndexPaths.closeSurvey, IndexPaths.deleteSurvey:
                let cell: UITableViewCell = tableView.dequeueReusableCell(withStyle: .subtitle)
                
                cell.defaultFormatting()
                
                if indexPath == IndexPaths.closeSurvey {
                    cell.textLabel!.text = manager.survey.isClosed ? "Open Survey" : "Close Survey"
                    cell.detailTextLabel!.text = "When a survey is closed, participants cannot vote"
                } else if indexPath == IndexPaths.deleteSurvey {
                    cell.textLabel!.text = "Delete Survey"
                    cell.textLabel!.textColor = .red
                }
                
                return cell
            default:
                fatalError("no more indexpaths")
            }
        } else {
            guard indexPath == IndexPaths.allowsDuplicateVotes else {
                return self.tableView(tableView, cellForOptionAt: indexPath)
            }
            
            // Allows Duplicate Votes cell
            let cell = tableView.dequeue(BooleanTableViewCell.self, at: indexPath)
            
            //TODO: localize
            cell.labelTitle.text = "Allows Duplicate Votes"
            cell.switchBoolean.isOn = manager.survey.allowsDuplicateVotes
            cell.delegate = self
            
            return cell
        }
    }
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView(frame: .zero, style: .grouped)
    }
    
    // MARK: - METHODS
    
    private func toggleAllowsDuplicateVotes() {
        manager.survey.allowsDuplicateVotes.invert()
        manager.updateSurvey { (isSuccessful) in
            if isSuccessful {
                self.tableView.reloadRows(at: [IndexPaths.allowsDuplicateVotes], with: .automatic)
            } else {
                UIAlertController(errorMessage: nil)
                    .present(in: self)
            }
        }
    }
    
    private func toggleClosedSurvey() {
        manager.toggleClosedSurvey { (isSuccessful) in
            if isSuccessful {
                self.tableView.reloadRows(at: [IndexPaths.closeSurvey], with: .automatic)
            } else {
                UIAlertController(errorMessage: nil)
                    .present(in: self)
            }
        }
    }
    
    private func deleteSurvey() {
        manager.deleteSurvey { (isSuccessful) in
            if isSuccessful {
                self.navigationController?.popViewController(animated: true)
            } else {
                UIAlertController(errorMessage: nil)
                    .present(in: self)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPaths.closeSurvey:
            
            //TODO: localization
            let alertMessage = manager.survey.isClosed ?
                "Are you sure you want to open this survey? Participants will be able to vote after opening this survey." :
                "Are you sure you want to close this survey? No one will be able to vote after closing this survey."
            
            let buttonTitle = manager.survey.isClosed ?
                "Open Survey" :
                "Close Survey"
            
            UIAlertController(
                title: nil,
                message: alertMessage,
                preferredStyle: .actionSheet)
                .addButton(title: buttonTitle, style: .destructive) { [weak self] _ in
                    self?.toggleClosedSurvey()
                }
                .addCancelButton()
                .present(in: self)
        case IndexPaths.deleteSurvey:
            UIAlertController(
                title: nil,
                message: "Are you sure you want to delete this survey?",
                preferredStyle: .actionSheet)
                .addButton(title: "Delete Survey", style: .destructive) { [weak self] _ in
                    self?.deleteSurvey()
                }
                .addCancelButton()
                .present(in: self)
        default:
            break
        }
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BooleanTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarControllerNavItem.title = self.title
    }
}

extension SurveySettingsViewController: BooleanTableViewCellDelegate {
    func booleanCell(_ booleanCell: BooleanTableViewCell, didChangeTo newState: Bool) {
        guard let indexPath = tableView.indexPath(for: booleanCell) else {
            return assertionFailure("index path not found")
        }
        
        switch indexPath {
        case IndexPaths.allowsDuplicateVotes:
            toggleAllowsDuplicateVotes()
        default:
            assertionFailure("unhandled index path")
        }
    }
}

fileprivate enum IndexPaths {
    
    static var allowsDuplicateVotes: IndexPath {
        return IndexPath(row: 0, section: 0)
    }
    
    static var closeSurvey: IndexPath {
        return IndexPath(row: 0, section: 1)
    }
    
    static var deleteSurvey: IndexPath {
        return IndexPath(row: 0, section: 2)
    }
}
