
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Profile Header
                    HStack(spacing: 16) {
                        Image("Profile") // Assuming Profile asset or fallback
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 5)
                            .overlay(
                                Image(systemName: "person.circle.fill") // Fallback
                                    .resizable()
                                    .foregroundColor(.gray)
                                    .opacity(0.5) // Only visible if Profile asset missing logic (not implemented here but visual fallback handled by system if image missing)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Kenny")
                                .font(.title2)
                                .bold()
                                .foregroundColor(Color(hex: "#01312D"))
                            Text("Premium Member")
                                .font(.caption)
                                .foregroundColor(Color(hex: "#72BF00"))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(Color(hex: "#72BF00").opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Button("Edit") {
                            // Edit Profile
                        }
                        .foregroundColor(Color(hex: "#01312D"))
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    // Groups
                    VStack(spacing: 20) {
                        
                        // General
                        SettingsGroup(title: "General") {
                            SettingsRow(icon: "bell", title: "Notifications", showToggle: true)
                            Divider()
                            SettingsRow(icon: "lock", title: "Privacy & Security")
                            Divider()
                            SettingsRow(icon: "globe", title: "Language", value: "English")
                        }
                        
                        // Support
                        SettingsGroup(title: "Support") {
                            SettingsRow(icon: "questionmark.circle", title: "Help Center")
                            Divider()
                            SettingsRow(icon: "envelope", title: "Contact Us")
                        }
                        
                        // Actions
                        Button(action: {
                            appState.logout()
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.square")
                                Text("Log Out")
                            }
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(15)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
    }
}

struct SettingsGroup<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal, 24)
            
            VStack(spacing: 0) {
                content
            }
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal)
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    var value: String? = nil
    var showToggle: Bool = false
    @State private var isToggled: Bool = true
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(Color(hex: "#01312D"))
                .frame(width: 24)
            
            Text(title)
                .foregroundColor(Color(hex: "#01312D"))
            
            Spacer()
            
            if showToggle {
                Toggle("", isOn: $isToggled)
                    .labelsHidden()
                    .tint(Color(hex: "#72BF00"))
            } else if let val = value {
                Text(val)
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            } else {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        .padding()
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}

