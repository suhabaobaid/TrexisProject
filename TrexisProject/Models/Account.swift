//
//  Account.swift
//  TrexisProject
//
//  Created by Suha Baobaid on 7/4/22.
//

import Foundation

struct Account: Codable {
    var id: String
    var name: String
    var balance: Double
    
    init(id: String, name: String, balance: Double) {
        self.id = id
        self.name = name
        self.balance = balance
    }
}
