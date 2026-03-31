import SwiftUI
import Combine

/// AppState manages the overall application navigation and authentication state
/// Follows MVVM pattern - this is the ViewModel layer
@MainActor
class AppState: ObservableObject {
    /// Current navigation route
    @Published var currentRoute: AppRoute = .welcome
    
    /// Authentication state
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    
    /// User Profile (Single Source of Truth)
    @Published var currentUser: UserProfile?
    
    /// Derived property for Level (Compatibility)
    var userLevel: String {
        currentUser?.currentLevel.rawValue ?? "Beginner"
    }
    
    // Services
    let authService: AuthServiceProtocol
    let databaseService: DatabaseServiceProtocol
    
    /// Navigation routes in the app
    enum AppRoute {
        case welcome
        case auth
        case mainTabs
    }
    
    /// Auth Screen Tabs
    enum AuthTab {
        case login
        case signup
    }
    
    @Published var currentAuthTab: AuthTab = .login
    
    init(authService: AuthServiceProtocol = FirebaseAuthService(),
         databaseService: DatabaseServiceProtocol = APIDatabaseService()) {
        self.authService = authService
        self.databaseService = databaseService
        
        checkAuthenticationStatus()
    }
    
    /// Check if user is already authenticated
    private func checkAuthenticationStatus() {
        if let user = authService.currentUser {
            self.currentUser = user
            self.isAuthenticated = true
            self.currentRoute = .mainTabs
            Task { try? await self.databaseService.syncUser(user: user) }
        } else {
            self.isAuthenticated = false
            self.currentUser = nil
            self.currentRoute = .welcome
        }
    }
    
    /// Handle login
    func login(email: String, password: String) {
        errorMessage = nil
        Task {
            do {
                try await authService.signIn(email: email, password: password)
                
                // Manually update state on success
                if let user = authService.currentUser {
                    await MainActor.run {
                        self.currentUser = user
                        self.isAuthenticated = true
                        self.currentRoute = .mainTabs
                        // Trigger sync
                        Task { try? await self.databaseService.syncUser(user: user) }
                    }
                }
            } catch {
                print("Auth Error: \(error)")
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    /// Handle signup
    func signup(name: String, email: String, password: String) {
        errorMessage = nil
        Task {
            do {
                try await authService.signUp(name: name, email: email, password: password)
                
                // Prevent auto-login, force user to login manually
                authService.signOut()
                
                await MainActor.run {
                    self.currentAuthTab = .login
                    self.errorMessage = "Account created! Please log in." // Using error message for feedback for now
                }
            } catch {
                print("Signup Error: \(error)")
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    /// Navigate to auth screen
    func showAuth() {
        currentRoute = .auth
        currentAuthTab = .login
    }

    /// Handle logout
    func logout() {
        authService.signOut()
        isAuthenticated = false
        currentUser = nil
        currentRoute = .welcome
        currentAuthTab = .login
    }
}

