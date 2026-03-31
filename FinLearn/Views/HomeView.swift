import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var globalProgress: Double = 0.0
    @State private var loading: Bool = true
    
    var body: some View {
        ZStack{
            Color(hex:"#EAFDEF")
                .ignoresSafeArea()
            
            if loading {
                ProgressView()
            } else {
                ScrollView(showsIndicators: false){
                    VStack(spacing: sizeClass == .regular ? 40 : 20) {
                        Header(firstName: "Kenny")
                        
                        PercentageCard(title:"Your Learning Progress", subhead:"All Levels", progressNumber: Float(globalProgress))
                        
                        if sizeClass == .regular {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 40) {
                                NavigationLink(destination: LearnView()) {
                                    CurrentChapter(title:"Introduction to Financial Literacy", paragraph:"Financial Literacy builds wealth and security")
                                        .frame(maxWidth: .infinity, minHeight: 180, alignment: .leading)
                                        .background(
                                            RoundedRectangle(cornerRadius:20)
                                                .fill(Color(hex:"#FFFFFF").opacity(0.5))
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                NavigationLink(destination: QuizView()) {
                                    RecentPractice(title:"Introduction to Financial Literacy",progress:0.6, status:"Good")
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        } else {
                            NavigationLink(destination: LearnView()) {
                                CurrentChapter(title:"Introduction to Financial Literacy", paragraph:"Financial Literacy builds wealth and security")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            NavigationLink(destination: QuizView()) {
                                RecentPractice(title:"Introduction to Financial Literacy",progress:0.6, status:"Good")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(sizeClass == .regular ? 40 : 20)
                }
            }
        }
        .task {
            await loadProgress()
        }
    }
    
    private func loadProgress() async {
        loading = true
        do {
            let stages = try await LearningService.shared.fetchStages()
            // Calculate global average of stage progress
            let totalProgress = stages.compactMap { $0.progress }.reduce(0, +)
            self.globalProgress = stages.isEmpty ? 0 : totalProgress / Double(stages.count)
            loading = false
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                return
            }
            print("Failed to load global progress: \(error)")
            loading = false
        }
    }
}
#Preview {
    HomeView()
}

