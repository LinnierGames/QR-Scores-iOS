//
//  UIDesignable+QRScores.swift
//  QR Scores
//
//  Created by Erick Sanchez on 1/13/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit

extension UIDesignable {
    
    @discardableResult
    static func applyPrimaryButton(to button: UIButton) -> UIDesignable<UIButton> {
        return wrapDesignable(to: button)
                .cornerRadius(4)
                .margin(UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0))
                .bgColor(.primary)
                .title(font: UIFont.boldSystemFont(ofSize: 15))
                .title(color: .white)
    }
}
