import SwiftUI

struct AuthView: View {
    @EnvironmentObject var appState: AppState
    enum Tab {case login , signup}
    @State private var selectedTab: Tab = .login
    
    var body: some View {
        ZStack{
            Color(hex:"#EAFDEF")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Header Buttons
                HStack {
                    AuthTabButton(
                        title:"Sign in",
                        isActive: selectedTab == .login
                    ){
                        selectedTab = .login
                    }
                    
                    AuthTabButton(
                        title:"Signup",
                        isActive: selectedTab == .signup
                    ){
                        selectedTab = .signup
                    }
                }
                .padding(.vertical, 7)
                .padding(.horizontal ,10)
                .frame(width:300 , height:49)
                .background(Color.white)
                .cornerRadius(12)
                
               
                
          
                
                VStack{
                    if selectedTab == .login {
                        LoginView()
                            .padding(.top,38)
                    }
                    if selectedTab == .signup {
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
