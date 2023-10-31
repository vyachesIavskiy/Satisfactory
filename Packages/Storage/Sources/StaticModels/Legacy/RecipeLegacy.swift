import Foundation

public struct RecipeLegacy: Decodable {
    public let id: String
    public let name: String
    public let input: [Ingredient]
    public let output: [Ingredient]
    public let machines: [String]
    public let duration: Int
    public let isDefault: Bool
    
    public init(
        id: String,
        name: String,
        input: [Ingredient],
        output: [Ingredient],
        machines: [String],
        duration: Int,
        isDefault: Bool
    ) {
        self.id = id
        self.name = name
        self.input = input
        self.output = output
        self.machines = machines
        self.duration = duration
        self.isDefault = isDefault
    }
}

public extension RecipeLegacy {
    struct Ingredient: Decodable {
        public var id: String
        public var amount: Double
        
        public init(id: String, amount: Double) {
            self.id = id
            self.amount = amount
        }
    }
}

