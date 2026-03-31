import Vapor

struct LoanApplication: Content {
    static let schema = "loans"
    
    var id: String?
    var userId: String
    var title: String
    var loanAmount: Double
    var annualInterestRate: Double
    var durationMonths: Int
    var monthlyPayment: Double
    var totalPayment: Double
    var applicationDate: Date
    var isPaid: Bool // Derived or explicit status replacement
}

struct LoanResult: Content {
    let loanAmount: Int
    let annualInterestRate: Double
    let durationMonths: Int
    let monthlyPayment: Int
    let totalPayment: Int
}

struct PaidLoan: Content {
    let loanID: String
    let loanAmount: Int
    let monthlyPayment: Int
    let totalPayment: Int
    let status: String
    let paidDate: String//"yyyy-MM-dd"
}
