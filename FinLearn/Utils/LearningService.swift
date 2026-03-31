import Foundation
import FirebaseAuth

// MARK: - Learning Service DTOs

struct StageDTO: Codable {
    let id: String
    let status: String
    let progress: Double?
}

struct ChapterDTO: Codable {
    let id: String?
    let stageId: String
    let title: String
    let order: Int
    let topicCount: Int?
    let status: String?
    let progress: Double?
}

struct TopicDTO: Codable {
    let id: String?
    let chapterId: String
    let title: String
    let order: Int
    let objectiveCount: Int?
    let status: String?
    let progress: Double?
}

struct ObjectiveDTO: Codable {
    let id: String?
    let topicId: String
    let title: String
    let content: String
    let order: Int
    let status: String?
}

struct LessonDTO: Codable {
    let id: String?
    let objectiveId: String
    let title: String
    let paragraph: String
    let keyTakeaway: String
}

struct CurrentPositionDTO: Codable {
    let stageId: String
    let chapterId: String
    let topicId: String
    let objectiveId: String
    let isAllComplete: Bool?
}

// MARK: - Learning Service

class LearningService {
    static let shared = LearningService()
    private init() {}
    
    // Force Mock Data for Presentation
    private let useMocksOnly = true
    
    private func getToken() async throws -> String {
        guard let user = Auth.auth().currentUser else { throw NetworkError.unauthorized }
        return try await user.getIDToken()
    }
    
    func fetchStages() async throws -> [StageDTO] {
        if useMocksOnly {
            print("Using enforced mock stages")
            return LearningMockData.stages
        }
        
        do {
            let token = try await getToken()
            return try await NetworkManager.shared.get(path: "learning/stages", token: token)
        } catch {
            return LearningMockData.stages
        }
    }
    
    func fetchChapters(stageId: String) async throws -> [ChapterDTO] {
        if useMocksOnly {
            return LearningMockData.chapters[stageId] ?? []
        }
        
        do {
            let token = try await getToken()
            return try await NetworkManager.shared.get(path: "learning/stages/\(stageId)/chapters", token: token)
        } catch {
            return LearningMockData.chapters[stageId] ?? []
        }
    }
    
    func fetchTopics(stageId: String, chapterId: String) async throws -> [TopicDTO] {
        if useMocksOnly {
            return LearningMockData.topics[chapterId] ?? []
        }
        
        do {
            let token = try await getToken()
            return try await NetworkManager.shared.get(path: "learning/stages/\(stageId)/chapters/\(chapterId)/topics", token: token)
        } catch {
            return LearningMockData.topics[chapterId] ?? []
        }
    }
    
    func fetchObjectives(stageId: String, chapterId: String, topicId: String) async throws -> [ObjectiveDTO] {
        if useMocksOnly {
            return LearningMockData.objectives[topicId] ?? []
        }
        
        do {
            let token = try await getToken()
            return try await NetworkManager.shared.get(path: "learning/stages/\(stageId)/chapters/\(chapterId)/topics/\(topicId)/objectives", token: token)
        } catch {
            return LearningMockData.objectives[topicId] ?? []
        }
    }
    
    func fetchLessons(stageId: String, chapterId: String, topicId: String, objectiveId: String) async throws -> [LessonDTO] {
        if useMocksOnly {
            return LearningMockData.lessons[objectiveId] ?? []
        }
        
        do {
            let token = try await getToken()
            return try await NetworkManager.shared.get(path: "learning/stages/\(stageId)/chapters/\(chapterId)/topics/\(topicId)/objectives/\(objectiveId)/lessons", token: token)
        } catch {
            return LearningMockData.lessons[objectiveId] ?? []
        }
    }
    
    func markObjectiveComplete(objectiveId: String) async throws {
        if useMocksOnly {
            print("Successfully marked locally (mocked)")
            return
        }
        
        do {
            let token = try await getToken()
            try await NetworkManager.shared.postNoReturn(path: "learning/objectives/\(objectiveId)/complete", body: ["":""], token: token)
        } catch {
            print("Failed to mark complete on server, proceeding locally: \(error)")
        }
    }
    
    func fetchCurrentPosition() async throws -> CurrentPositionDTO {
        if useMocksOnly {
            return LearningMockData.currentPosition
        }
        
        do {
            let token = try await getToken()
            return try await NetworkManager.shared.get(path: "learning/current-position", token: token)
        } catch {
            return LearningMockData.currentPosition
        }
    }
}
