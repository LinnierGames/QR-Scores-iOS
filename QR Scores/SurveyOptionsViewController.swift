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
            
            let listOfInfos = infos.map({ AdditionalInfo(title: $0.key, key: $0.key, inputType: $0.value) })
            self.additionalInfo = listOfInfos
        }
    }
    
    var additionalInfo: [AdditionalInfo]!
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var tableView: UITableView!
    @objc func pressNext(_ barButton: UIBarButtonItem) {
        print(manager)
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(
            title: "Next",
            style: .done,
            target: self,
            action: #selector(pressNext(_:))
        )
        navigationItem.setRightBarButton(cancelButton, animated: false)
        tableView.register(BooleanTableViewCell.self)
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
            let cell = tableView.dequeueReusableCell(
                withIdentifier: BooleanTableViewCell.identifier,
                for: indexPath
            ) as! BooleanTableViewCell
            
            cell.configure(infoForCell)
            cell.delegate = self
            
            return cell
        default:
            break
        }
        
        fatalError("\(#function) not implemented")
    }
}

extension SurveyOptionsViewController: BooleanTableViewCellDelegate {
    func booleanCell(_ booleanCell: BooleanTableViewCell, didChangeTo newState: Bool) {
        guard let info = booleanCell.info else {
            return assertionFailure("no info found")
        }
        
        let newValue = ValueType.boolean(value: newState)
        manager.updateAdditional(infoKey: info.key, to: newValue)
        
        if let infoIndex = self.additionalInfo.firstIndex(of: info) {
            additionalInfo[infoIndex].inputType = newValue
        }
    }
}
