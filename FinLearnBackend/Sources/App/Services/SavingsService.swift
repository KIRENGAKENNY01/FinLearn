import Vapor

struct SavingsResult: Content {
    let dateRange: String
    let monthIso: String // e.g., "2026-01"
    let status: String
    let totals: Totals
    
    struct Totals: Content {
        let plannedSavings: Double
        let actualSavings: Double
        let actualIncome: Double
        let actualExpenses: Double
    }
}

struct SavingsService {
    
    /// Evaluates if the user met their savings goal, considering emergencies.
    func evaluateGoal(
        startDate: Date,
        endDate: Date,
        expectedSavings: Double,
        actualIncome: Double,
        actualExpenses: Double,
        emergencies: [Emergency]
    ) -> SavingsResult {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        
        let startStr = formatter.string(from: startDate).uppercased()
        let endStr = formatter.string(from: endDate).uppercased()
        let yearStr = yearFormatter.string(from: endDate)
        
        let dateRange = "\(startStr) - \(endStr) \(yearStr)"
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "yyyy-MM"
        let monthIso = monthFormatter.string(from: startDate)
        
        let actualSavings = actualIncome - actualExpenses
        
        // 2. Adjust for Emergencies
        // We add back emergency costs: "If you hadn't had this emergency, would you have met the goal?"
        let totalEmergencies = emergencies.reduce(0) { $0 + $1.amount }
        let adjustedSavings = actualSavings + totalEmergencies
        
        // 3. Determine Success
        let goalMet = adjustedSavings >= expectedSavings
        let status = goalMet ? "Goal Met" : "Improvement"
        
        return SavingsResult(
            dateRange: dateRange,
            monthIso: monthIso,
            status: status,
            totals: .init(
                plannedSavings: expectedSavings,
                actualSavings: actualSavings,
                actualIncome: actualIncome,
                actualExpenses: actualExpenses
            )
        )
    }
}
