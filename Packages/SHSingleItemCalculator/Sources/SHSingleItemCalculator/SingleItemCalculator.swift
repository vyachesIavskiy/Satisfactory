import Foundation
import SHDependencies
import SHModels
import SHUtils

public final class SingleItemCalculator {
    // MARK: Ignored properties
    public var part: Part {
        production.part
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
    public var production: Production.Content.SingleItem
    public internal(set) var outputParts = [OutputPart]()
    
    public init(part: Part) {
        @Dependency(\.uuid)
        var uuid
        
        @Dependency(\.date)
        var date
        
        production = Production.Content.SingleItem(part: part, amount: 1.0)
    }
    
    public init(production: Production.Content.SingleItem) {
        self.production = production
    }
    
    // MARK: - Input
    public func addRecipe(
        _ recipe: Recipe,
        to part: Part,
        with proportion: Proportion = .auto
    ) {
        production.addRecipe(recipe, to: part, with: proportion)
    }
    
    public func updateInputPart(_ inputPart: Production.Content.SingleItem.InputPart) {
        production.updateInputPart(inputPart)
    }
    
    public func changeProportion(
        of recipe: Recipe,
        for part: Part,
        to newProportion: Proportion
    ) {
        production.changeProportion(of: recipe, for: part, to: newProportion)
    }
    
    public func moveInputItems(from offsets: IndexSet, to offset: Int) {
        production.inputParts.move(fromOffsets: offsets, toOffset: offset)
    }
    
    public func removeInputItem(_ part: Part) {
        production.removePart(part)
    }
    
    // Byproducts
    public func addByproduct(_ part: Part, producer: Recipe, consumer: Recipe) {
        production.add(producingRecipe: producer, consumingRecipe: consumer, for: part)
    }
    
    public func hasProducer(_ part: Part, recipe: Recipe) -> Bool {
        production.hasProducingRecipe(recipe, for: part)
    }
    
    public func hasConsumer(_ part: Part, recipe: Recipe) -> Bool {
        production.hasConsumingRecipe(recipe, for: part)
    }
    
    public func removeByrpoduct(_ part: Part) {
        production.removeByproduct(part: part)
    }
    
    public func removeProducer(_ recipe: Recipe, for part: Part) {
        production.removeProducingRecipe(recipe, part: part)
    }
    
    public func removeConsumer(_ recipe: Recipe, for part: Part) {
        production.removeConsumingRecipe(recipe, part: part)
    }
    
    // Output
    public func outputItem(for part: Part) -> OutputPart? {
        outputParts.first { $0.part == part }
    }
    
    public func outputRecipes(for part: Part) -> [OutputRecipe] {
        outputParts.first { $0.part == part }.map(\.recipes) ?? []
    }
    
    public func outputItemsContains(where predicate: (_ outputItem: OutputPart) throws -> Bool) rethrows -> Bool {
        try outputParts.contains(where: predicate)
    }
    
    public func outputItemsContains(part: Part) -> Bool {
        outputItemsContains { $0.part == part }
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
}

// MARK: InternalState
extension SingleItemCalculator {
    struct InternalState {
        var selectedInputParts = [Production.Content.SingleItem.InputPart]()
        var selectedByproducts = [Production.Content.SingleItem.InputByproduct]()
        
        mutating func reset(production: Production.Content.SingleItem) {
            selectedInputParts = production.inputParts
            selectedByproducts = production.byproducts
        }
        
        // MARK: Convenience helpers
        func selectedInputItem(with id: String) -> Production.Content.SingleItem.InputPart? {
            selectedInputParts.first { $0.part.id == id }
        }
        
        func index(of part: Part) -> Int? {
            selectedInputParts.firstIndex { $0.part == part }
        }
        
        func selectedByproduct(with id: String) -> Production.Content.SingleItem.InputByproduct? {
            selectedByproducts.first { $0.part.id == id }
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
        \(part.localizedName) (\(amount.formatted(.shNumber()))
        
        \(nodeDescription)
        """
    }
}
