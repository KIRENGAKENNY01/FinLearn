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
    
    init(authService: AuthServiceProtocol = MockAuthService(),
         databaseService: DatabaseServiceProtocol = MockDatabaseService()) {
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
        } else {
            self.isAuthenticated = false
            self.currentUser = nil
            self.currentRoute = .welcome
        }
    }
    
    /// Navigate to welcome screen
    func showWelcome() {
        currentRoute = .welcome
        isAuthenticated = false
        currentUser = nil
        authService.signOut()
    }
    
    /// Navigate to auth screen
    func showAuth() {
        currentRoute = .auth
    }
    
    /// Handle successful login/signup
    func authenticate() {
        Task {
            do {
                try await authService.signIn()
                if let user = authService.currentUser {
                    self.currentUser = user
                    self.isAuthenticated = true
                    self.currentRoute = .mainTabs
                }
            } catch {
                print("Auth Error: \(error)")
            }
        }
    }
    
    /// Handle logout
    func logout() {
        authService.signOut()
        isAuthenticated = false
        currentUser = nil
        currentRoute = .welcome
    }
}

