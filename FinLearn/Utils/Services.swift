
import Foundation
import Combine

// MARK: - Auth Service Protocol
protocol AuthServiceProtocol {
    var currentUser: UserProfile? { get }
    func signIn() async throws
    func signOut()
}

// MARK: - Database Service Protocol
protocol DatabaseServiceProtocol {
    func getUserProfile(userId: String) async throws -> UserProfile
    func getBudgetPlans(userId: String) async throws -> [BudgetPlan]
    func getTransactions(userId: String, budgetId: String) async throws -> [BudgetTransaction]
    func updateProgress(userId: String, progress: LearningProgress) async throws
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
    
    func signIn() async throws {
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
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
            BudgetPlan(id: "dec_2025", month: "December 2025", income: 1500000, totalExpenses: 1200000, savingsGoal: 200000, currency: "RWF")
        ]
    }
    
    func getTransactions(userId: String, budgetId: String) async throws -> [BudgetTransaction] {
        return [
            BudgetTransaction(id: "tx1", category: "Food", amount: 5000, date: Date(), note: "Lunch"),
            BudgetTransaction(id: "tx2", category: "Transport", amount: 2000, date: Date(), note: "Bus")
        ]
    }
    
    func updateProgress(userId: String, progress: LearningProgress) async throws {
        print("Mock: Saved progress for \(progress.courseId) - Status: \(progress.status)")
    }
}
