
import SwiftUI

struct QuizQuestionView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int? = nil
    @State private var score = 0
    @State private var showResult = false
    
    // Mock Questions
    let questions = [
        Question(
            text: "What is the 50/30/20 rule?",
            options: [
                "50% needs, 30% wants, 20% savings",
                "50% savings, 30% needs, 20% wants",
                "50% wants, 30% savings, 20% needs",
                "None of the above"
            ],
            correctAnswerIndex: 0
        ),
        Question(
            text: "Which of these is a fixed expense?",
            options: ["Groceries", "Rent", "Dining Out", "Entertainment"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What is compound interest?",
            options: [
                "Interest on principal only",
                "Interest on principal and accumulated interest",
                "Free money from the bank",
                "A fee for saving money"
            ],
            correctAnswerIndex: 1
        )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#EAFDEF")
                    .ignoresSafeArea()
                
                if showResult {
                    QuizResultView(score: score, total: questions.count, questions: questions)
                } else {
                    VStack(spacing: 24) {
                        // Progress
                        ProgressView(value: Double(currentQuestionIndex + 1), total: Double(questions.count))
                            .tint(Color(hex: "#72BF00"))
                            .padding(.horizontal)
                            .padding(.top)
                        
                        Text("Question \(currentQuestionIndex + 1)/\(questions.count)")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        // Question Card
                        Text(questions[currentQuestionIndex].text)
                            .font(.title3)
                            .bold()
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(hex: "#01312D"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        
                        // Options
                        VStack(spacing: 12) {
                            ForEach(0..<4) { index in
                                Button(action: {
                                    selectedAnswerIndex = index
                                }) {
                                    HStack {
                                        Text(questions[currentQuestionIndex].options[index])
                                            .foregroundColor(Color(hex: "#01312D"))
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                        if selectedAnswerIndex == index {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(Color(hex: "#72BF00"))
                                        } else {
                                            Image(systemName: "circle")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(selectedAnswerIndex == index ? Color(hex: "#72BF00") : Color.clear, lineWidth: 2)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        // Next Button
                        Button(action: {
                            submitAnswer()
                        }) {
                            Text(currentQuestionIndex == questions.count - 1 ? "Finish" : "Next")
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedAnswerIndex == nil ? Color.gray : Color(hex: "#72BF00"))
                                .cornerRadius(15)
                        }
                        .disabled(selectedAnswerIndex == nil)
                        .padding()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func submitAnswer() {
        if let selected = selectedAnswerIndex {
            if selected == questions[currentQuestionIndex].correctAnswerIndex {
                score += 1
            }
            
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                selectedAnswerIndex = nil
            } else {
                showResult = true
            }
        }
    }
}

struct Question {
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
}

#Preview {
    QuizQuestionView()
}
