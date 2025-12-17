
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
    let id: String
    let month: String // e.g., "November 2025" or ISO date
    let income: Double
    let totalExpenses: Double
    let savingsGoal: Double
    let currency: String
    
    var status: BudgetStatus {
        if totalExpenses > income { return .overBudget }
        if totalExpenses + savingsGoal <= income { return .onTrack }
        return .warning
    }
    
    enum BudgetStatus: String, Codable {
        case onTrack = "On Track"
        case warning = "Warning"
        case overBudget = "Over Budget"
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
    
    enum CompletionStatus: String, Codable {
        case notStarted
        case inProgress
        case completed
    }
}
