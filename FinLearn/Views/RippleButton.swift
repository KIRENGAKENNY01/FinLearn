import SwiftUI

struct RippleButton: View {
    var title:String
    var width:CGFloat
    var height:CGFloat
    var size:CGFloat
    @State  private var animateCircle = false
    
    var body: some View {
            ZStack{
                ZStack{
                    Color(hex:"#72BF00")
                    
                    Circle()
                        .fill(Color(hex:"#01312D"))
                        .scaleEffect(animateCircle ? 3.0:0.01)
                }
                Text(title)
                    .font(.system(size:size, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(width:width, height:height)
            .clipShape(RoundedRectangle(cornerRadius: 100))

        .simultaneousGesture(
            DragGesture(minimumDistance:0)
                .onChanged{ _ in
                    withAnimation(.easeOut(duration: 0.4)){
                        animateCircle = true
                    }
                }
                .onEnded{ _ in
                    withAnimation(.easeOut(duration: 0.4)) {
                        animateCircle = false
                    }
                }
                    
        )
    }
}
 
