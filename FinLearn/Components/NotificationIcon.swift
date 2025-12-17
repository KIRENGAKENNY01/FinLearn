import SwiftUI

struct NotificationIcon: View {
    @State private var hasUnread = false        // Set from your backend later
    var action: () -> Void                     // What happens when tapped
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                // Bell icon
                Image(systemName: "bell.fill")
                    .font(.title2)
                    .foregroundColor(Color(hex: "#1B2534"))
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color(hex: "#FFFFFF"))
                            .opacity(0.3)
                    )
                
                // Red badge (only when unread)
                if hasUnread {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .offset(x: 4, y: -4)
                        .shadow(radius: 3)
                        .transition(.scale.combined(with: .opacity))
                        .animation(.spring(response: 0.4), value: hasUnread)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())   // No default button look
    }
}
