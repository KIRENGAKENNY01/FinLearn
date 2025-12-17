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
                    .font(Font.custom("Sansita-Bold", size: 32))
                    .foregroundColor(Color(hex:"#01312D"))
                
                //Subtitle
                Text("Your personal guide to \n Financial Freedom.")
                    .font(.system(size:16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                
                Spacer()

                Button(action: {
                    appState.showAuth()
                }) {
                    RippleButton(title:"Get started", width:308 , height:55, size:18)
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

