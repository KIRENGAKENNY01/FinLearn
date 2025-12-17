import SwiftUI

struct Signup: View {
    @EnvironmentObject var appState: AppState
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""

    
    var body: some View {
            
            VStack(spacing:49){
                
                VStack(alignment:.leading , spacing:8){
                    Text("Get Started!")
                        .font(.system(size: 30 , weight: .bold ))
                    Text("Let us start your journey")
                }
                .frame(maxWidth:.infinity , alignment:.leading)
                .padding(.horizontal , 20)
                
                
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
                            title:"password",
                            text:$password
                        )
                        
                        
                    }
                   
                    Button(action: {
                        // TODO: Add actual signup logic here
                        // After successful signup, navigate to login or authenticate directly
                        // For now, just authenticate
                        appState.authenticate()
                    }) {
                        RippleButton(title:"Register", width:150 , height:50,size:18)
                    }

                    
                }
                
                
            
            }
            .padding()
            .frame(maxWidth:.infinity , maxHeight:.infinity , alignment:.top)
        
        
    }
}


#Preview{
    Signup()
        .environmentObject(AppState())
}
