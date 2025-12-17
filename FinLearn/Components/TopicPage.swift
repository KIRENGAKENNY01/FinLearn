import SwiftUI



struct TopicPage: View {
    let title:String

    
    
    var body: some View {
        
        HStack(){
            HStack(alignment:.center, spacing:20 ) {
                ZStack {
                    
                    Circle()
                        .fill(Color(hex: "#01312D"))
                        .frame(width: 50, height: 50)
                    
                    
                    Image("coins")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(Color(hex:"#FFFFFF"))
                        .frame(width: 30, height: 30)
                    
                }
                .frame(width: 35, height: 35)
                
                VStack(alignment:.leading  ,spacing:5){
                    Text(title)
                        .font(.system(size: 14 , weight:.bold ))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
            }
            
            Spacer()
            
            Image("chevron")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            
            
            
        }
        .padding(24)
        .frame(maxWidth:340, minHeight: 100, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius:20)
                .fill(Color(hex:"#FFFFFF").opacity(0.5))
        )
        
        
    }
}


struct ViewTopicPage: View {
 
    var body: some View {
        VStack {
            TopicPage(title:"Introduction to Financial Literacy")
        }
        
    }
}


#Preview {
    ViewTopicPage()
}


