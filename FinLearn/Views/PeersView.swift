import SwiftUI

struct PeersView: View {
    @State private var selectedTab: String = "Progress"
    
    var body: some View {
        ZStack {
            Color(hex: "#EAFDEF")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    
                    // 1. Header Section
                    PeerHeaderView()
                    
                    // 2. Personal Progress Section
                    PersonalProgressSection()
                    
                    // 3. Learning Journey Section
                    LearningJourneySection()
                    
                    // 4. Tools Usage Section
                    ToolsUsageSection()
                    
                    // 5. Achievements Section
                    AchievementsSection()
                    
                    // 6. Community Pulse Section
                    CommunityPulseSection()
                    
                }
                .padding(.bottom, 40)
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

// MARK: - 1. Header Section
struct PeerHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Progress")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
                
                Text("Your growth & community momentum")
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: "#01312D").opacity(0.7))
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {}) {
                    Image(systemName: "bell.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color(hex: "#01312D"))
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

// MARK: - 2. Personal Progress Section
struct PersonalProgressSection: View {
    var body: some View {
        VStack(spacing: 16) {
            
            // Stats Cards
            HStack(spacing: 12) {
                ProgressStatCard(title: "Streak", value: "7 Days", icon: "flame.fill", color: "#FFC107")
                ProgressStatCard(title: "Topics", value: "12/30", icon: "checkmark.circle.fill", color: "#72BF00")
                ProgressStatCard(title: "Level", value: "Smart Saver", icon: "star.fill", color: "#2196F3")
            }
            .padding(.horizontal)
            
            // Overall Progress Bar
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Overall Completion")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color(hex: "#01312D"))
                    Spacer()
                    Text("40%")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color(hex: "#72BF00"))
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(hex: "#D6FDA3").opacity(0.5))
                            .frame(height: 12)
                        
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(hex: "#72BF00"))
                            .frame(width: geometry.size.width * 0.4, height: 12)
                    }
                }
                .frame(height: 12)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal)
        }
    }
}

struct ProgressStatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(Color(hex: color))
                    .padding(8)
                    .background(Color(hex: color).opacity(0.15))
                    .clipShape(Circle())
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Text(title)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
    }
}

// MARK: - 3. Learning Journey Section
struct LearningJourneySection: View {
    let topics = [
        TopicModel(title: "Budgeting Basics", progress: 1.0, status: "Completed"),
        TopicModel(title: "Saving Money", progress: 0.6, status: "In Progress"),
        TopicModel(title: "Loans & Interest", progress: 0.0, status: "Not Started")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Learning Journey")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(hex: "#01312D"))
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(spacing: 12) {
                ForEach(topics) { topic in
                    TopicRow(topic: topic)
                }
                
                Button(action: {}) {
                    Text("Continue Learning")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#01312D"))
                        .cornerRadius(16)
                }
                .padding(.top, 8)
            }
            .padding(.horizontal)
        }
    }
}

struct TopicModel: Identifiable {
    let id = UUID()
    let title: String
    let progress: Double
    let status: String
}

struct TopicRow: View {
    let topic: TopicModel
    
    var statusColor: Color {
        switch topic.status {
        case "Completed": return Color(hex: "#72BF00")
        case "In Progress": return Color(hex: "#FFC107")
        default: return Color(hex: "#E0E0E0")
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .stroke(Color(hex: "#E0E0E0"), lineWidth: 4)
                    .frame(width: 40, height: 40)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(topic.progress.isFinite ? min(max(topic.progress, 0.0), 1.0) : 0.0))
                    .stroke(Color(hex: "#72BF00"), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 40, height: 40)
                
                Text("\(Int(topic.progress * 100))%")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(topic.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(hex: "#01312D"))
                
                Text(topic.status)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
    }
}

// MARK: - 4. Tools Usage Section
struct ToolsUsageSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Tools Usage")
                .font(.title2)
                .bold()
                .foregroundColor(Color(hex: "#01312D"))
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ToolUsageCard(title: "Budget Planner", usage: "3 Budgets Created", icon: "chart.pie.fill", color: "#FFC107")
                    ToolUsageCard(title: "Savings Tracker", usage: "$500 Saved", icon: "banknote.fill", color: "#72BF00")
                    ToolUsageCard(title: "Loan Calculator", usage: "Used 5 times", icon: "building.columns.fill", color: "#2196F3")
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ToolUsageCard: View {
    let title: String
    let usage: String
    let icon: String
    let color: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Circle()
                .fill(Color(hex: color).opacity(0.2))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(Color(hex: color))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
                
                Text(usage)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(16)
        .frame(width: 160)
        .background(Color.white)
        .cornerRadius(20)
    }
}

// MARK: - 5. Achievements Section
struct AchievementsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Achievements")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(hex: "#01312D"))
                Spacer()
                ButtonButtonArrowView()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    AchievementBadge(title: "First Budget", icon: "pencil.and.outline", isUnlocked: true)
                    AchievementBadge(title: "7-Day Streak", icon: "flame.fill", isUnlocked: true)
                    AchievementBadge(title: "Debt Free", icon: "lock.fill", isUnlocked: false)
                    AchievementBadge(title: "Savings Pro", icon: "lock.fill", isUnlocked: false)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct AchievementBadge: View {
    let title: String
    let icon: String
    let isUnlocked: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(isUnlocked ? Color(hex: "#D6FDA3") : Color.gray.opacity(0.1))
                    .frame(width: 70, height: 70)
                
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(isUnlocked ? Color(hex: "#01312D") : Color.gray)
            }
            
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "#01312D"))
        }
        .opacity(isUnlocked ? 1 : 0.6)
    }
}

// MARK: - 6. Community Pulse Section (Leaderboard)
struct CommunityPulseSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Leaderboard")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(hex: "#01312D"))
                Spacer()
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Text("View All")
                            .font(.subheadline)
                            .bold()
                        Image(systemName: "arrow.right")
                            .font(.caption)
                    }
                    .foregroundColor(Color(hex: "#72BF00"))
                }
            }
            .padding(.horizontal)
            
            // Top 3 Podium
            HStack(alignment: .bottom, spacing: 16) {
                Spacer()
                // 2nd Place
                PodiumView(rank: 2, name: "Masuma", points: 1490, image: "person.crop.circle.fill", color: "#FFC107") // Using Amber for contrast or secondary green
                    .offset(y: 20)
                
                // 1st Place
                PodiumView(rank: 1, name: "Hasan", points: 1800, image: "crown.fill", color: "#72BF00", isFirst: true)
                    .zIndex(1)
                
                // 3rd Place
                PodiumView(rank: 3, name: "Tanim", points: 1205, image: "person.crop.circle", color: "#2196F3") // Using Blue for contrast
                    .offset(y: 30)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            // List for others
            VStack(spacing: 12) {
                PeersLeaderboardRow(rank: 4, name: "Sadia Afrin", points: 1000)
                PeersLeaderboardRow(rank: 5, name: "Rejaul Karim", points: 900)
                PeersLeaderboardRow(rank: 6, name: "You", points: 720, isMe: true)
            }
            .padding(.horizontal)
        }
    }
}

struct PodiumView: View {
    let rank: Int
    let name: String
    let points: Int
    let image: String
    let color: String
    var isFirst: Bool = false
    
    var body: some View {
        VStack(spacing: 8) {
            // Crown for 1st
            if isFirst {
                Image(systemName: "crown.fill")
                    .foregroundColor(Color(hex: "#FFC107"))
                    .font(.system(size: 24))
                    .padding(.bottom, -10)
            }
            
            // Avatar with Ring
            ZStack {
                Circle()
                    .stroke(Color(hex: color), lineWidth: 3)
                    .background(Circle().fill(Color.white))
                    .frame(width: isFirst ? 80 : 60, height: isFirst ? 80 : 60)
                
                Image(systemName: image.contains("crown") ? "person.fill" : image) // Fallback for demo
                    .resizable()
                    .scaledToFit()
                    .frame(width: isFirst ? 40 : 30, height: isFirst ? 40 : 30)
                    .foregroundColor(Color(hex: "#01312D"))
                
                // Rank Badge
                VStack {
                    Spacer()
                    Text("\(rank)")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .background(Color(hex: color))
                        .clipShape(Circle())
                        .offset(y: 10)
                }
            }
            .frame(width: isFirst ? 80 : 60, height: isFirst ? 80 + 10 : 60 + 10)
            
            // Name & Points
            VStack(spacing: 2) {
                Text(name)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
                    .lineLimit(1)
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 11))
                        .foregroundColor(Color(hex: "#FFC107"))
                    Text("\(points)")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(width: 90) // Fixed width for alignment
    }
}

struct PeersLeaderboardRow: View {
    let rank: Int
    let name: String
    let points: Int
    var isMe: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(rank)")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(isMe ? .white : .gray)
                .frame(width: 24)
            
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 32, height: 32)
                    .overlay(Image(systemName: "person.fill").font(.caption).foregroundColor(.gray))
                
                Text(name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(isMe ? .white : Color(hex: "#01312D"))
                
                if isMe {
                    Text("(YOU)")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            
            Spacer()
            
            Text("\(points) pts")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(isMe ? .white : Color(hex: "#01312D"))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isMe ? Color(hex: "#01312D") : Color.white)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct ButtonButtonArrowView: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .font(.caption)
            .foregroundColor(Color(hex: "#01312D"))
    }
}

#Preview {
    PeersView()
}
