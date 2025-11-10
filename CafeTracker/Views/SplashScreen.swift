//
//  SplashScreen.swift
//  CafeTracker
//
//  Created by Keerthi Pelluru on 11/9/25.
//

// code for the splash screen of the app (first point of the app)
import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    @State private var scale = 0.8
    
    var body: some View {
        
            ZStack {
                // Gradient background
                LinearGradient(
                    colors: [
                        Color.AppColors.darkBrown,
                        Color.AppColors.mediumBrown,
                        Color.AppColors.lightBrown
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Coffee cup icon
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 140, height: 140)
                            .blur(radius: 20)
                        
                        Image(systemName: "cup.and.saucer.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color.AppColors.cream,
                                        Color.AppColors.lightCream
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                    .scaleEffect(scale)
                    
                    // App name
                    VStack(spacing: 4) {
                        Text(AppConstants.appName)
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundColor(Color.AppColors.lightCream)
                        
                        Text(AppConstants.appTagline)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.AppColors.cream.opacity(0.8))
                            .tracking(2)
                    }
                    .opacity(opacity)
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    opacity = 1.0
                    scale = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isActive = true
                    }
                }
            }
        }
    }

#Preview {
    SplashScreen()
}


