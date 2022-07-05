//
//  User.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/5/22.
//

import Foundation

struct User: Codable {
    var id: String
    var username: String
    
    init(id: String = UUID().uuidString, username: String) {
        self.id = id
        self.username = username
    }
    
    // NOTE: to be used if there is some type of persistence for logged in state
    static func isLoggedIn() -> Bool {
        guard let _ = UserDefaults.standard.string(forKey: "AccessToken") else {
            return false
        }
        return true
    }
}
