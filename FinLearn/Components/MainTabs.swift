import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case home, learn, tools, peers, settings
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .learn: return "Learn"
        case .tools: return "Tools"
        case .peers: return "Peers"
        case .settings: return "Settings"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "home"
        case .learn: return "learn"
        case .tools: return "tools"
        case .peers: return "peers"
        case .settings: return "settings"
        }
    }
}

struct MainTabs: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.verticalSizeClass) var vSizeClass
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        if sizeClass == .regular || vSizeClass == .compact {
            // iPad or iPhone Landscape -> Sidebar
            NavigationSplitView {
                sidebarView
            } detail: {
                NavigationStack {
                    destinationView(for: selectedTab)
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .navigationSplitViewStyle(.balanced)
        } else {
            // iPhone Portrait -> Bottom Tabs
            TabView(selection: $selectedTab) {
                ForEach(AppTab.allCases) { tab in
                    NavigationStack {
                        destinationView(for: tab)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .tag(tab)
                    .tabItem {
                        Label(tab.title, image: tab.icon)
                    }
                }
            }
            .tint(Color(hex: "#72BF00"))
        }
    }
    
    var sidebarView: some View {
        ZStack {
            Color(hex: "#01312D").ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                // Logo Area
                HStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Text("FinLearn")
                        .appFont(AppTypography.title1)
                        .foregroundColor(.white)
                }
                .padding(.top, 40)
                .padding(.horizontal, 20)
                
                // Navigation Items
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(AppTab.allCases) { tab in
                        Button(action: { selectedTab = tab }) {
                            HStack(spacing: 16) {
                                Image(tab.icon)
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: vSizeClass == .compact ? 20 : 24, height: vSizeClass == .compact ? 20 : 24)
                                    .foregroundColor(selectedTab == tab ? Color(hex: "#72BF00") : .white)
                                
                                Text(tab.title)
                                    .appFont(AppTypography.headline)
                                    .foregroundColor(selectedTab == tab ? Color(hex: "#72BF00") : .white)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, vSizeClass == .compact ? 8 : 12)
                            .background(selectedTab == tab ? Color.white.opacity(0.1) : Color.clear)
                            .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 12)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private func destinationView(for tab: AppTab) -> some View {
        switch tab {
        case .home:
            HomeView()
        case .learn:
            LearnView()
        case .tools:
            ToolsView()
        case .peers:
            PeersView()
        case .settings:
            SettingsView()
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