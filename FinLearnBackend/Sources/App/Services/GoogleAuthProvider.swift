import Vapor
import JWT

struct ServiceAccount: Codable {
    let type: String
    let project_id: String
    let private_key_id: String
    let private_key: String
    let client_email: String
    let client_id: String
    let auth_uri: String
    let token_uri: String
    let auth_provider_x509_cert_url: String
    let client_x509_cert_url: String
}

struct GoogleClaims: JWTPayload {
    let iss: String
    let scope: String
    let aud: String
    let iat: Int
    let exp: Int
    
    func verify(using signer: JWTSigner) throws {
        // No verification needed for self-signed
    }
}

struct GoogleTokenResponse: Content {
    let access_token: String
    let expires_in: Int
    let token_type: String
}

actor GoogleAuthProvider {
    let serviceAccount: ServiceAccount
    var accessToken: String?
    var expiration: Date = Date()
    let client: Client
    
    init(serviceAccountPath: String, client: Client) throws {
        let data = try Data(contentsOf: URL(fileURLWithPath: serviceAccountPath))
        self.serviceAccount = try JSONDecoder().decode(ServiceAccount.self, from: data)
        self.client = client
    }
    
    func getAccessToken() async throws -> String {
        if let token = accessToken, Date() < expiration {
            return token
        }
        
        // Create JWT
        let now = Int(Date().timeIntervalSince1970)
        let claims = GoogleClaims(
            iss: serviceAccount.client_email,
            scope: "https://www.googleapis.com/auth/datastore",
            aud: serviceAccount.token_uri,
            iat: now,
            exp: now + 3600
        )
        
        // Sign JWT
        let signers = JWTSigners()
        let signer = try JWTSigner.rs256(key: .private(pem: serviceAccount.private_key))
        signers.use(signer)
        
        let jwt = try signers.sign(claims)
        
        // Exchange for Access Token
        let response = try await client.post(URI(string: serviceAccount.token_uri)) { req in
            try req.content.encode([
                "grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer",
                "assertion": jwt
            ], as: .urlEncodedForm)
        }
        
        let tokenResponse = try response.content.decode(GoogleTokenResponse.self)
        self.accessToken = tokenResponse.access_token
        self.expiration = Date().addingTimeInterval(TimeInterval(tokenResponse.expires_in - 60)) // Buffer
        
        return tokenResponse.access_token
    }
}
