import Vapor

struct BudgetController: RouteCollection {
    let service: BudgetService
    
    func boot(routes: RoutesBuilder) throws {
        let budget = routes.grouped("budget")
        budget.get("latest", use: getLatestBudget)
        budget.get("month", ":monthIso", use: getBudgetByMonth)
        budget.post(use: saveBudget)
        budget.post("followup", use: calculateFollowUp)
    }
    
    func getLatestBudget(req: Request) async throws -> Response {
        let user = try req.auth.require(User.self)
        guard let uid = user.id, let firestore = req.application.firestore else {
            throw Abort(.internalServerError)
        }
        
        if let plan = try await fetchBudget(firestore: firestore, userId: uid, documentId: "current", req: req) {
            return try await plan.encodeResponse(for: req)
        }
        return Response(status: .noContent)
    }

    func getBudgetByMonth(req: Request) async throws -> Response {
        let user = try req.auth.require(User.self)
        guard let uid = user.id, 
              let monthIso = req.parameters.get("monthIso"),
              let firestore = req.application.firestore else {
            throw Abort(.badRequest)
        }
        
        if let plan = try await fetchBudget(firestore: firestore, userId: uid, documentId: monthIso, req: req) {
            return try await plan.encodeResponse(for: req)
        }
        return Response(status: .noContent)
    }

    private func fetchBudget(firestore: FirestoreService, userId: String, documentId: String, req: Request) async throws -> BudgetPlan? {
        do {
            let doc: FirestoreDocument<FirestoreBudgetPlan> = try await firestore.getDocument(collection: "users/\(userId)/budgets", documentId: documentId)
            let fPlan = doc.fields
            
            return BudgetPlan(
                id: doc.name.components(separatedBy: "/").last,
                userId: userId,
                monthIso: fPlan.monthIso.stringValue,
                totalPlannedIncome: fPlan.totalPlannedIncome.doubleValue,
                totalPlannedExpenses: fPlan.totalPlannedExpenses.doubleValue,
                actualTotalIncome: fPlan.actualTotalIncome?.doubleValue ?? 0,
                actualTotalExpenses: fPlan.actualTotalExpenses?.doubleValue ?? 0,
                currency: fPlan.currency.stringValue,
                createdAt: ISO8601DateFormatter().date(from: fPlan.createdAt?.stringValue ?? ""),
                lastFollowUpDate: nil,
                incomeItems: fPlan.incomeItems?.arrayValue.values?.map { 
                    BudgetItem(category: $0.mapValue.fields.category.stringValue, amount: $0.mapValue.fields.amount.doubleValue)
                } ?? [],
                expenseItems: fPlan.expenseItems?.arrayValue.values?.map { 
                    BudgetItem(category: $0.mapValue.fields.category.stringValue, amount: $0.mapValue.fields.amount.doubleValue)
                } ?? [],
                emergencies: fPlan.emergencies?.arrayValue.values?.map { 
                    Emergency(title: $0.mapValue.fields.title.stringValue, amount: $0.mapValue.fields.amount.doubleValue)
                } ?? [],
                isCompleted: fPlan.isCompleted?.booleanValue ?? false
            )
        } catch {
            req.logger.debug("Structured budget not found for \(documentId) (normal for new months). Checking legacy format...")
            do {
                let doc: FirestoreDocument<FirestoreData> = try await firestore.getDocument(collection: "users/\(userId)/budgets", documentId: documentId)
                guard let data = doc.fields.data.stringValue.data(using: .utf8) else { return nil }
                return try JSONDecoder().decode(BudgetPlan.self, from: data)
            } catch {
                return nil
            }
        }
    }
    
    func saveBudget(req: Request) async throws -> BudgetPlan {
        let user = try req.auth.require(User.self)
        guard let uid = user.id, let firestore = req.application.firestore else {
            throw Abort(.internalServerError)
        }
        
        req.logger.info("Saving budget (structured) for user: \(uid)")
        
        var plan: BudgetPlan
        do {
            plan = try req.content.decode(BudgetPlan.self)
        } catch {
            req.logger.error("Failed to decode BudgetPlan: \(error)")
            throw Abort(.badRequest, reason: "Invalid budget data: \(error)")
        }
        
        plan.userId = uid
        let now = Date()
        plan.createdAt = now
        
        let fDoc = FirestoreBudgetPlan(
            monthIso: StringValue(stringValue: plan.monthIso),
            totalPlannedIncome: DoubleValue(doubleValue: plan.totalPlannedIncome),
            totalPlannedExpenses: DoubleValue(doubleValue: plan.totalPlannedExpenses),
            actualTotalIncome: DoubleValue(doubleValue: plan.actualTotalIncome ?? 0),
            actualTotalExpenses: DoubleValue(doubleValue: plan.actualTotalExpenses ?? 0),
            currency: StringValue(stringValue: plan.currency),
            createdAt: StringValue(stringValue: ISO8601DateFormatter().string(from: now)),
            incomeItems: ArrayValue(values: (plan.incomeItems ?? []).map { 
                MapValue(fields: FirestoreBudgetItem(category: StringValue(stringValue: $0.category), amount: DoubleValue(doubleValue: $0.amount)))
            }),
            expenseItems: ArrayValue(values: (plan.expenseItems ?? []).map { 
                MapValue(fields: FirestoreBudgetItem(category: StringValue(stringValue: $0.category), amount: DoubleValue(doubleValue: $0.amount)))
            }),
            emergencies: ArrayValue(values: (plan.emergencies ?? []).map { 
                MapValue(fields: FirestoreEmergency(title: StringValue(stringValue: $0.title), amount: DoubleValue(doubleValue: $0.amount)))
            }),
            isCompleted: BooleanValue(booleanValue: plan.isCompleted ?? false)
        )
        
        _ = try await firestore.setDocument(
            collection: "users/\(uid)/budgets",
            documentId: "current",
            data: fDoc
        )

        // Also save with month-specific ID for validation
        _ = try await firestore.setDocument(
            collection: "users/\(uid)/budgets",
            documentId: plan.monthIso,
            data: fDoc
        )
        
        return plan
    }
    
    func calculateFollowUp(req: Request) async throws -> BudgetResult {
        let user = try req.auth.require(User.self)
        guard let uid = user.id, let firestore = req.application.firestore else {
            throw Abort(.internalServerError)
        }

        struct FollowUpInput: Content {
            let plan: BudgetPlan
            let actualIncome: Double
            let actualExpenses: Double
            let emergencies: [Emergency]
        }
        
        let input = try req.content.decode(FollowUpInput.self)
        let result = service.calculateFollowUp(plan: input.plan, actualIncome: input.actualIncome, actualExpenses: input.actualExpenses, emergencies: input.emergencies)
        
        // Save to Firestore (Simple JSON String Strategy)
        if let jsonData = try? JSONEncoder().encode(result), let jsonString = String(data: jsonData, encoding: .utf8) {
            let firestoreData = FirestoreData(data: StringValue(stringValue: jsonString))
            let docId = "followup_\(input.plan.monthIso)"
            
            _ = try? await firestore.setDocument(
                collection: "users/\(uid)/budgets", 
                documentId: docId, 
                data: firestoreData
            )
            
            // NEW: Mark budget as completed
            try await markBudgetCompleted(firestore: firestore, userId: uid, plan: input.plan, req: req)
        }
        
        return result
    }
    
    // Helper to update budget as completed
    private func markBudgetCompleted(firestore: FirestoreService, userId: String, plan: BudgetPlan, req: Request) async throws {
         let docId = plan.monthIso
         
         if let currentPlan = try await fetchBudget(firestore: firestore, userId: userId, documentId: docId, req: req) {
             var updated = currentPlan
             updated.isCompleted = true
             
             // Explicitly map to help compiler
             let incomeMaps: [MapValue<FirestoreBudgetItem>] = (updated.incomeItems ?? []).map { 
                 MapValue(fields: FirestoreBudgetItem(category: StringValue(stringValue: $0.category), amount: DoubleValue(doubleValue: $0.amount)))
             }
             let expenseMaps: [MapValue<FirestoreBudgetItem>] = (updated.expenseItems ?? []).map { 
                 MapValue(fields: FirestoreBudgetItem(category: StringValue(stringValue: $0.category), amount: DoubleValue(doubleValue: $0.amount)))
             }
             let emergencyMaps: [MapValue<FirestoreEmergency>] = (updated.emergencies ?? []).map { 
                 MapValue(fields: FirestoreEmergency(title: StringValue(stringValue: $0.title), amount: DoubleValue(doubleValue: $0.amount)))
             }

             // Re-encode to FirestoreBudgetPlan
             let fDoc = FirestoreBudgetPlan(
                 monthIso: StringValue(stringValue: updated.monthIso),
                 totalPlannedIncome: DoubleValue(doubleValue: updated.totalPlannedIncome),
                 totalPlannedExpenses: DoubleValue(doubleValue: updated.totalPlannedExpenses),
                 actualTotalIncome: DoubleValue(doubleValue: updated.actualTotalIncome ?? 0),
                 actualTotalExpenses: DoubleValue(doubleValue: updated.actualTotalExpenses ?? 0),
                 currency: StringValue(stringValue: updated.currency),
                 createdAt: StringValue(stringValue: ISO8601DateFormatter().string(from: updated.createdAt ?? Date())),
                 incomeItems: ArrayValue(values: incomeMaps),
                 expenseItems: ArrayValue(values: expenseMaps),
                 emergencies: ArrayValue(values: emergencyMaps),
                 isCompleted: BooleanValue(booleanValue: true)
             )
             
             _ = try await firestore.setDocument(collection: "users/\(userId)/budgets", documentId: docId, data: fDoc)
             // Update "current" pointer too if it matches
             _ = try await firestore.setDocument(collection: "users/\(userId)/budgets", documentId: "current", data: fDoc)
         }
    }
}

// MARK: - Firestore Mapping Types
struct FirestoreBudgetPlan: Codable, Content {
    let monthIso: StringValue
    let totalPlannedIncome: DoubleValue
    let totalPlannedExpenses: DoubleValue
    let actualTotalIncome: DoubleValue?
    let actualTotalExpenses: DoubleValue?
    let currency: StringValue
    let createdAt: StringValue?
    let incomeItems: ArrayValue<MapValue<FirestoreBudgetItem>>?
    let expenseItems: ArrayValue<MapValue<FirestoreBudgetItem>>?
    let emergencies: ArrayValue<MapValue<FirestoreEmergency>>?
    let isCompleted: BooleanValue?
}

struct FirestoreEmergency: Codable {
    let title: StringValue
    let amount: DoubleValue
}

struct FirestoreBudgetItem: Codable {
    let category: StringValue
    let amount: DoubleValue
}

// End of file

