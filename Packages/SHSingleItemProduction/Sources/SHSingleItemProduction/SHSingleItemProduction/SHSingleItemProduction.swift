import Foundation
import SHStorage
import SHModels
import SHUtils

public final class SHSingleItemProduction {
    // MARK: Ignored properties
    public var item: any Item {
        input.finalItem
    }
    
    public var amount: Double {
        get { input.amount }
        set { input.amount = newValue }
    }
    
    var nodes = [Node]()
    var subproductions = [Subproduction]()
    
    var internalState = InternalState()
    
    @Dependency(\.uuid)
    var uuid
    
    // MARK: Observed properties
    public var input: Input
    public internal(set) var outputItems = [OutputItem]()
    
    public init(item: any Item) {
        input = Input(finalItem: item, amount: 1.0)
    }
    
    public init(production: Production) {
        input = Input(finalItem: production.item, amount: production.amount)
        
        input.inputItems = production.inputItems.map {
            InputItem(item: $0.item, recipes: $0.recipes.map {
                InputRecipe(recipe: $0.recipe, proportion: $0.proportion)
            })
        }
        
        input.byproducts = production.byproducts.map {
            InputByproduct(item: $0.item, producers: $0.producers.map {
                InputByproduct.Producer(recipe: $0.recipe, consumers: $0.consumers)
            })
        }
    }
    
    // MARK: - Input
    public func addRecipe(
        _ recipe: Recipe,
        to item: some Item,
        with proportion: SHProductionProportion = .auto
    ) {
        input.addRecipe(recipe, to: item, with: proportion)
    }
    
    public func updateInputItem(_ inputItem: InputItem) {
        input.updateInputItem(inputItem)
    }
    
    public func changeProportion(
        of recipe: Recipe,
        for item: any Item,
        to newProportion: SHProductionProportion
    ) {
        input.changeProportion(of: recipe, for: item, to: newProportion)
    }
    
    public func changeProportion(
        of recipe: InputRecipe,
        for item: any Item,
        to newProportion: SHProductionProportion
    ) {
        changeProportion(of: recipe.recipe, for: item, to: newProportion)
    }
    
    public func moveInputItems(from offsets: IndexSet, to offset: Int) {
        input.moveInputItem(from: offsets, to: offset)
    }
    
    public func removeInputItem(_ item: some Item) {
        input.removeInputItem(with: item)
    }
    
    public subscript(inputItemIndex index: Int) -> InputItem {
        get { input.inputItems[index] }
        set { input.inputItems[index] = newValue }
    }
    
    public func inputItemsContains(where predicate: (_ inputItem: InputItem) throws -> Bool) rethrows -> Bool {
        try input.inputItems.contains(where: predicate)
    }
    
    public func inputItemsContains(item: some Item) -> Bool {
        input.inputItems.contains(item)
    }
    
    public func inputRecipesContains(where predicate: (_ inputRecipe: InputRecipe) throws -> Bool) rethrows -> Bool {
        try inputItemsContains { item in
            try item.recipes.contains(where: predicate)
        }
    }
    
    public func inputRecipesContains(recipe: Recipe) -> Bool {
        inputRecipesContains { $0.id == recipe.id }
    }
    
    public func iterateInputItems(_ handler: (_ offset: Int, _ inputItem: InputItem) -> Void) {
        var index = 0
        while input.inputItems.indices.contains(index) {
            let inputItem = input.inputItems[index]
            handler(index, inputItem)
            index += 1
        }
    }
    
    public func iterateInputRecipes(
        for inputItem: InputItem,
        handler: (_ offset: Int, _ recipe: InputRecipe) -> Void
    ) {
        var index = 0
        while inputItem.recipes.indices.contains(index) {
            let inputRecipe = inputItem.recipes[index]
            handler(index, inputRecipe)
            index += 1
        }
    }
    
    // Byproducts
    public func addByproduct(_ item: any Item, producer: Recipe, consumer: Recipe) {
        input.addByproduct(item, producer: producer, consumer: consumer)
    }
    
    public func hasProducer(_ item: any Item, recipe: Recipe) -> Bool {
        input.byproducts.contains {
            $0.item.id == item.id && $0.producers.contains {
                $0.recipe.id == recipe.id
            }
        }
    }
    
    public func hasConsumer(_ item: any Item, recipe: Recipe) -> Bool {
        input.byproducts.contains {
            $0.item.id == item.id && $0.producers.contains {
                $0.consumers.contains {
                    $0.id == recipe.id
                }
            }
        }
    }
    
    public func removeByrpoduct(_ item: any Item) {
        input.removeByrpoduct(item)
    }
    
    public func removeProducer(_ recipe: Recipe, for item: any Item) {
        input.removeProducer(recipe, for: item)
    }
    
    public func removeConsumer(_ recipe: Recipe, for byproduct: any Item) {
        input.removeConsumer(recipe, for: byproduct)
    }
    
    // Output
    public func outputItem(for item: any Item) -> OutputItem? {
        outputItems.first { $0.item.id == item.id }
    }
    
    public func outputRecipes(for item: any Item) -> [OutputRecipe] {
        outputItems.first { $0.item.id == item.id }.map(\.recipes) ?? []
    }
    
    public func outputItemsContains(where predicate: (_ outputItem: OutputItem) throws -> Bool) rethrows -> Bool {
        try outputItems.contains(where: predicate)
    }
    
    public func outputItemsContains(item: any Item) -> Bool {
        outputItemsContains { $0.item.id == item.id }
    }
    
    public func outputRecipesContains(where predicate: (_ outputRecipe: OutputRecipe) throws -> Bool) rethrows -> Bool {
        try outputItemsContains { outputItem in
            try outputItem.recipes.contains(where: predicate)
        }
    }
    
    public func outputRecipesContains(recipe: Recipe) -> Bool {
        outputRecipesContains { $0.recipe.id == recipe.id }
    }
    
    /// Triggers production recalculation. Output will be populated after calling this function.
    public func update() {
        // Reseting internal state
        internalState.reset(input: input)
        
        // Reset additional nodes
        subproductions = []
        
        // Create nodes for final product recipes
        buildNodes()
        
        // Build a tree
        buildTree()
        
        // Build subproductions
        for subproduction in subproductions {
            subproduction.update()
        }
        
        // Build and return an output
        buildOutput()
    }
    
    public func createNewSavedProduction() -> Production {
        Production(
            id: UUID(),
            name: input.finalItem.localizedName,
            item: input.finalItem,
            amount: input.amount,
            inputItems: input.inputItems.map {
                Production.InputItem(item: $0.item, recipes: $0.recipes.map {
                    Production.InputRecipe(recipe: $0.recipe, proportion: $0.proportion)
                })
            },
            byproducts: input.byproducts.map {
                Production.InputByproduct(item: $0.item, producers: $0.producers.map {
                    Production.InputByproductProducer(recipe: $0.recipe, consumers: $0.consumers)
                })
            }
        )
    }
    
    public func updateSavedProduction(_ savedProduction: Production) -> Production {
        Production(
            id: savedProduction.id,
            name: savedProduction.name,
            item: savedProduction.item,
            amount: input.amount,
            inputItems: input.inputItems.map {
                Production.InputItem(item: $0.item, recipes: $0.recipes.map {
                    Production.InputRecipe(recipe: $0.recipe, proportion: $0.proportion)
                })
            },
            byproducts: input.byproducts.map {
                Production.InputByproduct(item: $0.item, producers: $0.producers.map {
                    Production.InputByproductProducer(recipe: $0.recipe, consumers: $0.consumers)
                })
            }
        )
    }
    
    public func hasUnsavedChanges(comparingTo savedProduction: Production) -> Bool {
        // TODO: Compare
        true
    }
}

// MARK: InternalState
extension SHSingleItemProduction {
    struct InternalState {
        var selectedInputItems = [SHSingleItemProduction.InputItem]()
        var selectedByproducts = [SHSingleItemProduction.InputByproduct]()
        var byproducts = [Byproduct]()
        
        mutating func reset(input: SHSingleItemProduction.Input) {
            selectedInputItems = input.inputItems
            selectedByproducts = input.byproducts
            byproducts = []
        }
        
        // MARK: Convenience helpers
        func selectedInputItem(with id: String) -> SHSingleItemProduction.InputItem? {
            selectedInputItems.first { $0.item.id == id }
        }
        
        func index(of item: some Item) -> Int? {
            selectedInputItems.firstIndex { $0.item.id == item.id }
        }
        
        func selectedByproduct(with id: String) -> SHSingleItemProduction.InputByproduct? {
            selectedByproducts.first { $0.item.id == id }
        }
    }
}

// MARK: Hashable
extension SHSingleItemProduction: Hashable {
    public static func == (lhs: SHSingleItemProduction, rhs: SHSingleItemProduction) -> Bool {
        lhs.input == rhs.input &&
        lhs.outputItems == rhs.outputItems
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(input)
        hasher.combine(outputItems)
    }
}

// MARK: Print format
extension SHSingleItemProduction: CustomStringConvertible {
    public var description: String {
        var nodeDescription = ""
        var nodes = nodes
        var spacing = ""
        while !nodes.isEmpty {
            nodeDescription += nodes.map { $0.description(with: spacing) }.joined(separator: "\n") + "\n"
            spacing += "  "
            nodes = nodes.flatMap(\.inputNodes)
        }
        
        return """
        \(item.localizedName) (\(amount.formatted(.shNumber)))
        
        \(nodeDescription)
        """
    }
}
