import Foundation
import SHModels
import SHStaticModels

extension Production.Content.SingleItem.Persistent {
    package struct V2: Codable, Hashable {
        package var partID: String
        package var amount: Double
        package var inputParts: [InputPart]
        package var byproducts: [Byproduct]
        package var statistics: Statistics
        
        package init(
            partID: String,
            amount: Double,
            inputParts: [InputPart],
            byproducts: [Byproduct],
            statistics: Statistics = Statistics()
        ) {
            self.partID = partID
            self.amount = amount
            self.inputParts = inputParts
            self.byproducts = byproducts
            self.statistics = statistics
        }
        
        mutating func migrate(_ migration: Migration) {
            if let part = migration.partIDs.first(oldID: partID) {
                partID = part.newID
            }
            
            for (inputItemIndex, inputItem) in inputParts.enumerated() {
                if let part = migration.partIDs.first(oldID: inputItem.partID) {
                    inputParts[inputItemIndex].partID = part.newID
                }
                
                for (recipeIndex, recipe) in inputItem.recipes.enumerated() {
                    if let recipe = migration.recipeIDs.first(oldID: recipe.recipeID) {
                        inputParts[inputItemIndex].recipes[recipeIndex].recipeID = recipe.newID
                    }
                }
            }
        }
    }
}

extension Production.Content.SingleItem.Persistent.V2 {
    package struct InputPart: Codable, Hashable {
        package var id: UUID
        package var partID: String
        package var recipes: [Recipe]
        
        package init(id: UUID, partID: String, recipes: [Recipe]) {
            self.id = id
            self.partID = partID
            self.recipes = recipes
        }
    }
}

extension Production.Content.SingleItem.Persistent.V2.InputPart {
    package struct Recipe: Codable, Hashable {
        package var id: UUID
        package var recipeID: String
        package var proportion: Proportion
        
        package init(id: UUID, recipeID: String, proportion: Proportion) {
            self.id = id
            self.recipeID = recipeID
            self.proportion = proportion
        }
    }
}

extension Production.Content.SingleItem.Persistent.V2 {
    package struct Byproduct: Codable, Hashable {
        package var id: UUID
        package var partID: String
        package var producers: [Producer]
        
        package init(id: UUID, partID: String, producers: [Producer]) {
            self.id = id
            self.partID = partID
            self.producers = producers
        }
    }
}

extension Production.Content.SingleItem.Persistent.V2.Byproduct {
    package struct Producer: Codable, Hashable {
        package var id: UUID
        package var recipeID: String
        package var consumers: [Consumer]
        
        package init(id: UUID, recipeID: String, consumers: [Consumer]) {
            self.id = id
            self.recipeID = recipeID
            self.consumers = consumers
        }
    }
}

extension Production.Content.SingleItem.Persistent.V2.Byproduct.Producer {
    package struct Consumer: Codable, Hashable {
        package var id: UUID
        package var recipeID: String
        
        package init(id: UUID, recipeID: String) {
            self.id = id
            self.recipeID = recipeID
        }
    }
}

extension Production.Content.SingleItem.Persistent.V2 {
    package struct Statistics: Codable, Hashable {
        package var parts: [StatisticPart]
        package var naturalResources: [StatisticNaturalResource]
        
        package init(parts: [StatisticPart] = [], naturalResources: [StatisticNaturalResource] = []) {
            self.parts = parts
            self.naturalResources = naturalResources
        }
    }
}

extension Production.Content.SingleItem.Persistent.V2 {
    package struct StatisticPart: Codable, Hashable {
        package var partID: String
        package var recipes: [StatisticRecipe]
        
        package init(partID: String, recipes: [StatisticRecipe]) {
            self.partID = partID
            self.recipes = recipes
        }
    }
}

extension Production.Content.SingleItem.Persistent.V2 {
    package struct StatisticRecipe: Codable, Hashable {
        package var recipeID: String
        package var amount: Double
        
        package init(recipeID: String, amount: Double) {
            self.recipeID = recipeID
            self.amount = amount
        }
    }
}

extension Production.Content.SingleItem.Persistent.V2 {
    package struct StatisticNaturalResource: Codable, Hashable {
        package var partID: String
        package var amount: Double
        
        package init(partID: String, amount: Double) {
            self.partID = partID
            self.amount = amount
        }
    }
}
