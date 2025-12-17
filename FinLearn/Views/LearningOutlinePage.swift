
import SwiftUI

struct LearningOutlinePage: View {
    let objective: LearningObjective
    let accent: Color
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Illustration
                    HStack {
                        Spacer()
                        Image("intro_illustration") // Placeholder for the mountain/person image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                        Spacer()
                    }
                    .padding(.top)
                    
                    // Title
                    Text("Course Title: Why Financial Literacy Matters in Everyday Life")
                        .font(.title2)
                        .bold() // Sansita bold typically
                        .foregroundColor(Color(hex: "#01312D"))
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
                            .foregroundColor(Color(hex: "#01312D"))
                    }
                    
                    // Content Sections
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // Section 1
                        VStack(alignment: .leading, spacing: 8) {
                            Text("1. What is Financial Literacy?")
                                .font(.headline)
                                .underline()
                                .foregroundColor(Color(hex: "#01312D"))
                            
                            Text("Financial literacy means having the knowledge and skills to manage money effectively.")
                                .font(.body)
                                .foregroundColor(Color(hex: "#01312D").opacity(0.8))
                            
                            Text("The five key areas: earning, spending, saving, investing, and protecting money.")
                                .font(.body)
                                .foregroundColor(Color(hex: "#01312D").opacity(0.8))
                        }
                        
                        // Section 2 (Scenario)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("A planner earning RWF 500,000 ends the month with over RWF 210,000 left plus RWF 25,000 saved, feeling relaxed and ready for the next month. The non-planner spends everything by week three, borrows RWF 50,000, and finishes broke, stressed, and in debt.")
                                .font(.body)
                                .foregroundColor(Color(hex: "#01312D").opacity(0.8))
                                .padding(.vertical, 8)
                        }
                        
                        // Takeaway
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Takeaway:")
                                .font(.headline)
                                .underline()
                                .foregroundColor(Color(hex: "#01312D"))
                            
                            Text("Financial literacy is not about being rich, it's about making informed choices with the money you have.")
                                .font(.body)
                                .foregroundColor(Color(hex: "#01312D").opacity(0.8))
                        }
                    }
                    
                    Spacer(minLength: 40)
                    
                    // Completed Button
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
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
        }
        .navigationBarBackButtonHidden(false) // Standard back button is fine, or custom if requested
    }
}

