import SwiftUI

struct LearningLevel: Identifiable {
    enum LevelType: String {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
    }
    
    let id = UUID()
    let type: LevelType
    let title: String
   
    let duration: String
    let gradient: [Color]
    let accent: Color
    let progress: Float
    let lessons: [LessonItem]
    let status: String
}

struct LessonItem: Identifiable {
    let id = UUID()
    let backendId: String
    let title: String
    let paragraph: String
    let objectivesCount: Int
    let status: String
    let duration: String
}

enum CompletionStatus: String, Codable {
    case locked
    case notStarted
    case ongoing
    case completed
}

struct LearningObjective: Identifiable {
    let id: UUID
    let backendId: String
    let title: String
    let description: String
    let status: CompletionStatus?
    
    init(id: UUID = UUID(), backendId: String = "", title: String, description: String, status: CompletionStatus? = nil) {
        self.id = id
        self.backendId = backendId
        self.title = title
        self.description = description
        self.status = status
    }
}

// MARK: - Cards

struct LevelCard: View {
    let level: LearningLevel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(colors: level.gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(level.type.rawValue)
                        .appFont(AppTypography.headline)
                        .foregroundColor(.textColor)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                    
                    Spacer()
                    
                    Text(level.duration)
                        .appFont(AppTypography.footnote)
                        .foregroundColor(.textColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                }
                
                Text(level.title)
                    .appFont(AppTypography.title1)
                    .foregroundColor(.textColor)
                    .fixedSize(horizontal: false, vertical: true)
                
           
                
                Spacer()
                
                HStack {
                    Label("\(level.lessons.count) lessons", systemImage: "book.fill")
                        .appFont(AppTypography.subhead)
                        .foregroundColor(.textColor)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.textColor)
                }
                .padding(.top, 8)
            }
            .padding(18)
        }
        .frame(maxWidth: .infinity, minHeight: 180)
        .shadow(color: level.accent.opacity(0.15), radius: 12, x: 0, y: 8)
    }
}

struct LessonCard: View {
    let lesson: LessonItem
    let accent: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(accent.opacity(0.15))
                    .frame(width: 46, height: 46)
                Image("book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(accent)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(lesson.title)
                    .appFont(AppTypography.headline)
                    .foregroundColor(.textColor)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("\(lesson.objectivesCount) objectives • \(lesson.duration)")
                    .appFont(AppTypography.footnote)
                    .foregroundColor(.textColor.opacity(0.7))
            }
            
            Spacer()
            
            Text(lesson.status)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(accent)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(accent.opacity(0.15))
                .cornerRadius(12)
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color(hex: "#1B2534").opacity(0.5))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct ObjectiveCard: View {
    let objective: LearningObjective
    let accent: Color
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(accent.opacity(0.15))
                    .frame(width: 46, height: 46)
                Image("mission")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(objective.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(hex: "#1B2534"))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(objective.description)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#1B2534").opacity(0.7))
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color(hex: "#1B2534").opacity(0.5))
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}

struct ToolCard: View {
    let title: String
    let description: String
    let imageName: String
    let accent: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Spacer()
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
            }
            
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color(hex: "#1B2534"))
            
            Text(description)
                .font(.system(size: 13))
                .foregroundColor(Color(hex: "#1B2534").opacity(0.7))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(accent.opacity(0.12))
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(accent.opacity(0.3), lineWidth: 1)
        )
    }
}

struct LeaderboardRow: View {
    let rank: Int
    let name: String
    let progress: Double
    let accent: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Text("#\(rank)")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(accent)
                .frame(width: 36, height: 36)
                .background(accent.opacity(0.15))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(hex: "#1B2534"))
                
                ProgressView(value: progress)
                    .progressViewStyle(.linear)
                    .tint(accent)
            }
            
            Spacer()
            
            Text("\(Int(progress * 100))%")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(accent)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 3)
    }
}

#Preview("Level Card") {
    LevelCard(
        level: LearningLevel(
            type: .beginner,
            title: "Foundation of Financial Literacy",
            duration: "2-3 hrs",
            gradient: [Color(hex: "#EAFDEF"), Color(hex: "#C8F7B9")],
            accent: Color(hex: "#72BF00"),
            progress: Float(0.2),
            lessons: [],
            status: "ongoing"
        )
    )
    .padding()
    .background(Color(hex: "#EAFDEF"))
}


