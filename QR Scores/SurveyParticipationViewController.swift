//
//  SurveyParticipationViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyParticipationViewController: UIViewController {
    
    // MARK: - VARS
    
    final unowned var manager: DetailedSurveyManager
    
    var participantVisual: UIView? {
        get {
            return nil
        }
    }
    
    init(manager: DetailedSurveyManager) {
        self.manager = manager
        super.init(nibName: "SurveyParticipationViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) not implemented")
    }
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func updateUI() {
        labelSurveyType.text = manager.surveyTypeTitle
        labelSurveyDescription.text = manager.surveyTypeDescription
    }
    
    override func loadView() {
        super.loadView()
        
        if let view = participantVisual {
            stackViewContent.addArrangedSubview(view)
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var stackViewContent: UIStackView!
    @IBOutlet weak var labelSurveyType: UILabel!
    @IBOutlet weak var labelSurveyDescription: UILabel!
    @IBOutlet weak var labelNumberOfParticipants: UILabel!
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
}
