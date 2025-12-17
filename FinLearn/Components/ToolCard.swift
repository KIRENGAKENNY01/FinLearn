import SwiftUI

struct DashboardToolCard: View {
    let title: String
    let description: String
    let imageName: String
    let accent: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
                    .multilineTextAlignment(.center)
                
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 180)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    ZStack {
        Color(hex: "#EAFDEF")
        ToolCard(
            title: "Budget Planner",
            description: "Simple calculator for income versus monthly expenses.",
            imageName: "PersonCoin",
            accent: .green
        )
        .padding()
    }
}
