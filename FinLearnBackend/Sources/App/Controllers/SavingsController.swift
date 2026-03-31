import Vapor

struct SavingsController: RouteCollection {
    let service: SavingsService
    
    func boot(routes: RoutesBuilder) throws {
        let savings = routes.grouped("savings")
        savings.post("evaluate", use: evaluate)
        savings.get("history", use: getHistory)
    }
    
    func evaluate(req: Request) async throws -> SavingsResult {
        let user = try req.auth.require(User.self)
        guard let uid = user.id, let firestore = req.application.firestore else {
            throw Abort(.internalServerError)
        }
 
        struct EvalInput: Content {
            let startDate: Date
            let endDate: Date
            let expectedSavings: Double
            let actualIncome: Double
            let actualExpenses: Double
            let emergencies: [Emergency]
        }
        let input = try req.content.decode(EvalInput.self)
        let result = service.evaluateGoal(
            startDate: input.startDate,
            endDate: input.endDate,
            expectedSavings: input.expectedSavings, 
            actualIncome: input.actualIncome, 
            actualExpenses: input.actualExpenses, 
            emergencies: input.emergencies
        )
        
        // Save to Firestore (Simple JSON String Strategy)
        if let jsonData = try? JSONEncoder().encode(result), let jsonString = String(data: jsonData, encoding: .utf8) {
            let firestoreData = FirestoreData(data: StringValue(stringValue: jsonString))
            // Use timestamp as ID for history
            let docId = "\(Int(Date().timeIntervalSince1970))" 
            
            _ = try? await firestore.createDocument(
                collection: "users/\(uid)/savings", 
                documentId: docId, 
                data: firestoreData
            )
        }
        
        return result
    }
    
    func getHistory(req: Request) async throws -> [SavingsResult] {
        let user = try req.auth.require(User.self)
        guard let uid = user.id, let firestore = req.application.firestore else {
            throw Abort(.internalServerError)
        }
        
        let docs: [FirestoreDocument<FirestoreData>] = try await firestore.listDocuments(collection: "users/\(uid)/savings")
        
        return docs.compactMap { doc in
            guard let data = doc.fields.data.stringValue.data(using: .utf8) else { return nil }
            return try? JSONDecoder().decode(SavingsResult.self, from: data)
        }
    }
}
