import Foundation

enum NetworkError: Error {
    case invalidURL
    case serverError(String)
    case decodingError(Error)
    case unauthorized
}

class NetworkManager {
    static let shared = NetworkManager()
    
    // Change this to your local IP if testing on a physical device
    // Use 127.0.0.1 for simulator, or the machine's local IP for physical devices
    // Local IP: 10.12.73.138
    let baseURL = "http://10.12.73.138:8081/api/v1"
    
    private init() {}
    
    func get<T: Decodable>(path: String, token: String? = nil) async throws -> T {
        guard let url = URL(string: "\(baseURL)/\(path)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError("Invalid response")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == 401 { throw NetworkError.unauthorized }
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown Error"
            throw NetworkError.serverError(errorMessage)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 
            
            if data.isEmpty || httpResponse.statusCode == 204 {
                let nullData = "null".data(using: .utf8)!
                return try decoder.decode(T.self, from: nullData)
            }
            
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error for \(path): \(error)")
            throw NetworkError.decodingError(error)
        }
    }
    
    func post<T: Decodable, U: Encodable>(path: String, body: U, token: String? = nil) async throws -> T {
        guard let url = URL(string: "\(baseURL)/\(path)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let encoder = JSONEncoder()
        // Configure date encoding if needed
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try encoder.encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError("Invalid response")
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == 401 { throw NetworkError.unauthorized }
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown Error"
            throw NetworkError.serverError(errorMessage)
        }
        
        // If expectation is Void/Empty, we can return a dummy if T is Void (not easily possible in swift generics without specialization)
        // Check if T is special ReturnType
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error for \(path): \(error)")
            throw NetworkError.decodingError(error)
        }
    }
    
    // Helper for POST requests that don't expect a return body (just 200 OK)
    func postNoReturn<U: Encodable>(path: String, body: U, token: String? = nil) async throws {
        guard let url = URL(string: "\(baseURL)/\(path)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown Error"
            throw NetworkError.serverError(errorMessage)
        }
    }
}
