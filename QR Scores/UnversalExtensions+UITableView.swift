//
//  UnversalExtensions+UITableView.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/30/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
    func dequeueReusableCell(withStyle style: UITableViewCell.CellStyle) -> UITableViewCell {
        let identifier = String(style.rawValue)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell(style: style, reuseIdentifier: identifier)
        }
        
        return cell
    }
}

extension UITableViewCell {
    
    func clearFormatting() {
        self.textLabel?.text = nil
        self.textLabel?.textColor = .black
        self.detailTextLabel?.text = nil
        self.detailTextLabel?.textColor = .black
    }
    
    func defaultFormatting() {
        self.textLabel?.text = nil
        self.textLabel?.textColor = .black
        self.detailTextLabel?.text = nil
        self.detailTextLabel?.textColor = .lightGray
    }
}
