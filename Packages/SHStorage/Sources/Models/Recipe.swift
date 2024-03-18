import Foundation

// MARK: Model

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
    struct Ingredient: Identifiable, Equatable {
        public let role: Role
        public let item: any Item
        public let amount: Double
        
        public var id: String { "\(role.rawValue.lowercased())-\(item.id)" }
        
        public init(role: Role, item: some Item, amount: Double) {
            self.role = role
            self.item = item
            self.amount = amount
        }
        
        public static func == (lhs: Recipe.Ingredient, rhs: Recipe.Ingredient) -> Bool {
            lhs.role == rhs.role && lhs.item.id == rhs.item.id && lhs.amount == rhs.amount
        }
    }
}

public extension Recipe.Ingredient {
    enum Role: String, Equatable, CustomStringConvertible {
        case input = "Input"
        case output = "Output"
        case byproduct = "Byproduct"
        
        public var description: String { rawValue }
    }
}

public extension Sequence where Element == Recipe {
    func first(itemID: String, role: Recipe.Ingredient.Role) -> Recipe? {
        first { match($0, itemID: itemID, role: role) }
    }
    
    func filter(for itemID: String, role: Recipe.Ingredient.Role) -> [Recipe] {
        filter { match($0, itemID: itemID, role: role) }
    }
    
    private func match(_ recipe: Recipe, itemID: String, role: Recipe.Ingredient.Role) -> Bool {
        switch role {
        case .input: recipe.input.contains { $0.item.id == itemID }
        case .output: recipe.output.item.id == itemID
        case .byproduct: recipe.byproducts.contains { $0.item.id == itemID }
        }
    }
}
