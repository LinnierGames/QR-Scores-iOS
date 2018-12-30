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
    
    weak var manager: DetailedSurveyManager!
    
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
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var imageViewQRCode: UIImageView!
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
}
