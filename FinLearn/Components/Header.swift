
import SwiftUI

struct Header:View {
    let  firstName: String
    
    var body: some View {
        HStack(){
            VStack(alignment: .leading) {
                Text("Hello")
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(Color(hex: "#1B2534"))
                HStack {
                    Text(firstName)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(hex: "#1B2534"))
                    Image("hy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
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


