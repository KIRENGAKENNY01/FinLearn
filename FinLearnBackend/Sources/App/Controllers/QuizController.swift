import Vapor

struct QuizController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let quizzes = routes.grouped("quizzes")
        quizzes.get(use: listQuizzes)
        quizzes.post(":quizId", "submit", use: submitQuiz)
        quizzes.get("history", use: getQuizHistory)
    }
    
    // MARK: - Static Data
    
    // In a real app, this might come from a DB, but for this "Learn" app, content is often static
    private let availableQuizzes = [
        Quiz(
            id: "beginner_1",
            title: "Financial Basics",
            description: "Test your knowledge on budgeting and saving fundamentals.",
            questions: [
                QuizQuestion(
                    id: "q1",
                    text: "What is the 50/30/20 rule?",
                    options: [
                        "50% Needs, 30% Wants, 20% Savings",
                        "50% Savings, 30% Needs, 20% Wants",
                        "50% Wants, 30% Savings, 20% Needs",
                        "None of the above"
                    ],
                    correctIndex: 0,
                    explanation: "The 50/30/20 rule suggests 50% for needs, 30% for wants, and 20% for savings/debt."
                ),
                QuizQuestion(
                    id: "q2",
                    text: "Which of these is a fixed expense?",
                    options: ["Dining Out", "Rent", "Clothing", "Entertainment"],
                    correctIndex: 1,
                    explanation: "Rent is a fixed monthly cost, unlike variable expenses like dining or clothing."
                )
            ]
        ),
        Quiz(
            id: "beginner_2",
            title: "Debt Management",
            description: "Understand the basics of loans and interest.",
            questions: [
                 QuizQuestion(
                    id: "q1",
                    text: "What does APR stand for?",
                    options: ["Annual Percentage Rate", "Actual Payment Return", "All Paid Return", "Annual Payment Rate"],
                    correctIndex: 0,
                    explanation: "APR stands for Annual Percentage Rate, usually showing the yearly cost of borrowing."
                )
            ]
        )
    ]
    
    // MARK: - Handlers
    
    func listQuizzes(req: Request) async throws -> [Quiz] {
        // Authenticated user check not strictly required for listing, but good practice
        _ = try req.auth.require(User.self)
        return availableQuizzes
    }
    
    func submitQuiz(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        guard let quizId = req.parameters.get("quizId"),
              let firestore = req.application.firestore else {
            throw Abort(.badRequest)
        }
        
        struct SubmitInput: Content {
            let score: Int
            let totalQuestions: Int
        }
        let input = try req.content.decode(SubmitInput.self)
        
        let result = QuizResult(
            quizId: quizId,
            score: input.score,
            totalQuestions: input.totalQuestions,
            date: Date()
        )
        
        // Save to Firestore
        let docId = "\(Int(Date().timeIntervalSince1970))"
        let firestoreData = QuizResultData(
            quizId: StringValue(stringValue: result.quizId),
            score: IntegerValue(integerValue: result.score),
            totalQuestions: IntegerValue(integerValue: result.totalQuestions),
            date: StringValue(stringValue: ISO8601DateFormatter().string(from: result.date))
        )
        
        // Firestore REST API requires "fields" key for data
        struct Wrapper: Content {
            let fields: QuizResultData
        }
        
        _ = try await firestore.createDocument(
            collection: "users/\(user.id!)/quizzes",
            documentId: docId,
            data: Wrapper(fields: firestoreData) 
        )
        
        return .ok
    }
    
    func getQuizHistory(req: Request) async throws -> [QuizResult] {
        let user = try req.auth.require(User.self)
        guard let firestore = req.application.firestore else { return [] }
        
        let docs: [FirestoreDocument<QuizResultData>] = try await firestore.listDocuments(collection: "users/\(user.id!)/quizzes")
        
        return docs.compactMap { doc in
            let fields = doc.fields
            // Parse Date
            let date = ISO8601DateFormatter().date(from: fields.date.stringValue) ?? Date()
            
            return QuizResult(
                quizId: fields.quizId.stringValue,
                score: Int(fields.score.integerValue) ?? 0,
                totalQuestions: Int(fields.totalQuestions.integerValue) ?? 0,
                date: date
            )
        }
    }
}
