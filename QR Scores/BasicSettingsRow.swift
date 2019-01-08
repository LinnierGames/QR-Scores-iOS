//
//  BasicSettingsRow.swift
//  QR Scores
//
//  Created by Erick Sanchez on 1/7/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit

struct BasicSettingsRow: SettingsRow {
    let title: String?
    let subtitle: String?
    let operation: () -> Void
}
