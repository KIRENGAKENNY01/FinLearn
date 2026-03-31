import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.post(use: createUser)
        users.get("me", use: getCurrentUser)
    }
    
    func createUser(req: Request) async throws -> HTTPStatus {
        let user = try req.content.decode(User.self)
        guard let firestore = req.application.firestore else {
            throw Abort(.internalServerError, reason: "Firestore not configured")
        }
        
        // Convert User to Firestore Format (fields)
        // This is the manual mapping to ensure correct Firestore JSON structure
        let firestoreData = FirestoreUser(fields: FirestoreUserFields(
            email: .init(stringValue: user.email),
            displayName: .init(stringValue: user.displayName),
            totalPoints: .init(integerValue: user.totalPoints),
            currentLevel: .init(stringValue: user.currentLevel.rawValue),
            fcmToken: user.fcmToken != nil ? .init(stringValue: user.fcmToken!) : nil
        ))
        
        _ = try await firestore.createDocument(
            collection: "users", 
            documentId: user.id ?? "unknown", 
            data: firestoreData.fields
        )
        
        return .created
    }
    
    func getCurrentUser(req: Request) async throws -> User {
        let user = try req.auth.require(User.self) // From Middleware
        guard let firestore = req.application.firestore, let uid = user.id else {
            throw Abort(.internalServerError)
        }
        
        let doc: FirestoreDocument<FirestoreUserFields> = try await firestore.getDocument(collection: "users", documentId: uid)
        
        return User(
            id: uid,
            email: doc.fields.email.stringValue,
            displayName: doc.fields.displayName.stringValue,
            photoURL: nil,
            totalPoints: Int(doc.fields.totalPoints.integerValue) ?? 0,
            currentLevel: User.UserLevel(rawValue: doc.fields.currentLevel.stringValue) ?? .beginner,
            fcmToken: doc.fields.fcmToken?.stringValue
        )
    }
}

// Firestore Specific Structures for User
struct FirestoreUser: Content {
    let fields: FirestoreUserFields
}

struct FirestoreUserFields: Content {
    let email: StringValue
    let displayName: StringValue
    let totalPoints: IntegerValue
    let currentLevel: StringValue
    let fcmToken: StringValue?
}


