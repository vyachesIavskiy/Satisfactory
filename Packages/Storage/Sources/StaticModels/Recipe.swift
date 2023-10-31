import Foundation

public struct Recipe: Codable {
    public let id: String
    public let inputs: [Ingredient]
    public let output: Ingredient
    public let byproducts: [Ingredient]?
    public let machineIDs: [String]
    public let duration: Int
    public let isDefault: Bool
    
    public init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproducts: [Ingredient]?,
        machineIDs: [String],
        duration: Int,
        isDefault: Bool
    ) {
        self.id = id
        self.inputs = inputs
        self.output = output
        self.byproducts = byproducts
        self.machineIDs = machineIDs
        self.duration = duration
        self.isDefault = isDefault
    }
}

public extension Recipe {
    struct Ingredient: Codable {
        public let itemID: String
        public let amount: Double
        
        public init(itemID: String, amount: Double) {
            self.itemID = itemID
            self.amount = amount
        }
    }
}

