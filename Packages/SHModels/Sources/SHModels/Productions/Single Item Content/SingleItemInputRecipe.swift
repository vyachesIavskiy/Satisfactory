import Foundation

extension Production.Content.SingleItem {
    public struct InputRecipe: Hashable, Sendable {
        public let id: UUID
        public var recipe: Recipe
        public var proportion: Proportion
        
        public init(id: UUID, recipe: Recipe, proportion: Proportion) {
            self.id = id
            self.recipe = recipe
            self.proportion = proportion
        }
    }
}

// MARK: Input recipe + Sequence
extension Sequence<Production.Content.SingleItem.InputRecipe> {
    public func first(recipe: Recipe) -> Element? {
        first { $0.recipe == recipe }
    }
}

// MARK: Input recipe + Collection
extension Collection<Production.Content.SingleItem.InputRecipe> {
    public func firstIndex(recipe: Recipe) -> Index? {
        firstIndex { $0.recipe == recipe }
    }
}
