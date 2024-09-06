import Foundation
import SHDependencies

extension FromResourcesProduction {
    public struct InputResource: Hashable, Sendable {
        public let id: UUID
        public var item: any Item
        public var amount: Double
        public var recipes: [InputRecipe]
        
        public init(id: UUID, item: any Item, amount: Double, recipes: [InputRecipe]) {
            self.id = id
            self.item = item
            self.amount = amount
            self.recipes = recipes
        }
        
        // Equatable
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id &&
            lhs.item.id == rhs.item.id &&
            lhs.amount == rhs.amount &&
            lhs.recipes == rhs.recipes
        }
        
        // Hashable
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(item.id)
            hasher.combine(amount)
            hasher.combine(recipes)
        }
    }
}

// MARK: Input item + Sequence
extension Sequence<FromResourcesProduction.InputResource> {
    public func first(item: any Item) -> Element? {
        first { $0.item.id == item.id }
    }
    public func contains(item: any Item) -> Bool {
        contains { $0.item.id == item.id }
    }
}

// MARK: Input item + Collection
extension Collection<FromResourcesProduction.InputResource> {
    public func firstIndex(item: any Item) -> Index? {
        firstIndex { $0.item.id == item.id }
    }
}
