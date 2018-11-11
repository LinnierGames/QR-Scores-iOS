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
    
    lazy var pdfDocument = PDFDocument()
    
    enum Errors: Error {
        case failedToAddPage
        case failedToGeneratePDFData
    }
    
    init() {
        
    }
    
    mutating func addGridPage(with image: UIImage, imageSize: CGSize) throws {
        
        let pageBounds = CGRect(x: 16, y: 16, width: 612 - 32, height: 792 - 32)
//        let images = [UIImage].init(repeating: image, count: repeatCount)
//
//        guard let gridImage = collageImage(rect: pageBounds, images: images) else {
//            throw Errors.failedToAddPage
//        }
        
        guard let gridImage = duplicateGrid(from: image, imageSize: imageSize, padding: CGSize(width: 8, height: 8), bound: pageBounds) else {
            throw Errors.failedToAddPage
        }
        
        // Create a PDF page instance from your image
        guard let pdfPage = PDFPage(image: gridImage) else {
            throw Errors.failedToAddPage
        }
        
        // Insert the PDF page into your document
        pdfDocument.insert(pdfPage, at: pdfDocument.pageCount)
    }
    
    mutating func pdf() -> Data? {
        return pdfDocument.dataRepresentation()
    }
    
//    func pdf(from image: UIImage) -> Data? {
//
//        // Get the raw data of your PDF document
//        let data =
//
//        guard let output = data else {
//            return nil
//        }
//
//        return output
//    }
}

//struct PDFPage {
//
//}

func duplicateGrid(from image: UIImage, imageSize: CGSize, padding: CGSize = .zero, bound: CGRect) -> UIImage? {
    
    UIGraphicsBeginImageContextWithOptions(bound.size, false, UIScreen.main.scale)
    
    let nRows = Int(bound.height / (imageSize.height + padding.height))
    let nColumns = Int(bound.width / (imageSize.width + padding.width))
    
    for aRow in 0..<nRows {
        for aColumn in 0..<nColumns {
            let origin = CGPoint(
                x: CGFloat(aColumn) * (imageSize.width + padding.width) + bound.origin.x,
                y: CGFloat(aRow) * (imageSize.height + padding.height) + bound.origin.y
            )
            let position = CGRect(origin: origin, size: imageSize)
            image.draw(in: position)
        }
    }
    
    let outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage
}
//
//func collageImage (rect:CGRect, images:[UIImage]) -> UIImage? {
//
//    let maxSide = max(rect.width / CGFloat(images.count), rect.height / CGFloat(images.count)) //* 0.80
//    //let rowHeight = rect.height / CGFloat(images.count) * 0.8
//    let maxImagesPerRow = 9
//    var index = 0
//    var currentRow = 1
//    var xtransform:CGFloat = 0.0
//    var ytransform:CGFloat = 0.0
//    var smallRect:CGRect = CGRect.zero
//
//    UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
//
//    for img in images {
//
//        let x = index % maxImagesPerRow //row should change when modulus is 0
//        index += 1
//
//        //row changes when modulus of counter returns zero @ maxImagesPerRow
//        if x == 0 {
//            //last column of current row
//            //xtransform += CGFloat(maxSide)
//            smallRect = CGRect(x: xtransform, y: ytransform, width: maxSide, height: maxSide)
//
//            //reset for new row
//            currentRow += 1
//            xtransform = 0.0
//            ytransform = (maxSide * CGFloat(currentRow - 1))
//
//        } else {
//            //not a new row
//            if xtransform == 0 {
//                //this is first column
//                //draw rect at 0,ytransform
//                smallRect = CGRect(x: xtransform, y: ytransform, width: maxSide, height: maxSide)
//                xtransform += CGFloat(maxSide)
//            } else {
//                //not the first column so translate x, ytransform to be reset for new rows only
//                smallRect = CGRect(x: xtransform, y: ytransform, width: maxSide, height: maxSide)
//                xtransform += CGFloat(maxSide)
//            }
//
//        }
//
//        //draw in rect
//        img.draw(in: smallRect)
//
//    }
//
//    let outputImage = UIGraphicsGetImageFromCurrentImageContext();
//
//    UIGraphicsEndImageContext();
//
//    return outputImage
//}
