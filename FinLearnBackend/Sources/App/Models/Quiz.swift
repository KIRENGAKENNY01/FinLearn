import Vapor

// MARK: - Quiz Content Models

struct Quiz: Content {
    let id: String
    let title: String
    let description: String
    let questions: [QuizQuestion]
}

struct QuizQuestion: Content {
    let id: String
    let text: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
}

// MARK: - User Results

struct QuizResult: Content {
    let quizId: String
    let score: Int
    let totalQuestions: Int
    let date: Date
}

// MARK: - Firestore Helpers

struct FirestoreQuizResult: Content {
    let quizId: StringValue
    let score: IntegerValue
    let totalQuestions: IntegerValue
    let date: StringValue
}
