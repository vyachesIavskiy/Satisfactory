import SHModels

typealias Byproducts = [ProductionByproduct]

extension Byproducts {
    mutating func add(_ item: some Item, from fromRecipe: Recipe, to toRecipe: Recipe) {
        guard let index = firstIndex(of: item) else {
            append(item, from: fromRecipe, to: toRecipe)
            return
        }
        
        for (producedIndex, produced) in self[index].produced.enumerated() {
            if produced.recipe != fromRecipe {
                self[index].produced.append(ProductionByproduct.Produced(recipe: fromRecipe, required: toRecipe))
            } else {
                if !produced.required.contains(toRecipe) {
                    self[index].produced[producedIndex].required.append(ProductionByproduct.Produced.Required(recipe: toRecipe))
                }
            }
        }
    }
    
    mutating func remove(_ item: some Item, recipe: Recipe) {
        guard let index = firstIndex(of: item) else { return }
        
        for (producedIndex, produced) in self[index].produced.enumerated() {
            if produced.recipe == recipe {
                self[index].produced.remove(at: producedIndex)
            } else {
                for (requiredIndex, `required`) in produced.required.enumerated() {
                    if `required`.recipe == recipe {
                        self[index].produced[producedIndex].required.remove(at: requiredIndex)
                    }
                }
                
                removeIfNeeded(at: index, producedIndex: producedIndex)
            }
        }
        
        removeIfNeeded(at: index)
    }
    
    mutating func reset() {
        // This will reset all byproduct amounts to zero
        for (byproductIndex, byproduct) in enumerated() {
            for (producedIndex, produced) in byproduct.produced.enumerated() {
                for requiredIndex in produced.required.indices {
                    self[byproductIndex].produced[producedIndex].required[requiredIndex].amount = 0
                }
                self[byproductIndex].produced[producedIndex].amount = 0
            }
        }
    }
    
    private mutating func append(_ item: some Item, from fromRecipe: Recipe, to toRecipe: Recipe) {
        append(ProductionByproduct(
            item: item,
            fromRecipe: fromRecipe,
            toRecipe: toRecipe
        ))
    }
    
    private mutating func removeIfNeeded(at index: Int) {
        if self[index].produced.isEmpty {
            remove(at: index)
        }
    }
    
    private mutating func removeIfNeeded(at index: Int, producedIndex: Int) {
        self[index].removeProducedIfNeeded(at: producedIndex)
    }
}
