
import SwiftUI

struct LoanView: View {
    @State private var amount: Double = 500000
    @State private var interestRate: Double = 5.0
    @State private var months: Double = 12
    
    var monthlyPayment: Double {
        let p = amount
        let r = (interestRate / 100) / 12
        let n = months
        if r == 0 { return p / n }
        let numerator = p * r * pow((1 + r), n)
        let denominator = pow((1 + r), n) - 1
        return numerator / denominator
    }
    
    var totalPayment: Double {
        return monthlyPayment * months
    }
    
    var totalInterest: Double {
        return totalPayment - amount
    }
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Header
                    HStack {
                        Text("Loan Calculator")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color(hex: "#01312D"))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    // CARD 1: INPUTS
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Loan Details")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        VStack(alignment: .leading) {
                            Text("Amount: \(Int(amount)) RWF")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Slider(value: $amount, in: 10000...5000000, step: 10000)
                                .accentColor(Color(hex: "#72BF00"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Interest: \(String(format: "%.1f", interestRate))%")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Slider(value: $interestRate, in: 1...20, step: 0.5)
                                .accentColor(Color(hex: "#72BF00"))
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Duration: \(Int(months)) Months")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Slider(value: $months, in: 1...60, step: 1)
                                .accentColor(Color(hex: "#72BF00"))
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    // CARD 2: MONTHLY PAYMENT (Visual Highlight)
                    VStack(spacing: 10) {
                        Text("Monthly Payment")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#01312D").opacity(0.8))
                        
                        Text("\(Int(monthlyPayment)) RWF")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        Text("For \(Int(months)) months")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(32)
                    .background(
                        ZStack {
                            Color(hex: "#DDFEC5") // Light Lime
                            // Optional: Add card2 image as overlay if purely decorative
                            // Image("cards2").resizable().scaledToFit().opacity(0.1)
                        }
                    )
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    // CARD 3: BREAKDOWN
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total Payment")
                                .foregroundColor(Color(hex: "#01312D"))
                            Spacer()
                            Text("\(Int(totalPayment)) RWF")
                                .bold()
                                .foregroundColor(Color(hex: "#01312D"))
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Total Interest")
                                .foregroundColor(Color(hex: "#01312D"))
                            Spacer()
                            Text("\(Int(totalInterest)) RWF")
                                .bold()
                                .foregroundColor(Color.orange)
                        }
                        
                        Divider()
                        
                        Button(action: {
                            // Apply action
                        }) {
                            Text("Apply for Loan")
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#72BF00"))
                                .cornerRadius(15)
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LoanView()
    }
}
