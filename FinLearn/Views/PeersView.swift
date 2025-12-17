
import SwiftUI

struct PeersView: View {
    // Mock Data for Leaderboard
    let peers = [
        ("Kenny", 2400, "User1"), // Assume User1 is an asset or default avatar
        ("Sarah", 2150, "User2"),
        ("Mike", 1920, "User3"),
        ("Jessica", 1850, "User4"),
        ("David", 1700, "User5"),
        ("Emily", 1540, "User6")
    ]
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Leaderboard")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(hex: "#01312D"))
                        Spacer()
                    }
                    .padding()
                    
                    // Top 3 Podium Area (Visual mock)
                    HStack(alignment: .bottom, spacing: 16) {
                        // 2nd Place
                        VStack {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60, height: 60)
                                .overlay(Text("2").font(.title).bold())
                            Text(peers[1].0).font(.caption).bold()
                            Text("\(peers[1].1)").font(.caption2)
                            Rectangle()
                                .fill(Color(hex: "#30A46C").opacity(0.6))
                                .frame(width: 70, height: 100)
                                .cornerRadius(10, corners: [.topLeft, .topRight])
                        }
                        
                        // 1st Place
                        VStack {
                            Image("Logo") // Use App Logo or Crown icon
                                .resizable().scaledToFit().frame(width: 30)
                            Circle()
                                .fill(Color.yellow.opacity(0.3))
                                .frame(width: 80, height: 80)
                                .overlay(Text("1").font(.largeTitle).bold())
                            Text(peers[0].0).font(.headline).bold()
                            Text("\(peers[0].1)").font(.caption)
                            Rectangle()
                                .fill(Color(hex: "#72BF00")) // Bright Green
                                .frame(width: 90, height: 140)
                                .cornerRadius(10, corners: [.topLeft, .topRight])
                        }
                        
                        // 3rd Place
                        VStack {
                            Circle()
                                .fill(Color.brown.opacity(0.3))
                                .frame(width: 60, height: 60)
                                .overlay(Text("3").font(.title).bold())
                            Text(peers[2].0).font(.caption).bold()
                            Text("\(peers[2].1)").font(.caption2)
                            Rectangle()
                                .fill(Color(hex: "#30A46C").opacity(0.6))
                                .frame(width: 70, height: 80)
                                .cornerRadius(10, corners: [.topLeft, .topRight])
                        }
                    }
                    .padding(.bottom, 20)
                    
                    // Rest of List
                    VStack(spacing: 12) {
                        ForEach(3..<peers.count, id: \.self) { index in
                            HStack {
                                Text("\(index + 1)")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(.gray)
                                    .frame(width: 30)
                                
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .foregroundColor(.gray)
                                    )
                                
                                Text(peers[index].0)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(hex: "#01312D"))
                                
                                Spacer()
                                
                                Text("\(peers[index].1) pts")
                                    .bold()
                                    .foregroundColor(Color(hex: "#72BF00"))
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Helper for specific corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    NavigationStack {
        PeersView()
    }
}
