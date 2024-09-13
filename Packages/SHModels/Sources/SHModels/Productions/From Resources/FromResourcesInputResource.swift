import Foundation
import SHDependencies

extension FromResourcesProduction {
    public struct InputResource: Hashable, Sendable {
        public let id: UUID
        public var part: Part
        public var amount: Double
        public var recipes: [InputRecipe]
        
        public init(id: UUID, part: Part, amount: Double, recipes: [InputRecipe]) {
            self.id = id
            self.part = part
            self.amount = amount
            self.recipes = recipes
        }
    }
}

// MARK: Input item + Sequence
extension Sequence<FromResourcesProduction.InputResource> {
    public func first(part: Part) -> Element? {
        first { $0.part == part }
    }
    public func contains(part: Part) -> Bool {
        contains { $0.part == part }
    }
}

// MARK: Input item + Collection
extension Collection<FromResourcesProduction.InputResource> {
    public func firstIndex(part: Part) -> Index? {
        firstIndex { $0.part == part }
    }
}
