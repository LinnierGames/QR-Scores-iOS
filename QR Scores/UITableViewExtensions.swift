//
//  UITableViewExtensions.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

protocol RegisterableCell {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension RegisterableCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UITableView {
    func register<T: RegisterableCell>(_ type: T.Type) {
        let identifier = type.identifier
        let nib = type.nib
        
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeue<T: RegisterableCell>(_ type: T.Type, at indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
}
