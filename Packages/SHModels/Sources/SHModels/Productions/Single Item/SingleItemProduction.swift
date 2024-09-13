import Foundation
import Dependencies

public struct SingleItemProduction: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var creationDate: Date
    public var part: Part
    public var amount: Double
    public var inputParts: [InputPart]
    public var byproducts: [InputByproduct]
    public var statistics: Statistics
    
    public var assetName: String {
        part.id
    }
    
    @Dependency(\.uuid)
    private var uuid
    
    public init(
        id: UUID,
        name: String,
        creationDate: Date,
        part: Part,
        amount: Double,
        inputParts: [InputPart] = [],
        byproducts: [InputByproduct] = [],
        statistics: Statistics = Statistics()
    ) {
        self.id = id
        self.name = name
        self.creationDate = creationDate
        self.part = part
        self.amount = amount
        self.inputParts = inputParts
        self.byproducts = byproducts
        self.statistics = statistics
    }
    
    public mutating func addRecipe(_ recipe: Recipe, to part: Part, with proportion: Proportion) {
        if let index = inputParts.firstIndex(part: part) {
            inputParts[index].addRecipe(recipe, proportion: proportion)
        } else {
            inputParts.append(InputPart(id: uuid(), part: part, recipes: [
                InputRecipe(id: uuid(), recipe: recipe, proportion: proportion)
            ]))
        }
    }
    
    public mutating func updateInputPart(_ inputPart: InputPart) {
        guard let index = inputParts.firstIndex(part: inputPart.part) else { return }
        
        inputParts[index] = inputPart
    }
    
    public mutating func changeProportion(
        of recipe: Recipe,
        for part: Part,
        to newProportion: Proportion
    ) {
        guard
            let itemIndex = inputParts.firstIndex(part: part),
            let recipeIndex = inputParts[itemIndex].recipes.firstIndex(recipe: recipe)
        else { return }
        
        inputParts[itemIndex].recipes[recipeIndex].proportion = newProportion
    }
    
    public mutating func removePart(_ part: Part) {
        guard self.part != part else { return }
        
        inputParts.removeAll { $0.part == part }
    }
    
    // Byproducts
    public func hasProducingRecipe(_ recipe: Recipe, for part: Part) -> Bool {
        byproducts.contains {
            $0.part == part && $0.producers.contains(recipe: recipe)
        }
    }
    
    public func hasConsumingRecipe(_ recipe: Recipe, for part: Part) -> Bool {
        byproducts.contains {
            $0.part == part && $0.producers.contains {
                $0.consumers.contains(recipe: recipe)
            }
        }
    }
    
    public mutating func add(producingRecipe: Recipe, consumingRecipe: Recipe, for part: Part) {
        guard let byproductIndex = byproducts.firstIndex(part: part) else {
            byproducts.append(
                InputByproduct(id: uuid(), part: part, producingRecipe: producingRecipe, consumingRecipe: consumingRecipe)
            )
            return
        }
        
        guard let producingIndex = byproducts[byproductIndex].producers.firstIndex(recipe: producingRecipe) else {
            byproducts[byproductIndex].producers.append(
                InputByproductProducer(id: uuid(), producingRecipe: producingRecipe, consumingRecipe: consumingRecipe)
            )
            return
        }
        
        guard byproducts[byproductIndex].producers[producingIndex].consumers.contains(recipe: consumingRecipe) else {
            return
        }
        
        byproducts[byproductIndex].producers[producingIndex].consumers.append(
            InputByproductConsumer(id: uuid(), recipe: consumingRecipe)
        )
    }
    
    public mutating func removeByproduct(part: Part) {
        byproducts.removeAll { $0.part == part }
    }
    
    public mutating func removeProducingRecipe(_ recipe: Recipe, part: Part) {
        guard let byproductIndex = byproducts.firstIndex(part: part) else { return }
        
        byproducts[byproductIndex].producers.removeAll { $0.recipe == recipe }
    }
    
    public mutating func removeConsumingRecipe(_ recipe: Recipe, part: Part) {
        guard let byproductIndex = byproducts.firstIndex(part: part) else { return }
        
        for producingIndex in byproducts[byproductIndex].producers.indices {
            byproducts[byproductIndex].producers[producingIndex].consumers.removeAll { $0.recipe == recipe }
            
            if byproducts[byproductIndex].producers[producingIndex].consumers.isEmpty {
                byproducts[byproductIndex].producers.remove(at: producingIndex)
            }
        }
    }
    
    // Equatable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.creationDate == rhs.creationDate &&
        lhs.part == rhs.part &&
        lhs.amount == rhs.amount &&
        lhs.inputParts == rhs.inputParts &&
        lhs.byproducts == rhs.byproducts &&
        lhs.statistics == rhs.statistics
    }
    
    // Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(creationDate)
        hasher.combine(part)
        hasher.combine(amount)
        hasher.combine(inputParts)
        hasher.combine(byproducts)
        hasher.combine(statistics)
    }
}
