import Vapor

struct LearningService {
    
    // MARK: - Seeding
    func seedCurriculum(req: Request) async throws -> String {
        guard let firestore = req.application.firestore else { return "No Firestore configured" }
        
        var counts = [
            "stages": 0, "chapters": 0, "topics": 0, "objectives": 0, "lessons": 0
        ]
        
        print("[SEED] Starting seeding (Clean Update)...")
        
        // 1. Stages
        await withTaskGroup(of: Void.self) { group in
            for (id, title, order) in CurriculumData.stages {
                group.addTask {
                    do {
                        let stage = FirestoreStage(title: FirestoreString(stringValue: title), order: FirestoreInt(order))
                        _ = try await firestore.setDocument(collection: "stages", documentId: id, data: stage)
                        print("[SEED] Set stage \(id)")
                    } catch {
                        print("[SEED ERROR] Stage \(id): \(error)")
                    }
                }
            }
        }
        counts["stages"] = CurriculumData.stages.count
        
        // 2. Chapters
        await withTaskGroup(of: Void.self) { group in
            for (id, stageId, title, order) in CurriculumData.chapters {
                group.addTask {
                    do {
                        let chapter = FirestoreChapter(stageId: FirestoreString(stringValue: stageId), title: FirestoreString(stringValue: title), order: FirestoreInt(order))
                        _ = try await firestore.setDocument(collection: "stages/\(stageId)/chapters", documentId: id, data: chapter)
                        print("[SEED] Set chapter \(id)")
                    } catch {
                        print("[SEED ERROR] Chapter \(id): \(error)")
                    }
                }
            }
        }
        counts["chapters"] = CurriculumData.chapters.count
        
        // 3. Topics
        await withTaskGroup(of: Void.self) { group in
            for (id, chapterId, title, order) in CurriculumData.topics {
                guard let chapter = CurriculumData.chapters.first(where: { $0.id == chapterId }) else { continue }
                let stageId = chapter.stageId
                let path = "stages/\(stageId)/chapters/\(chapterId)/topics"
                
                group.addTask {
                    do {
                        let topic = FirestoreTopic(chapterId: FirestoreString(stringValue: chapterId), title: FirestoreString(stringValue: title), order: FirestoreInt(order))
                        _ = try await firestore.setDocument(collection: path, documentId: id, data: topic)
                        print("[SEED] Set topic \(id)")
                    } catch {
                        print("[SEED ERROR] Topic \(id): \(error)")
                    }
                }
            }
        }
        counts["topics"] = CurriculumData.topics.count
        
        // 4. Objectives
        await withTaskGroup(of: Void.self) { group in
            for (id, topicId, title, content, order) in CurriculumData.objectives {
                guard let topic = CurriculumData.topics.first(where: { $0.id == topicId }),
                      let chapter = CurriculumData.chapters.first(where: { $0.id == topic.chapterId }) else { continue }
                let stageId = chapter.stageId
                let chapterId = topic.chapterId
                let path = "stages/\(stageId)/chapters/\(chapterId)/topics/\(topicId)/objectives"
                
                group.addTask {
                    do {
                        let objective = FirestoreObjective(topicId: FirestoreString(stringValue: topicId), title: FirestoreString(stringValue: title), content: FirestoreString(stringValue: content), order: FirestoreInt(order))
                        _ = try await firestore.setDocument(collection: path, documentId: id, data: objective)
                        print("[SEED] Set objective \(id)")
                    } catch {
                        print("[SEED ERROR] Objective \(id): \(error)")
                    }
                }
            }
        }
        counts["objectives"] = CurriculumData.objectives.count
        
        // 5. Lessons
        await withTaskGroup(of: Void.self) { group in
            for (id, objectiveId, title, paragraph, keyTakeaway) in CurriculumData.lessons {
                 guard let objective = CurriculumData.objectives.first(where: { $0.id == objectiveId }),
                       let topic = CurriculumData.topics.first(where: { $0.id == objective.topicId }),
                       let chapter = CurriculumData.chapters.first(where: { $0.id == topic.chapterId }) else { continue }
                
                let stageId = chapter.stageId
                let chapterId = topic.chapterId
                let topicId = objective.topicId
                let path = "stages/\(stageId)/chapters/\(chapterId)/topics/\(topicId)/objectives/\(objectiveId)/lessons"
                
                group.addTask {
                    do {
                        let lesson = FirestoreLesson(
                            objectiveId: FirestoreString(stringValue: objectiveId),
                            title: FirestoreString(stringValue: title),
                            paragraph: FirestoreString(stringValue: paragraph),
                            keyTakeaway: FirestoreString(stringValue: keyTakeaway)
                        )
                        _ = try await firestore.setDocument(collection: path, documentId: id, data: lesson)
                        print("[SEED] Set lesson \(id)")
                    } catch {
                        print("[SEED ERROR] Lesson \(id): \(error)")
                    }
                }
            }
        }
        counts["lessons"] = CurriculumData.lessons.count
        
        return "Clean Seeding Complete. Counts: \(counts)"
    }
    
    // MARK: - Fetching
    
    // MARK: - Fetching
    
    // MARK: - Fetching
    
    func getFullStageContent(req: Request, userId: String, stageId: String) async throws -> FullStageContent {
        async let stages = getStages(req: req, userId: userId)
        
        let chapters = try await getChapters(req: req, userId: userId, stageId: stageId)
        guard let stage = try await stages.first(where: { $0.id == stageId }) else {
            throw Abort(.notFound, reason: "Stage not found")
        }
        
        var fullChapters: [FullChapterContent] = []
        
        // Fetch all chapters in parallel
        try await withThrowingTaskGroup(of: FullChapterContent.self) { group in
            for chapter in chapters {
                group.addTask {
                    let topics = try await getTopics(req: req, stageId: stageId, chapterId: chapter.id!)
                    var fullTopics: [FullTopicContent] = []
                    
                    // Fetch all topics in parallel
                    try await withThrowingTaskGroup(of: FullTopicContent.self) { topicGroup in
                        for topic in topics {
                            topicGroup.addTask {
                                let objectives = try await getObjectives(req: req, stageId: stageId, chapterId: chapter.id!, topicId: topic.id!)
                                var fullObjectives: [FullObjectiveContent] = []
                                
                                // Fetch all objectives in parallel
                                try await withThrowingTaskGroup(of: FullObjectiveContent.self) { objGroup in
                                    for obj in objectives {
                                        objGroup.addTask {
                                            let lessons = try await getLessons(req: req, stageId: stageId, chapterId: chapter.id!, topicId: topic.id!, objectiveId: obj.id!)
                                            return FullObjectiveContent(objective: obj, lessons: lessons)
                                        }
                                    }
                                    while let objContent = try await objGroup.next() {
                                        fullObjectives.append(objContent)
                                    }
                                }
                                fullObjectives.sort { $0.objective.order < $1.objective.order }
                                return FullTopicContent(topic: topic, objectives: fullObjectives)
                            }
                        }
                        while let topicContent = try await topicGroup.next() {
                            fullTopics.append(topicContent)
                        }
                    }
                    fullTopics.sort { $0.topic.order < $1.topic.order }
                    return FullChapterContent(chapter: chapter, topics: fullTopics)
                }
            }
            while let chapterContent = try await group.next() {
                fullChapters.append(chapterContent)
            }
        }
        
        fullChapters.sort { $0.chapter.order < $1.chapter.order }
        return FullStageContent(stage: stage, chapters: fullChapters)
    }

    func getStages(req: Request, userId: String) async throws -> [StageResponse] {
        let progress = try await getUserProgress(req, userId: userId)
        
        let stageIds = CurriculumData.stages.map { $0.id }
        var stages: [StageResponse] = []
        
        for i in 0..<stageIds.count {
            let stageId = stageIds[i]
            let isDone = isStageCompleted(stageId: stageId, progress: progress)
            
            var status: CompletionStatus = .locked
            if i == 0 {
                // First stage is always available if the app is started
                status = isDone ? .completed : .ongoing
            } else {
                let prevStageId = stageIds[i-1]
                let prevStageDone = isStageCompleted(stageId: prevStageId, progress: progress)
                if prevStageDone {
                    status = isDone ? .completed : .ongoing
                } else {
                    status = .locked
                }
            }
            stages.append(StageResponse(
                id: stageId,
                status: status,
                progress: getStageProgress(stageId: stageId, progress: progress)
            ))
        }
        
        return stages
    }
    
    func getChapters(req: Request, userId: String, stageId: String) async throws -> [Chapter] {
        let progress = try await getUserProgress(req, userId: userId)
        
        let stageChapters = CurriculumData.chapters.filter { $0.stageId == stageId }
            .sorted { $0.order < $1.order }
        
        var chapters: [Chapter] = []
        for i in 0..<stageChapters.count {
            let chData = stageChapters[i]
            let isDone = isChapterCompleted(stageId: stageId, chapterId: chData.id, progress: progress)
            
            var status: CompletionStatus = .locked
            
            // Check if stage is unlocked
            let stageIds = CurriculumData.stages.map { $0.id }
            let stageIdx = stageIds.firstIndex(of: stageId) ?? 0
            let isStageUnlocked = (stageIdx == 0) || isStageCompleted(stageId: stageIds[stageIdx-1], progress: progress)
            
            if !isStageUnlocked {
                status = .locked
            } else if i == 0 {
                status = isDone ? .completed : .ongoing
            } else {
                let prevDone = isChapterCompleted(stageId: stageId, chapterId: stageChapters[i-1].id, progress: progress)
                if prevDone {
                    status = isDone ? .completed : .ongoing
                } else {
                    status = .locked
                }
            }
            
            chapters.append(Chapter(
                id: chData.id,
                stageId: stageId,
                title: chData.title,
                order: chData.order,
                topicCount: getTopicCount(chapterId: chData.id),
                status: status,
                progress: getChapterProgress(chapterId: chData.id, progress: progress)
            ))
        }
        
        return chapters
    }
    
    func getTopics(req: Request, stageId: String, chapterId: String) async throws -> [Topic] {
        let userId = try req.auth.require(User.self).id!
        let progress = try await getUserProgress(req, userId: userId)
        
        let chapterTopics = CurriculumData.topics.filter { $0.chapterId == chapterId }
            .sorted { $0.order < $1.order }
            
        var topics: [Topic] = []
        for i in 0..<chapterTopics.count {
            let tData = chapterTopics[i]
            let isDone = isTopicCompleted(topicId: tData.id, progress: progress)
            
            var status: CompletionStatus = .locked
            
            // Check if chapter is unlocked
            let chapterData = CurriculumData.chapters.first(where: { $0.id == chapterId })!
            let stageChapters = CurriculumData.chapters.filter { $0.stageId == chapterData.stageId }.sorted { $0.order < $1.order }
            let chapterIdx = stageChapters.firstIndex(where: { $0.id == chapterId }) ?? 0
            
            let isChapterUnlocked: Bool
            if chapterIdx == 0 {
                // First chapter of stage -> check if stage is unlocked
                let stageIds = CurriculumData.stages.map { $0.id }
                let stageIdx = stageIds.firstIndex(of: chapterData.stageId) ?? 0
                isChapterUnlocked = (stageIdx == 0) || isStageCompleted(stageId: stageIds[stageIdx-1], progress: progress)
            } else {
                // Not first chapter -> check if previous chapter is done
                isChapterUnlocked = isChapterCompleted(stageId: chapterData.stageId, chapterId: stageChapters[chapterIdx-1].id, progress: progress)
            }
            
            if !isChapterUnlocked {
                status = .locked
            } else if i == 0 {
                status = isDone ? .completed : .ongoing
            } else {
                let prevDone = isTopicCompleted(topicId: chapterTopics[i-1].id, progress: progress)
                if prevDone {
                    status = isDone ? .completed : .ongoing
                } else {
                    status = .locked
                }
            }
            
            topics.append(Topic(
                id: tData.id,
                chapterId: chapterId,
                title: tData.title,
                order: tData.order,
                objectiveCount: getObjectiveCount(topicId: tData.id),
                status: status,
                progress: getTopicProgress(topicId: tData.id, progress: progress)
            ))
        }
        
        return topics
    }
    
    func getObjectives(req: Request, stageId: String, chapterId: String, topicId: String) async throws -> [LearningObjective] {
        let userId = try req.auth.require(User.self).id!
        let progress = try await getUserProgress(req, userId: userId)
        
        let topicObjectives = CurriculumData.objectives.filter { $0.topicId == topicId }
            .sorted { $0.order < $1.order }
            
        var objectives: [LearningObjective] = []
        for i in 0..<topicObjectives.count {
            let oData = topicObjectives[i]
            let isDone = progress.completedObjectiveIds.contains(oData.id)
            
            var status: CompletionStatus = .locked
            
            // Check if topic is unlocked
            let topicData = CurriculumData.topics.first(where: { $0.id == topicId })!
            let chapterTopics = CurriculumData.topics.filter { $0.chapterId == topicData.chapterId }.sorted { $0.order < $1.order }
            let topicIdx = chapterTopics.firstIndex(where: { $0.id == topicId }) ?? 0
            
            let isTopicUnlocked: Bool
            if topicIdx == 0 {
                // First topic of chapter -> check if chapter is unlocked
                let chData = CurriculumData.chapters.first(where: { $0.id == topicData.chapterId })!
                let stChapters = CurriculumData.chapters.filter { $0.stageId == chData.stageId }.sorted { $0.order < $1.order }
                let chIdx = stChapters.firstIndex(where: { $0.id == chData.id }) ?? 0
                
                if chIdx == 0 {
                    let stIds = CurriculumData.stages.map { $0.id }
                    let stIdx = stIds.firstIndex(of: chData.stageId) ?? 0
                    isTopicUnlocked = (stIdx == 0) || isStageCompleted(stageId: stIds[stIdx-1], progress: progress)
                } else {
                    isTopicUnlocked = isChapterCompleted(stageId: chData.stageId, chapterId: stChapters[chIdx-1].id, progress: progress)
                }
            } else {
                isTopicUnlocked = isTopicCompleted(topicId: chapterTopics[topicIdx-1].id, progress: progress)
            }
            
            if !isTopicUnlocked {
                status = .locked
            } else if i == 0 {
                status = isDone ? .completed : .ongoing
            } else {
                let prevDone = progress.completedObjectiveIds.contains(topicObjectives[i-1].id)
                if prevDone {
                    status = isDone ? .completed : .ongoing
                } else {
                    status = .locked
                }
            }
            
            objectives.append(LearningObjective(
                id: oData.id,
                topicId: topicId,
                title: oData.title,
                content: oData.content,
                order: oData.order,
                status: status
            ))
        }
        
        return objectives
    }
    
    func getLessons(req: Request, stageId: String, chapterId: String, topicId: String, objectiveId: String) async throws -> [Lesson] {
        return CurriculumData.lessons.filter { $0.objectiveId == objectiveId }
            .map { Lesson(id: $0.id, objectiveId: $0.objectiveId, title: $0.title, paragraph: $0.paragraph, keyTakeaway: $0.keyTakeaway) }
    }

    // MARK: - Navigation Logic

    struct CurrentPosition: Content {
        let stageId: String
        let chapterId: String
        let topicId: String
        let objectiveId: String
        let isAllComplete: Bool
    }

    func getCurrentPosition(req: Request, userId: String) async throws -> CurrentPosition {
        let progress = try await getUserProgress(req, userId: userId)
        
        // Find the first objective that is not completed
        for stage in CurriculumData.stages {
            for chapter in CurriculumData.chapters.filter({ $0.stageId == stage.id }).sorted(by: { $0.order < $1.order }) {
                for topic in CurriculumData.topics.filter({ $0.chapterId == chapter.id }).sorted(by: { $0.order < $1.order }) {
                    for objective in CurriculumData.objectives.filter({ $0.topicId == topic.id }).sorted(by: { $0.order < $1.order }) {
                        if !progress.completedObjectiveIds.contains(objective.id) {
                            return CurrentPosition(
                                stageId: stage.id,
                                chapterId: chapter.id,
                                topicId: topic.id,
                                objectiveId: objective.id,
                                isAllComplete: false
                            )
                        }
                    }
                }
            }
        }
        
        // If all completed, return the last one (or a finished state)
        // For now, return the first one as default if something goes wrong
        return CurrentPosition(
            stageId: CurriculumData.stages[0].id,
            chapterId: CurriculumData.chapters[0].id,
            topicId: CurriculumData.topics[0].id,
            objectiveId: CurriculumData.objectives[0].id,
            isAllComplete: true
        )
    }
    
    // MARK: - Helpers (In-Memory)

    private func isTopicCompleted(topicId: String, progress: UserProgress) -> Bool {
        let objectiveIds = CurriculumData.objectives.filter { $0.topicId == topicId }.map { $0.id }
        if objectiveIds.isEmpty { return false }
        return objectiveIds.allSatisfy { progress.completedObjectiveIds.contains($0) }
    }
    
    private func isChapterCompleted(stageId: String, chapterId: String, progress: UserProgress) -> Bool {
        let topicIds = CurriculumData.topics.filter { $0.chapterId == chapterId }.map { $0.id }
        if topicIds.isEmpty { return false }
        return topicIds.allSatisfy { isTopicCompleted(topicId: $0, progress: progress) }
    }
    
    private func isStageCompleted(stageId: String, progress: UserProgress) -> Bool {
        let chapterIds = CurriculumData.chapters.filter { $0.stageId == stageId }.map { $0.id }
        if chapterIds.isEmpty { return false }
        return chapterIds.allSatisfy { isChapterCompleted(stageId: stageId, chapterId: $0, progress: progress) }
    }
    
    private func getTopicCount(chapterId: String) -> Int {
        return CurriculumData.topics.filter { $0.chapterId == chapterId }.count
    }
    
    private func getObjectiveCount(topicId: String) -> Int {
        return CurriculumData.objectives.filter { $0.topicId == topicId }.count
    }
    
    private func getTopicProgress(topicId: String, progress: UserProgress) -> Double {
        let objectiveIds = CurriculumData.objectives.filter { $0.topicId == topicId }.map { $0.id }
        if objectiveIds.isEmpty { return 0.0 }
        let completed = objectiveIds.filter { progress.completedObjectiveIds.contains($0) }.count
        return Double(completed) / Double(objectiveIds.count)
    }
    
    private func getChapterProgress(chapterId: String, progress: UserProgress) -> Double {
        let topics = CurriculumData.topics.filter { $0.chapterId == chapterId }
        if topics.isEmpty { return 0.0 }
        
        var totalObjectives = 0
        var completedObjectives = 0
        
        for topic in topics {
            let objectiveIds = CurriculumData.objectives.filter { $0.topicId == topic.id }.map { $0.id }
            totalObjectives += objectiveIds.count
            completedObjectives += objectiveIds.filter { progress.completedObjectiveIds.contains($0) }.count
        }
        
        if totalObjectives == 0 { return 0.0 }
        return Double(completedObjectives) / Double(totalObjectives)
    }
    
    private func getStageProgress(stageId: String, progress: UserProgress) -> Double {
        let chapters = CurriculumData.chapters.filter { $0.stageId == stageId }
        if chapters.isEmpty { return 0.0 }
        
        var totalObjectives = 0
        var completedObjectives = 0
        
        for chapter in chapters {
            let topics = CurriculumData.topics.filter { $0.chapterId == chapter.id }
            for topic in topics {
                let objectiveIds = CurriculumData.objectives.filter { $0.topicId == topic.id }.map { $0.id }
                totalObjectives += objectiveIds.count
                completedObjectives += objectiveIds.filter { progress.completedObjectiveIds.contains($0) }.count
            }
        }
        
        if totalObjectives == 0 { return 0.0 }
        return Double(completedObjectives) / Double(totalObjectives)
    }
    
    private func getGlobalProgress(progress: UserProgress) -> Double {
        let totalObjectives = CurriculumData.objectives.count
        if totalObjectives == 0 { return 0.0 }
        return Double(progress.completedObjectiveIds.count) / Double(totalObjectives)
    }
    
    // MARK: - Progress
    
    func markObjectiveComplete(req: Request, userId: String, objectiveId: String) async throws -> HTTPStatus {
        var progress = try await getUserProgress(req, userId: userId)
        
        if !progress.completedObjectiveIds.contains(objectiveId) {
            progress.completedObjectiveIds.append(objectiveId)
            progress.totalObjectivesCompleted += 1
            
            if let firestore = req.application.firestore,
               let jsonData = try? JSONEncoder().encode(progress),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                
                // Re-using the string blob storage for progress for now as it's easiest given UserProgress complexity
                struct FirestoreData: Content { let data: FirestoreString }
                
                _ = try await firestore.setDocument(
                    collection: "users/\(userId)/learning",
                    documentId: "progress",
                    data: FirestoreData(data: FirestoreString(stringValue: jsonString))
                )
            }
        }
        return .ok
    }
    
    private func getUserProgress(_ req: Request, userId: String) async throws -> UserProgress {
        guard let firestore = req.application.firestore else {
            return UserProgress(completedObjectiveIds: [], unlockedStageId: "beginner", currentChapterId: nil, totalObjectivesCompleted: 0, totalQuizzesCompleted: 0)
        }
        
        struct FirestoreData: Codable {
            let data: FirestoreString
        }
        
        do {
            let doc: FirestoreDocument<FirestoreData> = try await firestore.getDocument(collection: "users/\(userId)/learning", documentId: "progress")
            let jsonString = doc.fields.data.stringValue
            if let data = jsonString.data(using: .utf8) {
                return try JSONDecoder().decode(UserProgress.self, from: data)
            }
        } catch {
            return UserProgress(completedObjectiveIds: [], unlockedStageId: "beginner", currentChapterId: nil, totalObjectivesCompleted: 0, totalQuizzesCompleted: 0)
        }
        return UserProgress(completedObjectiveIds: [], unlockedStageId: "beginner", currentChapterId: nil, totalObjectivesCompleted: 0, totalQuizzesCompleted: 0)
    }
}
