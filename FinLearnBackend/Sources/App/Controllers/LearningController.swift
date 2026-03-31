import Vapor

struct LearningController: RouteCollection {
    let service: LearningService
    
    func boot(routes: RoutesBuilder) throws {
        let learning = routes.grouped("learning")
        
        // 1 & 5. Progress Percentages
        learning.get("progress", use: getTotalProgress)
        // learning.get("quizzes", "progress", use: getQuizProgress)
        // learning.get("stages", ":stageId", "progress", use: getStageProgress)
        
        // 3 & 4. Stages & Locking
        learning.get("stages", use: getStages)
        learning.get("stages", ":stageId", "chapters", use: getChapters)
        // 3b. Full Stage Content (Bulk Fetch)
        learning.get("stages", ":stageId", "full", use: getFullStageContent)
        
        // 7. Topics in Chapter
        learning.get("stages", ":stageId", "chapters", ":chapterId", "topics", use: getTopics)
        
        // 8. Objectives in Topic
        learning.get("stages", ":stageId", "chapters", ":chapterId", "topics", ":topicId", "objectives", use: getObjectives)
        
        // 9. Lesson Content (Lessons in Objective)
        learning.get("stages", ":stageId", "chapters", ":chapterId", "topics", ":topicId", "objectives", ":objectiveId", "lessons", use: getLessons)
        
        // 10. Mark Complete
        learning.post("objectives", ":objectiveId", "complete", use: completeObjective)
        
        // 11. Current Navigation Position
        learning.get("current-position", use: getCurrentPosition)
    }
    
    // Handlers
    func getTotalProgress(req: Request) async throws -> ProgressResponse { 
        return ProgressResponse(totalProgress: 45.0)
    }
    
    func getStages(req: Request) async throws -> [StageResponse] {
        let user = try req.auth.require(User.self)
        return try await service.getStages(req: req, userId: user.id!)
    }
    
    func getChapters(req: Request) async throws -> [Chapter] {
        let user = try req.auth.require(User.self)
        guard let stageId = req.parameters.get("stageId") else { throw Abort(.badRequest) }
        return try await service.getChapters(req: req, userId: user.id!, stageId: stageId)
    }
    
    func getFullStageContent(req: Request) async throws -> FullStageContent {
        let user = try req.auth.require(User.self)
        guard let stageId = req.parameters.get("stageId") else { throw Abort(.badRequest) }
        return try await service.getFullStageContent(req: req, userId: user.id!, stageId: stageId)
    }

    func getTopics(req: Request) async throws -> [Topic] {
        guard let stageId = req.parameters.get("stageId"),
              let chapterId = req.parameters.get("chapterId") else { throw Abort(.badRequest) }
        return try await service.getTopics(req: req, stageId: stageId, chapterId: chapterId)
    }

    func getObjectives(req: Request) async throws -> [LearningObjective] {
        guard let stageId = req.parameters.get("stageId"),
              let chapterId = req.parameters.get("chapterId"),
              let topicId = req.parameters.get("topicId") else { throw Abort(.badRequest) }
        return try await service.getObjectives(req: req, stageId: stageId, chapterId: chapterId, topicId: topicId)
    }

    func getLessons(req: Request) async throws -> [Lesson] {
        guard let stageId = req.parameters.get("stageId"),
              let chapterId = req.parameters.get("chapterId"),
              let topicId = req.parameters.get("topicId"),
              let objectiveId = req.parameters.get("objectiveId") else { throw Abort(.badRequest) }
        return try await service.getLessons(req: req, stageId: stageId, chapterId: chapterId, topicId: topicId, objectiveId: objectiveId)
    }

    func completeObjective(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        guard let objId = req.parameters.get("objectiveId") else { throw Abort(.badRequest) }
        return try await service.markObjectiveComplete(req: req, userId: user.id!, objectiveId: objId)
    }

    func getCurrentPosition(req: Request) async throws -> LearningService.CurrentPosition {
        let user = try req.auth.require(User.self)
        return try await service.getCurrentPosition(req: req, userId: user.id!)
    }
}



