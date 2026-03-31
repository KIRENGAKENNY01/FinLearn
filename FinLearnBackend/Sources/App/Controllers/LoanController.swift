import Vapor

struct LoanController: RouteCollection {
    let service: LoanService
    
    func boot(routes: RoutesBuilder) throws {
        let loan = routes.grouped("loan")
        loan.post("calculate", use: calculate)
        loan.post("apply", use: apply)
        loan.get("applications", use: listApplications)
    }
    
    struct LoanApplyInput: Content {
        let title: String
        let amount: Int
        let annualInterestRate: Double
        let durationMonths: Int
        let monthlyPayment: Int
        let totalPayment: Int
    }
    
    func calculate(req: Request) async throws -> LoanResult {
        struct CalcInput: Content {
            let amount: Double
            let rate: Double
            let months: Int
        }
        let input = try req.content.decode(CalcInput.self)
        return try service.calculateAmortization(amount: input.amount, rate: input.rate, months: input.months)
    }
    
    func apply(req: Request) async throws -> HTTPStatus {
        let input = try req.content.decode(LoanApplyInput.self)
        return try await service.applyForLoan(req: req, input: input)
    }
    
    func listApplications(req: Request) async throws -> [LoanApplication] {
        let user = try req.auth.require(User.self)
        guard let uid = user.id, let firestore = req.application.firestore else {
            throw Abort(.internalServerError)
        }
        
        let docs: [FirestoreDocument<FirestoreLoanApplication>] = try await firestore.listDocuments(collection: "users/\(uid)/loans")
        
        return docs.compactMap { doc in
            let f = doc.fields
            let id = doc.name.components(separatedBy: "/").last
            
            // Allow missing fields to just default or return nil if critical missing
            // For robustness, defaulting makes sense if it's just a view model
            
            return LoanApplication(
                id: id,
                userId: uid,
                title: f.title?.stringValue ?? "Untitled Loan",
                loanAmount: f.loanAmount?.doubleValue ?? 0,
                annualInterestRate: f.annualInterestRate?.doubleValue ?? 0,
                durationMonths: Int(f.durationMonths?.integerValue ?? "0") ?? 0,
                monthlyPayment: f.monthlyPayment?.doubleValue ?? 0,
                totalPayment: f.totalPayment?.doubleValue ?? 0,
                applicationDate: ISO8601DateFormatter().date(from: f.applicationDate?.stringValue ?? "") ?? Date(),
                isPaid: f.isPaid?.booleanValue ?? false
            )
        }
    }
}

// MARK: - Firestore Mapping Types

struct FirestoreLoanApplication: Codable, Content {
    let title: StringValue?
    let loanAmount: DoubleValue?
    let annualInterestRate: DoubleValue?
    let durationMonths: IntegerValue?
    let monthlyPayment: DoubleValue?
    let totalPayment: DoubleValue?
    let applicationDate: StringValue?
    let isPaid: BooleanValue?
}

struct FirestorePaidLoan: Codable, Content {
    let loanID: StringValue
    let loanAmount: IntegerValue
    let monthlyPayment: IntegerValue
    let totalPayment: IntegerValue
    let status: StringValue
    let paidDate: StringValue
}
