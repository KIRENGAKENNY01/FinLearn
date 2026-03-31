import Vapor

// MARK: - Firestore Primitives

struct StringValue: Codable {
    let stringValue: String
    
    init(stringValue: String) {
        self.stringValue = stringValue
    }
}

struct IntegerValue: Codable {
    let integerValue: String
    
    init(integerValue: Int) {
        self.integerValue = String(integerValue)
    }
    
    // Allow initializing from string directly if needed
    init(integerValue: String) {
        self.integerValue = integerValue
    }
}

struct DoubleValue: Codable {
    let doubleValue: Double
    
    init(doubleValue: Double) {
        self.doubleValue = doubleValue
    }
}

struct BooleanValue: Codable {
    let booleanValue: Bool
    
    init(booleanValue: Bool) {
        self.booleanValue = booleanValue
    }
}

struct ArrayValue<T: Codable>: Codable {
    let arrayValue: FirestoreArrayWrapper<T>
    
    init(values: [T]) {
        self.arrayValue = FirestoreArrayWrapper(values: values)
    }
}

struct FirestoreArrayWrapper<T: Codable>: Codable {
    let values: [T]?
}

struct MapValue<T: Codable>: Codable {
    let mapValue: FirestoreMapWrapper<T>
    
    init(fields: T) {
        self.mapValue = FirestoreMapWrapper(fields: fields)
    }
}

struct FirestoreMapWrapper<T: Codable>: Codable {
    let fields: T
}

struct FirestoreData: Codable, Content {
    let data: StringValue
}

struct QuizResultData: Codable, Content {
    let quizId: StringValue
    let score: IntegerValue
    let totalQuestions: IntegerValue
    let date: StringValue
}

