//
//  AuthenticationService.swift
//  CafeTracker
//
//  Created by Keerthi Pelluru on 11/10/25.
//

// this creates the login functionality
// allows the user to register

import Foundation
import Combine

enum AuthError: LocalizedError {
    case invalidEmail
    case weakPassword
    case emailAlreadyExists
    case userNotFound
    case incorrectPassword
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email address"
        case .weakPassword:
            return "Password must be at least 8 characters"
        case .emailAlreadyExists:
            return "An account with this email already exists"
        case .userNotFound:
            return "No account found with this email"
        case .incorrectPassword:
            return "Incorrect password"
        case .networkError:
            return "Network error. Please try again"
        }
    }
}

class AuthenticationService: ObservableObject {
    static let shared = AuthenticationService()
    
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    
    private let userDefaults = UserDefaults.standard
    private let usersKey = "registered_users"
    private let currentUserKey = "current_user"
    private let passwordsKey = "user_passwords" // In production, use Keychain!
    
    private init() {
        loadCurrentUser()
    }
    
    // MARK: - Registration
    
    func register(email: String, password: String, firstName: String, lastName: String) async throws -> User {
        // Validate email
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail
        }
        
        // Validate password
        guard password.count >= 8 else {
            throw AuthError.weakPassword
        }
        
        // Check if user already exists
        if userExists(email: email) {
            throw AuthError.emailAlreadyExists
        }
        
        // Create new user
        // get the first and last name of the user
        let user = User(email: email, firstName: firstName, lastName: lastName)
        
        // Save user
        try saveUser(user, password: password)
        
        // Set as current user
        currentUser = user
        isAuthenticated = true
        saveCurrentUser(user)
        
        return user
    }
    
    // MARK: - Login
    
    func login(email: String, password: String) async throws -> User {
        // Validate email
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail
        }
        
        // Check if user exists
        guard let user = getUser(email: email) else {
            throw AuthError.userNotFound
        }
        
        // Verify password
        guard verifyPassword(password, for: email) else {
            throw AuthError.incorrectPassword
        }
        
        // Set as current user
        currentUser = user
        isAuthenticated = true
        saveCurrentUser(user)
        
        return user
    }
    
    // MARK: - Logout
    
    func logout() {
        currentUser = nil
        isAuthenticated = false
        userDefaults.removeObject(forKey: currentUserKey)
    }
    
    // MARK: - Helper Methods
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func userExists(email: String) -> Bool {
        return getUser(email: email) != nil
    }
    
    private func getUser(email: String) -> User? {
        guard let data = userDefaults.data(forKey: usersKey),
              let users = try? JSONDecoder().decode([User].self, from: data) else {
            return nil
        }
        return users.first { $0.email.lowercased() == email.lowercased() }
    }
    
    private func saveUser(_ user: User, password: String) throws {
        // Load existing users
        var users: [User] = []
        if let data = userDefaults.data(forKey: usersKey),
           let existingUsers = try? JSONDecoder().decode([User].self, from: data) {
            users = existingUsers
        }
        
        // Add new user
        users.append(user)
        
        // Save users
        if let encoded = try? JSONEncoder().encode(users) {
            userDefaults.set(encoded, forKey: usersKey)
        }
        
        // Save password (In production, use Keychain!)
        var passwords: [String: String] = [:]
        if let data = userDefaults.data(forKey: passwordsKey),
           let existingPasswords = try? JSONDecoder().decode([String: String].self, from: data) {
            passwords = existingPasswords
        }
        passwords[user.email.lowercased()] = password
        if let encoded = try? JSONEncoder().encode(passwords) {
            userDefaults.set(encoded, forKey: passwordsKey)
        }
    }
    
    private func verifyPassword(_ password: String, for email: String) -> Bool {
        guard let data = userDefaults.data(forKey: passwordsKey),
              let passwords = try? JSONDecoder().decode([String: String].self, from: data),
              let savedPassword = passwords[email.lowercased()] else {
            return false
        }
        return savedPassword == password
    }
    
    private func saveCurrentUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            userDefaults.set(encoded, forKey: currentUserKey)
        }
    }
    
    private func loadCurrentUser() {
        guard let data = userDefaults.data(forKey: currentUserKey),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            return
        }
        currentUser = user
        isAuthenticated = true
    }
}
