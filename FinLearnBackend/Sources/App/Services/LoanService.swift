import Vapor

struct LoanService {
    
    /// Calculates monthly payment using Standard Amortization Formula.
    /// Includes validation: Loan > 0, interest >= 0, duration >= 1.
    func calculateAmortization(
        amount: Double,
        rate: Double, // annual percent
        months: Int
    ) throws -> LoanResult {
        // Validation
        guard amount > 0, rate >= 0, months >= 1 else {
            throw Abort(.badRequest, reason: "Invalid loan parameters")
        }
        
        let r = rate / 12 / 100 // monthly interest rate
        let n = Double(months)
        
        let monthlyPayment: Double
        if r == 0 {
            monthlyPayment = amount / n
        } else {
            // Formula: M = P * r * (1+r)^n / ((1+r)^n - 1)
            let numerator = amount * r * pow(1 + r, n)
            let denominator = pow(1 + r, n) - 1
            monthlyPayment = numerator / denominator
        }
        
        let totalPayment = monthlyPayment * n
        
        return LoanResult(
            loanAmount: Int(amount),
            annualInterestRate: rate,
            durationMonths: months,
            monthlyPayment: Int(monthlyPayment.rounded()),
            totalPayment: Int(totalPayment.rounded())
        )
    }
    
    /// Saves a loan application record.
    /// Note: Requires 'req.firebase' to be configured.
    func applyForLoan(req: Request, input: LoanController.LoanApplyInput) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        
        let application = LoanApplication(
            id: nil,
            userId: user.id!,
            title: input.title,
            loanAmount: Double(input.amount),
            annualInterestRate: input.annualInterestRate,
            durationMonths: input.durationMonths,
            monthlyPayment: Double(input.monthlyPayment),
            totalPayment: Double(input.totalPayment),
            applicationDate: Date(),
            isPaid: false // Active by default
        )
        
        if let firestore = req.application.firestore {
            let docId = application.id ?? UUID().uuidString
            
            let fDoc = FirestoreLoanApplication(
                title: StringValue(stringValue: application.title),
                loanAmount: DoubleValue(doubleValue: application.loanAmount),
                annualInterestRate: DoubleValue(doubleValue: application.annualInterestRate),
                durationMonths: IntegerValue(integerValue: application.durationMonths),
                monthlyPayment: DoubleValue(doubleValue: application.monthlyPayment),
                totalPayment: DoubleValue(doubleValue: application.totalPayment),
                applicationDate: StringValue(stringValue: ISO8601DateFormatter().string(from: application.applicationDate)),
                isPaid: BooleanValue(booleanValue: application.isPaid)
            )
            
            _ = try await firestore.createDocument(
                collection: "users/\(user.id!)/loans", 
                documentId: docId, 
                data: fDoc
            )
        }
        
        req.logger.info("Loan Application saved for user \(user.id!): \(application)")
        return .created
    }
    
    // ... Loan methods
    func getPaidLoans(req: Request) async throws -> [PaidLoan] { 
        return []
    }
}
