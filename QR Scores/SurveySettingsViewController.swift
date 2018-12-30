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
    
    weak var manager: DetailedSurveyManager!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    private func closeSurvey() {
        manager.closeSurvey { (isSuccessful) in
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
            UIAlertController(
                title: nil,
                message: "Are you sure you want to close this survey? No one will be able to vote after closing this survey.",
                preferredStyle: .actionSheet)
                .addButton(title: "Close Survey", style: .destructive) { [weak self] _ in
                    self?.closeSurvey()
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

}

fileprivate enum IndexPaths {
    static var closeSurvey: IndexPath {
        return IndexPath(row: 0, section: 0)
    }
    
    static var deleteSurvey: IndexPath {
        return IndexPath(row: 0, section: 1)
    }
}
