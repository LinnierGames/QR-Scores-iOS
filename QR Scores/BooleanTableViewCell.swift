//
//  BooleanTableViewCell.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

protocol BooleanTableViewCellDelegate: class {
    func booleanCell(_ booleanCell: BooleanTableViewCell, didChangeTo newState: Bool)
}

class BooleanTableViewCell: UITableViewCell, RegisterableCell {
    
    static var identifier: String = "boolean cell"

    // MARK: - VARS
    
    var info: AdditionalInfo?
    
    weak var delegate: BooleanTableViewCellDelegate?
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func configure(_ info: AdditionalInfo) {
        guard let bool = info.inputType.boolean else {
            return assertionFailure("wrong type")
        }
        
        labelTitle.text = info.title
        switchBoolean.isOn = bool
        self.info = info
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var switchBoolean: UISwitch!
    @IBAction func switchDidChange(_ sender: Any) {
        delegate?.booleanCell(self, didChangeTo: switchBoolean.isOn)
    }
    
    // MARK: - LIFE CYCLE
    
}
