
import SwiftUI

struct LockedStageView: View {
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // 404/Error Image
                Image("error")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .padding(.top, 40)
                
                // Text Content
                VStack(spacing: 16) {
                    Text("You haven’t reached this stage")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(hex: "#01312D"))
                        .multilineTextAlignment(.center)
                    
                    Text("You need to be first proven as driver for a Transport service")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LockedStageView()
    }
}
