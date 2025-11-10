//
//  AuthViewModel.swift
//  CafeTracker
//
//  Created by Keerthi Pelluru on 11/10/25.
//

// this is the middle layer of the view and the service
// sends and transforms the registration data
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var firstName = ""
    @Published var lastName = ""
    
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showError = false
    
    private let authService = AuthenticationService.shared
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Login
    
    func login() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
            showError = false
        }
        
        do {
            _ = try await authService.login(email: email, password: password)
            await MainActor.run {
                isLoading = false
            }
        } catch {
            await MainActor.run {
                isLoading = false
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
    
    // MARK: - Register
    
    func register() async {
        // Validate passwords match
        guard password == confirmPassword else {
            await MainActor.run {
                errorMessage = "Passwords do not match"
                showError = true
            }
            return
        }
        
        await MainActor.run {
            isLoading = true
            errorMessage = nil
            showError = false
        }
        
        do {
            _ = try await authService.register(email: email, password: password, firstName: firstName, lastName: lastName)
            await MainActor.run {
                isLoading = false
            }
        } catch {
            await MainActor.run {
                isLoading = false
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
    
    func clearFields() {
        email = ""
        password = ""
        confirmPassword = ""
        firstName = ""
        lastName = ""
        errorMessage = nil
        showError = false
    }
}
