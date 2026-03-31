import SwiftUI

struct Signup: View {
    @EnvironmentObject var appState: AppState
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        
        VStack(spacing:49){
            
            VStack(spacing: 8) {
                Text("Get Started!")
                    .appFont(AppTypography.largeTitle)
                    .foregroundColor(.textColor)
                Text("Let us start your journey")
                    .appFont(AppTypography.body)
                    .foregroundColor(.textColor.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 20)
            
            
            VStack(spacing:48) {
                
                VStack(spacing:24){
                    FormInput(
                        icon:"user",
                        title:"Full name",
                        text:$name
                    )
                    
                    FormInput(
                        icon:"email",
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
                
                RippleButton(title: "Register", width: 150, height: 50, size: 18) {
                    appState.signup(name: name, email: email, password: password)
                }
                
                
            }
            
            
            
        }
        .padding()
        .frame(maxWidth:.infinity , maxHeight:.infinity , alignment:.top)
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
    Signup()
        .environmentObject(AppState())
}
