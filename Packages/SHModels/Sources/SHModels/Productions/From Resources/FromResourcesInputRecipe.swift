import Foundation

extension FromResourcesProduction {
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
extension Sequence<FromResourcesProduction.InputRecipe> {
    public func first(recipe: Recipe) -> Element? {
        first { $0.recipe == recipe }
    }
}

// MARK: Input recipe + Collection
extension Collection<FromResourcesProduction.InputRecipe> {
    public func firstIndex(recipe: Recipe) -> Index? {
        firstIndex { $0.recipe == recipe }
    }
}
