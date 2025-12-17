
import SwiftUI

// MARK: - Models
struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
    let category: String
}

// MARK: - Main Budget View
struct BudgetView: View {
    @EnvironmentObject var appState: AppState // Access global state
    
    // Dynamic Data
    @State private var expenses: [BudgetTransaction] = []
    @State private var income: Double = 0
    @State private var expenseTotal: Double = 0
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Header Area
                    VStack(spacing: 8) {
                        Text("11 OCT - 11 NOV")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        Text("2025")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        Text("Last Month")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    
                    // Donut Chart Area
                    ZStack {
                        DonutChart(incomePercentage: 0.4, expensePercentage: 0.6)
                            .frame(width: 200, height: 200)
                        
                        // Inner circle color provided by Chart or ZStack background?
                        // The design has white center.
                        Circle()
                            .fill(Color(hex: "#EAFDEF"))
                            .frame(width: 140, height: 140)
                    }
                    
                    // Stats Row
                    HStack(spacing: 40) {
                        VStack {
                            Text("Income")
                                .font(.caption)
                                .foregroundColor(Color(hex: "#01312D"))
                            Text("\(Int(income)) RWF")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color.blue)
                        }
                        
                        VStack {
                            Text("Expenses")
                                .font(.caption)
                                .foregroundColor(Color(hex: "#01312D"))
                            Text("\(Int(expenseTotal)) RWF")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color.yellow) // Adjust to match image yellow
                        }
                    }
                    
                    VStack(spacing: 5) {
                        Text("Status")
                            .font(.caption)
                            .foregroundColor(.gray)
                        HStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 8, height: 8)
                            Text("You've gone over budget.")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#01312D"))
                        }
                    }
                    
                    // History Button
                    NavigationLink(destination: BudgetHistoryView()) {
                        Text("History")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color(hex: "#72BF00"))
                            .cornerRadius(25)
                    }
                    
                    // Recent List
                    VStack {
                        HStack {
                            Text("This month")
                                .font(.headline)
                                .foregroundColor(Color(hex: "#01312D"))
                            Spacer()
                            Button("See more") {
                                // Action
                            }
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#72BF00"))
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            // Budget/Income Toggle visual
                            HStack {
                                Text("Expenses")
                                    .font(.caption)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color(hex: "#72BF00"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                Spacer()
                                Text("Income") // Inactive
                                    .font(.caption)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(20)
                            }
                            .padding()
                            
                            HStack {
                                Text("Total")
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("500,000RWF")
                                    .bold()
                                    .foregroundColor(Color(hex: "#01312D"))
                            }
                            .padding()
                            Divider()
                            
                            ForEach(expenses) { item in
                                HStack {
                                    Text(item.category)
                                        .foregroundColor(Color(hex: "#01312D"))
                                    Spacer()
                                    Text("\(Int(item.amount)) RWF")
                                        .bold()
                                        .foregroundColor(Color(hex: "#01312D"))
                                }
                                .padding()
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                    
                    // Edit/Add Button
                    NavigationLink(destination: BudgetEditView()) {
                        Text("Edit Plan / Follow Up")
                            .foregroundColor(Color(hex: "#72BF00"))
                            .padding()
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .navigationTitle("Budget Planner")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadBudget()
        }
    }
    
    func loadBudget() {
        guard let user = appState.currentUser else { return }
        Task {
            // Fetch Budget Plan
            let plans = try? await appState.databaseService.getBudgetPlans(userId: user.id)
            if let firstPlan = plans?.first {
                self.income = firstPlan.income
                // In real app, calculate total expenses from transactions
            }
            
            // Fetch Transactions
            if let txs = try? await appState.databaseService.getTransactions(userId: user.id, budgetId: "dec_2025") {
                self.expenses = txs
                self.expenseTotal = txs.reduce(0) { $0 + $1.amount }
            }
        }
    }
}

// MARK: - Components
struct DonutChart: View {
    let incomePercentage: Double
    let expensePercentage: Double
    
    var body: some View {
        ZStack {
            // Income Slice (Blue)
            Circle()
                .trim(from: 0, to: incomePercentage)
                .stroke(Color.blue, lineWidth: 40)
                .rotationEffect(.degrees(-90))
            
            // Expense Slice (Yellow)
            Circle()
                .trim(from: incomePercentage, to: 1)
                .stroke(Color.yellow, lineWidth: 40)
                .rotationEffect(.degrees(-90))
        }
    }
}

// MARK: - History View
struct BudgetHistoryView: View {
    let months = [
        "11 Jan - 11 Feb 2025",
        "11 Feb - 11 Mar 2025",
        "11 Mar - 11 Apr 2025",
        "11 Apr - 11 May 2025",
        "11 May - 11 Jun 2025",
        "11 Jun - 11 Jul 2025"
    ]
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    Text("History")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(hex: "#01312D"))
                        .padding(.top, 20)
                    
                    ForEach(months, id: \.self) { month in
                        NavigationLink(destination: BudgetView()) {
                            HStack {
                                Circle()
                                    .fill(Color(hex: "#01312D"))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Image(systemName: "clock") // Replace with icon
                                            .foregroundColor(.white)
                                    )
                                Text(month)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(hex: "#01312D"))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(hex: "#01312D"))
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .navigationTitle("Budget Planner")
    }
}

// MARK: - Edit View
struct BudgetEditView: View {
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("11 NOV - 11 DEC")
                        .font(.headline)
                    Text("2025")
                        .font(.subheadline)
                    Text("This Month")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Expenses")
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(hex: "#72BF00"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            Spacer()
                            Text("Income")
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(20)
                        }
                        
                        HStack {
                            Text("Total")
                            Spacer()
                            Text("500,000RWF")
                                .bold()
                        }
                        .padding(.vertical)
                        Divider()
                        
                        // Fake Form Fields
                        EditRow(label: "Netflix", amount: "14,000RWF")
                        EditRow(label: "Food", amount: "100,000RWF")
                        EditRow(label: "Fuel", amount: "100,000RWF")
                        EditRow(label: "Utilities", amount: "100,000RWF")
                        EditRow(label: "Utilities", amount: "100,000RWF")

                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    HStack(spacing: 20) {
                        Button("Follow up") { }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#72BF00"))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                        
                        Button("Add budget") { }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#DDFEC5")) // Light green
                            .foregroundColor(Color(hex: "#72BF00"))
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(hex: "#72BF00"), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                    
                    // Recommendations Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recommendations")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#72BF00"))
                        
                        HStack(alignment: .top) {
                            Circle().fill(.black).frame(width: 8, height: 8).padding(.top, 6)
                            Text("You should cut 5% expense on entertainment")
                                .font(.caption)
                        }
                        
                        HStack(alignment: .top) {
                            Circle().fill(.black).frame(width: 8, height: 8).padding(.top, 6)
                            Text("You should use your water correctly as the price has rose up")
                                .font(.caption)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                }
                .padding(.top)
            }
        }
        .navigationTitle("Budget Planner")
    }
}

struct EditRow: View {
    let label: String
    let amount: String
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
            Spacer()
            Text(amount)
                .bold()
                .foregroundColor(Color(hex: "#01312D"))
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    NavigationStack {
        BudgetView()
    }
}
