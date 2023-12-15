//
//  User.swift
//  Harmony
//
//  Created by Nikhil kumar on 12/1/23.
//

import Foundation
import GRDB

struct User: Codable, FetchableRecord, MutablePersistableRecord {
    var userId: Int
    var name: String
    var email: String
    var password: String
    
    // Initialize User with moods array
    init(userId: Int, name: String, email: String, password: String) {
        self.userId = userId
        self.name = name
        self.email = email
        self.password = password
        
    }
}
