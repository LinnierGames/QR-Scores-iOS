//
//  SettingsTableViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 1/7/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    // MARK: - VARS
    
    // MARK: - RETURN VALUES
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:  // contact us, submit feedback
            return 2
        case 1: // logout
            return 1
        default:
            fatalError("unhandled section")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case IndexPaths.contactUs:
            let cell = tableView.dequeueReusableCell(withStyle: .default)
            
            cell.textLabel!.text = "Contact Us"
            
            return cell
        case IndexPaths.submitReview:
            let cell = tableView.dequeueReusableCell(withStyle: .default)
            
            cell.textLabel!.text = "Submit Review"
            
            return cell
        case IndexPaths.logout:
            let cell = tableView.dequeueReusableCell(withStyle: .default)
            
            cell.textLabel!.text = "Logout"
            
            return cell
        default:
            fatalError("unhandled index path")
        }
    }
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView(frame: .zero, style: .grouped)
    }
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}

private enum IndexPaths {
    static let contactUs = IndexPath(row: 0, section: 0)
    static let submitReview = IndexPath(row: 1, section: 0)
    static let logout = IndexPath(row: 0, section: 1)
}
