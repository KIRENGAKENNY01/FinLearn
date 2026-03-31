import SwiftUI

struct RippleButtonStyle: ButtonStyle {
    var title: String
    var width: CGFloat
    var height: CGFloat
    var size: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            ZStack {
                Color(hex: "#72BF00")
                
                Circle()
                    .fill(Color(hex: "#01312D"))
                    .scaleEffect(configuration.isPressed ? 3.0 : 0.01)
                    .opacity(configuration.isPressed ? 1.0 : 0.0)
            }
            Text(title)
                .font(.system(size: size, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: 100))
        .animation(.easeOut(duration: 0.4), value: configuration.isPressed)
    }
}

// For backward compatibility if needed as a standalone view
struct RippleButton: View {
    var title: String
    var width: CGFloat
    var height: CGFloat
    var size: CGFloat
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Text("") // Content is handled by style
        }
        .buttonStyle(RippleButtonStyle(title: title, width: width, height: height, size: size))
    }
}
 
