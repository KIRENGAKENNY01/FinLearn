import SwiftUI



struct Advanced: View {
    
    let lessons = [
        Lesson(icon: "book", title: "Introduction to Budgeting", finished: "2/5 Completed", status: "In Progress"),
        Lesson(icon: "book", title: "What is Saving?", finished: "4/4 Completed", status: "Finished"),
        Lesson(icon: "book", title: "Understanding Bank Accounts", finished: "0/6 Completed", status: "Not Started"),
        Lesson(icon: "book", title: "Basic Investing Concepts", finished: "1/8 Completed", status: "In Progress"),
        Lesson(icon: "book", title: "Emergency Funds 101", finished: "3/10 Completed", status: "In Progress"),
        Lesson(icon: "book", title: "Needs vs Wants", finished: "0/4 Completed", status: "Not Started"),
        Lesson(icon: "book", title: "Needs vs Wants", finished: "0/4 Completed", status: "Not Started"),
        Lesson(icon: "book", title: "Needs vs Wants", finished: "0/4 Completed", status: "Not Started"),
        Lesson(icon: "book", title: "Needs vs Wants", finished: "0/4 Completed", status: "Not Started"),
        Lesson(icon: "book", title: "Needs vs Wants", finished: "0/4 Completed", status: "Not Started"),
        Lesson(icon: "book", title: "Needs vs Wants", finished: "0/4 Completed", status: "Not Started")
        
 
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 32) {
                
                
              
                
                // Top Progress Card (fixed at the top of the scroll)
                PercentageCard(title: "Introduction to Investment",
                               subhead: "Advanced",
                               progressNumber: 0.6)
                    .padding(.horizontal, 20)
         
                                HStack {
                                    Text("Chapters")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundStyle(Color(hex: "#1B2534"))
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 40)
                                .padding(.top, 10)
                
                // List of Lesson Cards
                LazyVStack(spacing: 16) {
                    
                    ForEach(lessons) { lesson in
                        ReusableCard(
                            icon: lesson.icon,
                            title: lesson.title,
                            finished: lesson.finished,
                            status: lesson.status
                        )
                        .onTapGesture {
                            print("Tapped: \(lesson.title)")
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                // Optional: Add extra bottom padding so last card isn't stuck to edge
                Spacer()
                    .frame(height: 100)
            }
            .padding(.top, 20)
        }
        .background(Color(hex: "#EAFDEF")) // Match your app background
        .ignoresSafeArea(edges: .bottom)    // Optional: for full bleed
    }
}



#Preview{
    Advanced()
}



