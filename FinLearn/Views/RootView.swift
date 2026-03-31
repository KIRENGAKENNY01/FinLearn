import SwiftUI

/// RootView is the main entry point that switches between auth flow and main app
struct RootView: View {
    @StateObject private var appState = AppState() // Defaults to MockAuthService and MockDatabaseService
    
    var body: some View {
        Group {
            switch appState.currentRoute {
            case .welcome:
                NavigationStack {
                    LandingView()
                        .environmentObject(appState)
                }
                
            case .auth:
                NavigationStack {
                    AuthView()
                        .environmentObject(appState)
                }
                
            case .mainTabs:
                MainTabs()
                    .environmentObject(appState)
            }
        }
        .animation(.easeInOut, value: appState.currentRoute)
    }
}

#Preview("Welcome") {
    RootView()
}

#Preview("Authenticated") {
    let appState = AppState(authService: MockAuthService(), databaseService: MockDatabaseService())
    appState.login(email: "kenny@example.com", password: "password")
    return MainTabs()
        .environmentObject(appState)
}

