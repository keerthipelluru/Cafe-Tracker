//
//  RegistrationView.swift
//  CafeTracker
//
//  Created by Keerthi Pelluru on 11/10/25.
//
import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = AuthViewModel()
    @Environment(\.dismiss) private var dismiss
    
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
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color.AppColors.darkBrown)
                            .frame(width: 40, height: 40)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                
                ScrollView {
                    VStack(spacing: 32) {
                        // Title
                        VStack(spacing: 8) {
                            Text("Create Account")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(Color.AppColors.darkBrown)
                            
                            Text("Join the coffee community")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.AppColors.lightBrown.opacity(0.8))
                        }
                        .padding(.top, 20)
                        
                        // Registration Form
                        VStack(spacing: 20) {
                            // First Name Field
                            CustomTextField(
                                icon: "person.fill",
                                placeholder: "First Name",
                                text: $viewModel.firstName,
                            )
                            
                            // Last Name Field
                            CustomTextField(
                                icon: "person.fill",
                                placeholder: "Last Name",
                                text: $viewModel.lastName,
                            )
                            
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
                            
                            // Confirm Password Field
                            CustomSecureField(
                                icon: "lock.fill",
                                placeholder: "Confirm Password",
                                text: $viewModel.confirmPassword
                            )
                            
                            // Password Requirements
                            HStack {
                                Image(systemName: "info.circle.fill")
                                    .font(.system(size: 12))
                                Text("Password must be at least 8 characters")
                                    .font(.system(size: 12))
                                Spacer()
                            }
                            .foregroundColor(Color.AppColors.lightBrown.opacity(0.6))
                            .padding(.horizontal, 4)
                            
                            // Register Button
                            Button {
                                Task {
                                    await viewModel.register()
                                }
                            } label: {
                                HStack {
                                    if viewModel.isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    } else {
                                        Text("Create Account")
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
                        }
                        .padding(.horizontal, 32)
                        
                        Spacer()
                            .frame(height: 40)
                    }
                }
            }
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "An error occurred")
        }
    }
}
