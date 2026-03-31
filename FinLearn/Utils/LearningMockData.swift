import Foundation

struct LearningMockData {
    static let stages: [StageDTO] = [
        StageDTO(id: "beginner", status: "ongoing", progress: 0.25),
        StageDTO(id: "intermediate", status: "locked", progress: 0.0),
        StageDTO(id: "advanced", status: "locked", progress: 0.0)
    ]
    
    static let chapters: [String: [ChapterDTO]] = [
        "beginner": [
            ChapterDTO(id: "ch1", stageId: "beginner", title: "Budgeting Basics", order: 1, topicCount: 3, status: "ongoing", progress: 0.33),
            ChapterDTO(id: "ch2", stageId: "beginner", title: "Emergency Funds", order: 2, topicCount: 2, status: "locked", progress: 0.0),
            ChapterDTO(id: "ch3", stageId: "beginner", title: "Understanding Interest", order: 3, topicCount: 2, status: "locked", progress: 0.0)
        ]
    ]
    
    static let topics: [String: [TopicDTO]] = [
        "ch1": [
            TopicDTO(id: "t1", chapterId: "ch1", title: "What is a Budget?", order: 1, objectiveCount: 1, status: "completed", progress: 1.0),
            TopicDTO(id: "t2", chapterId: "ch1", title: "50/30/20 Rule", order: 2, objectiveCount: 1, status: "ongoing", progress: 0.0),
            TopicDTO(id: "t3", chapterId: "ch1", title: "Tracking Expenses", order: 3, objectiveCount: 1, status: "locked", progress: 0.0)
        ]
    ]
    
    static let objectives: [String: [ObjectiveDTO]] = [
        "t1": [
            ObjectiveDTO(id: "obj1", topicId: "t1", title: "Budget Definition", content: "Learn the core definition and importance of budgeting.", order: 1, status: "completed")
        ],
        "t2": [
            ObjectiveDTO(id: "obj2", topicId: "t2", title: "Rule Breakdown", content: "Understand how to divide your income into categories.", order: 1, status: "notStarted")
        ],
        "t3": [
            ObjectiveDTO(id: "obj3", topicId: "t3", title: "Manual vs Digital", content: "Compare different methods of tracking daily spending.", order: 1, status: "locked")
        ]
    ]
    
    static let lessons: [String: [LessonDTO]] = [
        "obj1": [
            LessonDTO(
                id: "l1", 
                objectiveId: "obj1", 
                title: "Fundamentals of Budgeting", 
                paragraph: "A budget is a financial plan for a defined period, often one year. It greatly enhances the success of financial operations. It is a way of ensuring that you are spending less than you earn and saving for your long-term goals. Without a budget, it's easy to lose track of where your money is going.", 
                keyTakeaway: "A budget is your roadmap to financial freedom."
            )
        ],
         "obj2": [
            LessonDTO(
                id: "l2", 
                objectiveId: "obj2", 
                title: "The 50/30/20 Strategy", 
                paragraph: "The 50/30/20 rule is a simple budgeting method that can help you manage your money effectively. It suggests that you spend 50% of your after-tax income on needs, 30% on wants, and 20% on savings and debt repayment.", 
                keyTakeaway: "Balance your needs, wants, and savings for a healthy financial life."
            )
        ]
    ]
    
    static let currentPosition = CurrentPositionDTO(
        stageId: "beginner",
        chapterId: "ch1",
        topicId: "t2",
        objectiveId: "obj2",
        isAllComplete: false
    )
}
