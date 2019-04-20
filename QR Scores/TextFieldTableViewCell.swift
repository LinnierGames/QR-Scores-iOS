//
//  TextFieldTableViewCell.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/22/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

protocol TextFieldTableViewCellDelegate: class {
    func textFieldCell(_ textFieldCell: TextFieldTableViewCell, didChangeTo newState: String)
}

class TextFieldTableViewCell: UITableViewCell, RegisterableCell {
    
    static var identifier: String = "textfield cell"
    
    // MARK: - VARS
    
    var info: AdditionalInfo?
    
    weak var delegate: TextFieldTableViewCellDelegate?
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func configure(_ info: AdditionalInfo, placeholder: String = "") {        
        guard let string = info.inputType.intoString else {
            return assertionFailure("wrong type")
        }
        
        labelTitle.text = info.title
        textField.text = string
        textField.placeholder = placeholder
        self.info = info
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - LIFE CYCLE
    
}

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldCell(self, didChangeTo: textField.text ?? "")
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        delegate?.textFieldCell(self, didChangeTo: textField.text ?? "")
//
//        return true
//    }
}
