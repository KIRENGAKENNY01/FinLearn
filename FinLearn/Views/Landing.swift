import SwiftUI

struct LandingView:View{
    @EnvironmentObject var appState: AppState
    
    var body: some View{
        ZStack{
            Color(hex:"#EAFDEF")
                .ignoresSafeArea()
            VStack(spacing: 16){
             Spacer()
            
                //logo
            Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width:90 , height:90)
            //App title
                Text("FinLearn")
                    .font(Font.custom("Sansita-Bold", size: 34))
                    .foregroundColor(Color(hex:"#1B2534"))
                
                //Subtitle
                Text("Your personal guide to \n Financial Freedom.")
                    .font(.system(size:17))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: "#1B2534").opacity(0.7))
                
                Spacer()

                RippleButton(title: "Get started", width: 308, height: 55, size: 17) {
                    appState.showAuth()
                }
                .padding(.horizontal, 32)
            }
        }
    }
}

#Preview {
    LandingView()
        .environmentObject(AppState())
}

