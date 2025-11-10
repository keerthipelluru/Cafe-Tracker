//
//  User.swift
//  CafeTracker
//
//  Created by Keerthi Pelluru on 11/10/25.
//

// User object
/* [must have properties)
 id (UUID -- unique id for the user)
 email (username)
 password
 first name
 last name
 createdAt (means there are registered)
 */
import Foundation
struct User: Identifiable, Codable {
    let id: UUID
    var email: String
    var firstName: String
    var lastName: String
    var createdAt: Date
    
    
    // initialize the user object
    init(id: UUID = UUID(), email: String, firstName: String, lastName: String, createdAt: Date = Date() ){
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.createdAt = createdAt
        
    }
}
