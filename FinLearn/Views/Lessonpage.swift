import SwiftUI

struct LessonPage: View {
    let lesson: LessonItem
    let accent: Color
    
    // Placeholder topics per lesson (replace with backend data)
    private var topics: [LearningObjective] {
        [
            LearningObjective(title: "Why financial literacy matters in everyday life", description: "Learn the core definition and why it matters for everyday decisions."),
            LearningObjective(title: "Income, Expenses, Savings, and Investments", description: "Connect financial skills to real-world outcomes like saving and spending."),
            LearningObjective(title: "Common financial myths and realities", description: "Spot common pitfalls and how to avoid them.")
        ]
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text(lesson.title)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text(lesson.paragraph)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Topics")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        Spacer()
                        Text("\(lesson.objectivesCount) Topics")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                    }
                    
                    LazyVStack(spacing: 14) {
                        ForEach(topics) { topic in
                            NavigationLink {
                                ObjectivePage(
                                    lesson: lesson,
                                    accent: accent
                                )
                            } label: {
                                ReusableCard(
                                    icon: "book",
                                    title: topic.title,
                                    finished: "\(lesson.objectivesCount) objectives",
                                    status: lesson.status
                                )
                            }
                            .buttonStyle(.plain)
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
    }
}

#Preview {
    NavigationStack {
        LessonPage(
            lesson: LessonItem(
                title: "Why financial literacy matters in everyday life",
                paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.",
                objectivesCount: 4,
                status: "Completed",
                duration: "15 min"
            ),
            accent: Color(hex: "#72BF00")
        )
    }
}
