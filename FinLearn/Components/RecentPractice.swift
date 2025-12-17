
import SwiftUI


struct RecentPractice:View {
    let title: String
    let  progress: Float
    let status: String
    
    
    
    
    var body:some View {
        HStack(alignment:.center, spacing:48) {
            VStack(alignment:.leading,spacing:12) {
                HStack(spacing:8) {
                    ZStack {
                        
                        Circle()
                            .fill(Color(hex: "#D6FDA3"))
                            .frame(width: 30, height: 30)
                        
                       
                        Image("flash")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(hex: "#A2ACBD"))
                            .frame(width: 20, height: 20)
                           
                    }
                    .frame(width: 35, height: 35)
                    
                    Text("Recent Practice")
                        .font(.system(size: 12 , weight: .light ))
                             
     
                }
                
               
                Text(title)
                    .font(.system(size: 18 , weight: .bold ))
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)

                NavigationLink(destination: LearnView()) {
                    RippleButton(title:"See more", width:100 , height:30,size:12)
                    
                }
            }
        
            VStack(alignment:.center ,spacing:5){
                
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color(hex: "#1B2534"))
                
                HStack(spacing:8){
                    Circle()
                        .fill(Color(hex:"#72BF00"))
                        .frame(width:8 , height:8)
                    Text(status)
                        .font(.system(size:12, weight:.light))
                        .foregroundColor(Color(hex:"#1B2534"))
                }.frame(width:58 , height:15)
                
                
            }
          
        }
        .padding(24)
        .frame(maxWidth:340, minHeight: 180, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius:20)
                .fill(Color(hex:"#FFFFFF").opacity(0.5))
        )
       

        
        
       
        
        
    }
    
}





struct ViewPractice: View {
 
    var body: some View {
        VStack {
            RecentPractice(title:"Introduction to Financial Literacy",progress:0.6, status:"Good")
        }
        
    }
}


#Preview {
    ViewPractice()
}
