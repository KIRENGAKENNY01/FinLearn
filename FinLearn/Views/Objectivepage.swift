import SwiftUI

struct ObjectivePage: View {
    let lesson: LessonItem
    let accent: Color
    
    private let objectives: [LearningObjective] = [
        LearningObjective(title: "Understand what financial literacy means", description: "Learn the core definition and why it matters for everyday decisions."),
        LearningObjective(title: "Explain why financial knowledge is essential in daily life.", description: "Connect financial skills to real-world outcomes like saving and spending."),
        LearningObjective(title: "Recognize the impact of poor financial decisions.", description: "Spot common pitfalls and how to avoid them."),
        LearningObjective(title: "Identify simple ways to start improving financial literacy today.", description: "Actionable steps you can take immediately.")
    ]
    
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
                    Text("Course Title:")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                    
                    Text(lesson.title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
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
                            .font(.system(size: 14 , weight: .light ))
                                 
         
                    }
                    
                    PercentageCard(title:"Completion of Course Objective",subhead:"Beginner",progressNumber:0.6 )

                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Learning Objectives")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    LazyVStack(spacing: 12) {
                        ForEach(objectives) { objective in
                            NavigationLink {
                                LearningOutlinePage(objective: objective, accent: accent)
                            } label: {
                                ObjectiveCard(objective: objective, accent: accent)
                            }
                            .buttonStyle(.plain)
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
    }
}

private struct ProgressRing: View {
    let progress: Double
    let accent: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(accent.opacity(0.15), lineWidth: 12)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(accent, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            VStack(spacing: 4) {
                Text("Completion")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(hex: "#01312D"))
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(accent)
            }
        }
    }
}

#Preview{
    NavigationStack {
        ObjectivePage(
            lesson: LessonItem(title: "Why financial literacy matters in everyday life", paragraph:"Why financial literacy matters in everyday life" , objectivesCount: 4, status: "In Progress", duration: "15 min"),
            accent: Color(hex: "#72BF00")
        )
    }
}
