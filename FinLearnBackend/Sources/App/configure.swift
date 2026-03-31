import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Services
    let serviceAccountPath = app.directory.workingDirectory + "serviceAccountKey.json"
    let googleAuth = try GoogleAuthProvider(serviceAccountPath: serviceAccountPath, client: app.client)
    let firestoreService = FirestoreService(auth: googleAuth, client: app.client, projectId: googleAuth.serviceAccount.project_id)
    
    app.storage[FirestoreServiceKey.self] = firestoreService

    // Middleware
    let cors = CORSMiddleware(
        configuration: .init(
            allowedOrigin: .all,
            allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
            allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
        )
    )
    app.middleware.use(cors)
    
    // register routes
    try routes(app)
}

struct FirestoreServiceKey: StorageKey {
    typealias Value = FirestoreService
}

extension Application {
    var firestore: FirestoreService? {
        get { self.storage[FirestoreServiceKey.self] }
        set { self.storage[FirestoreServiceKey.self] = newValue }
    }
}
