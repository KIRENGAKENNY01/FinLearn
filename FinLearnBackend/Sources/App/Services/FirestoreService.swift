import Vapor

struct FirestoreDocument<T: Codable>: Codable {
    let name: String
    let fields: T
    let createTime: String?
    let updateTime: String?
}

// Minimal wrapper for Firestore REST API
struct FirestoreService {
    let auth: GoogleAuthProvider
    let client: Client
    let projectId: String
    
    var baseUrl: String {
        "https://firestore.googleapis.com/v1/projects/\(projectId)/databases/(default)/documents"
    }
    
    // Create or Overwrite a document
    func createDocument<T: Content>(collection: String, documentId: String, data: T) async throws -> FirestoreDocument<T> {
        let token = try await auth.getAccessToken()
        let uri = URI(string: "\(baseUrl)/\(collection)?documentId=\(documentId)")
        
        let response = try await client.post(uri) { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token)
            // Wrap in "fields" key for Firestore API
            try req.content.encode(["fields": data])
        }
        
        guard response.status == .ok else {
            let errorBody = response.body.flatMap { $0.getString(at: $0.readerIndex, length: $0.readableBytes) } ?? ""
            throw Abort(response.status, reason: "Firestore Error: \(errorBody)")
        }
        
        return try response.content.decode(FirestoreDocument<T>.self)
    }

    // Upsert (Create or Update) a document using PATCH
    func setDocument<T: Content>(collection: String, documentId: String, data: T) async throws -> FirestoreDocument<T> {
        let token = try await auth.getAccessToken()
        let uri = URI(string: "\(baseUrl)/\(collection)/\(documentId)")
        
        let response = try await client.patch(uri) { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token)
            // Wrap in "fields" key for Firestore API
            try req.content.encode(["fields": data])
        }
        
        guard response.status == .ok else {
            let errorBody = response.body.flatMap { $0.getString(at: $0.readerIndex, length: $0.readableBytes) } ?? ""
            print("--- FIRESTORE SET ERROR ---")
            print("Status: \(response.status)")
            print("Body: \(errorBody)")
            print("---------------------------")
            throw Abort(response.status, reason: "Firestore Set Error: \(errorBody)")
        }
        
        return try response.content.decode(FirestoreDocument<T>.self)
    }
    
    // Read a document
    func getDocument<T: Codable>(collection: String, documentId: String) async throws -> FirestoreDocument<T> {
        let token = try await auth.getAccessToken()
        let uri = URI(string: "\(baseUrl)/\(collection)/\(documentId)")
        
        let response = try await client.get(uri) { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token)
        }
        
        guard response.status == .ok else {
            let errorBody = response.body.flatMap { $0.getString(at: $0.readerIndex, length: $0.readableBytes) } ?? ""
            throw Abort(response.status, reason: "Firestore Error: \(errorBody)")
        }
        
        return try response.content.decode(FirestoreDocument<T>.self)
    }
    // Delete a document
    func deleteDocument(collection: String, documentId: String) async throws {
        let token = try await auth.getAccessToken()
        let uri = URI(string: "\(baseUrl)/\(collection)/\(documentId)")
        
        let response = try await client.delete(uri) { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token)
        }
        
        // Success ranges: 200 OK
        guard response.status == .ok else {
             // If 404, consider it success (already gone)
             if response.status == .notFound { return }
             let errorBody = response.body.flatMap { $0.getString(at: $0.readerIndex, length: $0.readableBytes) } ?? ""
             throw Abort(response.status, reason: "Firestore Delete Error: \(errorBody)")
        }
    }
    
    // List documents in a collection
    func listDocuments<T: Codable>(collection: String) async throws -> [FirestoreDocument<T>] {
        let token = try await auth.getAccessToken()
        let uri = URI(string: "\(baseUrl)/\(collection)")
        
        let response = try await client.get(uri) { req in
            req.headers.bearerAuthorization = BearerAuthorization(token: token)
        }
        
        guard response.status == .ok else {
            // Return empty array if collection not found (404)
            if response.status == .notFound { return [] }
            let errorBody = response.body.flatMap { $0.getString(at: $0.readerIndex, length: $0.readableBytes) } ?? ""
            throw Abort(response.status, reason: "Firestore List Error: \(errorBody)")
        }
        
        let list = try response.content.decode(ListResponse<T>.self)
        return list.documents ?? []
    }
}

private struct ListResponse<U: Codable>: Codable {
    let documents: [FirestoreDocument<U>]?
}
