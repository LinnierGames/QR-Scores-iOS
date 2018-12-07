//
//  StringExtensions.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/6/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

extension String {
    var kabbobCased: String {
        return self.replacingOccurrences(of: " ", with: "-").lowercased()
    }
}
