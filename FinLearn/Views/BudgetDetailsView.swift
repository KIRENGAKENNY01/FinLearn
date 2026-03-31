import SwiftUI

struct BudgetDetailsView: View {
    let income: Double
    let expenseTotal: Double
    let expenses: [BudgetItem]
    let incomes: [BudgetItem]
    let budgetPlan: BudgetPlan?
    
    @State private var selectedTab = "Expenses"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header (Back + Title)
                // Note: NavigationView handles the back button usually, 
                // but we follow the design's specific header if needed.
                
                VStack(spacing: 4) {
                    Text(budgetPlan?.formattedDateRange ?? "No period found")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    Text("This Month")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.top, 10)
                
                // Detailed Card
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button("Edit Plan") { }
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "#72BF00"))
                            .padding(.trailing, 25)
                            .padding(.top, 20)
                    }
                    
                    // Tab Switcher (Pill Style)
                    HStack {
                        TabPillButton(title: "Expenses", isSelected: selectedTab == "Expenses") {
                            selectedTab = "Expenses"
                        }
                        TabPillButton(title: "Income", isSelected: selectedTab == "Incomes") {
                            selectedTab = "Incomes"
                        }
                    }
                    .padding(6)
                    .background(Color(hex: "#F5F5F5"))
                    .cornerRadius(32)
                    .padding(.horizontal, 30)
                    .padding(.top, 15)
                    
                    // Full Items List
                    VStack(spacing: 12) {
                        // Total Row
                        HStack {
                            Text("Total")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(Int(selectedTab == "Expenses" ? expenseTotal : income).formattedWithCommas)RWF")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .padding(.top, 15)
                        
                        Divider()
                        
                        let items = selectedTab == "Expenses" ? expenses : incomes
                        if items.isEmpty {
                            Text("No \(selectedTab.lowercased()) entries.")
                                .foregroundColor(.gray)
                                .padding(.vertical, 20)
                        } else {
                            ForEach(items) { item in
                                HStack {
                                    Text(item.category)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.gray)
                                    Spacer()
                                    Text("\(Int(item.amount).formattedWithCommas)RWF")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.black)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                }
                .background(Color.white)
                .cornerRadius(40)
                .padding(.horizontal, 10)
                
                HStack(spacing: 15) {
                    NavigationLink(destination: FollowUpView(budgetPlan: budgetPlan)) {
                        Text("Follow up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color(hex: "#72BF00"))
                            .cornerRadius(30)
                    }
                    
                    NavigationLink(destination: AddBudgetView()) {
                        Text("Add budget")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#72BF00"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(hex: "#72BF00"), lineWidth: 2)
                            )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Recommendations Card
                VStack(alignment: .leading, spacing: 20) {
                    Text("Recommendations")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#72BF00"))
                    
                    VStack(alignment: .leading, spacing: 15) {
                        BudgetRecommendationRow(text: "You should cut 5% expense on entertainment")
                        BudgetRecommendationRow(text: "You should use your water correctly as the price has rose up")
                    }
                }
                .padding(25)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(30)
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            .padding(.bottom, 30)
        }
        .background(Color(hex: "#EEFBF2").edgesIgnoringSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BudgetRecommendationRow: View {
    let text: String
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.top, 6)
            
            Text(text)
                .font(.system(size: 15))
                .foregroundColor(.black.opacity(0.8))
                .lineSpacing(4)
        }
    }
}
