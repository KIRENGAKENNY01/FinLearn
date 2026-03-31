import SwiftUI

struct SavingsEvaluationView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    let budgetPlan: BudgetPlan
    
    @State private var actualIncome: String = ""
    @State private var actualExpenses: String = ""
    @State private var submitting = false
    @State private var evaluationResult: SavingsResultDTO?
    @State private var showResult = false
    
    var plannedSavings: Double {
        budgetPlan.totalPlannedIncome - budgetPlan.totalPlannedExpenses
    }
    
    var actualSavings: Double {
        let income = Double(actualIncome) ?? 0
        let expenses = Double(actualExpenses) ?? 0
        return income - expenses
    }
    
    var body: some View {
        ZStack {
            Color(hex: "#EEFBF2").ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.1), radius: 5)
                        }
                        
                        Text("Saving tool")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 8) {
                        Text("How's the Savings?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        Text(budgetPlan.formattedDateRange)
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 25) {
                        // Income Section
                        EvaluationSection(
                            title: "Income",
                            plannedLabel: "Planned Amount",
                            plannedValue: budgetPlan.totalPlannedIncome,
                            actualLabel: "Actual Amount",
                            actualValue: $actualIncome
                        )
                        
                        // Expenses Section
                        EvaluationSection(
                            title: "Expenses",
                            plannedLabel: "Planned Amount",
                            plannedValue: budgetPlan.totalPlannedExpenses,
                            actualLabel: "Actual Amount",
                            actualValue: $actualExpenses
                        )
                        
                        // Savings Section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Savings")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color(hex: "#01312D"))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Planned Amount")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color(hex: "#01312D"))
                                
                                Text("\(Int(plannedSavings).formattedWithCommas) RWF")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Actual Amount")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color(hex: "#01312D"))
                                
                                Text("\(Int(actualSavings).formattedWithCommas) RWF")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(hex: "#01312D"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Button(action: submitEvaluation) {
                        if submitting {
                            ProgressView().tint(.white)
                        } else {
                            Text("Submit")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(hex: "#72BF00"))
                                .cornerRadius(35)
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    .disabled(submitting || actualIncome.isEmpty || actualExpenses.isEmpty)
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .fullScreenCover(isPresented: $showResult) {
            if let result = evaluationResult {
                EvaluationResultView(result: result)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            // Pre-fill with planned if user hasn't typed anything
            if actualIncome.isEmpty { actualIncome = "\(Int(budgetPlan.totalPlannedIncome))" }
            if actualExpenses.isEmpty { actualExpenses = "\(Int(budgetPlan.totalPlannedExpenses))" }
        }
    }
    
    func submitEvaluation() {
        submitting = true
        Task {
            do {
                let inc = Double(actualIncome) ?? 0
                let exp = Double(actualExpenses) ?? 0
                
                // For simplicity in this evaluation, we use empty emergencies or we could add them
                let result = try await appState.databaseService.evaluateSavings(
                    startDate: budgetPlan.createdAt ?? Date(),
                    endDate: Calendar.current.date(byAdding: .month, value: 1, to: budgetPlan.createdAt ?? Date()) ?? Date(),
                    expected: plannedSavings,
                    income: inc,
                    expenses: exp,
                    emergencies: []
                )
                
                await MainActor.run {
                    self.evaluationResult = result
                    self.submitting = false
                    self.showResult = true
                }
            } catch {
                print("Failed to submit evaluation: \(error)")
                await MainActor.run { self.submitting = false }
            }
        }
    }
}

struct EvaluationSection: View {
    let title: String
    let plannedLabel: String
    let plannedValue: Double
    let actualLabel: String
    @Binding var actualValue: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(hex: "#01312D"))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(plannedLabel)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
                
                Text("\(Int(plannedValue).formattedWithCommas) RWF")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(actualLabel)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
                
                TextField("E.g. 42,000,000", text: $actualValue)
                    .keyboardType(.numberPad)
                    .font(.system(size: 16))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        HStack {
                            Spacer()
                            Text("RWF")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(hex: "#01312D"))
                                .padding(.trailing)
                        }
                    )
            }
        }
    }
}

struct EvaluationResultView: View {
    @Environment(\.dismiss) var dismiss
    let result: SavingsResultDTO
    
    var isSuccess: Bool {
        result.status == "Goal Met"
    }
    
    var body: some View {
        ZStack {
            (isSuccess ? Color(hex: "#01312D") : Color.orange).ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: isSuccess ? "trophy.fill" : "exclamationmark.triangle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                
                Text(isSuccess ? "Congratulations!" : "Keep Working!")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                
                Text(isSuccess ? "You hit your savings goal for this period!" : "You were a bit short of your goal this month. Let's adjust for next time.")
                    .font(.system(size: 18))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                VStack(spacing: 15) {
                    ResultRow(label: "Planned Savings", value: result.totals.plannedSavings)
                    ResultRow(label: "Actual Savings", value: result.totals.actualSavings)
                }
                .padding(25)
                .background(Color.white.opacity(0.1))
                .cornerRadius(20)
                .padding(.horizontal, 30)
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(isSuccess ? Color(hex: "#01312D") : .orange)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            }
        }
    }
}

struct ResultRow: View {
    let label: String
    let value: Double
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.white.opacity(0.8))
            Spacer()
            Text("\(Int(value).formattedWithCommas) RWF")
                .bold()
                .foregroundColor(.white)
        }
    }
}
