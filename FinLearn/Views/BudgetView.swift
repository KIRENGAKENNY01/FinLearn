import SwiftUI

struct BudgetView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab = "Expenses"
    @State private var income: Double = 0
    @State private var expenseTotal: Double = 0
    @State private var expenses: [BudgetItem] = []
    @State private var incomes: [BudgetItem] = []
    @State private var showAddBudget = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Header (Back + Title)
                // Date and Title (Back handled by navigation title or system)
                VStack(spacing: 4) {
                    Text("Budget Planner")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                }
                .padding(.top, 10)
                
                if budgetPlan == nil {
                    // Initial State: Prompt to add budget
                    VStack(spacing: 30) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(Color(hex: "#72BF00"))
                        
                        VStack(spacing: 10) {
                            Text("No budget created yet")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("Plan your finances today!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {
                            showAddBudget = true
                        }) {
                            Text("Add Budget")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 15)
                                .background(Color(hex: "#72BF00"))
                                .cornerRadius(30)
                        }
                    }
                    .padding(.top, 80)
                } else {
                    // Dashboard View
                    VStack(spacing: 15) {
                        Text(budgetPlan?.formattedDateRange ?? "No period found")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        Text("Last Month")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        // Donut Chart Area
                        ZStack {
                            DonutChart(incomePercentage: 0.4, expensePercentage: 0.6)
                                .frame(width: 220, height: 220)
                            
                            Circle()
                                .fill(Color(hex: "#EEFBF2"))
                                .frame(width: 150, height: 150)
                        }
                        .padding(.vertical, 10)
                        
                        // Income / Expenses Summary
                        HStack(spacing: 50) {
                            VStack(spacing: 5) {
                                Text("Income")
                                    .foregroundColor(.gray)
                                Text("\(Int(income).formattedWithCommas) RWF")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(hex: "#1DA1F2"))
                            }
                            
                            VStack(spacing: 5) {
                                Text("Expenses")
                                    .foregroundColor(.gray)
                                Text("\(Int(expenseTotal).formattedWithCommas) RWF")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color(hex: "#FFC107"))
                            }
                        }
                        
                        VStack(spacing: 5) {
                            Text("Status")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            HStack(spacing: 5) {
                                Circle()
                                    .fill(Color(hex: "#72BF00"))
                                    .frame(width: 8, height: 8)
                                Text("You've gone over budget.")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#01312D"))
                            }
                        }
                        .padding(.top, 5)
                        
                // This Month Section
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("This month")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        Spacer()
                        
                        NavigationLink(destination: BudgetDetailsView(
                            income: income,
                            expenseTotal: expenseTotal,
                            expenses: expenses,
                            incomes: incomes,
                            budgetPlan: budgetPlan
                        )) {
                            Text("See more")
                                .font(.system(size: 16))
                                .foregroundColor(Color(hex: "#72BF00"))
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 20)
                    
                    // Transaction List Card (Summarized)
                    VStack(spacing: 0) {
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
                        .padding(.top, 20)
                        
                        // Items
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
                                // Summarize to 4 items
                                ForEach(items.prefix(4)) { item in
                                    HStack {
                                        Text(item.category)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text("\(Int(item.amount).formattedWithCommas)RWF")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                    }
                    .background(Color.white)
                    .clipShape(RoundedTopCorners(radius: 40))
                }
                .padding(.top, 20)
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .background(Color(hex: "#EEFBF2").edgesIgnoringSafeArea(.all))
        .navigationTitle("Budget")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .onAppear {
            loadBudget()
        }
        .fullScreenCover(isPresented: $showAddBudget) {
            AddBudgetView()
        }
    }
    
    func loadBudget() {
        loading = true
        Task {
            do {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM"
                let currentMonth = formatter.string(from: Date())
                
                // Try fetching current month budget first
                var plan = try await appState.databaseService.getBudgetForMonth(monthIso: currentMonth)
                
                // Fallback to latest if current month not found
                if plan == nil {
                    plan = try await appState.databaseService.getLatestBudget()
                }
                
                if let finalPlan = plan {
                    await MainActor.run {
                        if finalPlan.isCompleted == true {
                             // If the budget for this period is over, we show the 'Add Budget' screen (nil plan)
                             // You might want to optionally show a "View Past Budgets" button, but for now this forces next period creation.
                             self.budgetPlan = nil
                        } else {
                            self.income = finalPlan.totalPlannedIncome
                            self.expenseTotal = finalPlan.totalPlannedExpenses
                            self.budgetPlan = finalPlan
                            self.expenses = finalPlan.expenseItems ?? []
                            self.incomes = finalPlan.incomeItems ?? []
                        }
                        self.loading = false
                    }
                } else {
                    await MainActor.run { self.loading = false }
                }
            } catch {
                print("Failed to load budget: \(error)")
                await MainActor.run { self.loading = false }
            }
        }
    }
    
    @State private var loading = false
    @State private var budgetPlan: BudgetPlan?
    
    var isOneMonthPassed: Bool {
        guard let createdAt = budgetPlan?.createdAt else { return false }
        let oneMonthAgo = Calendar.current.date(byAdding: .month, value: 1, to: createdAt) ?? Date()
        return Date() >= oneMonthAgo
    }
}

// Support Views

struct TabPillButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 15, weight: isSelected ? .bold : .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(isSelected ? Color(hex: "#72BF00") : Color.clear)
                .foregroundColor(isSelected ? .white : .gray)
                .cornerRadius(25)
        }
    }
}

struct DonutChart: View {
    let incomePercentage: Double
    let expensePercentage: Double
    
    var body: some View {
        ZStack {
            // Income portion (Blue)
            Circle()
                .trim(from: 0, to: 0.4)
                .stroke(Color(hex: "#1DA1F2"), lineWidth: 45)
                .rotationEffect(.degrees(-90))
                .overlay(
                    Text("40%")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .offset(x: -60, y: -40)
                )
            
            // Expense portion (Yellow)
            Circle()
                .trim(from: 0.4, to: 1.0)
                .stroke(Color(hex: "#FFC107"), lineWidth: 45)
                .rotationEffect(.degrees(-90))
                .overlay(
                    Text("60%")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                        .offset(x: 40, y: 60)
                )
        }
    }
}

struct RoundedTopCorners: Shape {
    var radius: CGFloat = .infinity
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


// --- ADD BUDGET VIEW ---
struct BudgetCategoryItem: Identifiable {
    let id = UUID()
    var category: String = ""
    var amount: String = ""
}

// --- ADD BUDGET VIEW ---
struct AddBudgetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
    
    @State private var incomeItems: [BudgetCategoryItem] = [BudgetCategoryItem()]
    @State private var expenseItems: [BudgetCategoryItem] = [BudgetCategoryItem()]
    @State private var currency: String = "RWF"  // Added missing state
    
    @State private var saving: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // Header
                ZStack {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color(hex: "#01312D"))
                                .padding(12)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 5) {
                        Text("Add budget")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color(hex: "#01312D"))
                    }
                }
                .padding(.top, 10)
                
                // Dates
                VStack(alignment: .leading, spacing: 20) {
                    DateInput(title: "Start of Month", date: $startDate, range: Date()...)
                    DateInput(title: "End of Month", date: $endDate, range: startDate...)
                }
                .padding(.horizontal)
                
                // Income Section
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Income")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#01312D"))
                        Spacer()
                        Button(action: {
                            incomeItems.append(BudgetCategoryItem())
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                                .background(Color(hex: "#72BF00")) // Light green
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    
                    ForEach($incomeItems) { $item in
                        BudgetEntryRow(item: $item, currency: $currency)
                    }
                }
                
                // Expenses Section
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text("Expenses")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#01312D"))
                        Spacer()
                        Button(action: {
                            expenseItems.append(BudgetCategoryItem())
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                                .background(Color(hex: "#72BF00"))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    
                    ForEach($expenseItems) { $item in
                        BudgetEntryRow(item: $item, currency: $currency)
                    }
                }
                
                // Save Button
                Button(action: saveBudget) {
                    if saving {
                        ProgressView().tint(.white)
                    } else {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#72BF00")) // Green
                            .cornerRadius(30)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                .disabled(saving)
                
                Spacer(minLength: 40)
            }
            .padding(.vertical)
        }
        .background(Color(hex: "#EAFDEF").edgesIgnoringSafeArea(.all)) // Light Mesh Gradient feel
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
    }
    
    func saveBudget() {
        // Calculate totals
        let totalIncome = incomeItems.reduce(0.0) { $0 + (Double($1.amount) ?? 0) }
        let totalExpenses = expenseItems.reduce(0.0) { $0 + (Double($1.amount) ?? 0) }
        
        if totalIncome == 0 && totalExpenses == 0 { return }
        
        saving = true
        
        // Use Start Date for MonthIso
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        let monthIso = formatter.string(from: startDate)
        
        let incomeList = incomeItems.compactMap { item -> BudgetItem? in
            guard let amount = Double(item.amount), !item.category.isEmpty else { return nil }
            return BudgetItem(category: item.category, amount: amount)
        }
        
        let expenseList = expenseItems.compactMap { item -> BudgetItem? in
            guard let amount = Double(item.amount), !item.category.isEmpty else { return nil }
            return BudgetItem(category: item.category, amount: amount)
        }
        
        let plan = BudgetPlan(
            id: nil,
            userId: nil, // logic handles this
            monthIso: monthIso,
            totalPlannedIncome: totalIncome,
            totalPlannedExpenses: totalExpenses,
            actualTotalIncome: 0,
            actualTotalExpenses: 0,
            currency: "RWF",
            createdAt: Date(),
            lastFollowUpDate: nil,
            incomeItems: incomeList,
            expenseItems: expenseList,
            emergencies: []
        )
        
        Task {
            do {
                _ = try await appState.databaseService.saveBudgetPlan(plan: plan)
                dismiss()
            } catch {
                print("Error saving budget: \(error)")
                saving = false
            }
        }
    }
}


struct BudgetEntryRow: View {
    @Binding var item: BudgetCategoryItem
    @Binding var currency: String
    
    let currencies = ["RWF", "USD", "EUR", "GBP", "KES"]
    
    var body: some View {
        VStack(spacing: 12) {
            // Category Input
            TextField("Category", text: $item.category)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            
            // Amount Input with Currency
            HStack {
                TextField("Amount", text: $item.amount)
                    .keyboardType(.numberPad)
                    .foregroundColor(.black)
                
                Spacer()
                
                Menu {
                    ForEach(currencies, id: \.self) { curr in
                        Button(curr) {
                            currency = curr
                        }
                    }
                } label: {
                    HStack(spacing: 4) {
                        Text(currency)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(hex: "#01312D")) // Dark Green Label
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

// --- FOLLOW UP VIEW (STUB) ---
struct FollowUpView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    let budgetPlan: BudgetPlan?
    
    @State private var plannedIncome: String = "20,000,000"
    @State private var actualIncome: String = "0"
    
    @State private var plannedExpenses: String = "20,000,000"
    @State private var actualExpenses: String = "0"
    
    @State private var emergencyCategory: String = ""
    @State private var emergencyAmount: String = ""
    @State private var currency: String = "RWF"
    
    @State private var items: [Emergency] = []
    @State private var submitting: Bool = false
    @State private var showResult: Bool = false
    @State private var calculationResult: BudgetResult?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                
                // Title and Date
                VStack(spacing: 12) {
                    Text("How's the Budget?")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    Text(budgetPlan?.monthIso ?? "11 NOV - 11 DEC 2025")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                
                // Income Section
                VStack(alignment: .leading, spacing: 20) {
                    Text("Income")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    FollowUpInputRow(label: "Planned Amount", value: .constant("\(Int(budgetPlan?.totalPlannedIncome ?? 0))"), currency: $currency)
                        .disabled(true)
                    FollowUpInputRow(label: "Actual Amount", value: $actualIncome, currency: $currency)
                }
                .padding(.horizontal)
                
                // Expenses Section
                VStack(alignment: .leading, spacing: 20) {
                    Text("Expenses")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    FollowUpInputRow(label: "Planned Amount", value: .constant("\(Int(budgetPlan?.totalPlannedExpenses ?? 0))"), currency: $currency)
                        .disabled(true)
                    FollowUpInputRow(label: "Actual Amount", value: $actualExpenses, currency: $currency)
                }
                .padding(.horizontal)
                
                // Emergencies Section
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Emergencies")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(hex: "#01312D"))
                            Text("Add any unplanned expenses here")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: { 
                            if let amt = Double(emergencyAmount), !emergencyCategory.isEmpty {
                                items.append(Emergency(title: emergencyCategory, amount: amt))
                                emergencyCategory = ""
                                emergencyAmount = ""
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color(hex: "#72BF00"))
                                .cornerRadius(8)
                        }
                    }
                    
                    VStack(spacing: 15) {
                        TextField("Category (e.g. Car Repair)", text: $emergencyCategory)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1), lineWidth: 1))
                        
                        HStack {
                            TextField("Amount", text: $emergencyAmount)
                                .padding()
                                .keyboardType(.numberPad)
                            
                            Menu {
                                Button("RWF") { currency = "RWF" }
                                Button("USD") { currency = "USD" }
                            } label: {
                                HStack {
                                    Text(currency)
                                        .bold()
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 12))
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .background(Color(hex: "#01312D"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding(.trailing, 5)
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.1), lineWidth: 1))
                    }
                    
                    // List of added emergencies
                    ForEach(items) { item in
                        HStack {
                            Text(item.title)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(Int(item.amount)) \(currency)")
                                .bold()
                        }
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                // Submit Button
                Button(action: submitFollowUp) {
                    if submitting {
                        ProgressView().tint(.white)
                    } else {
                        Text("Submit")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color(hex: "#72BF00"))
                            .cornerRadius(30)
                    }
                }
                .padding(.horizontal, 60)
                .padding(.top, 20)
                .disabled(submitting)
                
                Spacer(minLength: 40)
            }
        }
        .background(Color(hex: "#EEFBF2").edgesIgnoringSafeArea(.all))
        .navigationTitle("Budget Planner")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Budget Results", isPresented: $showResult) {
            Button("OK") { dismiss() }
        } message: {
            if let result = calculationResult {
                Text(result.status + "\n\nAdherence: \(Int(result.percentages.expenseAdherence))%")
            }
        }
    }
    
    func submitFollowUp() {
        guard let plan = budgetPlan else { return }
        submitting = true
        
        Task {
            do {
                let actualInc = Double(actualIncome) ?? 0
                let actualExp = Double(actualExpenses) ?? 0
                
                let result = try await appState.databaseService.calculateFollowUp(
                    plan: plan,
                    actualIncome: actualInc,
                    actualExpenses: actualExp,
                    emergencies: items
                )
                
                calculationResult = result
                submitting = false
                showResult = true
            } catch {
                print("Failed follow-up: \(error)")
                submitting = false
            }
        }
    }
}

struct FollowUpInputRow: View {
    let label: String
    @Binding var value: String
    @Binding var currency: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color(hex: "#01312D"))
            
            HStack {
                TextField("", text: $value)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                    .keyboardType(.numberPad)
                
                Menu {
                    Button("RWF") { currency = "RWF" }
                    Button("USD") { currency = "USD" }
                    Button("EUR") { currency = "EUR" }
                } label: {
                    HStack {
                        Text(currency)
                            .font(.system(size: 14, weight: .bold))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(hex: "#01312D"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.1), lineWidth: 1))
        }
    }
}
