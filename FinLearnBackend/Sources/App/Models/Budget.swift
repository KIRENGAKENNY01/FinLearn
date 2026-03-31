import Vapor

struct BudgetPlan: Content {
    static let schema = "budgets"
    
    var id: String?
    var userId: String?
    var monthIso: String // "2025-11"
    var totalPlannedIncome: Double
    var totalPlannedExpenses: Double
    var actualTotalIncome: Double?
    var actualTotalExpenses: Double?
    var currency: String
    var createdAt: Date?
    var lastFollowUpDate: Date?
    
    var incomeItems: [BudgetItem]?
    var expenseItems: [BudgetItem]?
    var emergencies: [Emergency]?
    var isCompleted: Bool? // Marks if the budget period is over
}

struct BudgetItem: Content {
    var category: String
    var amount: Double
}

struct Emergency: Content {
    var title: String
    var amount: Double
}

struct Transaction: Content {
    var id: String?
    var category: String
    var amount: Double
    var date: Date
    var type: TransactionType // income, expense
}

enum TransactionType: String, Codable {
    case income
    case expense
}
