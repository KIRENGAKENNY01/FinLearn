import SwiftUI

struct ObjectivePage: View {
    let lesson: LessonItem
    let topic: LearningObjective
    let accent: Color
    let stageId: String
    
    @State private var objectives: [LearningObjective] = []
    @State private var loading: Bool = true
    @State private var topicProgress: Double = 0.0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                
                // Hero
                Image("MoneyMotivation")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 240)
                    .padding(.top, 12)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Topic Title:")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color(hex: "#1B2534").opacity(0.7))
                    
                    Text(topic.title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(hex: "#1B2534"))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing:8) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#D6FDA3"))
                                .frame(width: 35, height: 35)
                            
                            Image("mission")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(hex: "#A2ACBD"))
                                .frame(width: 20, height: 20)
                        }
                        .frame(width: 35, height: 35)
                        
                        Text("Progress")
                            .font(.system(size: 15 , weight: .light ))
                    }
                    
                    PercentageCard(title: "Course Completion Progress", subhead: "Active Study", progressNumber: Float(topicProgress))
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 8) {
                        Image(systemName: "target")
                             .font(.system(size: 24))
                             .foregroundColor(Color(hex: "#1B2534"))
                        Text("Learning Objectives")
                            .font(.headline)
                            .bold()
                            .foregroundColor(Color(hex: "#01312D"))
                    }
                    .padding(.bottom, 8)
                    
                    if loading {
                        ProgressView()
                            .padding()
                    } else if objectives.isEmpty {
                        Text("No objectives found for this topic.")
                            .foregroundColor(.secondary)
                    } else {
                        LazyVStack(spacing: 12) {
                            ForEach(objectives) { objective in
                                NavigationLink {
                                    LearningOutlinePage(
                                        objective: objective,
                                        accent: accent,
                                        stageId: stageId,
                                        chapterId: lesson.backendId,
                                        topicId: topic.backendId
                                    )
                                } label: {
                                    ReusableCard(
                                        icon: "coin",
                                        title: objective.title,
                                        finished: "Click to learn",
                                        status: objective.status?.rawValue ?? ""
                                    )
                                }
                                .buttonStyle(.plain)
                                .disabled(objective.status == .locked)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .background(Color(hex: "#EAFDEF"))
        .navigationTitle("Objectives")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadObjectives()
        }
    }
    
    private func loadObjectives() async {
        loading = true
        do {
            let objectiveDTOs = try await LearningService.shared.fetchObjectives(
                stageId: stageId,
                chapterId: lesson.backendId,
                topicId: topic.backendId
            )
            
            // The backend returns TopicProgress in TopicResponse, but ObjectivePage 
            // is already showing objectives. We can calculate progress locally here too.
            let completedCount = objectiveDTOs.filter { $0.status == "completed" }.count
            self.topicProgress = Double(completedCount) / Double(max(1, objectiveDTOs.count))
            
            objectives = objectiveDTOs.map { dto in
                LearningObjective(
                    backendId: dto.id ?? "",
                    title: dto.title,
                    description: dto.content,
                    status: CompletionStatus(rawValue: dto.status ?? "locked")
                )
            }
            loading = false
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return
            }
            print("Failed to load objectives: \(error)")
            loading = false
        }
    }
}
