import SwiftUI



struct ReusableCard: View {
    let icon:String
    let title:String
    let finished:String
    let status:String
    
    
    private var isLocked: Bool {
        status.lowercased() == "locked"
    }
    
    private var isCompleted: Bool {
        status.lowercased() == "completed" || status.lowercased() == "finished"
    }
    
    private var statusColor: Color {
        switch status.lowercased() {
        case "completed", "finished": return Color(hex: "#72BF00")
        case "ongoing", "in progress": return Color(hex: "#FFD700")
        case "locked": return Color.gray
        default: return Color.gray
        }
    }

    var body: some View {
        HStack(){
            HStack(alignment:.center, spacing:20 ) {
                ZStack {
                    Circle()
                        .fill(isLocked ? Color.gray.opacity(0.3) : Color(hex: "#1B2534"))
                        .frame(width: 50, height: 50)
                    
                    Image(isLocked ? "lock.fill" : icon) 
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .foregroundColor(isLocked ? .gray : Color(hex:"#FFFFFF"))
                        .frame(width: 25, height: 25)
                }
                .frame(width: 35, height: 35)
                
                VStack(alignment:.leading  ,spacing:5){
                    Text(title)
                        .font(.system(size: 17 , weight:.bold ))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(isLocked ? .gray : Color(hex: "#1B2534"))
                    
                    if !finished.isEmpty || !status.isEmpty {
                        HStack(spacing:2){
                            Text(isLocked ? "Locked" : finished)
                                .font(.system(size: 13 , weight: .light ))
                                .foregroundColor(isLocked ? .gray : Color(hex: "#1B2534"))
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            if !isLocked {
                                HStack(spacing:8){
                                    Circle()
                                        .fill(statusColor)
                                        .frame(width:8 , height:8)
                                    Text(status)
                                        .font(.system(size:13, weight:.light))
                                        .foregroundColor(Color(hex:"#1B2534"))
                                }.frame(width:90 , height:15)
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            if !isLocked {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.black)
            } else {
                Image(systemName: "lock.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius:20)
                .fill(
                    isCompleted ? Color(hex: "#D6FDA3") : (isLocked ? Color.white : Color(hex: "#F2FCEC"))
                )
                .shadow(color: Color.black.opacity(isLocked ? 0.05 : 0), radius: 5, x: 0, y: 2)
        )
        .animation(.spring(), value: status)
        .contentShape(Rectangle())
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

