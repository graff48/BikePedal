
import SwiftUI

// Helper function for localization
func LocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

// Energetic Bike Theme Colors
struct BikeThemeColors {
    static let primary = Color(red: 0.0, green: 0.6, blue: 0.2) // Forest Green
    static let primaryVariant = Color(red: 0.0, green: 0.4, blue: 0.1) // Dark Forest Green
    static let secondary = Color(red: 1.0, green: 0.6, blue: 0.0) // Energetic Orange
    static let secondaryVariant = Color(red: 0.9, green: 0.4, blue: 0.0) // Deep Orange
    static let accent = Color(red: 0.2, green: 0.8, blue: 0.9) // Sky Blue
    static let surface = Color.white.opacity(0.9) // Semi-transparent white
    static let surfaceVariant = Color.white.opacity(0.95) // More opaque white
    static let background = Color.clear // Transparent for background image
    static let error = Color(red: 0.9, green: 0.2, blue: 0.2) // Bright Red
    static let onPrimary = Color.white
    static let onSecondary = Color.white
    static let onSurface = Color(red: 0.1, green: 0.1, blue: 0.1) // Dark text
    static let onBackground = Color.white // White text on background
}

// Energetic Bike Button Style
struct BikeButton: ViewModifier {
    let backgroundColor: Color
    let textColor: Color
    let isElevated: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(textColor)
            .padding(.horizontal, 28)
            .padding(.vertical, 14)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [backgroundColor, backgroundColor.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(25)
            .shadow(color: isElevated ? Color.black.opacity(0.3) : Color.clear, radius: isElevated ? 6 : 0, x: 0, y: isElevated ? 3 : 0)
    }
}

struct BikeCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(BikeThemeColors.surfaceVariant)
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
            )
    }
}

struct ForestBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.1, green: 0.3, blue: 0.1), // Dark forest green
                Color(red: 0.2, green: 0.5, blue: 0.2), // Medium forest green
                Color(red: 0.3, green: 0.6, blue: 0.3), // Light forest green
                Color(red: 0.4, green: 0.7, blue: 0.4)  // Bright forest green
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay(
            // Tree silhouettes pattern
            ForestPattern()
                .opacity(0.3)
        )
    }
}

struct ForestPattern: View {
    var body: some View {
        Canvas { context, size in
            // Draw stylized tree shapes
            let treeCount = 8
            let treeWidth = size.width / CGFloat(treeCount)
            
            for i in 0..<treeCount {
                let x = CGFloat(i) * treeWidth + treeWidth / 2
                let treeHeight = CGFloat.random(in: 100...200)
                let y = size.height - treeHeight
                
                // Tree trunk
                context.fill(
                    Path(CGRect(x: x - 8, y: size.height - 40, width: 16, height: 40)),
                    with: .color(Color.black.opacity(0.4))
                )
                
                // Tree canopy
                context.fill(
                    Path(ellipseIn: CGRect(x: x - 30, y: y, width: 60, height: treeHeight)),
                    with: .color(Color.black.opacity(0.3))
                )
            }
        }
    }
}

extension View {
    func bikeButton(backgroundColor: Color, textColor: Color, elevated: Bool = true) -> some View {
        self.modifier(BikeButton(backgroundColor: backgroundColor, textColor: textColor, isElevated: elevated))
    }
    
    func bikeCard() -> some View {
        self.modifier(BikeCard())
    }
}
