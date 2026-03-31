import SwiftUI

struct LearnView: View {
    @State private var levels: [LearningLevel] = []
    @State private var loading: Bool = true
    @State private var selectedIndex: Int = 0
    
    // Mapping for UI properties since they aren't in backend yet
    private let levelUI: [String: (title: String, duration: String, gradient: [Color], accent: Color)] = [
        "beginner": (
            "Foundation of Financial Literacy",
            "45-60 min",
            [Color(hex: "#EAFDEF"), Color(hex: "#D6FDA3")],
            Color(hex: "#72BF00")
        ),
        "intermediate": (
            "Managing Credit & Borrowing",
            "60-90 min",
            [Color(hex: "#EAFDEF"), Color(hex: "#C8F7B9")],
            Color(hex: "#30A46C")
        ),
        "advanced": (
            "Investing & Wealth Building",
            "90-120 min",
            [Color(hex: "#EAFDEF"), Color(hex: "#BFF3A3")],
            Color(hex: "#1E8C4A")
        )
    ]
    
    private var selectedLevel: LearningLevel? {
        guard !levels.isEmpty, selectedIndex < levels.count else { return nil }
        return levels[selectedIndex]
    }
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            if loading {
                ProgressView("Loading Curriculum...")
                    .padding()
            } else if levels.isEmpty {
                VStack {
                    Text("No curriculum found.")
                    Button("Retry") {
                        Task { await loadData() }
                    }
                }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Header(firstName: "Kenny")
                        
                        // Level pills
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(Array(levels.enumerated()), id: \.offset) { idx, level in
                                    Button {
                                        selectedIndex = idx
                                    } label: {
                                        Text(level.type.rawValue)
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(selectedIndex == idx ? .white : Color(hex: "#1B2534"))
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 10)
                                            .background(
                                                RoundedRectangle(cornerRadius: 18)
                                                    .fill(selectedIndex == idx ? Color(hex: "#72BF00") : Color.white)
                                            )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        if let level = selectedLevel {
                            if level.status.lowercased() == "locked" {
                                LockedStageView()
                                    .transition(.opacity)
                                    .padding(.top, 40)
                            } else {
                                // Progress card using PercentageCard
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        PercentageCard(
                                            title: level.title,
                                            subhead: level.type.rawValue,
                                            progressNumber: level.progress
                                        )
                                    }
                                }
                                .padding(.horizontal, 20)
                                
                                // Chapters list
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Chapters")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(Color(hex: "#1B2534"))
                                        .padding(.horizontal, 20)
                                    
                                    VStack(spacing: 12) {
                                        ForEach(level.lessons) { lesson in
                                            NavigationLink {
                                                LessonPage(
                                                    lesson: lesson,
                                                    accent: level.accent,
                                                    stageId: level.type.rawValue.lowercased()
                                                )
                                            } label: {
                                                ReusableCard(
                                                    icon: "book",
                                                    title: lesson.title,
                                                    finished: "\(lesson.objectivesCount) Topics",
                                                    status: lesson.status
                                                )
                                            }
                                            .buttonStyle(.plain)
                                            .disabled(lesson.status.lowercased() == "locked")
                                        }
                                    }
                                }
                                .padding(.bottom, 20)
                                .padding(.horizontal, 20)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                        }
                    }
                    .padding(.top, 10)
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .scrollDismissesKeyboard(.interactively)
        .task {
            await loadData()
        }
    }
    
    private func loadData() async {
        loading = true
        do {
            let stageDTOs = try await LearningService.shared.fetchStages()
            let currentPos = try? await LearningService.shared.fetchCurrentPosition()
            
            var loadedLevels: [LearningLevel] = []
            
            for (index, dto) in stageDTOs.enumerated() {
                let ui = levelUI[dto.id] ?? ("Unknown", "N/A", [Color(hex: "#EAFDEF"), Color.black], Color.gray)
                let chapters = try await LearningService.shared.fetchChapters(stageId: dto.id)
                
                let lessons = chapters.map { ch in
                    LessonItem(
                        backendId: ch.id ?? "",
                        title: ch.title,
                        paragraph: "",
                        objectivesCount: ch.topicCount ?? 0,
                        status: ch.status ?? "locked",
                        duration: "10 min"
                    )
                }
                
                let levelObj = LearningLevel(
                    type: LearningLevel.LevelType(rawValue: dto.id.capitalized) ?? .beginner,
                    title: ui.title,
                    duration: ui.duration,
                    gradient: ui.gradient,
                    accent: ui.accent,
                    progress: Float(dto.progress ?? 0.0),
                    lessons: lessons,
                    status: dto.status
                )
                loadedLevels.append(levelObj)
                
                // Auto-select the stage from currentPosition
                if let currentPos = currentPos, currentPos.stageId == dto.id {
                    self.selectedIndex = index
                }
            }
            
            withAnimation(.easeInOut) {
                levels = loadedLevels
                loading = false
            }
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return
            }
            print("Failed to load levels: \(error)")
            loading = false
        }
    }
}

#Preview {
    NavigationStack {
        LearnView()
    }
}
