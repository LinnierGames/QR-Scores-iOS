//
//  SurveyOptionsViewController.swift
//  QR Scores
//
//  Created by Erick Sanchez on 12/21/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import UIKit

struct AdditionalInfo: Hashable {
    
    let title: String
    let key: String
    var inputType: ValueType
    
    static func == (lhs: AdditionalInfo, rhs: AdditionalInfo) -> Bool {
        return lhs.key == rhs.key
    }
    
    var hashValue: Int {
        return key.hashValue
    }
}

class SurveyOptionsViewController: UIViewController {
    
    // MARK: - VARS
    
    var manager: CreateSurveyManager! {
        didSet {
            guard let infos = manager?.survey.additionalInfo else {
                fatalError("cannot set manager to nil")
            }
            
            //FIXME: This does not map in the correct order
            let listOfInfos = infos.map({ AdditionalInfo(title: $0.key, key: $0.key, inputType: $0.value) })
            self.additionalInfo = listOfInfos
        }
    }
    
    var additionalInfo: [AdditionalInfo]!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    fileprivate func updateAdditionalInfo(_ info: AdditionalInfo, to newValue: ValueType) {
        manager.updateAdditional(infoKey: info.key, to: newValue)
        
        if let infoIndex = self.additionalInfo.firstIndex(of: info) {
            additionalInfo[infoIndex].inputType = newValue
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var tableView: UITableView!
    @objc func pressNext(_ barButton: UIBarButtonItem) {
        let surveyTitleVc = SurveyTitleViewController()
        surveyTitleVc.manager = self.manager
        
        navigationController?.pushViewController(surveyTitleVc, animated: true)
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nextButton = UIBarButtonItem(
            title: "Next",
            style: .done,
            target: self,
            action: #selector(pressNext(_:))
        )
        navigationItem.setRightBarButton(nextButton, animated: false)
        
        tableView.register(BooleanTableViewCell.self)
        tableView.register(TextFieldTableViewCell.self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
    }
}

extension SurveyOptionsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.survey.additionalInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let infoForCell = additionalInfo[indexPath.row]
        
        switch infoForCell.inputType {
        case .boolean:
            let cell = tableView.dequeue(BooleanTableViewCell.self, at: indexPath)
            
            cell.configure(infoForCell)
            cell.delegate = self
            
            return cell
        case .string, .integer, .double:
            let cell = tableView.dequeue(TextFieldTableViewCell.self, at: indexPath)
            
            cell.configure(infoForCell)
            cell.delegate = self
            
            return cell
        default:
            #warning ("number input type not implemented")
            
            fatalError("\(#function) not implemented")
        }
        
    }
}

extension SurveyOptionsViewController: BooleanTableViewCellDelegate, TextFieldTableViewCellDelegate {
    func booleanCell(_ booleanCell: BooleanTableViewCell, didChangeTo newState: Bool) {
        guard let info = booleanCell.info else {
            return assertionFailure("no info found")
        }
        
        let newValue = ValueType.boolean(value: newState)
        updateAdditionalInfo(info, to: newValue)
    }
    
    func textFieldCell(_ textFieldCell: TextFieldTableViewCell, didChangeTo newState: String) {
        guard let info = textFieldCell.info else {
            return assertionFailure("no info found")
        }
        
        guard let newValue = info.inputType.fromString(newState) else {
            return assertionFailure("failed to change from string to inputType ValyeType")
        }
        
        updateAdditionalInfo(info, to: newValue)
        
//        switch info.inputType {
//        case .string:
//            let newValue = ValueType.string(value: newState)
//            updateAdditionalInfo(info, to: newValue)
//        case .integer:
//            guard let integerFromString = Int(newState) else {
//                return assertionFailure("failed to turn string into integer")
//            }
//
//            let newValue = ValueType.integer(value: integerFromString)
//            updateAdditionalInfo(info, to: newValue)
//        case .double:
//            guard let doubleFromString = Double(newState) else {
//                return assertionFailure("failed to turn string into double")
//            }
//
//            let newValue = ValueType.double(value: doubleFromString)
//            updateAdditionalInfo(info, to: newValue)
//        default:
//            //TODO: other survey types
//            fatalError("\(#function) not implemented")
//        }
    }
}
