

import SwiftUI

struct CircularProgressBar: View {
    
    @Binding var progress:Float
    var body:some View {
        ZStack{
            
            
            Circle()
                .stroke(
                    Color(hex:"#72BF00").opacity(0.2),
                    lineWidth:18.0
                )
    
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress.isFinite ? min(max(Double(progress), 0.0), 1.0) : 0.0))
                .stroke(style:StrokeStyle(lineWidth:16.0, lineCap:.round, lineJoin:.round))
                .foregroundColor(Color(hex:"#72BF00"))
                .rotationEffect(Angle(degrees:270))
                .animation(.smooth(duration:1.8), value:progress)
    
            Text("\(Int(progress * 100))%")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color(hex: "#1B2534"))
                            .background(
                                Circle()
                                    .fill(Color(hex: "#F4FFC7"))
                                    .frame(width: 75, height: 75)
                            )
        }.frame(width: 102, height: 100)  // Perfect fixed size
        
     
        
    }
    
}


struct ViewProgress: View {
    @State  var progressValue: Float = 0.0
    
    
    var body: some View {
        VStack {
            CircularProgressBar(progress: self.$progressValue)
                .frame(width:102, height:100)
                .padding(20.0).onAppear(){
                    self.progressValue = 0.50
                }
        }
        
    }
}
#Preview {
    ViewProgress()
}
