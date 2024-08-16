import Foundation
import Dependencies

public struct SingleItemProduction: Identifiable, Hashable, Sendable {
    public var id: UUID
    public var name: String
    public var item: any Item
    public var amount: Double
    public var inputItems: [InputItem]
    public var byproducts: [InputByproduct]
    
    @Dependency(\.uuid)
    private var uuid
    
    public init(
        id: UUID,
        name: String,
        item: some Item,
        amount: Double,
        inputItems: [InputItem] = [],
        byproducts: [InputByproduct] = []
    ) {
        self.id = id
        self.name = name
        self.item = item
        self.amount = amount
        self.inputItems = inputItems
        self.byproducts = byproducts
    }
    
    public mutating func addRecipe(_ recipe: Recipe, to item: some Item, with proportion: Proportion) {
        if let index = inputItems.firstIndex(item: item) {
            inputItems[index].addRecipe(recipe, proportion: proportion)
        } else {
            inputItems.append(InputItem(id: uuid(), item: item, recipes: [
                InputRecipe(id: uuid(), recipe: recipe, proportion: proportion)
            ]))
        }
    }
    
    public mutating func updateInputItem(_ inputItem: InputItem) {
        guard let index = inputItems.firstIndex(item: inputItem.item) else { return }
        
        inputItems[index] = inputItem
    }
    
    public mutating func changeProportion(
        of recipe: Recipe,
        for item: some Item,
        to newProportion: Proportion
    ) {
        guard
            let itemIndex = inputItems.firstIndex(item: item),
            let recipeIndex = inputItems[itemIndex].recipes.firstIndex(recipe: recipe)
        else { return }
        
        inputItems[itemIndex].recipes[recipeIndex].proportion = newProportion
    }
    
    public mutating func removeItem(_ item: some Item) {
        guard self.item.id != item.id else { return }
        
        inputItems.removeAll { $0.item.id == item.id }
    }
    
    // Byproducts
    public func hasProducingRecipe(_ recipe: Recipe, for item: some Item) -> Bool {
        byproducts.contains {
            $0.item.id == item.id && $0.producers.contains(recipe: recipe)
        }
    }
    
    public func hasConsumingRecipe(_ recipe: Recipe, for item: some Item) -> Bool {
        byproducts.contains {
            $0.item.id == item.id && $0.producers.contains {
                $0.consumers.contains(recipe: recipe)
            }
        }
    }
    
    public mutating func add(producingRecipe: Recipe, consumingRecipe: Recipe, for item: some Item) {
        guard let byproductIndex = byproducts.firstIndex(item: item) else {
            byproducts.append(
                InputByproduct(id: uuid(), item: item, producingRecipe: producingRecipe, consumingRecipe: consumingRecipe)
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
    
    public mutating func removeByproduct(item: some Item) {
        byproducts.removeAll { $0.item.id == item.id }
    }
    
    public mutating func removeProducingRecipe(_ recipe: Recipe, item: some Item) {
        guard let byproductIndex = byproducts.firstIndex(item: item) else { return }
        
        byproducts[byproductIndex].producers.removeAll { $0.recipe == recipe }
    }
    
    public mutating func removeConsumingRecipe(_ recipe: Recipe, item: some Item) {
        guard let byproductIndex = byproducts.firstIndex(item: item) else { return }
        
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
        lhs.item.id == rhs.item.id &&
        lhs.amount == rhs.amount &&
        lhs.inputItems == rhs.inputItems &&
        lhs.byproducts == rhs.byproducts
    }
    
    // Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(item.id)
        hasher.combine(amount)
        hasher.combine(inputItems)
        hasher.combine(byproducts)
    }
}

// MARK: Single item production + Sequence
public extension Sequence<SingleItemProduction> {
    func first(id: UUID) -> Element?  {
        first { $0.id == id }
    }
}

// MARK: Single item production + Collection
public extension Collection<SingleItemProduction> {
    func firstIndex(id: UUID) -> Index? {
        firstIndex { $0.id == id }
    }
}
