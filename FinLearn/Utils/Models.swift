
import Foundation

// MARK: - User Profile
struct UserProfile: Codable, Identifiable {
    let id: String // Matches uid
    let email: String
    let displayName: String
    let photoURL: String?
    var totalPoints: Int
    var currentLevel: UserLevel
    let createdAt: Date
    
    enum UserLevel: String, Codable {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
    }
}

// MARK: - Financial Models

struct BudgetPlan: Codable, Identifiable {
    var id: String?
    var userId: String?
    var monthIso: String // e.g., "2025-11"
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
    
    enum CodingKeys: String, CodingKey {
        case id, userId, monthIso, totalPlannedIncome, totalPlannedExpenses, actualTotalIncome, actualTotalExpenses, currency, createdAt, lastFollowUpDate, incomeItems, expenseItems, emergencies, isCompleted
    }
    
    // UI Helpers (backwards compatibility or simplified access)
    var income: Double { totalPlannedIncome }
    var totalExpenses: Double { totalPlannedExpenses }
    var month: String { monthIso }

    var formattedDateRange: String {
        let components = monthIso.components(separatedBy: "-")
        guard components.count == 2, let year = components.first, let month = components.last else { return monthIso }
        
        let monthMap: [String: String] = [
            "01": "JAN", "02": "FEB", "03": "MAR", "04": "APR", "05": "MAY", "06": "JUN",
            "07": "JUL", "08": "AUG", "09": "SEP", "10": "OCT", "11": "NOV", "12": "DEC"
        ]
        
        let mStr = monthMap[month] ?? month
        let nextMonthInt = (Int(month) ?? 0) % 12 + 1
        let nextMonth = String(format: "%02d", nextMonthInt)
        let nmStr = monthMap[nextMonth] ?? nextMonth
        let nextYear = (Int(month) == 12) ? String((Int(year) ?? 0) + 1) : year
        
        return "11 \(mStr) - 11 \(nmStr) \(nextYear)"
    }
}

struct BudgetItem: Codable, Identifiable {
    var id: String { category + "\(amount)" }
    let category: String
    let amount: Double
}

struct Emergency: Codable, Identifiable {
    var id: String { title + "\(amount)" }
    let title: String
    let amount: Double
}

struct BudgetResult: Codable {
    let dateRange: String
    let totals: Totals
    let percentages: Percentages
    let expensesBreakdown: [ExpenseItem]
    let status: String
    
    struct Totals: Codable {
        let plannedIncome: Double
        let plannedExpenses: Double
        let actualIncome: Double
        let actualExpenses: Double
        let adjustedExpenses: Double
    }
    
    struct Percentages: Codable {
        let expenseAdherence: Double
    }
    
    struct ExpenseItem: Codable {
        let category: String
        let amount: Double
    }
}

struct BudgetTransaction: Codable, Identifiable {
    let id: String
    let category: String
    let amount: Double
    let date: Date
    let note: String?
}

// MARK: - Learning Progress

struct LearningProgress: Codable, Identifiable {
    let id: String // usually courseId
    let courseId: String
    let type: ContentType
    let status: CompletionStatus
    let score: Int?
    let completionDate: Date?
    
    enum ContentType: String, Codable {
        case quiz
        case lesson
    }
}
