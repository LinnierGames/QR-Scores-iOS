//
//  EmailSettingsRow.swift
//  QR Scores
//
//  Created by Erick Sanchez on 1/7/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit
import MessageUI

class EmailSettingsRow: NSObject, SettingsRow {
    
    struct Email {
        let recipients: [String]
        let subject: String
        let body: String
    }
    
    let title: String?
    let subtitle: String?
    lazy var operation: () -> Void = { [weak self] in
        guard let uS = self else { return }
        
        let vc: UIViewController
        if MFMailComposeViewController.canSendMail() {
            let mailVc = MFMailComposeViewController()
            
            mailVc.setToRecipients(uS.email.recipients)
            mailVc.setSubject(uS.email.subject)
            mailVc.setMessageBody(uS.email.body, isHTML: false)
            mailVc.mailComposeDelegate = self
            
            vc = mailVc
        } else {
            vc = UIAlertController(
                title: "Cannot Send Email",
                message: "",
                preferredStyle: .alert)
                .addDismissButton()
        }
        
        uS.presentor?.present(vc, animated: true)
    }
    
    let email: Email
    weak var presentor: UIViewController?
    let callback: (() -> Void)?
    
    init(title: String?, subtitle: String? = nil, email: Email, presentor: UIViewController, callback: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.email = email
        self.presentor = presentor
        self.callback = callback
    }
}

extension EmailSettingsRow: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        presentor?.dismiss(animated: true) { [weak self] in
            self?.callback?()
        }
    }
}

extension EmailSettingsRow.Email {
    static var contactUs: EmailSettingsRow.Email {
        return EmailSettingsRow.Email(recipients: ["esericksanc@gmail.com"], subject: "Contact Us", body: "")
    }
}
