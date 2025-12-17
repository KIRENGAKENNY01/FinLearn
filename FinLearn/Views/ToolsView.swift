

import SwiftUI

struct ToolsView: View {
    private let accent = Color(hex: "#01312D")

    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    Header(firstName:"Kenny")
                    
                    // Promo Card
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Learn, Practice, & Prosper")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(hex: "#1B2534"))
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("Use smart tools to plan, save, and master your money.")
                                .font(.system(size: 13))
                                .foregroundColor(Color(hex: "#1B2534").opacity(0.7))
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Image("PersonCoin")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 140)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex: "#C3FE58").opacity(0.5))
                    )
                    .padding(.horizontal, 20)

                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        

                        // Budget Planner
                        NavigationLink(destination: BudgetView()) {
                            DashboardToolCard(
                                title: "Budget Planner",
                                description: "Simple calculator for income versus monthly expenses.",
                                imageName: "wallet",
                                accent: Color(hex: "#72BF00")
                            )
                        }
                        
                        // Savings Tracker
                        NavigationLink(destination: SavingsView()) {
                            DashboardToolCard(
                                title: "Savings Tracker",
                                description: "Visual tool to plan and track your savings progress",
                                imageName: "bagOfCoin",
                                accent: Color(hex: "#30A46C")
                            )
                        }
                        
                        // Loan Calculator
                        NavigationLink(destination: LoanView()) {
                            DashboardToolCard(
                                title: "Loan Calculator",
                                description: "Smart tool to estimate interest and repayment amounts.",
                                imageName: "card1",
                                accent: Color(hex: "#1E8C4A")
                            )
                        }
                        
                        // Quiz Challenges
                        NavigationLink(destination: QuizView()) {
                            DashboardToolCard(
                                title: "Quiz Challenges",
                                description: "Fun quizzes to test and strengthen your money skills.",
                                imageName: "puzzle",
                                accent: Color(hex: "#01312D") // Dark Green
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
            }
        }
        // If RootView/MainTabs provides NavigationStack, this title might double up if not careful.
        // We removed .navigationTitle to allow custom header or inherit.
        // But usually "Tools" title comes from Tab or Nav.
        // Added custom Text("Tools") header to match design Image 1.
    }
}

#Preview {
    NavigationStack {
        ToolsView()
    }
}

