import SwiftUI

struct LearningOutlinePage: View {
    @State var objective: LearningObjective
    let accent: Color
    @State var stageId: String
    @State var chapterId: String
    @State var topicId: String
    
    @State private var lesson: LessonDTO?
    @State private var loading: Bool = true
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            if loading {
                VStack {
                    ProgressView("Loading content...")
                    Text("Fetching your next lesson...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
            } else if let lesson = lesson {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Illustration
                        HStack {
                            Spacer()
                            Image("MoneyMotivation") 
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                            Spacer()
                        }
                        .padding(.top)
                        
                        // Title
                        Text(lesson.title)
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color(hex: "#1B2534"))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        // Outline Header
                        HStack {
                            Image(systemName: "note.text")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(hex: "#DDFEC5"))
                                .padding(8)
                                .background(Color(hex: "#DDFEC5"))
                                .clipShape(Circle())
                            
                            Text("Learning Outline")
                                .font(.headline)
                                .bold()
                                .foregroundColor(Color(hex: "#1B2534"))
                        }
                        
                        // Content Sections
                        VStack(alignment: .leading, spacing: 24) {
                            
                            // Paragraph
                            Text(lesson.paragraph)
                                .font(.body)
                                .foregroundColor(Color(hex: "#1B2534").opacity(0.8))
                            
                            // Takeaway
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Takeaway:")
                                    .font(.headline)
                                    .underline()
                                    .foregroundColor(Color(hex: "#1B2534"))
                                
                                Text(lesson.keyTakeaway)
                                    .font(.body)
                                    .foregroundColor(Color(hex: "#1B2534").opacity(0.8))
                            }
                        }
                        
                        Spacer(minLength: 40)
                        
                        // Completed Button
                        Button(action: {
                            Task {
                                await completeAndNext()
                            }
                        }) {
                            Text("Completed")
                                .font(.headline)
                                .bold()
                                .foregroundColor(Color(hex: "#72BF00"))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#DDFEC5"))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(hex: "#72BF00"), lineWidth: 1)
                                )
                        }
                        .padding(.bottom, 40)
                    }
                    .padding(24)
                }
                .scrollDismissesKeyboard(.interactively)
            } else {
                VStack {
                    Text("Content not found.")
                    Button("Retry") {
                        Task { await loadLesson() }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(false)
        .task {
            await loadLesson()
        }
    }
    
    private func loadLesson() async {
        loading = true
        do {
            let lessons = try await LearningService.shared.fetchLessons(
                stageId: stageId,
                chapterId: chapterId,
                topicId: topicId,
                objectiveId: objective.backendId
            )
            lesson = lessons.first
            loading = false
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return
            }
            print("Failed to load lesson content: \(error)")
            loading = false
        }
    }

    private func completeAndNext() async {
        loading = true
        do {
            // 1. Mark current as complete
            try await LearningService.shared.markObjectiveComplete(objectiveId: objective.backendId)
            
            // 2. Dismiss back to previous page
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to complete objective: \(error)")
            presentationMode.wrappedValue.dismiss()
        }
    }
}
