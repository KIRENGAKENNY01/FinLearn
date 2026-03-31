import SwiftUI

struct FormInput: View {
    let icon: String
    let title: String
    @Binding var text: String
    
    // Set this to true when you use it for password
    var isSecure: Bool = false
    
    // State to toggle password visibility
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(icon)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(hex: "#A2ACBD"))
                .frame(width: 24, height: 24)
                .padding(.top, 6)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(hex: "#1B2534"))
                
                ZStack(alignment: .trailing) {
                    if isSecure && !isPasswordVisible {
                        SecureField("", text: $text, prompt: Text("Write here...").foregroundColor(Color(hex: "#A2ACBD")))
                            .padding(.vertical, 4)
                            .foregroundColor(.textColor)
                    } else {
                        TextField("", text: $text, prompt: Text("Write here...").foregroundColor(Color(hex: "#A2ACBD")))
                            .padding(.vertical, 4)
                            .foregroundColor(.textColor)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    if isSecure {
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color(hex: "#A2ACBD"))
                                .padding(.trailing, 8)
                        }
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .frame(maxWidth: 400)
        .frame(height: 72)
    }
}
