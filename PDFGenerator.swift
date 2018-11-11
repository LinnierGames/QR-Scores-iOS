//
//  PDFGenerator.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/11/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit
import PDFKit

struct PDFGenerator {
    
    init() {
        
    }
    
    func pdf(from image: UIImage) -> Data? {
        
        // Create an empty PDF document
        let pdfDocument = PDFDocument()
        
        // Create a PDF page instance from your image
        guard let pdfPage = PDFPage(image: image) else {
            return nil
        }
        
        // Insert the PDF page into your document
        pdfDocument.insert(pdfPage, at: 0)
        
        // Get the raw data of your PDF document
        let data = pdfDocument.dataRepresentation()
        
        guard let output = data else {
            return nil
        }
        
        return output
    }
}
