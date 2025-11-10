//
//  CafeTrackerApp.swift
//  CafeTracker
//
//  Created by Keerthi Pelluru on 11/9/25.
//

// main entry point of the app
import SwiftUI

@main
struct CafeTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview("Login") {
    LoginView()
}

#Preview("Registration") {
    RegistrationView()
}
