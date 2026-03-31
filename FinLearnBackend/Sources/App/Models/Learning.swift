import Vapor

// MARK: - Learning Content Models (Static/Admin Data)
struct LearningStage: Content {
    var id: String? // "beginner", "intermediate", "advanced"
    var title: String
    var order: Int
}

struct Chapter: Content {
    var id: String?
    var stageId: String
    var title: String
    var order: Int
    // calculated fields for response
    var topicCount: Int? 
    var status: CompletionStatus?
    var progress: Double?
}

struct Topic: Content {
    var id: String?
    var chapterId: String
    var title: String
    var order: Int
    // calculated
    var objectiveCount: Int?
    var status: CompletionStatus?
    var progress: Double?
}

struct LearningObjective: Content {
    var id: String?
    var topicId: String
    var title: String
    var content: String // For LessonOutlinePage
    var order: Int
    var status: CompletionStatus?
}

struct Lesson: Content {
    var id: String?
    var objectiveId: String
    var title: String
    var paragraph: String // Standard content
    var keyTakeaway: String // For keyTakeAway
}

// MARK: - User Progress Models
struct UserProgress: Content {
    var id: String? // userId
    var completedObjectiveIds: [String]
    var unlockedStageId: String // highest unlocked stage
    var currentChapterId: String?
    
    // Denormalized counters for fast percentage calc
    var totalObjectivesCompleted: Int
    var totalQuizzesCompleted: Int
    
    // Helper to check stage
    var completedStages: [String] = [] 
}

enum CompletionStatus: String, Codable {
    case locked, notStarted, ongoing, completed
}

struct StageResponse: Content {
    var id: String
    var status: CompletionStatus
    var progress: Double?
}

struct ProgressResponse: Content {
    var totalProgress: Double
}

// MARK: - Firestore Serialization Helper Models
struct FirestoreString: Codable { var stringValue: String }
struct FirestoreInt: Codable { var integerValue: String }

extension FirestoreInt {
    init(_ value: Int) {
        self.integerValue = String(value)
    }
}

// Firestore Representations
struct FirestoreStage: Content {
    var title: FirestoreString
    var order: FirestoreInt
}

struct FirestoreChapter: Content {
    var stageId: FirestoreString
    var title: FirestoreString
    var order: FirestoreInt
}

struct FirestoreTopic: Content {
    var chapterId: FirestoreString
    var title: FirestoreString
    var order: FirestoreInt
}

struct FirestoreObjective: Content {
    var topicId: FirestoreString
    var title: FirestoreString
    var content: FirestoreString
    var order: FirestoreInt
}

struct FirestoreLesson: Content {
    var objectiveId: FirestoreString
    var title: FirestoreString
    var paragraph: FirestoreString
    var keyTakeaway: FirestoreString
}

// MARK: - Bulk Fetch Models
struct FullStageContent: Content {
    var stage: StageResponse
    var chapters: [FullChapterContent]
}

struct FullChapterContent: Content {
    var chapter: Chapter
    var topics: [FullTopicContent]
}

struct FullTopicContent: Content {
    var topic: Topic
    var objectives: [FullObjectiveContent]
}

struct FullObjectiveContent: Content {
    var objective: LearningObjective
    var lessons: [Lesson]
}
