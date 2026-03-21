import SwiftUI

enum AppTheme {
    static let background = LinearGradient(
        colors: [
            Color(red: 0.95, green: 0.93, blue: 0.89),
            Color(red: 0.91, green: 0.89, blue: 0.84)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let ink = Color(red: 0.17, green: 0.15, blue: 0.12)
    static let accent = Color(red: 0.11, green: 0.18, blue: 0.32)
    static let softBorder = Color.black.opacity(0.08)
    static let card = Color.white.opacity(0.72)
    static let muted = Color.black.opacity(0.55)
}

enum AppFont {
    static func title(_ size: CGFloat) -> Font {
        .system(size: size, weight: .semibold, design: .serif)
    }

    static func body(_ size: CGFloat) -> Font {
        .system(size: size, weight: .regular, design: .default)
    }
}
