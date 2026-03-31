import SwiftUI

struct LessonPage: View {
    let lesson: LessonItem
    let accent: Color
    let stageId: String
    
    @State private var topics: [LearningObjective] = []
    @State private var loading: Bool = true
    @State private var chapterProgress: Double = 0.0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(lesson.title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(hex: "#1B2534"))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    PercentageCard(title: "Chapter Progress", subhead: "Current Chapter", progressNumber: Float(chapterProgress))
                    
                    Text(lesson.paragraph)
                        .font(.system(size: 17))
                        .foregroundColor(Color(hex: "#1B2534").opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Topics")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(hex: "#1B2534"))
                        Spacer()
                        Text("\(topics.count) Topics")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color(hex: "#1B2534").opacity(0.7))
                    }
                    
                    if loading {
                        ProgressView()
                            .padding()
                    } else if topics.isEmpty {
                        Text("No topics available.")
                            .foregroundColor(.secondary)
                    } else {
                        LazyVStack(spacing: 14) {
                            ForEach(topics) { topic in
                                NavigationLink {
                                    ObjectivePage(
                                        lesson: lesson,
                                        topic: topic,
                                        accent: accent,
                                        stageId: stageId
                                    )
                                } label: {
                                    ReusableCard(
                                        icon: "book",
                                        title: topic.title,
                                        finished: "Click to see objectives",
                                        status: topic.status?.rawValue ?? "Not started"
                                    )
                                }
                                .buttonStyle(.plain)
                                .disabled(topic.status == .locked)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
        .background(Color(hex: "#EAFDEF"))
        .navigationTitle("Lesson")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadTopics()
        }
    }
    
    private func loadTopics() async {
        loading = true
        do {
            let topicDTOs = try await LearningService.shared.fetchTopics(stageId: stageId, chapterId: lesson.backendId)
            // Calculate chapter progress locally from topic statuses
            // (Alternative: backend could return it, but calculating from topics is fine here)
            let completedCount = topicDTOs.filter { $0.status == "completed" }.count
            self.chapterProgress = Double(completedCount) / Double(max(1, topicDTOs.count))
            
            topics = topicDTOs.map { dto in
                LearningObjective(
                    backendId: dto.id ?? "",
                    title: dto.title,
                    description: "", // Topic doesn't have description in backend yet
                    status: CompletionStatus(rawValue: dto.status ?? "locked")
                )
            }
            loading = false
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return
            }
            print("Failed to load topics: \(error)")
            loading = false
        }
    }
}
