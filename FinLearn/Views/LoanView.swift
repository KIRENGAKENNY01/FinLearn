import SwiftUI

struct LoanView: View {
    @EnvironmentObject var appState: AppState
    @State private var amount: Double = 500000
    @State private var interestRate: Double = 5.0
    @State private var months: Double = 12
    @State private var loanTitle: String = ""
    @State private var applying: Bool = false
    @State private var showSuccess: Bool = false
    
    var monthlyPayment: Double {
        let p = amount
        let r = (interestRate / 100) / 12
        let n = months
        if r == 0 { return p / n }
        let numerator = p * r * pow((1 + r), n)
        let denominator = pow((1 + r), n) - 1
        return numerator / denominator
    }
    
    var totalPayment: Double {
        return monthlyPayment * months
    }
    
    var totalInterest: Double {
        return totalPayment - amount
    }
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Header
                    HStack {
                        Text("Loan Calculator")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color(hex: "#01312D"))
                        Spacer()
                        NavigationLink(destination: LoanApplicationsView()) {
                            Text("My Loans")
                                .font(.subheadline)
                                .foregroundColor(Color(hex: "#72BF00"))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(hex: "#DDFEC5"))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // Input Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Loan Title").font(.headline).foregroundColor(Color(hex: "#01312D"))
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Title")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color(hex: "#01312D"))
                            TextField("Enter loan title", text: $loanTitle)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)

                    
                    // CARD 1: INPUTS
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Loan Details")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        VStack(alignment: .leading) {
                            Text("Amount: \(Int(amount)) RWF")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Slider(value: $amount, in: 10000...5000000, step: 10000)
                                .accentColor(Color(hex: "#72BF00"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Interest: \(String(format: "%.1f", interestRate))%")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Slider(value: $interestRate, in: 1...20, step: 0.5)
                                .accentColor(Color(hex: "#72BF00"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Duration: \(Int(months)) Months")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Slider(value: $months, in: 1...60, step: 1)
                                .accentColor(Color(hex: "#72BF00"))
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    // CARD 2: MONTHLY PAYMENT
                    VStack(spacing: 10) {
                        Text("Monthly Payment")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#01312D").opacity(0.8))
                        
                        Text("\(Int(monthlyPayment)) RWF")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        Text("For \(Int(months)) months")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(32)
                    .background(Color(hex: "#DDFEC5"))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    // CARD 3: BREAKDOWN
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total Payment")
                                .foregroundColor(Color(hex: "#01312D"))
                            Spacer()
                            Text("\(Int(totalPayment)) RWF")
                                .bold()
                                .foregroundColor(Color(hex: "#01312D"))
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Total Interest")
                                .foregroundColor(Color(hex: "#01312D"))
                            Spacer()
                            Text("\(Int(totalInterest)) RWF")
                                .bold()
                                .foregroundColor(Color.orange)
                        }
                        
                        Divider()
                        
                        Button(action: applyForLoan) {
                            if applying {
                                ProgressView().tint(.white)
                            } else {
                                Text("Apply for Loan")
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                        .background(loanTitle.isEmpty ? Color.gray : Color(hex: "#72BF00"))
                        .cornerRadius(15)
                        .disabled(loanTitle.isEmpty || applying)
                        
                        NavigationLink(destination: LoanApplicationsView(), isActive: $showSuccess) {
                            EmptyView()
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func applyForLoan() {
        applying = true
        Task {
            do {
                try await appState.databaseService.applyForLoan(
                    title: loanTitle,
                    amount: Int(amount),
                    rate: interestRate,
                    months: Int(months)
                )
                applying = false
                showSuccess = true
            } catch {
                print("Failed to apply: \(error)")
                applying = false
            }
        }
    }
}

// MARK: - Loan Applications View
struct LoanApplicationsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    @State private var applications: [LoanApplicationDTO] = []
    @State private var loading = false
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF").ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("My Applications")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color(hex: "#01312D"))
                        Text("Track your loan status")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal)
                    
                    if loading {
                        ProgressView().padding()
                    } else if applications.isEmpty {
                        Text("No applications found.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        // Applications List
                        VStack(spacing: 16) {
                            ForEach(applications) { app in
                                NavigationLink(destination: LoanSummaryView(application: app)) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(app.title)
                                                .font(.headline)
                                                .foregroundColor(Color(hex: "#01312D"))
                                            Text(app.applicationDate, style: .date)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Text("\(Int(app.loanAmount)) RWF")
                                            .bold()
                                            .foregroundColor(Color(hex: "#01312D"))
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(16)
                                    .shadow(color: .black.opacity(0.03), radius: 5, x: 0, y: 2)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Recommendations Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recommendations")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#72BF00"))
                        
                        RecommendationRow(text: "Avoid multiple simultaneous loans")
                        RecommendationRow(text: "Plan repayment before borrowing")
                        RecommendationRow(text: "Save for small emergencies")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(hex: "#01312D"))
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Applications")
                    .font(.headline)
                    .foregroundColor(Color(hex: "#01312D"))
            }
        }
        .onAppear {
            fetchApplications()
        }
    }
    
    func fetchApplications() {
        loading = true
        Task {
            do {
                self.applications = try await appState.databaseService.getLoanApplications()
                loading = false
            } catch {
                print("Failed to fetch loans: \(error)")
                loading = false
            }
        }
    }
}

struct RecommendationRow: View {
    let text: String
    var body: some View {
        HStack(alignment: .top) {
            Circle().fill(.black).frame(width: 8, height: 8).padding(.top, 6)
            Text(text)
                .font(.caption)
        }
    }
}

// MARK: - Loan Summary View
struct LoanSummaryView: View {
    @Environment(\.dismiss) var dismiss
    let application: LoanApplicationDTO
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF").ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 20) {
                    Text("Loan Summary")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    VStack(spacing: 15) {
                        SummaryRow(label: "Loan Amount", value: "\(Int(application.loanAmount)) RWF")
                        SummaryRow(label: "Monthly Payment", value: "\(Int(application.monthlyPayment)) RWF")
                        SummaryRow(label: "Total Repayment", value: "\(Int(application.totalPayment)) RWF")
                        SummaryRow(label: "Interest Rate", value: "\(String(format: "%.1f", application.annualInterestRate))%")
                        SummaryRow(label: "Duration", value: "\(application.durationMonths) Months")
                        SummaryRow(label: "Application Date", value: application.applicationDate.formatted(date: .abbreviated, time: .omitted))
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.05), radius: 10)
                }
                .padding()
                
                Button(action: { dismiss() }) {
                    Text("Completed")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#72BF00"))
                        .cornerRadius(30)
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .padding(.top, 40)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SummaryRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .bold()
                .foregroundColor(Color(hex: "#01312D"))
        }
    }
}
