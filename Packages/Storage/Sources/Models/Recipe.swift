import Foundation

public struct Recipe: BaseItem {
    public let id: String
    public let input: [Ingredient]
    public let output: Ingredient
    public let byproducts: [Ingredient]
    public let machines: [Building]
    public let duration: Int
    public let isDefault: Bool
    
    public init(
        id: String,
        input: [Ingredient],
        output: Ingredient,
        byproducts: [Ingredient] = [],
        machines: [Building],
        duration: Int,
        isDefault: Bool = true
    ) {
        self.id = id
        self.input = input
        self.output = output
        self.byproducts = byproducts
        self.machines = machines
        self.duration = duration
        self.isDefault = isDefault
    }
}

public extension Recipe {
    struct Ingredient {
        public let item: Item
        public let amount: Double
        
        public init(item: Item, amount: Double) {
            self.item = item
            self.amount = amount
        }
    }
}
