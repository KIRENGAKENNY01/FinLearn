import SwiftUI



struct ReusableCard: View {
    let icon:String
    let title:String
    let finished:String
    let status:String
    
    
    private var statusColor: Color {
            switch status.lowercased() {
            case "completed", "finished":
                return Color(hex: "#72BF00")  // Green
            case "ongoing", "in progress":
                return Color(hex: "#FFC107")  // Amber
            case "not yet", "not started":
                return Color(hex: "#2196F3")  // Blue
            default:
                return Color.gray             // Fallback
            }
        }
    
    var body: some View {
        
        HStack(){
            HStack(alignment:.center, spacing:20 ) {
                ZStack {
                    
                    Circle()
                        .fill(Color(hex: "#01312D"))
                        .frame(width: 50, height: 50)
                    
                    
                    Image(icon)
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
                    
                    HStack(spacing:2){
                        Text(finished)
                            .font(.system(size: 12 , weight:.light ))
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        
                        HStack(spacing:8){
                            Circle()
                                .fill(statusColor)
                                .frame(width:8 , height:8)
                            Text(status)
                                .font(.system(size:12, weight:.light))
                                .foregroundColor(Color(hex:"#1B2534"))
                               
                        }.frame(width:90 , height:15)
                    }
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
                .fill(
                    (status.lowercased() == "completed" || status.lowercased() == "finished")
                    ? Color(hex: "#D6FDA3")
                    : Color(hex: "#FFFFFF").opacity(0.5)
                )
        )
        
        
    }
}


struct ViewReusable: View {
 
    var body: some View {
        VStack {
            ReusableCard(icon:"book" ,title:"Introduction to Financial Literacy",finished:"4 topics", status:"Completed")
        }
        
    }
}


#Preview {
    ViewReusable()
}

