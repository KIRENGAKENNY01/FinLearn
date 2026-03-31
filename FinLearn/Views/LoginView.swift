import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email =  ""
    @State private var password = ""
 
    
    var body: some View {
        
            VStack(spacing:49) {
                VStack(spacing: 8) {
                    Text("Welcome Back!")
                        .appFont(AppTypography.largeTitle)
                        .foregroundColor(.textColor)
                    Text("Provide your credentials")
                        .appFont(AppTypography.body)
                        .foregroundColor(.textColor.opacity(0.7))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 20)
                
            
                VStack(spacing:48){
                    VStack(spacing:24){
                        FormInput(
                            icon:"user",
                            title:"Email",
                            text:$email
                        )
                        FormInput(
                            icon:"lock",
                            title:"Password",
                            text:$password,
                            isSecure: true
                        )
                        
                    }
                    
                    RippleButton(title: "Login", width: 150, height: 50, size: 18) {
                        appState.login(email: email, password: password)
                    }
                }
               
            }
            .padding()
            .frame(maxWidth: .infinity , maxHeight:.infinity , alignment:.top)
            .onTapGesture { hideKeyboard() }
            .alert(item: Binding(
                get: { appState.errorMessage.map { ErrorWrapper(error: $0) } },
                set: { _ in appState.errorMessage = nil }
            )) { wrapper in
                Alert(title: Text("Error"), message: Text(wrapper.error), dismissButton: .default(Text("OK")))
            }
    }
    

}
#Preview{
    LoginView()
        .environmentObject(AppState())
}
