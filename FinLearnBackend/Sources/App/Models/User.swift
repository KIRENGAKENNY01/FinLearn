import Vapor

// Shim for @DocumentID if Firestore module not available
@propertyWrapper
struct DocumentID<Value: Codable>: Codable {
    var wrappedValue: Value?
    
    init(wrappedValue: Value?) {
        self.wrappedValue = wrappedValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = try? container.decode(Value.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}


struct User: Content {
    static let schema = "users"
    
    // @DocumentID var id: String? 
    var id: String?
    var email: String
    var displayName: String
    var photoURL: String?
    var totalPoints: Int
    var currentLevel: UserLevel
    var fcmToken: String? // For Push Notifications
    var createdAt: Date?
    
    enum LoanStatus: String, Codable {
        case pending, approved, rejected
    }
    
    enum UserLevel: String, Codable {
        case beginner = "Beginner"
        case intermediate = "Intermediate"
        case advanced = "Advanced"
    }
}

extension User: Authenticatable {}
