import SwiftUI

struct AuthView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack{
            Color(hex:"#EAFDEF")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Header Buttons
                HStack {
                    AuthTabButton(
                        title:"Sign in",
                        isActive: appState.currentAuthTab == .login
                    ){
                        appState.currentAuthTab = .login
                    }
                    
                    AuthTabButton(
                        title:"Signup",
                        isActive: appState.currentAuthTab == .signup
                    ){
                        appState.currentAuthTab = .signup
                    }
                }
                .padding(.vertical, 7)
                .padding(.horizontal ,10)
                .frame(width:300 , height:49)
                .background(Color.white)
                .cornerRadius(12)
                
               
                
          
                
                VStack{
                    if appState.currentAuthTab == .login {
                        LoginView()
                            .padding(.top,38)
                    }
                    if appState.currentAuthTab == .signup {
                        Signup()
                            .padding(.top,38)
                    }
                }
            }
        }
    }
}


#Preview {
    AuthView()
        .environmentObject(AppState())
}
