import Foundation
import SHStorage
import SHModels
import SHUtils

public final class SHSingleItemProduction {
    // MARK: Ignored properties
    public var item: any Item {
        production.item
    }
    
    public var amount: Double {
        get { production.amount }
        set { production.amount = newValue }
    }
    
    var mainNodes = [Node]()
    var additionalNodes = [Node]()
    
    var internalState = InternalState()
    
    @Dependency(\.uuid)
    var uuid
    
    // MARK: Observed properties
    public var production: SingleItemProduction
    private var savedProduction: SingleItemProduction
    public internal(set) var outputItems = [OutputItem]()
    
    public init(item: any Item) {
        @Dependency(\.uuid)
        var uuid
        
        production = SingleItemProduction(id: uuid(), name: "", item: item, amount: 1.0)
        savedProduction = production
    }
    
    public init(production: SingleItemProduction) {
        self.production = production
        savedProduction = production
    }
    
    // MARK: - Input
    public func addRecipe(
        _ recipe: Recipe,
        to item: some Item,
        with proportion: Proportion = .auto
    ) {
        production.addRecipe(recipe, to: item, with: proportion)
    }
    
    public func updateInputItem(_ inputItem: SingleItemProduction.InputItem) {
        production.updateInputItem(inputItem)
    }
    
    public func changeProportion(
        of recipe: Recipe,
        for item: any Item,
        to newProportion: Proportion
    ) {
        production.changeProportion(of: recipe, for: item, to: newProportion)
    }
    
//    public func changeProportion(
//        of recipe: InputRecipe,
//        for item: any Item,
//        to newProportion: Proportion
//    ) {
//        changeProportion(of: recipe.recipe, for: item, to: newProportion)
//    }
    
//    public func moveInputItems(from offsets: IndexSet, to offset: Int) {
//        input.moveInputItem(from: offsets, to: offset)
//    }
    
    public func removeInputItem(_ item: some Item) {
        production.removeItem(item)
    }
    
//    public subscript(inputItemIndex index: Int) -> InputItem {
//        get { input.inputItems[index] }
//        set { input.inputItems[index] = newValue }
//    }
    
//    public func inputItemsContains(where predicate: (_ inputItem: InputItem) throws -> Bool) rethrows -> Bool {
//        try input.inputItems.contains(where: predicate)
//    }
    
//    public func inputItemsContains(item: some Item) -> Bool {
//        input.inputItems.contains(item)
//    }
    
//    public func inputRecipesContains(where predicate: (_ inputRecipe: InputRecipe) throws -> Bool) rethrows -> Bool {
//        try inputItemsContains { item in
//            try item.recipes.contains(where: predicate)
//        }
//    }
    
//    public func inputRecipesContains(recipe: Recipe) -> Bool {
//        inputRecipesContains { $0.id == recipe.id }
//    }
    
//    public func iterateInputItems(_ handler: (_ offset: Int, _ inputItem: InputItem) -> Void) {
//        var index = 0
//        while input.inputItems.indices.contains(index) {
//            let inputItem = input.inputItems[index]
//            handler(index, inputItem)
//            index += 1
//        }
//    }
    
//    public func iterateInputRecipes(
//        for inputItem: InputItem,
//        handler: (_ offset: Int, _ recipe: InputRecipe) -> Void
//    ) {
//        var index = 0
//        while inputItem.recipes.indices.contains(index) {
//            let inputRecipe = inputItem.recipes[index]
//            handler(index, inputRecipe)
//            index += 1
//        }
//    }
    
    // Byproducts
    public func addByproduct(_ item: any Item, producer: Recipe, consumer: Recipe) {
        production.add(producingRecipe: producer, consumingRecipe: consumer, for: item)
    }
    
    public func hasProducer(_ item: any Item, recipe: Recipe) -> Bool {
        production.hasProducingRecipe(recipe, for: item)
    }
    
    public func hasConsumer(_ item: any Item, recipe: Recipe) -> Bool {
        production.hasConsumingRecipe(recipe, for: item)
    }
    
    public func removeByrpoduct(_ item: any Item) {
        production.removeByproduct(item: item)
    }
    
    public func removeProducer(_ recipe: Recipe, for item: any Item) {
        production.removeProducingRecipe(recipe, item: item)
    }
    
    public func removeConsumer(_ recipe: Recipe, for item: any Item) {
        production.removeConsumingRecipe(recipe, item: item)
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
        internalState.reset(production: production)
        
        // Reset additional nodes
        additionalNodes = []
        
        // Create nodes for final product recipes
        buildNodes()
        
        // Build a tree
        buildTree()
        
        // Build additional trees
        buildAdditionalTrees()
        
        // Build and return an output
        buildOutput()
    }
    
    public func save() {
        savedProduction = production
    }
    
    public var hasUnsavedChanges: Bool {
        savedProduction != production
    }
}

// MARK: InternalState
extension SHSingleItemProduction {
    struct InternalState {
        var selectedInputItems = [SingleItemProduction.InputItem]()
        var selectedByproducts = [SingleItemProduction.InputByproduct]()
        var byproducts = [Byproduct]()
        
        mutating func reset(production: SingleItemProduction) {
            selectedInputItems = production.inputItems
            selectedByproducts = production.byproducts
            byproducts = []
        }
        
        // MARK: Convenience helpers
        func selectedInputItem(with id: String) -> SingleItemProduction.InputItem? {
            selectedInputItems.first { $0.item.id == id }
        }
        
        func index(of item: some Item) -> Int? {
            selectedInputItems.firstIndex { $0.item.id == item.id }
        }
        
        func selectedByproduct(with id: String) -> SingleItemProduction.InputByproduct? {
            selectedByproducts.first { $0.item.id == id }
        }
    }
}

// MARK: Hashable
extension SHSingleItemProduction: Hashable {
    public static func == (lhs: SHSingleItemProduction, rhs: SHSingleItemProduction) -> Bool {
        lhs.production == rhs.production &&
        lhs.outputItems == rhs.outputItems
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(production)
        hasher.combine(outputItems)
    }
}

// MARK: Print format
extension SHSingleItemProduction: CustomStringConvertible {
    public var description: String {
        var nodeDescription = ""
        var nodes = mainNodes + additionalNodes
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
