//
//  Color+Extensions.swift
//  CafeTracker
//
//  Created by Keerthi Pelluru on 11/9/25.
//
import SwiftUI

extension Color {
    struct AppColors {
        // Browns
        static let darkBrown = Color(hex: "2C1810")
        static let mediumBrown = Color(hex: "4A2C1A")
        static let lightBrown = Color(hex: "6B4423")
        
        // Creams
        static let cream = Color(hex: "D4A574")
        static let lightCream = Color(hex: "F5E6D3")
        
        // Backgrounds
        static let backgroundLight = Color(hex: "F5F5F0")
        static let backgroundDark = Color(hex: "E8E3D8")
        
        // Accents
        static let accentGold = Color(hex: "C9A961")
        static let accentDark = Color(hex: "1A0F08")
    }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
