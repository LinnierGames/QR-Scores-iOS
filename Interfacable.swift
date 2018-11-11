//
//  Interfacable.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit.UIViewController

protocol Interfacable {
    static func initFromXib() -> Self
}

extension Interfacable where Self: UIViewController {
    static func initFromXib() -> Self {
        return Self.self.init(nibName: String(describing: Self.self), bundle: nil)
    }
}
