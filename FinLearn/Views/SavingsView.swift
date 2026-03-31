import SwiftUI

struct SavingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @State private var history: [SavingsResultDTO] = []
    @State private var latestBudget: BudgetPlan?
    @State private var showEvaluation = false
    @State private var loading = false
    @State private var showAddSavings = false
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    
                    let currentMonthIso: String = {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM"
                        return formatter.string(from: Date())
                    }()
                    
                    let currentEvaluation = history.first(where: { $0.monthIso == currentMonthIso })
                    
                    VStack(spacing: 4) {
                        Text(currentEvaluation?.dateRange ?? latestBudget?.formattedDateRange ?? "No period found")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        Text("Current Evaluation Period")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    
                    // Main Card (Image 1 style)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Savings")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#01312D").opacity(0.6))
                        
                        let totalSavings = currentEvaluation?.totals.actualSavings ?? (latestBudget.map { 
                            ($0.actualTotalIncome ?? $0.totalPlannedIncome) - ($0.actualTotalExpenses ?? $0.totalPlannedExpenses) 
                        } ?? 0)
                        Text("\(Int(totalSavings).formattedWithCommas) RWF")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        // Line with dots
                        HStack(spacing: 0) {
                            Circle().fill(Color(hex: "#01312D")).frame(width: 6, height: 6)
                            Rectangle().fill(Color(hex: "#01312D")).frame(height: 1)
                            Circle().fill(Color(hex: "#01312D")).frame(width: 6, height: 6)
                        }
                        
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Income")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#01312D").opacity(0.6))
                                
                                let incomeVal = currentEvaluation?.totals.actualIncome ?? (latestBudget?.actualTotalIncome ?? latestBudget?.totalPlannedIncome ?? 0)
                                
                                Text("\(Int(incomeVal).formattedWithCommas) RWF")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(Color(hex: "#01312D"))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Rectangle()
                                .fill(Color(hex: "#01312D").opacity(0.5))
                                .frame(width: 1.5, height: 50)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Expense")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#01312D").opacity(0.6))
                                
                                let expenseVal = currentEvaluation?.totals.actualExpenses ?? (latestBudget?.actualTotalExpenses ?? latestBudget?.totalPlannedExpenses ?? 0)
                                
                                Text("\(Int(expenseVal).formattedWithCommas) RWF")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(Color(hex: "#01312D"))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        }
                    }
                    .padding(30)
                    .background(Color(hex: "#DDFEC5"))
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                    // Add Savings Button
                    Button(action: { showAddSavings = true }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Savings")
                                .font(.system(size: 18, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(hex: "#72BF00"))
                        .cornerRadius(30)
                        .shadow(color: Color(hex: "#72BF00").opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal)
                    
                    // Follow up Card (Image 1 style)
                    HStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Follow up")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(hex: "#01312D"))
                            
                            Text("Check if you savings goal\nthis month was met")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#01312D").opacity(0.8))
                                .lineSpacing(2)
                            
                            Button(action: { 
                                if latestBudget != nil {
                                    showEvaluation = true 
                                }
                            }) {
                                Text("Check")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 35)
                                    .padding(.vertical, 12)
                                    .background(latestBudget == nil ? Color.gray : Color(hex: "#72BF00"))
                                    .cornerRadius(25)
                            }
                        }
                        
                        Spacer()
                        
                        // Illustration Placeholder (I'll use a generic image if rafiki doesn't exist, but design shows a coin person)
                        Image(systemName: "hand.raised.fill") // Replace with real asset if available
                            .font(.system(size: 60))
                            .foregroundColor(Color(hex: "#72BF00"))
                            .overlay(
                                Image(systemName: "dollarsign.circle.fill")
                                    .font(.system(size: 30))
                                    .background(Color.white.clipShape(Circle()))
                                    .offset(x: -20, y: -20)
                            )
                    }
                    .padding(30)
                    .background(Color(hex: "#DDFEC5"))
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                    // Savings History Section
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Savings history")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        VStack(spacing: 0) {
                            // Header
                            HStack {
                                Text("Month")
                                    .font(.system(size: 16, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("Savings")
                                    .font(.system(size: 16, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("Status")
                                    .font(.system(size: 16, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal, 25)
                            .padding(.vertical, 15)
                            .background(Color(hex: "#01312D"))
                            .foregroundColor(.white)
                            .cornerRadius(12, corners: [.topLeft, .topRight])
                            
                            // Rows
                            VStack(spacing: 12) {
                                let historyItems = history.isEmpty ? mockHistory : history
                                ForEach(historyItems) { item in
                                    HStack {
                                        Text(item.dateRange) // Month
                                            .font(.system(size: 15))
                                            .foregroundColor(Color(hex: "#01312D"))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text("\(Int(item.totals.actualSavings).formattedWithCommas) Rwf")
                                            .font(.system(size: 15, weight: .bold))
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        
                                        Text(item.status)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(statusColor(item.status))
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 8)
                                            .background(statusColor(item.status).opacity(0.1))
                                            .cornerRadius(15)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 12)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                }
                            }
                            .padding(.top, 12)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .navigationTitle("Saving tool")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .fullScreenCover(isPresented: $showEvaluation) {
            if let budget = latestBudget {
                SavingsEvaluationView(budgetPlan: budget)
            }
        }
        .onAppear {
            fetchHistory()
        }
        .navigationDestination(isPresented: $showAddSavings) {
            AddSavingsView(rootIsActive: $showAddSavings)
        }
    }
    
    func fetchHistory() {
        loading = true
        Task {
            do {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM"
                let currentMonth = formatter.string(from: Date())
                
                let hist = try await appState.databaseService.getSavingsHistory()
                // Focus on current month budget
                var budget = try await appState.databaseService.getBudgetForMonth(monthIso: currentMonth)
                if budget == nil {
                    budget = try await appState.databaseService.getLatestBudget()
                }
                
                await MainActor.run {
                    self.history = hist
                    self.latestBudget = budget
                    self.loading = false
                }
            } catch {
                print("Failed to fetch dashboard data: \(error)")
                await MainActor.run { self.loading = false }
            }
        }
    }
    
    // Status color helper
    func statusColor(_ status: String) -> Color {
        switch status.lowercased() {
        case "good", "goal met": return Color.green
        case "medium": return Color.orange
        case "bad": return Color.red
        default: return Color.gray
        }
    }
    
    // Mock History for Preview when empty
    var mockHistory: [SavingsResultDTO] {
        return [
            SavingsResultDTO(dateRange: "January", monthIso: "2025-01", status: "Medium", totals: .init(plannedSavings: 0, actualSavings: 10000, actualIncome: 0, actualExpenses: 0)),
            SavingsResultDTO(dateRange: "February", monthIso: "2025-02", status: "Good", totals: .init(plannedSavings: 0, actualSavings: 1900, actualIncome: 0, actualExpenses: 0)),
            SavingsResultDTO(dateRange: "March", monthIso: "2025-03", status: "Bad", totals: .init(plannedSavings: 0, actualSavings: 5000, actualIncome: 0, actualExpenses: 0)),
            SavingsResultDTO(dateRange: "April", monthIso: "2025-04", status: "Medium", totals: .init(plannedSavings: 0, actualSavings: 4000, actualIncome: 0, actualExpenses: 0)),
            SavingsResultDTO(dateRange: "May", monthIso: "2025-05", status: "Good", totals: .init(plannedSavings: 0, actualSavings: 6000, actualIncome: 0, actualExpenses: 0)),
        ]
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
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

// MARK: - Add Savings View
struct AddSavingsView: View {
    @Binding var rootIsActive: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State private var navigateToSuccess = false
    @State private var navigateToFail = false
    @State private var submitting = false
    
    // Inputs (Image 2 style)
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
    @State private var savingsAmount = ""
    @State private var currency = "RWF"
    
    // Validation State
    @State private var matchedBudget: BudgetPlan?
    @State private var budgetWarning: String?
    @State private var isFetchingBudget = false
    
    @State private var lastResult: SavingsResultDTO?
    
    var monthIso: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter.string(from: startDate)
    }
    
    var availableSavings: Double {
        guard let budget = matchedBudget else { return 0 }
        return budget.totalPlannedIncome - budget.totalPlannedExpenses
    }
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF").ignoresSafeArea()
            ScrollView {
                VStack(spacing: 35) {
                    // Header
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
                        }
                        
                        Text("Budget Planner")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    Text("Add Savings")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    VStack(alignment: .leading, spacing: 25) {
                        // Date Pickers
                        DateInput(title: "Start of Month", date: $startDate)
                        DateInput(title: "End of Month", date: $endDate)
                        
                        // Budget Status Warning
                        if isFetchingBudget {
                            HStack {
                                ProgressView()
                                Text("Checking budget for \(monthIso)...")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        } else if let warning = budgetWarning {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.orange)
                                Text(warning)
                                    .font(.caption)
                                    .foregroundColor(.orange)
                            }
                            .padding(.horizontal)
                        } else if let budget = matchedBudget {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Budget Found for \(monthIso)")
                                    .font(.caption.bold())
                                    .foregroundColor(.green)
                                Text("Max possible savings based on budget: \(Int(availableSavings).formattedWithCommas) \(budget.currency)")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                        
                        // Savings Amount
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Savings")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(hex: "#01312D"))
                            
                            HStack {
                                TextField("Amount", text: $savingsAmount)
                                    .font(.system(size: 16))
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Menu {
                                    Button("RWF") { currency = "RWF" }
                                    Button("USD") { currency = "USD" }
                                } label: {
                                    HStack(spacing: 8) {
                                        Text(currency)
                                            .font(.system(size: 14, weight: .bold))
                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 10))
                                    }
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 10)
                                    .background(Color(hex: "#01312D"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(15)
                            
                            if let amt = Double(savingsAmount), amt > availableSavings && matchedBudget != nil {
                                Text("Planned savings cannot exceed your budget difference (\(Int(availableSavings).formattedWithCommas))")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.top, 4)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: evaluate) {
                        if submitting {
                            ProgressView().tint(.white)
                        } else {
                            Text("Save")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(Color(hex: "#72BF00"))
                                .cornerRadius(30)
                        }
                    }
                    .padding(.horizontal, 60)
                    .padding(.top, 10)
                    .disabled(submitting || matchedBudget == nil || (Double(savingsAmount) ?? 0) > availableSavings)
                }
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: startDate) { _ in fetchBudget() }
        .onAppear { fetchBudget() }
        .navigationDestination(isPresented: $navigateToSuccess) {
            if let result = lastResult {
                SavingsSuccessView(rootIsActive: $rootIsActive, result: result)
            }
        }
        .navigationDestination(isPresented: $navigateToFail) {
            if let result = lastResult {
                SavingsFailView(rootIsActive: $rootIsActive, result: result)
            }
        }
    }
    
    func fetchBudget() {
        isFetchingBudget = true
        budgetWarning = nil
        Task {
            do {
                let budget = try await appState.databaseService.getBudgetForMonth(monthIso: monthIso)
                await MainActor.run {
                    self.matchedBudget = budget
                    if budget == nil {
                        self.budgetWarning = "You haven't saved a budget for \(monthIso) yet. Please create one first."
                    }
                    self.isFetchingBudget = false
                }
            } catch {
                await MainActor.run {
                    self.budgetWarning = "Could not verify budget for this month."
                    self.isFetchingBudget = false
                }
            }
        }
    }

    func evaluate() {
        let plan = Double(savingsAmount) ?? 0 // If none put zero
        
        // Final sanity check
        guard let budget = matchedBudget else { return }
        if plan > availableSavings { return }

        submitting = true
        Task {
            do {
                let inc = budget.actualTotalIncome ?? 0
                let exp = budget.actualTotalExpenses ?? 0
                
                let result = try await appState.databaseService.evaluateSavings(
                    startDate: startDate,
                    endDate: endDate,
                    expected: plan,
                    income: inc,
                    expenses: exp,
                    emergencies: []
                )
                self.lastResult = result
                if result.status == "Goal Met" {
                    navigateToSuccess = true
                } else {
                    navigateToFail = true
                }
                submitting = false
                
            } catch {
                print("Failed to evaluate: \(error)")
                submitting = false
            }
        }
    }
}

// MARK: - Savings Success View
struct SavingsSuccessView: View {
    @Binding var rootIsActive: Bool
    let result: SavingsResultDTO
    
    var body: some View {
        ZStack {
            Color(hex: "#72BF00")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                Image("Cup")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                VStack(spacing: 8) {
                    Text("\(Int(result.totals.actualSavings)) RWF")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    Text("You did it")
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    Text("Congratulations! You’ve reached your savings goal this month. great job staying on track!")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "#01312D"))
                        .padding(.horizontal)
                }
                .padding()
                .background(Color(hex: "#DDFEC5"))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: { rootIsActive = false }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#72BF00"))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#DDFEC5"))
                        .cornerRadius(30)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Savings Fail View
struct SavingsFailView: View {
    @Binding var rootIsActive: Bool
    let result: SavingsResultDTO
    
    var body: some View {
        ZStack {
            Color(hex: "#01312D")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                Image("Cup")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                VStack(spacing: 8) {
                    Text("\(Int(result.totals.actualSavings)) RWF")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    Text("You can improve")
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    Text("You didn't quite reach your goal this month, but don't worry! Keep tracking and adjust your spending.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(hex: "#01312D"))
                        .padding(.horizontal)
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button(action: { rootIsActive = false }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(Color(hex: "#72BF00"))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
    }
}

struct BudgetInputRow: View {
    let title: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .bold()
                .foregroundColor(Color(hex: "#01312D"))
            TextField("Enter amount", text: $text)
                .keyboardType(.numberPad)
                .foregroundColor(.black)
                .padding()
                .background(Color.gray.opacity(0.05))
                .cornerRadius(8)
        }
    }
}
