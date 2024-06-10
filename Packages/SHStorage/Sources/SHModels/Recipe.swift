import Foundation

// MARK: Model

public struct Recipe: BaseItem {
    public let id: String
    public let input: [Ingredient]
    public let output: Ingredient
    public let byproducts: [Ingredient]
    public let machine: Building?
    public let manualCrafting: [Building]
    public let duration: Int
    public let isDefault: Bool
    
    public init(
        id: String,
        input: [Ingredient],
        output: Ingredient,
        byproducts: [Ingredient] = [],
        machine: Building? = nil,
        manualCrafting: [Building] = [],
        duration: Int,
        isDefault: Bool = true
    ) {
        self.id = id
        self.input = input
        self.output = output
        self.byproducts = byproducts
        self.machine = machine
        self.manualCrafting = manualCrafting
        self.duration = duration
        self.isDefault = isDefault
    }
    
    public func amountPerMinute(for ingredient: Ingredient) -> Double {
        ingredient.amount * (60 / Double(duration))
    }
    
    public func multiplier(for item: some Item, amount: Double) -> Double {
        var multiplier = 1.0
        if item.id == output.item.id {
            multiplier = amount / amountPerMinute(for: output)
        } else if let byproduct = byproducts.first(where: { $0.id == item.id }) {
            multiplier = amount / amountPerMinute(for: byproduct)
        }
        
        return multiplier
    }
}

public extension Recipe {
    struct Ingredient: Identifiable, Hashable, Sendable {
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
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(role)
            hasher.combine(item.id)
            hasher.combine(amount)
        }
    }
}

public extension Recipe.Ingredient {
    enum Role: String, Equatable, CustomStringConvertible, Sendable {
        case input = "Input"
        case output = "Output"
        case byproduct = "Byproduct"
        
        public var description: String { rawValue }
    }
}

public extension Sequence<Recipe> {
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
    
    func sortedByDefault() -> [Recipe] {
        sorted(using: [
            KeyPathComparator(\.isDefault, comparator: DefaultRecipeComparator()),
            KeyPathComparator(\.localizedName)
        ])
    }
}

// MARK: - Default comparator
private struct DefaultRecipeComparator: SortComparator {
    var order: SortOrder = .forward
    
    func compare(_ lhs: Bool, _ rhs: Bool) -> ComparisonResult {
        switch order {
        case .forward: result(lhs, rhs)
        case .reverse: result(rhs, lhs)
        }
    }
    
    private func result(_ lhs: Bool, _ rhs: Bool) -> ComparisonResult {
        if lhs, !rhs {
            .orderedAscending
        } else if rhs, !lhs {
            .orderedDescending
        } else {
            .orderedSame
        }
    }
}
