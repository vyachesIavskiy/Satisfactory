import Foundation
import Dependencies

extension SingleItemProduction {
    public struct InputItem: Hashable, Sendable {
        public let id: UUID
        public var item: any Item
        public var recipes: [InputRecipe]
        
        @Dependency(\.uuid)
        private var uuid
        
        public init(id: UUID, item: some Item, recipes: [InputRecipe]) {
            self.id = id
            self.item = item
            self.recipes = recipes
        }
        
        mutating func addRecipe(_ recipe: Recipe, proportion: Proportion) {
            guard !recipes.contains(where: { $0.recipe == recipe }) else { return }
            
            recipes.append(InputRecipe(id: uuid(), recipe: recipe, proportion: proportion))
        }
        
        // Equatable
        public static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id &&
            lhs.item.id == rhs.item.id &&
            lhs.recipes == rhs.recipes
        }
        
        // Hashable
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(item.id)
            hasher.combine(recipes)
        }
    }
}

// MARK: Input item + Sequence
extension Sequence<SingleItemProduction.InputItem> {
    public func first(item: any Item) -> Element? {
        first { $0.item.id == item.id }
    }
    public func contains(item: any Item) -> Bool {
        contains { $0.item.id == item.id }
    }
}

// MARK: Input item + Collection
extension Collection<SingleItemProduction.InputItem> {
    public func firstIndex(item: any Item) -> Index? {
        firstIndex { $0.item.id == item.id }
    }
}
