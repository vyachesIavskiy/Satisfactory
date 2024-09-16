import Foundation

// MARK: Model

public struct Recipe: BaseItem {
    public let id: String
    public let output: Ingredient
    public let byproducts: [Ingredient]
    public let inputs: [Ingredient]
    public let machine: Building?
    public let duration: Double
    public let powerConsumption: PowerConsumption
    public let isDefault: Bool
    
    public var description: String {
        "Recipe: \(localizedName)"
    }
    
    public init(
        id: String,
        output: Ingredient,
        byproducts: [Ingredient] = [],
        inputs: [Ingredient],
        machine: Building? = nil,
        duration: Double,
        powerConsumption: PowerConsumption,
        isDefault: Bool = true
    ) {
        self.id = id
        self.output = output
        self.byproducts = byproducts
        self.inputs = inputs
        self.machine = machine
        self.duration = duration
        self.powerConsumption = powerConsumption
        self.isDefault = isDefault
    }
    
    public var amountPerMinute: Double {
        amountPerMinute(for: output)
    }
    
    public func amountPerMinute(for ingredient: Ingredient) -> Double {
        ingredient.amount * (60 / duration)
    }
    
    public func multiplier(for part: Part, amount: Double) -> Double {
        var multiplier = 1.0
        if part == output.part {
            multiplier = amount / amountPerMinute(for: output)
        } else if let byproduct = byproducts.first(where: { $0.part == part }) {
            multiplier = amount / amountPerMinute(for: byproduct)
        }
        
        return multiplier
    }
    
    public func ingredient(partID: String) -> Ingredient? {
        if output.part.id == partID {
            output
        } else if let byproduct = byproducts.first(partID: partID) {
            byproduct
        } else if let input = inputs.first(partID: partID) {
            input
        } else {
            nil
        }
    }
}

extension Recipe {
    public struct Ingredient: Identifiable, Hashable, Sendable {
        public let role: Role
        public let part: Part
        public let amount: Double
        
        public var id: String { "\(role.rawValue.lowercased())-\(part.id)" }
        
        public init(role: Role, part: Part, amount: Double) {
            self.role = role
            self.part = part
            self.amount = amount
        }
    }
}

extension Recipe.Ingredient {
    public enum Role: String, Equatable, CustomStringConvertible, Sendable {
        case output = "Output"
        case byproduct = "Byproduct"
        case input = "Input"
        
        public var description: String { rawValue }
    }
}

extension Recipe {
    public struct PowerConsumption: Hashable, Sendable {
        public var min: Int
        public var max: Int
        
        public init(min: Int = 0, max: Int = 0) {
            self.min = min
            self.max = max
        }
        
        public init(_ amount: Int) {
            self.init(min: amount, max: amount)
        }
    }
}

public extension Sequence<Recipe> {
    func first(partID: String, role: Recipe.Ingredient.Role) -> Recipe? {
        first { match($0, partID: partID, role: role) }
    }
    
    func filter(for partID: String, role: Recipe.Ingredient.Role) -> [Recipe] {
        filter { match($0, partID: partID, role: role) }
    }
    
    private func match(_ recipe: Recipe, partID: String, role: Recipe.Ingredient.Role) -> Bool {
        switch role {
        case .input: recipe.inputs.contains { $0.part.id == partID }
        case .output: recipe.output.part.id == partID
        case .byproduct: recipe.byproducts.contains { $0.part.id == partID }
        }
    }
    
    func sortedByDefault() -> [Recipe] {
        sorted(using: KeyPathComparator(\.isDefault, comparator: DefaultRecipeComparator()))
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

extension Sequence<Recipe.Ingredient> {
    public func first(partID: String) -> Element? {
        first { $0.part.id == partID }
    }
    
    public func first(of part: Part) -> Element? {
        first(partID: part.id)
    }
    
    public func filter(by partID: String) -> [Element] {
        filter { $0.part.id == partID }
    }
    
    public func filter(by part: Part) -> [Element] {
        filter(by: part.id)
    }
}

extension Collection<Recipe.Ingredient> {
    public func firstIndex(partID: String) -> Index? {
        firstIndex { $0.part.id == partID }
    }
    
    public func firstIndex(of part: Part) -> Index? {
        firstIndex(partID: part.id)
    }
}
