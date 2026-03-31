 import SwiftUI

struct CurrentChapter:View {
    let title: String
    let paragraph: String
    
    
    var body:some View {
        HStack(alignment:.top, spacing:2) {
            VStack(alignment:.leading,spacing:16) {
                HStack(spacing:8) {
                    ZStack {
                        
                        Circle()
                            .fill(Color(hex: "#D6FDA3"))
                            .frame(width: 35, height: 35)
                        
                       
                        Image("flash")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(hex: "#A2ACBD"))
                            .frame(width: 20, height: 20)
                           
                    }
                    .frame(width: 35, height: 35)
                    
                    Text("Current Chapter")
                        .font(.system(size: 13 , weight: .light ))
                        .foregroundColor(.textColor)
                             
     
                }
                
               
                Text(title)
                    .font(.system(size: 17 , weight: .bold ))
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.textColor)
                 Text(paragraph)
                    .font(.system(size:17))
                    .foregroundColor(.textColor)
                
                NavigationLink(destination: LearnView()) {
                    RippleButton(title:"Continue", width:100 , height:30,size:13)
                    
                }
            }
            
            
            Image("Learning")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
          
        }
        .padding(24)
        
       
        
        
    }
    
}




struct ViewCurrent: View {
 
    var body: some View {
        VStack {
            CurrentChapter(title:"Introduction to Financial Literacy", paragraph:"Financial Literacy builds wealth and security")
        }
        
    }
}


#Preview {
ViewCurrent()
}
