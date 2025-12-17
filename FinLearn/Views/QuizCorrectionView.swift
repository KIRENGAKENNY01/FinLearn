
import SwiftUI

struct QuizCorrectionView: View {
    let questions: [Question]
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("Corrections")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(hex: "#01312D"))
                        .padding(.top)
                    
                    ForEach(0..<questions.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Q\(index + 1): \(questions[index].text)")
                                .font(.headline)
                                .foregroundColor(Color(hex: "#01312D"))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(0..<questions[index].options.count, id: \.self) { optIndex in
                                    HStack {
                                        Text(questions[index].options[optIndex])
                                            .font(.subheadline)
                                            .foregroundColor(
                                                optIndex == questions[index].correctAnswerIndex ? .white : .black
                                            )
                                        Spacer()
                                        if optIndex == questions[index].correctAnswerIndex {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .padding()
                                    .background(
                                        optIndex == questions[index].correctAnswerIndex ? Color(hex: "#72BF00") : Color.white
                                    )
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 40)
                }
            }
        }
        .navigationTitle("Review")
        .navigationBarTitleDisplayMode(.inline)
    }
}
