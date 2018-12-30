//
//  SurveyDetailedViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/11/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

class SurveyDetailedViewController: UIViewController, Interfacable {

    // MARK: - VARS
    
    var survey: Survey!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    private func updateUI() {
        self.labelTitle.text = survey.title
        self.labelSubtitle.text = survey.description
        
        check(
            survey: survey,
            scanToVote: { (survey) in
                self.labelNumberOfParticipants.text = String(survey.numberOfParticipants)
        },
            likeOrDislike: { (survey) in
                self.labelNumberOfParticipants.text = String(survey.numberOfParticipants)
        },
            sliderAverage: { (survey) in
                self.labelNumberOfParticipants.text = String(survey.numberOfParticipants)
        },
            sliderHistogram: { (survey) in
                self.labelNumberOfParticipants.text = String(survey.numberOfParticipants)
        })
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        let url = self.survey.generatedUrl
        let imageViewSize = self.imageViewQRCode.frame.size
        queue.async {
            var generator = QRCodeGenerator(url: url)
            let imageSize = CGSize.square(from: imageViewSize)
            let image = generator.generateImage(outputSize: imageSize)
            
            DispatchQueue.main.async {
                self.imageViewQRCode.image = image
            }
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelNumberOfParticipants: UILabel!
    @IBOutlet weak var imageViewQRCode: UIImageView!
    @IBAction func pressExportQRCode(_ sender: Any) {
        guard let activity = UIActivityViewController(surveyQRCode: survey) else {
            return assertionFailure("failed to create survey")
        }
        
        self.present(activity, animated: true)
    }
    
    @IBAction func pressCloseSurvey(_ sender: Any) {
    }
    
    @IBAction func pressDeleteSurvey(_ sender: Any) {
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateUI()
    }
}
