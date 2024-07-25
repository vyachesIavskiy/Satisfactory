import Foundation
import SHModels

extension SHSingleItemProduction {
    public struct OutputItem: Identifiable {
        public let id = UUID()
        public let item: any Item
        public var recipes: [OutputRecipe]
        
        public var amount: Double {
            recipes.reduce(0.0) { $0 + $1.output.amount }
        }
        
        public init(item: any Item, recipes: [OutputRecipe]) {
            self.item = item
            self.recipes = recipes
        }
    }
}

extension SHSingleItemProduction.OutputItem: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.item.id == rhs.item.id &&
        lhs.recipes == rhs.recipes
    }
}
