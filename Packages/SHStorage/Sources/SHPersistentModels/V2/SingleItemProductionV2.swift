import Foundation
import SHModels

extension SingleItemProduction.Persistent {
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

extension SingleItemProduction.Persistent.V2 {
    public struct InputItem: Codable, Hashable {
        public var id: UUID
        public var itemID: String
        public var recipes: [Recipe]
        
        public init(id: UUID, itemID: String, recipes: [Recipe]) {
            self.id = id
            self.itemID = itemID
            self.recipes = recipes
        }
    }
}

extension SingleItemProduction.Persistent.V2.InputItem {
    public struct Recipe: Codable, Hashable {
        public var id: UUID
        public var recipeID: String
        public var proportion: Proportion
        
        public init(id: UUID, recipeID: String, proportion: Proportion) {
            self.id = id
            self.recipeID = recipeID
            self.proportion = proportion
        }
    }
}

extension SingleItemProduction.Persistent.V2 {
    public struct Byproduct: Codable, Hashable {
        public var id: UUID
        public var itemID: String
        public var producers: [Producer]
        
        public init(id: UUID, itemID: String, producers: [Producer]) {
            self.id = id
            self.itemID = itemID
            self.producers = producers
        }
    }
}

extension SingleItemProduction.Persistent.V2.Byproduct {
    public struct Producer: Codable, Hashable {
        public var id: UUID
        public var recipeID: String
        public var consumers: [Consumer]
        
        public init(id: UUID, recipeID: String, consumers: [Consumer]) {
            self.id = id
            self.recipeID = recipeID
            self.consumers = consumers
        }
    }
}

extension SingleItemProduction.Persistent.V2.Byproduct.Producer {
    public struct Consumer: Codable, Hashable {
        public var id: UUID
        public var recipeID: String
        
        public init(id: UUID, recipeID: String) {
            self.id = id
            self.recipeID = recipeID
        }
    }
}
