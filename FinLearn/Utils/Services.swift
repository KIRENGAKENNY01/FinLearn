
import Foundation
import Combine

// MARK: - Auth Service Protocol
protocol AuthServiceProtocol {
    var currentUser: UserProfile? { get }
    func signIn(email: String, password: String) async throws
    func signUp(name: String, email: String, password: String) async throws
    func signOut()
}

// MARK: - Database Service Protocol
protocol DatabaseServiceProtocol {
    func getUserProfile(userId: String) async throws -> UserProfile
    func getBudgetPlans(userId: String) async throws -> [BudgetPlan]
    func getLatestBudget() async throws -> BudgetPlan? 
    func getBudgetForMonth(monthIso: String) async throws -> BudgetPlan?
    func saveBudgetPlan(plan: BudgetPlan) async throws -> BudgetPlan
    func getTransactions(userId: String, budgetId: String) async throws -> [BudgetTransaction]
    func getLoanApplications() async throws -> [LoanApplicationDTO]
    func applyForLoan(title: String, amount: Int, rate: Double, months: Int) async throws
    func calculateFollowUp(plan: BudgetPlan, actualIncome: Double, actualExpenses: Double, emergencies: [Emergency]) async throws -> BudgetResult
    func getSavingsHistory() async throws -> [SavingsResultDTO]
    func evaluateSavings(startDate: Date, endDate: Date, expected: Double, income: Double, expenses: Double, emergencies: [EmergencyDTO]) async throws -> SavingsResultDTO
    func updateProgress(userId: String, progress: LearningProgress) async throws
    func syncUser(user: UserProfile) async throws
}

// MARK: - Mock Services (For Dev/Preview)

class MockAuthService: AuthServiceProtocol {
    var currentUser: UserProfile? = UserProfile(
        id: "mock_user_123",
        email: "kenny@example.com",
        displayName: "Kenny",
        photoURL: nil,
        totalPoints: 1250,
        currentLevel: .beginner,
        createdAt: Date()
    )
    
    func signIn(email: String, password: String) async throws {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        // Hardcoded success for mock
        currentUser = UserProfile(
            id: "mock_user_123",
            email: email,
            displayName: "Kenny",
            photoURL: nil,
            totalPoints: 1250,
            currentLevel: .beginner,
            createdAt: Date()
        )
    }
    
    func signUp(name: String, email: String, password: String) async throws {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        currentUser = UserProfile(
            id: "mock_user_new",
            email: email,
            displayName: name,
            photoURL: nil,
            totalPoints: 0,
            currentLevel: .beginner,
            createdAt: Date()
        )
    }
    
    func signOut() {
        currentUser = nil
    }
}

class MockDatabaseService: DatabaseServiceProtocol {
    
    func getUserProfile(userId: String) async throws -> UserProfile {
        return UserProfile(
            id: userId,
            email: "kenny@example.com",
            displayName: "Kenny",
            photoURL: nil,
            totalPoints: 2400,
            currentLevel: .intermediate,
            createdAt: Date()
        )
    }
    
    func getBudgetPlans(userId: String) async throws -> [BudgetPlan] {
        return [
            BudgetPlan(
                id: "dec_2025",
                userId: userId,
                monthIso: "2025-12",
                totalPlannedIncome: 1500000,
                totalPlannedExpenses: 1200000,
                actualTotalIncome: 0,
                actualTotalExpenses: 0,
                currency: "RWF",
                createdAt: Date(),
                lastFollowUpDate: nil,
                incomeItems: [],
                expenseItems: [],
                emergencies: []
            )
        ]
    }
    
    func getTransactions(userId: String, budgetId: String) async throws -> [BudgetTransaction] {
        return [
            BudgetTransaction(id: "tx1", category: "Food", amount: 5000, date: Date(), note: "Lunch"),
            BudgetTransaction(id: "tx2", category: "Transport", amount: 2000, date: Date(), note: "Bus")
        ]
    }
    
    func getLatestBudget() async throws -> BudgetPlan? {
        return nil
    }
    
    func getBudgetForMonth(monthIso: String) async throws -> BudgetPlan? {
        return nil
    }
    
    func saveBudgetPlan(plan: BudgetPlan) async throws -> BudgetPlan {
        return plan
    }
    
    func getLoanApplications() async throws -> [LoanApplicationDTO] {
        return [
            LoanApplicationDTO(id: "l1", title: "Personal Loan", loanAmount: 500000, annualInterestRate: 5.0, durationMonths: 12, monthlyPayment: 42000, totalPayment: 510000, applicationDate: Date(), isPaid: false)
        ]
    }
    
    func applyForLoan(title: String, amount: Int, rate: Double, months: Int) async throws {
        print("Mock: Applied for loan \(title)")
    }
    
    func calculateFollowUp(plan: BudgetPlan, actualIncome: Double, actualExpenses: Double, emergencies: [Emergency]) async throws -> BudgetResult {
        return BudgetResult(
            dateRange: plan.formattedDateRange,
            totals: .init(plannedIncome: plan.totalPlannedIncome, plannedExpenses: plan.totalPlannedExpenses, actualIncome: actualIncome, actualExpenses: actualExpenses, adjustedExpenses: actualExpenses),
            percentages: .init(expenseAdherence: 95.0),
            expensesBreakdown: [],
            status: "Great job! (Mock Result)"
        )
    }
    
    func getSavingsHistory() async throws -> [SavingsResultDTO] {
        return [
            SavingsResultDTO(dateRange: "Jan 2023", monthIso: "2023-01", status: "Goal Met", totals: SavingsTotalsDTO(plannedSavings: 100000, actualSavings: 110000, actualIncome: 1500000, actualExpenses: 1390000))
        ]
    }
    
    func evaluateSavings(startDate: Date, endDate: Date, expected: Double, income: Double, expenses: Double, emergencies: [EmergencyDTO]) async throws -> SavingsResultDTO {
        return SavingsResultDTO(dateRange: "Current", monthIso: "2026-01", status: "Goal Met", totals: SavingsTotalsDTO(plannedSavings: expected, actualSavings: income - expenses, actualIncome: income, actualExpenses: expenses))
    }
    
    func updateProgress(userId: String, progress: LearningProgress) async throws {
        print("Mock: Saved progress for \(progress.courseId) - Status: \(progress.status)")
    }
    
    func syncUser(user: UserProfile) async throws {
        print("Mock: Synced user \(user.displayName)")
    }
}

// MARK: - Real Services

 import FirebaseAuth


// MARK: - Local Persistence (UserDefaults)

class LocalPersistenceManager {
    static let shared = LocalPersistenceManager()
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let budgetPlans = "local_budget_plans"
        static let loanApplications = "local_loan_applications"
        static let savingsHistory = "local_savings_history"
    }
    
    // Budget
    func saveBudgetPlan(_ plan: BudgetPlan) {
        var plans = getBudgetPlans()
        if let index = plans.firstIndex(where: { $0.monthIso == plan.monthIso }) {
            plans[index] = plan
        } else {
            var newPlan = plan
            if newPlan.id == nil { newPlan.id = UUID().uuidString }
            plans.append(newPlan)
        }
        encodeAndSave(plans, key: Keys.budgetPlans)
    }
    
    func getBudgetPlans() -> [BudgetPlan] {
        return decodeAndGet([BudgetPlan].self, key: Keys.budgetPlans) ?? []
    }
    
    func getLatestBudget() -> BudgetPlan? {
        return getBudgetPlans().sorted { ($0.createdAt ?? Date()) > ($1.createdAt ?? Date()) }.first
    }
    
    func getBudgetForMonth(monthIso: String) -> BudgetPlan? {
        return getBudgetPlans().first(where: { $0.monthIso == monthIso })
    }
    
    // Loans
    func saveLoanApplication(_ app: LoanApplicationDTO) {
        var apps = getLoanApplications()
        var newApp = app
        if newApp.id == nil { newApp = LoanApplicationDTO(id: UUID().uuidString, title: app.title, loanAmount: app.loanAmount, annualInterestRate: app.annualInterestRate, durationMonths: app.durationMonths, monthlyPayment: app.monthlyPayment, totalPayment: app.totalPayment, applicationDate: app.applicationDate, isPaid: app.isPaid) }
        apps.append(newApp)
        encodeAndSave(apps, key: Keys.loanApplications)
    }
    
    func getLoanApplications() -> [LoanApplicationDTO] {
        return decodeAndGet([LoanApplicationDTO].self, key: Keys.loanApplications) ?? []
    }
    
    // Savings
    func saveSavingsResult(_ result: SavingsResultDTO) {
        var labels = getSavingsHistory()
        if let index = labels.firstIndex(where: { $0.monthIso == result.monthIso }) {
            labels[index] = result
        } else {
            labels.append(result)
        }
        encodeAndSave(labels, key: Keys.savingsHistory)
    }
    
    func getSavingsHistory() -> [SavingsResultDTO] {
        return decodeAndGet([SavingsResultDTO].self, key: Keys.savingsHistory) ?? []
    }
    
    // Helpers
    private func encodeAndSave<T: Encodable>(_ value: T, key: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            defaults.set(encoded, forKey: key)
        }
    }
    
    private func decodeAndGet<T: Decodable>(_ type: T.Type, key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

class FirebaseAuthService: AuthServiceProtocol {
    @Published var currentUser: UserProfile?
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        // Listen for Auth Changes
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let user = user {
                self?.currentUser = UserProfile(
                    id: user.uid,
                    email: user.email ?? "",
                    displayName: user.displayName ?? "User",
                    photoURL: user.photoURL?.absoluteString,
                    totalPoints: 0, // In a real app we would fetch this from DB immediately
                    currentLevel: .beginner,
                    createdAt: Date()
                )
            } else {
                self?.currentUser = nil
            }
        }
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signUp(name: String, email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let changeRequest = result.user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
        
        // Force refresh to get updated profile
        try await result.user.reload()
        
        // Update local state immediately if listener hasnt fired yet (optional, listener usually handles it)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
}

class APIDatabaseService: DatabaseServiceProtocol {
    
    // Force Local/Mock Mode
    private let useLocalOnly = true
    
    func getUserProfile(userId: String) async throws -> UserProfile {
        if useLocalOnly {
            return UserProfile(id: userId, email: "local@user.com", displayName: "Local User", photoURL: nil, totalPoints: 1000, currentLevel: .beginner, createdAt: Date())
        }
        
        // 1. Get Token
        guard let user = Auth.auth().currentUser else { throw NetworkError.unauthorized }
        let token = try await user.getIDToken()
        
        // 2. Call API
        struct BackendUser: Codable {
            let id: String?
            let email: String
            let displayName: String
            let photoURL: String?
            let totalPoints: Int
            let currentLevel: String
            let createdAt: Date?
        }
        
        let userModel: BackendUser = try await NetworkManager.shared.get(path: "users/me", token: token)
        
        return UserProfile(
            id: userModel.id ?? userId,
            email: userModel.email,
            displayName: userModel.displayName,
            photoURL: userModel.photoURL,
            totalPoints: userModel.totalPoints,
            currentLevel: UserProfile.UserLevel(rawValue: userModel.currentLevel) ?? .beginner,
            createdAt: userModel.createdAt ?? Date()
        )
    }
    
    func getBudgetPlans(userId: String) async throws -> [BudgetPlan] {
        return LocalPersistenceManager.shared.getBudgetPlans()
    }
    
    func getLatestBudget() async throws -> BudgetPlan? {
        if useLocalOnly { return LocalPersistenceManager.shared.getLatestBudget() }
        
        do {
            guard let firebaseUser = Auth.auth().currentUser else { throw NetworkError.unauthorized }
            let token = try await firebaseUser.getIDToken()
            return try await NetworkManager.shared.get(path: "budget/latest", token: token)
        } catch {
            return LocalPersistenceManager.shared.getLatestBudget()
        }
    }

    func getBudgetForMonth(monthIso: String) async throws -> BudgetPlan? {
        if useLocalOnly { return LocalPersistenceManager.shared.getBudgetForMonth(monthIso: monthIso) }
        
        do {
            guard let firebaseUser = Auth.auth().currentUser else { throw NetworkError.unauthorized }
            let token = try await firebaseUser.getIDToken()
            return try await NetworkManager.shared.get(path: "budget/month/\(monthIso)", token: token)
        } catch {
            return LocalPersistenceManager.shared.getBudgetForMonth(monthIso: monthIso)
        }
    }
    
    func saveBudgetPlan(plan: BudgetPlan) async throws -> BudgetPlan {
        LocalPersistenceManager.shared.saveBudgetPlan(plan)
        if useLocalOnly { return plan }
        
        do {
            guard let firebaseUser = Auth.auth().currentUser else { throw NetworkError.unauthorized }
            let token = try await firebaseUser.getIDToken()
            return try await NetworkManager.shared.post(path: "budget", body: plan, token: token)
        } catch {
            return plan
        }
    }
    
    func getTransactions(userId: String, budgetId: String) async throws -> [BudgetTransaction] {
        return []
    }
    
    func getLoanApplications() async throws -> [LoanApplicationDTO] {
        if useLocalOnly { return LocalPersistenceManager.shared.getLoanApplications() }
        
        do {
            guard let firebaseUser = Auth.auth().currentUser else { throw NetworkError.unauthorized }
            let token = try await firebaseUser.getIDToken()
            return try await NetworkManager.shared.get(path: "loan/applications", token: token)
        } catch {
            return LocalPersistenceManager.shared.getLoanApplications()
        }
    }
    
    func applyForLoan(title: String, amount: Int, rate: Double, months: Int) async throws {
        let r = (rate / 100) / 12
        let n = Double(months)
        let p = Double(amount)
        let m = r == 0 ? p / n : (p * r * pow(1 + r, n)) / (pow(1 + r, n) - 1)
        let total = m * n
        
        let app = LoanApplicationDTO(
            id: UUID().uuidString,
            title: title,
            loanAmount: Double(amount),
            annualInterestRate: rate,
            durationMonths: months,
            monthlyPayment: m.rounded(),
            totalPayment: total.rounded(),
            applicationDate: Date(),
            isPaid: false
        )
        
        LocalPersistenceManager.shared.saveLoanApplication(app)
        if useLocalOnly { return }
        
        do {
            guard let firebaseUser = Auth.auth().currentUser else { throw NetworkError.unauthorized }
            let token = try await firebaseUser.getIDToken()
            
            struct LoanApplyInput: Codable {
                let title: String
                let amount: Int
                let annualInterestRate: Double
                let durationMonths: Int
                let monthlyPayment: Int
                let totalPayment: Int
            }
            
            let input = LoanApplyInput(
                title: title,
                amount: amount,
                annualInterestRate: rate,
                durationMonths: months,
                monthlyPayment: Int(m.rounded()),
                totalPayment: Int(total.rounded())
            )
            
            try await NetworkManager.shared.postNoReturn(path: "loan/apply", body: input, token: token)
        } catch {
            print("Failed to sync loan to server: \(error)")
        }
    }
    
    func calculateFollowUp(plan: BudgetPlan, actualIncome: Double, actualExpenses: Double, emergencies: [Emergency]) async throws -> BudgetResult {
        // Local calculation for offline mode
        let result = BudgetResult(
            dateRange: plan.formattedDateRange,
            totals: .init(plannedIncome: plan.totalPlannedIncome, plannedExpenses: plan.totalPlannedExpenses, actualIncome: actualIncome, actualExpenses: actualExpenses, adjustedExpenses: actualExpenses),
            percentages: .init(expenseAdherence: 100.0), // Placeholder logic
            expensesBreakdown: [],
            status: "Budget updated locally."
        )
        
        if useLocalOnly { return result }
        
        do {
            guard let firebaseUser = Auth.auth().currentUser else { throw NetworkError.unauthorized }
            let token = try await firebaseUser.getIDToken()
            
            struct FollowUpInput: Codable {
                let plan: BudgetPlan
                let actualIncome: Double
                let actualExpenses: Double
                let emergencies: [Emergency]
            }
            
            let input = FollowUpInput(plan: plan, actualIncome: actualIncome, actualExpenses: actualExpenses, emergencies: emergencies)
            return try await NetworkManager.shared.post(path: "budget/followup", body: input, token: token)
        } catch {
            return result
        }
    }
    
    func getSavingsHistory() async throws -> [SavingsResultDTO] {
        if useLocalOnly { return LocalPersistenceManager.shared.getSavingsHistory() }
        
        do {
            guard let firebaseUser = Auth.auth().currentUser else { throw NetworkError.unauthorized }
            let token = try await firebaseUser.getIDToken()
            return try await NetworkManager.shared.get(path: "savings/history", token: token)
        } catch {
            return LocalPersistenceManager.shared.getSavingsHistory()
        }
    }
    
    func evaluateSavings(startDate: Date, endDate: Date, expected: Double, income: Double, expenses: Double, emergencies: [EmergencyDTO]) async throws -> SavingsResultDTO {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        let monthIso = formatter.string(from: startDate)
        
        let result = SavingsResultDTO(
            dateRange: monthIso,
            monthIso: monthIso,
            status: (income - expenses >= expected) ? "Goal Met" : "Bad",
            totals: SavingsTotalsDTO(plannedSavings: expected, actualSavings: income - expenses, actualIncome: income, actualExpenses: expenses)
        )
        
        LocalPersistenceManager.shared.saveSavingsResult(result)
        if useLocalOnly { return result }
        
        do {
            guard let firebaseUser = Auth.auth().currentUser else { throw NetworkError.unauthorized }
            let token = try await firebaseUser.getIDToken()
            
            struct EvalInput: Codable {
                let startDate: Date
                let endDate: Date
                let expectedSavings: Double
                let actualIncome: Double
                let actualExpenses: Double
                let emergencies: [EmergencyDTO]
            }
            
            let input = EvalInput(startDate: startDate, endDate: endDate, expectedSavings: expected, actualIncome: income, actualExpenses: expenses, emergencies: emergencies)
            return try await NetworkManager.shared.post(path: "savings/evaluate", body: input, token: token)
        } catch {
            return result
        }
    }
    
    func updateProgress(userId: String, progress: LearningProgress) async throws {
        if useLocalOnly { return }
        
        do {
            guard let firebaseUser = Auth.auth().currentUser else { throw NetworkError.unauthorized }
            let token = try await firebaseUser.getIDToken()
            let path = "learning/objectives/\(progress.courseId)/complete"
            struct EmptyBody: Codable {}
            try await NetworkManager.shared.postNoReturn(path: path, body: EmptyBody(), token: token)
        } catch {
            print("Failed to update progress on server: \(error)")
        }
    }
    
    func syncUser(user: UserProfile) async throws {
        if useLocalOnly { return }
        
        do {
            guard let currentUser = Auth.auth().currentUser else { return }
            let token = try await currentUser.getIDToken()
            
            struct CreateUser: Codable {
                let id: String
                let email: String
                let displayName: String
                let totalPoints: Int
                let currentLevel: String
            }
            
            let userModel = CreateUser(
                id: user.id,
                email: user.email,
                displayName: user.displayName,
                totalPoints: user.totalPoints,
                currentLevel: user.currentLevel.rawValue
            )
            
            try await NetworkManager.shared.postNoReturn(path: "users", body: userModel, token: token)
        } catch {
             print("Failed to sync user: \(error)")
        }
    }
}

// MARK: - DTOs
struct LoanApplicationDTO: Codable, Identifiable {
    let id: String?
    let title: String
    let loanAmount: Double
    let annualInterestRate: Double
    let durationMonths: Int
    let monthlyPayment: Double
    let totalPayment: Double
    let applicationDate: Date
    let isPaid: Bool
}

struct SavingsResultDTO: Codable, Identifiable {
    var id: String { dateRange } // fallback
    let dateRange: String
    let monthIso: String
    let status: String
    let totals: SavingsTotalsDTO
}

struct SavingsTotalsDTO: Codable {
    let plannedSavings: Double
    let actualSavings: Double
    let actualIncome: Double
    let actualExpenses: Double
}

struct EmergencyDTO: Codable {
    let title: String
    let amount: Double
}
