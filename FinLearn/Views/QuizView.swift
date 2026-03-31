
import SwiftUI

struct QuizView: View {
    @EnvironmentObject var appState: AppState // Access global state
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Header
                    HStack {
                        Text("Quiz Challenges")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color(hex: "#01312D"))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Text("Select a difficulty level to start testing your knowledge.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    // Categories
                    VStack(spacing: 16) {
                        
                        // Beginner - Always Open
                        NavigationLink(destination: QuizQuestionView()) {
                            QuizCategoryCard(
                                title: "Beginner",
                                description: "Start with the basics of budgeting and saving.",
                                icon: "star.fill",
                                color: Color(hex: "#72BF00")
                            )
                        }
                        
                        // Intermediate - Locked if Beginner
                        if appState.userLevel == "Beginner" {
                            NavigationLink(destination: LockedStageView()) {
                                QuizCategoryCard(
                                    title: "Intermediate",
                                    description: "Learn about investing and credit scores. (Locked)",
                                    icon: "lock.fill",
                                    color: .gray
                                )
                            }
                        } else {
                            NavigationLink(destination: Intermediate()) {
                                QuizCategoryCard(
                                    title: "Intermediate",
                                    description: "Learn about investing and credit scores.",
                                    icon: "star.leadinghalf.filled",
                                    color: Color(hex: "#30A46C")
                                )
                            }
                        }
                        
                        // Advanced - Locked if not Advanced
                        if appState.userLevel == "Advanced" {
                            NavigationLink(destination: Advanced()) {
                                QuizCategoryCard(
                                    title: "Advanced",
                                    description: "Master taxes, retirement, and complex assets.",
                                    icon: "star",
                                    color: Color(hex: "#1E8C4A")
                                )
                            }
                        } else {
                            NavigationLink(destination: LockedStageView()) {
                                QuizCategoryCard(
                                    title: "Advanced",
                                    description: "Master taxes, retirement, and complex assets. (Locked)",
                                    icon: "lock.fill",
                                    color: .gray
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuizCategoryCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.1))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(hex: "#01312D"))
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        QuizView()
    }
}
