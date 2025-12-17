

import SwiftUI


struct PercentageCard: View {
    let title: String
    let subhead: String
    let  progressNumber: Float
    
    var body: some View {
        HStack(spacing:20){
        
            VStack(alignment:.leading,spacing:16){
                HStack(spacing:8){
                    Circle()
                        .fill(Color(hex:"#72BF00"))
                        .frame(width:8 , height:8)
                    Text(subhead)
                        .font(.system(size:12, weight:.light))
                        .foregroundColor(Color(hex:"#1B2534"))
                }.frame(width:92 , height:30)
                    .background(
                        RoundedRectangle(cornerRadius:20)
                            .fill(Color(hex:"#72BF00").opacity(0.1))
                    )
                  
                    
                  
                Text(title)
                    .font(.system(size:20 , weight:.bold))
                    .foregroundColor(Color(hex:"#1B2534"))
            }
            Spacer()
            CircularProgressBar(progress:.constant(progressNumber))
                .frame(width:80, height:80)
        }
        .padding(24)
        .frame(width:340)
        .frame(height:158)
        .background(
            RoundedRectangle(cornerRadius:20)
                .fill(Color(hex:"#C3FE58").opacity(0.5))
            
        )
        
    }
}



struct ViewCard: View {
    
    
    
    var body: some View {
        VStack {
            PercentageCard(title:"You learning Progress",subhead:"Beginner",progressNumber:0.6 )
        }
        
    }
}
#Preview {
    ViewCard()
}
