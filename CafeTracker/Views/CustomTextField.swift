//
//  CustomTextField.swift
//  CafeTracker
//
//  Created by Keerthi Pelluru on 11/10/25.
//
import SwiftUI

struct CustomTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(Color.AppColors.lightBrown)
                .frame(width: 24)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 16))
                .foregroundColor(Color.AppColors.darkBrown)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.AppColors.darkBrown.opacity(0.05), radius: 8, y: 4)
    }
}

struct CustomSecureField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    @State private var isSecure = true
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(Color.AppColors.lightBrown)
                .frame(width: 24)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .foregroundColor(Color.AppColors.darkBrown)
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .foregroundColor(Color.AppColors.darkBrown)
            }
            
            Button {
                isSecure.toggle()
            } label: {
                Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color.AppColors.lightBrown.opacity(0.6))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.AppColors.darkBrown.opacity(0.05), radius: 8, y: 4)
    }
}
