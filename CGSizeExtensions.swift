//
//  CGSizeExtensions.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/11/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import CoreGraphics

extension CGSize {
    static func square(from size: CGSize) -> CGSize {
        let edgeLenght = min(size.width, size.height)
        
        return CGSize(width: edgeLenght, height: edgeLenght)
    }
}
