import SwiftUI

struct MainTabs:View {
  
    init(){
        let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(hex: "#01312D"))
        
        // Active icon + text color
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(hex:"#72BF00")
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                    .foregroundColor: UIColor(hex:"#72BF00")
                ]
                
                // Inactive icon + text color
                appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                    .foregroundColor: UIColor.white
                ]
                
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
                UITabBar.appearance().tintColor = .white
    }
    
    var body:some View {
        

        TabView(){
            NavigationStack {
                HomeView()
            }
            .tabItem { tabIcon("home", title: "Home", isSelected: false)}
            
            NavigationStack {
                LearnView()
            }
            .tabItem { tabIcon("learn", title: "Learn", isSelected: false)}
            
            NavigationStack {
                ToolsView()
            }
            .tabItem { tabIcon("tools", title: "Tools", isSelected: false)}
            
            NavigationStack {
                PeersView()
            }
            .tabItem { tabIcon("peers", title: "Peers", isSelected: false)}
            
            NavigationStack {
                SettingsView()
            }
            .tabItem { tabIcon("settings", title: "Settings", isSelected: false)}
            
                                                                                          
        }
        .tint(Color(hex: "#72BF00"))                    // Active = your green
                .onAppear {
                    UITabBar.appearance().unselectedItemTintColor = UIColor(Color.white)
                }
        
    }
    
    // Reusable tab icon with automatic active/inactive color
        @ViewBuilder
        private func tabIcon(_ name: String, title: String, isSelected: Bool) -> some View {
            Label {
                Text(title)
                    .font(.system(size: 11, weight: .medium))
            } icon: {
                Image(name)
                    .renderingMode(.template)
            }
        }
    }
    
    
    




#Preview{
    MainTabs()
        .environmentObject(AppState())
}