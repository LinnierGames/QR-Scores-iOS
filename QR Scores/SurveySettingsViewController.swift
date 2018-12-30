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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        case IndexPaths.closeSurvey:
            break
        case IndexPaths.deleteSurvey:
            break
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
