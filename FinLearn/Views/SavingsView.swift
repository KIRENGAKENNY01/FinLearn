
import SwiftUI

struct SavingsView: View {
    let history = [
        ("January", "10,000 Rwf", "Medium", Color.orange),
        ("February", "1,900 Rwf", "Good", Color.green),
        ("March", "5,000 Rwf", "Bad", Color.red),
        ("April", "4,000 Rwf", "Medium", Color.orange),
        ("May", "6,000 Rwf", "Good", Color.green)
    ]
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Header
                    VStack(spacing: 8) {
                        Text("11 NOV - 11 DEC 2025")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#01312D"))
                        Text("This Month")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.top)
                    
                    // Main Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Savings")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        Text("500,000 RWF")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color(hex: "#01312D"))
                        
                        Divider()
                            .background(Color.black)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Income")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("500,000 RWF")
                                    .font(.headline)
                                    .foregroundColor(Color(hex: "#01312D"))
                            }
                            
                            Spacer()
                            // Vertical Separator
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: 1, height: 40)
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Expense")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("500,000 RWF")
                                    .font(.headline)
                                    .foregroundColor(Color(hex: "#01312D"))
                            }
                        }
                    }
                    .padding(24)
                    .background(Color(hex: "#DDFEC5")) // Light lime green
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // Follow Up Card
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Follow up")
                                .font(.headline)
                                .foregroundColor(Color(hex: "#01312D"))
                            
                            Text("Check if you savings goal this month was met")
                                .font(.caption)
                                .foregroundColor(Color(hex: "#01312D"))
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Button(action: {}) {
                                Text("Check")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 10)
                                    .background(Color(hex: "#72BF00"))
                                    .cornerRadius(20)
                            }
                        }
                        
                        Spacer()
                        
                        // Illustration Placeholder (Coins/Person)
                        Image("rafiki") // Using existing asset
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    }
                    .padding(24)
                    .background(Color(hex: "#DDFEC5"))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // History Header
                    HStack {
                        Text("Savings history")
                            .font(.headline)
                            .foregroundColor(Color(hex: "#01312D"))
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // List Table Header
                    HStack {
                        Text("Month").bold()
                        Spacer()
                        Text("Savings").bold()
                        Spacer()
                        Text("Status").bold()
                    }
                    .padding()
                    .background(Color(hex: "#01312D"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    // History Rows
                    ForEach(history, id: \.0) { item in
                        HStack {
                            Text(item.0)
                                .foregroundColor(Color(hex: "#01312D"))
                            Spacer()
                            Text(item.1)
                                .bold()
                                .foregroundColor(Color(hex: "#01312D"))
                            Spacer()
                            Text(item.2)
                                .font(.caption)
                                .foregroundColor(item.3)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(item.3.opacity(0.2))
                                .cornerRadius(10)
                        }
                        .padding()
                        .background(Color(hex: "#FFFBE6"))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 50)
                }
            }
        }
        .navigationTitle("Saving tool")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SavingsView()
    }
}
