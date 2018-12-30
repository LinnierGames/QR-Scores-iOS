//
//  SurveyShareViewModel.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/29/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation
import UIKit.UIImage

class SurveyShareViewModel {
    
    // MARK: - VARS
    
    private var qrGenerator: QRCodeGenerator?
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func generateQRCode(from url: URL, size: CGSize, completion: @escaping (UIImage) -> Void) {
        
        if self.qrGenerator == nil {
            self.qrGenerator = QRCodeGenerator(url: url)
        }
        
        if let cachedImage = qrGenerator!.cachedImage {
            return completion(cachedImage)
        }
        
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async {
            let imageSize = CGSize.square(from: size)
            guard let image = self.qrGenerator!.generateImage(outputSize: imageSize) else {
                
                //TODO: use a failed to create image to display to the user
                
                return assertionFailure("failed to create code")
            }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
