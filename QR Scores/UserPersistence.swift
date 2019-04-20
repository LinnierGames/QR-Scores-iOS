//
//  UserPersistence.swift
//  QR Scores
//
//  Created by Erick Sanchez on 11/10/18.
//  Copyright © 2018 LinnierGames. All rights reserved.
//

import Foundation

class UserPersistence {
    
    // MARK: - VARS
    
    static var hasUserLoggedIn: Bool {
        if self._user != nil {
            return true
        }
        
        let userDefaults = UserDefaults.standard
        guard
            let userData = userDefaults.data(forKey: self.currentUserKey),
            let user = try? JSONDecoder().decode(User.self, from: userData) else {
                return false
        }
        
        self.setCurrent(user)
        
        return true
    }
    
    static var currentUser: User {
        guard let user = self._user else {
            fatalError("there is no use")
        }
        
        return user
    }
    
    private static var _user: User?
    
    private static let currentUserKey = "CURRENT_USER"
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    static func setCurrent(_ user: User, save: Bool = false) {
        self._user = user
        
        if save {
            let userDefaults = UserDefaults.standard
            guard let userData = try? JSONEncoder().encode(user) else {
                return assertionFailure("failed to encode user")
            }
            
            userDefaults.set(userData, forKey: self.currentUserKey)
        }
    }
    
    static func logoutCurrentUser() {
        self.clear()
        
        NotificationCenter.default.post(name: .userDidLogout, object: nil)
    }
    
    static func clear() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.removeObject(forKey: self.currentUserKey)
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE
}

extension NSNotification.Name {
    static let userDidLogout = Notification.Name.init("USER_DID_LOGOUT")
}
