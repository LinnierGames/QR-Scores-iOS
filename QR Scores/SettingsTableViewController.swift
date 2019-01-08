//
//  SettingsTableViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 1/7/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit

protocol SettingsRow {
    var title: String? { get }
    var subtitle: String? { get }
    var operation: () -> Void { get }
}

class SettingsTableViewController: UITableViewController {
    
    // MARK: - VARS
    
    private lazy var content: [[SettingsRow]] = [
        [
            EmailSettingsRow(title: "Contact Us", email: .contactUs, presentor: self),
            WebpageSettingsRow(title: "Write a Review", url: .appStoreReview, presentor: self),
        ],
        [
            BasicSettingsRow(title: "Logout", subtitle: nil) { [unowned self] in
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
        ]
    ]
    
    // MARK: - RETURN VALUES
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return content.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withStyle: .subtitle)
        
        let row = content[indexPath.section][indexPath.row]
        cell.textLabel!.text = row.title
        cell.detailTextLabel!.text = row.subtitle
        
        return cell
    }
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView(frame: .zero, style: .grouped)
    }
    
    // MARK: - METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let operation = content[indexPath.section] [indexPath.row].operation
        operation()
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}

private enum IndexPaths {
    static let contactUs = IndexPath(row: 0, section: 0)
    static let submitReview = IndexPath(row: 1, section: 0)
    static let logout = IndexPath(row: 0, section: 1)
}
