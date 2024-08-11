import Foundation
import SHModels

extension SHSingleItemProduction {
    public struct Input {
        /// A final item produced by calculation.
        public let finalItem: any Item
        
        /// Target amount of final item. All other items will be calculated based on this number.
        public var amount: Double
        
        /// Final and intermediate items with corresponding recipes, selected to produce the final item.
        public var inputItems: [InputItem]
        
        /// A separate byproduct relation between different items.
        public var byproducts: [InputByproduct]
        
        init(finalItem: any Item, amount: Double) {
            self.finalItem = finalItem
            self.amount = amount
            self.inputItems = []
            self.byproducts = []
        }
        
        mutating func addRecipe(_ recipe: Recipe, to item: any Item, with proportion: SHProductionProportion) {
            addInputRecipe(InputRecipe(recipe: recipe, proportion: proportion), to: item)
        }
        
        mutating func updateInputItem(_ inputItem: InputItem) {
            guard let index = inputItems.firstIndex(of: inputItem) else {
                return
            }
            
            inputItems[index] = inputItem
        }
        
        mutating func removeInputItem(with item: any Item) {
            guard item.id != finalItem.id else {
                // Final product cannot be removed from calculation
                return
            }
            
            guard let index = inputItems.firstIndex(item: item) else {
                return
            }
            
            inputItems.remove(at: index)
        }
        
        mutating func changeProportion(
            of recipe: Recipe,
            for item: any Item,
            to newProportion: SHProductionProportion
        ) {
            guard
                let itemIndex = inputItems.firstIndex(item: item),
                let recipeIndex = inputItems[itemIndex].recipes.firstIndex(where: { $0.recipe == recipe })
            else { return }
            
            inputItems[itemIndex].recipes[recipeIndex].proportion = newProportion
        }
        
        mutating func moveInputItem(from offsets: IndexSet, to offset: Int) {
            guard inputItems.indices.contains(offset) else { return }
            
            inputItems.move(fromOffsets: offsets, toOffset: offset)
        }
        
        // Byproducts
        mutating func addByproduct(_ item: any Item, producer: Recipe, consumer: Recipe) {
            guard let byproductIndex = byproducts.firstIndex(where: { $0.item.id == item.id }) else {
                byproducts.append(InputByproduct(item: item, producer: producer, consumer: consumer))
                return
            }
            
            guard let producingIndex = byproducts[byproductIndex].producers.firstIndex(where: { $0.recipe == producer }) else {
                byproducts[byproductIndex].producers.append(InputByproduct.Producer(producer, consumer: consumer))
                return
            }
            
            guard !byproducts[byproductIndex].producers[producingIndex].consumers.contains(consumer) else {
                return
            }
            
            // TODO: Need to check adding duplicate recipes. This might happen if same recipe is used to produce two different items.
            byproducts[byproductIndex].producers[producingIndex].consumers.append(consumer)
        }
        
        mutating func removeByrpoduct(_ item: any Item) {
            guard let byproductIndex = byproducts.firstIndex(where: { $0.item.id == item.id }) else {
                return
            }
            
            byproducts.remove(at: byproductIndex)
        }
        
        mutating func removeProducer(_ recipe: Recipe, for item: any Item) {
            guard
                let byproductIndex = byproducts.firstIndex(where: { $0.item.id == item.id }),
                let producingIndex = byproducts[byproductIndex].producers.firstIndex(where: { $0.recipe == recipe })
            else { return }
            
            byproducts[byproductIndex].producers.remove(at: producingIndex)
        }
        
        mutating func removeConsumer(_ recipe: Recipe, for byproduct: any Item) {
            guard let byproductIndex = byproducts.firstIndex(where: { $0.item.id == byproduct.id }) else {
                return
            }
            
            // ConsumingRecipe can consume byproducts from more than one ProducingRecipe, need to check all ProducingRecipes.
            for (producingIndex, producingRecipe) in byproducts[byproductIndex].producers.enumerated() {
                guard let consumingIndex = producingRecipe.consumers.firstIndex(of: recipe) else { continue }
                
                byproducts[byproductIndex].producers[producingIndex].consumers.remove(at: consumingIndex)
                if byproducts[byproductIndex].producers[producingIndex].consumers.isEmpty {
                    byproducts[byproductIndex].producers.remove(at: producingIndex)
                }
            }
        }
    }
}

private extension SHSingleItemProduction.Input {
    mutating func addInputRecipe(_ inputRecipe: SHSingleItemProduction.InputRecipe, to item: any Item) {
        guard let index = inputItems.firstIndex(item: item) else {
            inputItems.append(SHSingleItemProduction.InputItem(item: item, recipes: [inputRecipe]))
            return
        }
        
        inputItems[index].addProductRecipe(inputRecipe)
    }
}

extension SHSingleItemProduction.Input: Hashable {
    public static func == (lhs: SHSingleItemProduction.Input, rhs: SHSingleItemProduction.Input) -> Bool {
        lhs.finalItem.id == rhs.finalItem.id &&
        lhs.amount == rhs.amount &&
        lhs.inputItems == rhs.inputItems &&
        lhs.byproducts == rhs.byproducts
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(finalItem.id)
        hasher.combine(amount)
        hasher.combine(inputItems)
        hasher.combine(byproducts)
    }
}
