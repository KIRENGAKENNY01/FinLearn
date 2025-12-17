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
}

struct LessonItem: Identifiable {
    let id = UUID()
    let title: String
    let paragraph: String
    let objectivesCount: Int
    let status: String
    let duration: String
}

struct LearningObjective: Identifiable {
    let id = UUID()
    let title: String
    let description: String
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
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(hex: "#01312D"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                    
                    Spacer()
                    
                    Text(level.duration)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(hex: "#01312D"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                }
                
                Text(level.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(hex: "#01312D"))
                    .fixedSize(horizontal: false, vertical: true)
                
           
                
                Spacer()
                
                HStack {
                    Label("\(level.lessons.count) lessons", systemImage: "book.fill")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color(hex: "#01312D"))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(hex: "#01312D"))
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
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#01312D"))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("\(lesson.objectivesCount) objectives • \(lesson.duration)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(lesson.status)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(accent)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(accent.opacity(0.15))
                .cornerRadius(12)
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
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
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#01312D"))
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(objective.description)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
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
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(hex: "#01312D"))
            
            Text(description)
                .font(.system(size: 13))
                .foregroundColor(.gray)
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
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(accent)
                .frame(width: 36, height: 36)
                .background(accent.opacity(0.15))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#01312D"))
                
                ProgressView(value: progress)
                    .progressViewStyle(.linear)
                    .tint(accent)
            }
            
            Spacer()
            
            Text("\(Int(progress * 100))%")
                .font(.system(size: 14, weight: .semibold))
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
            lessons: []
        )
    )
    .padding()
    .background(Color(hex: "#EAFDEF"))
}


