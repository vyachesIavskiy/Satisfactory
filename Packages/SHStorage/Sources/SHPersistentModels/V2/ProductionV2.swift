import Foundation
import SHModels

extension Production.Persistent {
    public struct V2: Codable, Identifiable, Hashable {
        public var id: UUID
        public var name: String
        public var itemID: String
        public var amount: Double
        public var inputItems: [InputItem]
        public var byproducts: [Byproduct]
        
        public init(
            id: UUID,
            name: String,
            itemID: String,
            amount: Double,
            inputItems: [InputItem],
            byproducts: [Byproduct]
        ) {
            self.id = id
            self.name = name
            self.itemID = itemID
            self.amount = amount
            self.inputItems = inputItems
            self.byproducts = byproducts
        }
    }
}

extension Production.Persistent.V2 {
    public struct InputItem: Codable, Hashable {
        public var id: String
        public var recipes: [Recipe]
        
        public init(id: String, recipes: [Recipe]) {
            self.id = id
            self.recipes = recipes
        }
    }
}

extension Production.Persistent.V2.InputItem {
    public struct Recipe: Codable, Hashable {
        public var id: String
        public var proportion: SHProductionProportion
        
        public init(id: String, proportion: SHProductionProportion) {
            self.id = id
            self.proportion = proportion
        }
    }
}

extension Production.Persistent.V2 {
    public struct Byproduct: Codable, Hashable {
        public var itemID: String
        public var producers: [Producer]
        
        public init(itemID: String, producers: [Producer]) {
            self.itemID = itemID
            self.producers = producers
        }
    }
}

extension Production.Persistent.V2.Byproduct {
    public struct Producer: Codable, Hashable {
        public var recipeID: String
        public var consumerRecipeIDs: [String]
        
        public init(recipeID: String, consumerRecipeIDs: [String]) {
            self.recipeID = recipeID
            self.consumerRecipeIDs = consumerRecipeIDs
        }
    }
}
