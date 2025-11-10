//
//  LoginView.swift
//  CafeTracker
//
//  Created by Keerthi Pelluru on 11/10/25.
//

// UI of the registration view
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var showRegistration = false
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [
                    Color.AppColors.backgroundLight,
                    Color.AppColors.backgroundDark
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 32) {
                    Spacer()
                        .frame(height: 60)
                    
                    // Logo
                    VStack(spacing: 12) {
                        Image(systemName: "cup.and.saucer.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color.AppColors.lightBrown,
                                        Color.AppColors.cream
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("CaféTrace")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(Color.AppColors.darkBrown)
                        
                        Text("Track your coffee journey")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.AppColors.lightBrown.opacity(0.8))
                    }
                    .padding(.bottom, 20)
                    
                    // Login Form
                    VStack(spacing: 20) {
                        // Email Field
                        CustomTextField(
                            icon: "envelope.fill",
                            placeholder: "Email",
                            text: $viewModel.email
                        )
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        
                        // Password Field
                        CustomSecureField(
                            icon: "lock.fill",
                            placeholder: "Password",
                            text: $viewModel.password
                        )
                        
                        // Login Button
                        Button {
                            Task {
                                await viewModel.login()
                            }
                        } label: {
                            HStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else {
                                    Text("Log In")
                                        .font(.system(size: 18, weight: .semibold))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color.AppColors.lightBrown,
                                        Color.AppColors.mediumBrown
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        }
                        .disabled(viewModel.isLoading)
                        .padding(.top, 8)
                        
                        // Register Link
                        Button {
                            showRegistration = true
                        } label: {
                            HStack(spacing: 4) {
                                Text("Don't have an account?")
                                    .foregroundColor(Color.AppColors.lightBrown.opacity(0.8))
                                Text("Sign Up")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.AppColors.lightBrown)
                            }
                            .font(.system(size: 15))
                        }
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
            }
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "An error occurred")
        }
        .fullScreenCover(isPresented: $showRegistration) {
            RegistrationView()
        }
    }
}

