
import SwiftUI

struct Header:View {
    let  firstName: String
    
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                Text("Hello")
                    .font(.system(size:24 ,weight:.light))
                HStack(){
                    Text(firstName)
                        .font(.system(size:24 ,weight:.bold))
                    Image("hy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                
            }
             Spacer()
            
            HStack(spacing:8){
                Image("person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height:40)
                
                NotificationIcon {
                                    // Navigate or show sheet
                                    print("Opening notifications...")
                                    // Example: push with NavigationLink programmatically
                                    // or present sheet
                                }
                
            }
           
        }
        .padding(32)
        
    }

}



struct ViewHeader: View {
 
    var body: some View {
        VStack {
         Header(firstName:"Kenny")
        }
        
    }
}


#Preview {
    ViewHeader()
}


