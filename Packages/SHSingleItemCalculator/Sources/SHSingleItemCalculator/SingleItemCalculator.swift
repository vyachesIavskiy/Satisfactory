import Foundation
import SHDependencies
import SHModels
import SHUtils

public final class SingleItemCalculator {
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
    
    @Dependency(\.date)
    var date
    
    // MARK: Observed properties
    public var production: SingleItemProduction
    private var savedProduction: SingleItemProduction?
    public internal(set) var outputItems = [OutputItem]()
    
    public init(item: any Item) {
        @Dependency(\.uuid)
        var uuid
        
        @Dependency(\.date)
        var date
        
        production = SingleItemProduction(id: uuid(), name: "", creationDate: date(), item: item, amount: 1.0)
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
    
//    public func moveInputItems(from offsets: IndexSet, to offset: Int) {
//        input.moveInputItem(from: offsets, to: offset)
//    }
    
    public func removeInputItem(_ item: some Item) {
        production.removeItem(item)
    }
    
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
        
        // Apply registered byproducts to all trees
        applyByproducts()
        
        // Build and return an output
        buildOutput()
        
        // Update statistics for production
        updateStatistics()
    }
    
    public var hasSavedProduction: Bool {
        savedProduction != nil
    }
    
    public func save() {
        savedProduction = production
    }
    
    public var hasUnsavedChanges: Bool {
        savedProduction != production
    }
    
    public func deleteSavedProduction() {
        savedProduction = nil
    }
}

// MARK: InternalState
extension SingleItemCalculator {
    struct InternalState {
        var selectedInputItems = [SingleItemProduction.InputItem]()
        var selectedByproducts = [SingleItemProduction.InputByproduct]()
        
        mutating func reset(production: SingleItemProduction) {
            selectedInputItems = production.inputItems
            selectedByproducts = production.byproducts
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

// MARK: Print format
extension SingleItemCalculator: CustomStringConvertible {
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
