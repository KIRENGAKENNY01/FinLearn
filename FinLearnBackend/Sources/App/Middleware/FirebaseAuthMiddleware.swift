import Vapor
import JWT

struct FirebasePayload: JWTPayload {
    let subject: SubjectClaim
    let expiration: ExpirationClaim
    let userId: String
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case userId = "user_id"
        case email
    }
    
    func verify(using signer: JWTSigner) throws {
        // In a real app, you would verify the signature here.
        // For development/demo without fetching public keys, 
        // we check expiration at least.
        try self.expiration.verifyNotExpired()
    }
}

struct FirebaseAuthMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        guard let token = request.headers.bearerAuthorization?.token else {
            throw Abort(.unauthorized)
        }
        
        // 1. Parsing the JWT (Unverified Signature for Dev, Verified Expiration)
        // Note: To verify signature, we need Google's public keys. 
        // We will decode unverified to extract data for now.
        do {
            // This is a manual decode of the payload to get data without a signer configured in app.jwt.signers
            // In production, use req.jwt.verify(...) with fetched keys.
            let jwt = try request.application.jwt.signers.unverified(token, as: FirebasePayload.self)
            
            let uid = jwt.userId
            let email = jwt.email ?? "no-email"
            
            request.logger.info("Authenticated User: \(uid) (\(email))")
            
            request.auth.login(User(
                id: uid, 
                email: email, 
                displayName: "User", 
                totalPoints: 0, 
                currentLevel: .beginner
            ))
        } catch {
            request.logger.error("JWT Error: \(error)")
            throw Abort(.unauthorized, reason: "Invalid Token")
        }
        
        return try await next.respond(to: request)
    }
}
