import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    // API Group
    let api = app.grouped("api", "v1")
    
    let protected = api.grouped(FirebaseAuthMiddleware())
    
    // Services
    let budgetService = BudgetService()
    let loanService = LoanService()
    let savingsService = SavingsService()
    let learningService = LearningService()
    
    // Public / Dev Routes
    api.post("learning", "seed") { req async throws -> String in
        return try await learningService.seedCurriculum(req: req)
    }
    
    // Register Controllers
    try protected.register(collection: BudgetController(service: budgetService))
    try protected.register(collection: LoanController(service: loanService))
    try protected.register(collection: SavingsController(service: savingsService))
    try protected.register(collection: QuizController())
    try protected.register(collection: LearningController(service: learningService))
    try protected.register(collection: UserController())
}
