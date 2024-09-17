import Foundation
import Dependencies

extension Production.Content.SingleItem {
    public struct InputPart: Hashable, Sendable {
        public let id: UUID
        public var part: Part
        public var recipes: [InputRecipe]
        
        public init(id: UUID, part: Part, recipes: [InputRecipe]) {
            self.id = id
            self.part = part
            self.recipes = recipes
        }
        
        mutating func addRecipe(_ recipe: Recipe, proportion: Proportion) {
            @Dependency(\.uuid)
            var uuid
            
            guard !recipes.contains(where: { $0.recipe == recipe }) else { return }
            
            recipes.append(InputRecipe(id: uuid(), recipe: recipe, proportion: proportion))
        }
    }
}

// MARK: Input item + Sequence
extension Sequence<Production.Content.SingleItem.InputPart> {
    public func first(part: Part) -> Element? {
        first { $0.part == part }
    }
    public func contains(part: Part) -> Bool {
        contains { $0.part == part }
    }
}

// MARK: Input item + Collection
extension Collection<Production.Content.SingleItem.InputPart> {
    public func firstIndex(part: Part) -> Index? {
        firstIndex { $0.part == part }
    }
}
