import SwiftUI

extension Color {

    // Hex initializer (keep)
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }

    //  Light Theme Colors
    static let appBackground = Color(hex: "#F4F6FB")
    static let cardBackground = Color.white
    static let primaryText = Color(hex: "#1C1F2A")
    static let secondaryText = Color.gray
    static let accent = Color(hex: "#6C63FF")   // pastel purple
    static let accentSoft = Color(hex: "#E6E4FF")
}
