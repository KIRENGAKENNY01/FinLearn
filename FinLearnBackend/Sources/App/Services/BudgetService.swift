import Vapor

struct BudgetResult: Content {
    let dateRange: String // "11 NOV TO 11 DEC 2025"
    let totals: Totals
    let percentages: Percentages
    let expensesBreakdown: [ExpenseItem]
    let status: String
    
    struct Totals: Content {
        let plannedIncome: Double
        let plannedExpenses: Double
        let actualIncome: Double
        let actualExpenses: Double
        let adjustedExpenses: Double
    }
    
    struct Percentages: Content {
        let expenseAdherence: Double
    }
    
    struct ExpenseItem: Content {
        let category: String
        let amount: Double
    }
}

struct BudgetService {
    
    /// Calculates end-of-month performance, adjusting for emergencies.
    /// - Parameters:
    ///   - plan: The original budget plan with planned totals.
    ///   - actualIncome: Total income received.
    ///   - actualExpenses: Total expenses spent.
    ///   - emergencies: List of emergency items (title, amount).
    /// - Returns: A detailed BudgetResult.
    func calculateFollowUp(
        plan: BudgetPlan,
        actualIncome: Double,
        actualExpenses: Double,
        emergencies: [Emergency]
    ) -> BudgetResult {
        
        // 1. Calculate Emergency Impact
        let totalEmergencies = emergencies.reduce(0) { $0 + $1.amount }
        
        // 2. Adjust Expenses: Subtract emergencies from actual expenses to see "true" performance
        // If an expense was an emergency, it shouldn't penalize the user's adherence score
        let adjustedExpenses = actualExpenses - totalEmergencies
        
        // 3. Calculate Adherence Percentage
        // (Adjusted Actual / Planned) * 100
        let expenseAdherencePercent = plan.totalPlannedExpenses > 0 
            ? (adjustedExpenses / plan.totalPlannedExpenses) * 100 
            : 0
        
        // 4. Calculate Savings
        // let actualSavings = actualIncome - actualExpenses
        // let plannedSavings = plan.totalPlannedIncome - plan.totalPlannedExpenses
        
        // 5. Determine Status Message
        let status: String
        if adjustedExpenses <= plan.totalPlannedExpenses {
            status = "Great Job! You stayed within budget."
        } else {
            status = "Over budget. Try to reduce non-essential spending."
        }
        
        // 6. Format Date Range
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withFullDate]
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd MMM"
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        
        let start = plan.createdAt ?? Date()
        let end = Calendar.current.date(byAdding: .month, value: 1, to: start) ?? Date()
        
        let rangeStr = "\(displayFormatter.string(from: start).uppercased()) TO \(displayFormatter.string(from: end).uppercased()) \(yearFormatter.string(from: end))"
        
        return BudgetResult(
            dateRange: rangeStr,
            totals: .init(
                plannedIncome: plan.totalPlannedIncome,
                plannedExpenses: plan.totalPlannedExpenses,
                actualIncome: actualIncome,
                actualExpenses: actualExpenses,
                adjustedExpenses: adjustedExpenses
            ),
            percentages: .init(
                expenseAdherence: expenseAdherencePercent
            ),
            expensesBreakdown: [], // Populate from provided transactions if available
            status: status
        )
    }
}
