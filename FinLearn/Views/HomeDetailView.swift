import SwiftUI

/// Example detail view for Home tab navigation
struct HomeDetailView: View {
    let title: String
    let description: String
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                        .padding(.horizontal)
                    
                    Text(description)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    // Example: Another navigation level
                    NavigationLink(destination: HomeSubDetailView(subtitle: "Deep Navigation Example")) {
                        HStack {
                            Text("Go Deeper")
                                .font(.system(size: 16, weight: .medium))
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(Color(hex: "#72BF00"))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// Example sub-detail view to demonstrate deeper navigation
struct HomeSubDetailView: View {
    let subtitle: String
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(subtitle)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
                
                Text("This demonstrates navigation can go multiple levels deep within each tab's NavigationStack.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationTitle("Sub Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HomeDetailView(
            title: "Example Detail Screen",
            description: "This is an example of navigation from HomeView. Each tab has its own NavigationStack, so navigation works independently."
        )
    }
}

