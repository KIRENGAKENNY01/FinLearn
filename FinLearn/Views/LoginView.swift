import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email =  ""
    @State private var password = ""
 
    
    var body: some View {
        
            VStack(spacing:49) {
                VStack(alignment:.leading , spacing:8){
                    Text("Welcome Back!")
                        .font(.system(size: 30 , weight: .bold ))
                    Text("Provide your credentials")
                }
                .frame(maxWidth:.infinity , alignment:.leading)
                .padding(.horizontal , 20)
                
            
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
                            text:$password
                        )
                        
                    }
                    
                    Button(action: {
                        // TODO: Add actual login logic here
                        // For now, just authenticate
                        appState.authenticate()
                    }) {
                        RippleButton(title:"Login", width:150 , height:50,size:18)
                    }
                }
               
            }
            .padding()
            .frame(maxWidth: .infinity , maxHeight:.infinity , alignment:.top)
    }
    

}
#Preview{
    LoginView()
        .environmentObject(AppState())
}
