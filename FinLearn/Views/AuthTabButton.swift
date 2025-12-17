import SwiftUI

struct AuthTabButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(title)
                .font(.system(size: 16 , weight: .semibold))
                .foregroundStyle(isActive ? Color(hex:"#72BF00"):Color(hex:"#1B2534"))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    isActive ? Color(hex:"EAFDEF"): Color.clear
                )
                .cornerRadius(8)
        }
    }
}
