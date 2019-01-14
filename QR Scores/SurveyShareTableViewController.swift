//
//  SurveyShareTableViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/29/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyShareTableViewController: UITableViewController {
    
    // MARK: - VARS
    
    var manager: DetailedSurveyManager!
    
    final var tabBarControllerNavItem: UINavigationItem {
        return self.tabBarController!.navigationItem
    }
    
    private let viewModel = SurveyShareViewModel()
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    private func updateUI() {
        let url = manager.survey.generatedUrl
        let size = CGSize(
            width: 1024 * UIScreen.main.scale,
            height: 1024 * UIScreen.main.scale
        )
        viewModel.generateQRCode(from: url, size: size) { [weak self] image in
            self?.imageViewQRCode.image = image
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        case IndexPaths.singleQRCode:
            
            //TODO: loading screen
            guard let activity = UIActivityViewController.create(singleQRCodeFrom: manager.survey) else {
                return assertionFailure("failed to create survey")
            }
            
            tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
            self.present(activity, animated: true)
        case IndexPaths.fullPageQRCode:
            
            //TODO: loading screen
            guard let activity = UIActivityViewController.create(gridPageFrom: manager.survey) else {
                return assertionFailure("failed to create survey")
            }
            
            tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
            self.present(activity, animated: true)
        case IndexPaths.exportUrl:
            
            //TODO: loading screen
            guard let activity = UIActivityViewController.create(urlFrom: manager.survey) else {
                return assertionFailure("failed to create survey")
            }
            
            tableView.selectRow(at: nil, animated: true, scrollPosition: .none)
            self.present(activity, animated: true)
        default:
            break
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var imageViewQRCode: UIImageView!
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
        
        tabBarControllerNavItem.title = self.title
    }
}

fileprivate enum IndexPaths {
    static var singleQRCode: IndexPath {
        return IndexPath(row: 0, section: 1)
    }
    
    static var fullPageQRCode: IndexPath {
        return IndexPath(row: 1, section: 1)
    }
    
    static var exportUrl: IndexPath {
        return IndexPath(row: 2, section: 1)
    }
}
