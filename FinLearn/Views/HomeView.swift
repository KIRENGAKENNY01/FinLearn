import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack{
            Color(hex:"#EAFDEF")
                .ignoresSafeArea()
            ScrollView(showsIndicators: false){
                Header(firstName: "Kenny")

                    VStack() {
                        PercentageCard(title:"You learning Progress",subhead:"Beginner",progressNumber:0.6)
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
        }
    }
}
#Preview {
    HomeView()
}

