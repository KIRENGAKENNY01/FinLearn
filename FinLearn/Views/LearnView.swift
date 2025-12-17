import SwiftUI

struct LearnView: View {
    private let levels: [LearningLevel] = [
        LearningLevel(
            type: .beginner,
            title: "Foundation of Financial Literacy",
            
            duration: "45-60 min",
            gradient: [Color(hex: "#EAFDEF"), Color(hex: "#D6FDA3")],
            accent: Color(hex: "#72BF00"),
            progress: Float(0.2),
            lessons: [
                LessonItem(title: "Why financial literacy matters in everyday life",paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.", objectivesCount: 4, status: "In Progress", duration: "15 min"),
                LessonItem(title: "What is saving?",paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.", objectivesCount: 3, status: "Not started", duration: "12 min"),
                LessonItem(title: "Understanding bank accounts",paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.", objectivesCount: 4, status: "Not started", duration: "10 min")
            ]
        ),
        LearningLevel(
            type: .intermediate,
            title: "Managing Credit & Borrowing",
          
            duration: "60-90 min",
            gradient: [Color(hex: "#EAFDEF"), Color(hex: "#C8F7B9")],
            accent: Color(hex: "#30A46C"),
            progress: Float(0.35),
            lessons: [
                LessonItem(title: "Understanding credit and loans",paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.", objectivesCount: 5, status: "Not started", duration: "18 min"),
                LessonItem(title: "Building a credit score",paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.", objectivesCount: 4, status: "Not started", duration: "14 min"),
                LessonItem(title: "Debt repayment strategies",paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.", objectivesCount: 4, status: "Not started", duration: "20 min")
            ]
        ),
        LearningLevel(
            type: .advanced,
            title: "Investing & Wealth Building",
            duration: "90-120 min",
            gradient: [Color(hex: "#EAFDEF"), Color(hex: "#BFF3A3")],
            accent: Color(hex: "#1E8C4A"),
            progress: Float(0.2),
            lessons: [
                LessonItem(title: "Investing fundamentals",paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.", objectivesCount: 5, status: "Not started", duration: "22 min"),
                LessonItem(title: "Diversification and risk",paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.", objectivesCount: 4, status: "Not started", duration: "16 min"),
                LessonItem(title: "Retirement & long-term planning",paragraph: "Learn what financial literacy means and why it’s essential for your future. Understand the basics of earning, spending, saving, and investing money wisely.", objectivesCount: 5, status: "Not started", duration: "24 min")
            ]
        )
    ]
    
    @State private var selectedIndex: Int = 0
    private var selectedLevel: LearningLevel { levels[selectedIndex] }
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
            Header(firstName:"Kenny")
                  
                    
                    // Level pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Array(levels.enumerated()), id: \.offset) { idx, level in
                                Button {
                                    selectedIndex = idx
                                } label: {
                                    Text(level.type.rawValue)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(selectedIndex == idx ? .white : Color(hex: "#01312D"))
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
                    
                    // Progress card using PercentageCard
                    VStack(alignment: .leading, spacing: 12) {

                   HStack {

                            
                            PercentageCard(
                                title:selectedLevel.title ,
                                subhead:selectedLevel.type.rawValue,
                                progressNumber: selectedLevel.progress
                            )
                        }
                    }
                    .padding(.horizontal, 20)

                    
                    // Chapters list
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Chapters")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 12) {
                            ForEach(selectedLevel.lessons) { lesson in
                                NavigationLink {
                                    LessonPage(lesson: lesson, accent: selectedLevel.accent)
                                } label: {
                                    ReusableCard(
                                        icon: "book",
                                        title: lesson.title,
                                        finished: "\(lesson.objectivesCount) Topics",
                                        status: lesson.status
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                }
                .padding(.top, 10)
            }
        }
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview{
    NavigationStack {
        LearnView()
    }
}
