//
//  WebpageSettingsRow.swift
//  QR Scores
//
//  Created by Erick Sanchez on 1/8/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit
import SafariServices

class WebpageSettingsRow: NSObject, SettingsRow {
    
    let title: String?
    let subtitle: String?
    lazy var operation: () -> Void = { [weak self] in
        guard let uS = self else { return }
        
        let safariViewController = SFSafariViewController(url: uS.url)
        uS.presentor?.present(safariViewController, animated: true)
    }
    
    weak var presentor: UIViewController?
    let url: URL
    let callback: (() -> Void)?
    
    init(title: String?, subtitle: String? = nil, url: URL, presentor: UIViewController, callback: (() -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
        self.presentor = presentor
        self.callback = callback
    }
}

extension URL {
    static var appStoreReview: URL {
        guard let url = URL(string: "https://itunes.apple.com/app/id1441925524?action=write-review") else {
            fatalError("incorrect url")
        }
        
        return url
    }
    
    static var gettingStarted: URL {
        guard let url = URL(string: "https://medium.com/@ericksanchez_36220/is-qr-scores-for-you-and-your-surveys-293f6765dac3") else {
            fatalError("incorrect url")
        }
        
        return url
    }
}
