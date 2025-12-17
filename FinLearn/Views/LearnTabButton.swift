import SwiftUI

struct LearnTabButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(isActive ? Color.white : Color(hex: "#1B2534"))
                .padding(.horizontal,14)
                .padding(.vertical, 12)
                .background(
                    isActive ? Color(hex: "#72BF00") : Color.white
                )
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 200)
                        .stroke(Color(hex: "#72BF00"), lineWidth: isActive ? 0 : 0) // optional border for inactive
                )
        }
        .buttonStyle(PlainButtonStyle()) // prevents default blue tint on tap
    }
}
