import Foundation
import SHModels
import SHStaticModels

extension SingleItemProduction.Persistent {
    public struct V2: Codable, Identifiable, Hashable {
        public var id: UUID
        public var name: String
        public var itemID: String
        public var amount: Double
        public var inputItems: [InputItem]
        public var byproducts: [Byproduct]
        public var statistics: Statistics
        
        public init(
            id: UUID,
            name: String,
            itemID: String,
            amount: Double,
            inputItems: [InputItem],
            byproducts: [Byproduct],
            statistics: Statistics = Statistics()
        ) {
            self.id = id
            self.name = name
            self.itemID = itemID
            self.amount = amount
            self.inputItems = inputItems
            self.byproducts = byproducts
            self.statistics = statistics
        }
        
        mutating func migrate(_ migration: Migration) {
            if let part = migration.partIDs.first(oldID: itemID) {
                itemID = part.newID
            } else if let equipment = migration.equipmentIDs.first(oldID: itemID) {
                itemID = equipment.newID
            }
            
            for (inputItemIndex, inputItem) in inputItems.enumerated() {
                if let part = migration.partIDs.first(oldID: inputItem.itemID) {
                    inputItems[inputItemIndex].itemID = part.newID
                } else if let equipment = migration.equipmentIDs.first(oldID: inputItem.itemID) {
                    inputItems[inputItemIndex].itemID = equipment.newID
                }
                
                for (recipeIndex, recipe) in inputItem.recipes.enumerated() {
                    if let recipe = migration.recipeIDs.first(oldID: recipe.recipeID) {
                        inputItems[inputItemIndex].recipes[recipeIndex].recipeID = recipe.newID
                    }
                }
            }
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

extension SingleItemProduction.Persistent.V2 {
    public struct Statistics: Codable, Hashable {
        public var items: [StatisticItem]
        public var naturalResources: [StatisticNaturalResource]
        
        public init(items: [StatisticItem] = [], naturalResources: [StatisticNaturalResource] = []) {
            self.items = items
            self.naturalResources = naturalResources
        }
    }
}

extension SingleItemProduction.Persistent.V2 {
    public struct StatisticItem: Codable, Hashable {
        public var itemID: String
        public var recipes: [StatisticRecipe]
        
        public init(itemID: String, recipes: [StatisticRecipe]) {
            self.itemID = itemID
            self.recipes = recipes
        }
    }
}

extension SingleItemProduction.Persistent.V2 {
    public struct StatisticRecipe: Codable, Hashable {
        public var recipeID: String
        public var amount: Double
        
        public init(recipeID: String, amount: Double) {
            self.recipeID = recipeID
            self.amount = amount
        }
    }
}

extension SingleItemProduction.Persistent.V2 {
    public struct StatisticNaturalResource: Codable, Hashable {
        public var itemID: String
        public var amount: Double
        
        public init(itemID: String, amount: Double) {
            self.itemID = itemID
            self.amount = amount
        }
    }
}
