//
//  SurveySettingsViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/29/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

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
    
    // MARK: - METHODS
    
    private func toggleClosedSurvey() {
        manager.toggleClosedSurvey { (isSuccessful) in
            if isSuccessful {
                //TODO: reload the table view
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarControllerNavItem.title = self.title
    }

}

fileprivate enum IndexPaths {
    static var closeSurvey: IndexPath {
        return IndexPath(row: 0, section: 0)
    }
    
    static var deleteSurvey: IndexPath {
        return IndexPath(row: 0, section: 1)
    }
}
