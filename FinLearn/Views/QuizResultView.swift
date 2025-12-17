
import SwiftUI

struct QuizResultView: View {
    let score: Int
    let total: Int
    let questions: [Question]
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Success Image (Placeholder system icon or asset)
            Image(systemName: "trophy.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundColor(Color(hex: "#FFD700")) // Gold
            
            Text(score > total / 2 ? "Congratulations!" : "Good Effort!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color(hex: "#01312D"))
            
            Text("You scored \(score) out of \(total)")
                .font(.title2)
                .foregroundColor(.gray)
            
            Spacer()
            
            // Buttons
            VStack(spacing: 16) {
                NavigationLink(destination: QuizCorrectionView(questions: questions)) {
                    Text("Review Corrections")
                        .bold()
                        .foregroundColor(Color(hex: "#01312D"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(hex: "#01312D"), lineWidth: 1)
                        )
                }
                
                // Usually direct navigation back or close
                // Since this is inside QuizQuestionView's ZStack, we might need a way to exit.
                // For now, simple "Done" usually pops navigation.
            }
            .padding()
            .padding(.bottom, 20)
        }
        .padding()
        .background(Color(hex: "#EAFDEF"))
    }
}
