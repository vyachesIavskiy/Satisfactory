import Foundation
import SHModels

extension SingleItemCalculator {
    public struct OutputPart: Identifiable, Hashable, CustomStringConvertible {
        public let id: UUID
        public let part: Part
        public var recipes: [OutputRecipe]
        
        public var description: String {
            "Output: \(part), amount: \(amount), recipes: \(recipes)"
        }
        
        public var amount: Double {
            recipes.reduce(0.0) { $0 + $1.output.amount }
        }
        
        public init(id: UUID = UUID(), part: Part, recipes: [OutputRecipe]) {
            self.id = id
            self.part = part
            self.recipes = recipes
        }
    }
}
