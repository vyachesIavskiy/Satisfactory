import Foundation
import SHStorage
import SHModels
import SHUtils

public final class SHSingleItemProduction {
    private var input: Input
    private(set) var output: Output
    
    public var item: any Item {
        input.finalItem
    }
    
    public var amount: Double {
        get { input.amount }
        set { input.amount = newValue }
    }
    
    public var outputItems: [OutputItem] {
        output.outputItems
    }
    
    private var rootNodes = [Node]()
    private var internalState = InternalState()
    private var balancingState = BalancingState.unchecked
    
    public init(item: any Item) {
        input = Input(finalItem: item, amount: 1.0)
        output = Output(outputItems: [], unselectedItems: [item], hasByproducts: false)
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
        output.outputItems.first { $0.item.id == item.id }
    }
    
    public func outputRecipes(for item: any Item) -> [OutputRecipe] {
        output.outputItems.first { $0.item.id == item.id }.map(\.recipes) ?? []
    }
    
    public func outputItemsContains(where predicate: (_ outputItem: OutputItem) throws -> Bool) rethrows -> Bool {
        try output.outputItems.contains(where: predicate)
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
        
        // Create nodes for final product recipes
        buildRootNodes()
        
        // Build a tree
        buildTree()
        
        // Build and return an output
        buildOutput()
    }
}

// MARK: Private
private extension SHSingleItemProduction {
    /// Creates root recipes nodes for production product.
    /// - Parameter userInput: A user selected data used to populate a production tree.
    func buildRootNodes() {
        guard let productionProduct = internalState.selectedInputItem(with: item.id) else { return }
        
        // Get amounts without auto
        var amounts = productionProduct.recipes.map { productionRecipe in
            switch productionRecipe.proportion {
            case let .fixed(fixedAmount): fixedAmount
            case let .fraction(fraction): amount * fraction
            case .auto: 0.0
            }
        }
        
        // Calculate how many auto there are
        let autoCount = amounts.filter { $0.isZero }.count
        
        // Get amount left for auto
        let unusedAmount = amount - amounts.reduce(0.0, +)
        
        // Update auto amounts from what is left
        for index in amounts.indices {
            if amounts[index].isZero {
                amounts[index] = unusedAmount / Double(autoCount)
            }
        }
        
        rootNodes = zip(productionProduct.recipes, amounts).map { productionRecipe, amount in
            Node(item: item, recipe: productionRecipe.recipe, amount: amount)
        }
    }
    
    func buildTree() {
        balancingState = .unchecked
        
        // Depending on the primary item byproduct calculation can happen more than once.
        repeat {
            switch balancingState {
            case .restart:
                // If we restart, reset internal state
                internalState.reset(input: input)
                
                fallthrough
            case .unchecked:
                // If primary product is registered as byproduct, get all producing byproduct recipes.
                let primaryByproducts = internalState.selectedByproduct(with: item.id).map { byproduct in
                    byproduct.producers
                        .filter { rootNodes.map(\.recipe).contains($0.recipe) }
                        .map {
                            Byproduct(
                                item: item,
                                recipeID: $0.recipe.id,
                                amount: 0.0,
                                consumers: $0.consumers.map {
                                    Byproduct.Consumer(recipeID: $0.id, amount: 0.0)
                                }
                            )
                    }
                }
                
                if let primaryByproducts {
                    // Primary product is registered as byproduct. Start calculation cycles.
                    balancingState = .balancing(primaryItemByproducts: primaryByproducts)
                } else {
                    // Primary product is not registered as byproduct, build in one cycle
                    balancingState = .notNeeded
                }
            
            default:
                break
            }
            
            // A single calculation cycle
            for node in rootNodes {
                // During calculation we can deside to recalculate whole tree. Break early if this happens
                guard !balancingState.shouldRebalance else { break }
                
                // Build tree node by node.
                buildNode(node)
            }
            
        } while balancingState.shouldRebalance
    }
    
    /// Populates a recipe node with recipe, amounts and collects producing byproducts from recipe node. Recursively does the same for input recipe nodes.
    /// - Parameter recipeNode: A recipe node in question.
    func buildNode(_ node: Node) {
        // Check recipe node byproducts first.
        for byproduct in node.byproducts {
            guard
                // Check if this byproduct is registered as produced byproduct by user.
                let registeredByproduct = internalState.selectedByproduct(with: byproduct.item.id),
                // Check if the node recipe is registered as byproduct producer.
                let registeredProducingRecipe = registeredByproduct
                    .producers
                    .first(where: { $0.recipe == node.recipe })
            else { continue }
            
            // Create a byproduct
            var producingByproduct = Byproduct(
                item: byproduct.item,
                recipeID: node.recipe.id,
                amount: byproduct.amount,
                consumers: registeredProducingRecipe.consumers.map {
                    Byproduct.Consumer(recipeID: $0.id, amount: 0)
                }
            )
            
            // Update tree with found byproduct from the beginning.
            update(foundByproduct: &producingByproduct, producingNode: node)
            
            // Save created byproduct.
            internalState.byproducts.merge(with: [producingByproduct])
        }
        
        for (inputIndex, input) in node.inputs.enumerated() {
            // Check if user selected a recipe for an input.
            guard let productIndex = internalState.index(of: input.item) else { continue }
            
            // Check if there are byproduct producers for an input item and input is consuming them.
            let producers = internalState.byproducts
                .filter { $0.item.id == input.item.id }
                .map {
                    let consumed = $0.consumers.filter { $0.recipeID == node.recipe.id }.reduce(0.0) { $0 + $1.amount }
                    return Node.Input.ByproductProducer(recipeID: $0.recipeID, amount: consumed)
                }

            if !producers.isEmpty {
                // If producers found and input is consuming, attach them.
                node.inputs[inputIndex].byproductProducers = producers
            }
            
            // Check for primary byproduct
            if case var .balancing(primaryItemByproducts) = balancingState {
                // If input is a consumer of primary byproduct, update consumer's amount.
                for (byproductIndex, byproduct) in primaryItemByproducts.enumerated() {
                    if let consumingIndex = byproduct.consumers.firstIndex(where: { $0.recipeID == node.recipe.id }) {
                        primaryItemByproducts[byproductIndex].consumers[consumingIndex].amount = input.availableAmount
                    }
                }
                
                // Check if there are primary product byproduct producers for an input item and input is consuming them.
                let producers = primaryItemByproducts
                    .filter { $0.item.id == input.item.id }
                    .map {
                        let consumed = $0.consumers.filter { $0.recipeID == node.recipe.id }.reduce(0.0) { $0 + $1.amount }
                        return Node.Input.ByproductProducer(recipeID: $0.recipeID, amount: consumed)
                    }
                
                if !producers.isEmpty {
                    // If producers found and input is consuming, attach them.
                    node.inputs[inputIndex].byproductProducers = producers
                }
                
                // Save updated primary byproducts
                balancingState = .balancing(primaryItemByproducts: primaryItemByproducts)
                
                // Check if all consumers of primary byproduct set their amounts.
                if
                    !primaryItemByproducts.filter({ $0.consumers.contains { $0.recipeID == node.recipe.id } }).isEmpty,
                    primaryItemByproducts.allSatisfy({ $0.consumers.allSatisfy { $0.amount > 0 } })
                {
                    // By this time we have a sub tree which has enough data to evaluate primary item amounts.
                    
                    let totalConsumedAmount = primaryItemByproducts.reduce(0.0) { $0 + $1.totalConsumingAmount }
                    let totalProducedAmount = rootNodes.reduce(0.0) { $0 + $1.output.asByproduct.amount }
                    
                    if totalConsumedAmount == totalProducedAmount {
                        // Save primary item byproducts to reflect them in Output.
                        internalState.byproducts.merge(with: primaryItemByproducts)
                        // Consumed amount of byproduct is equal to produced amount. No need for further adjustments.
                        balancingState = .balanced
                    } else {
                        // Consumed amount is different (bigger) than produced amount. Need to adjust primary item byproduct
                        // amount and restart calculation.
                        updateRootNodesWithByproductAmount(primaryItemByproducts)
                        balancingState = .restart
                        return
                    }
                }
            }
            
            // Get available amount of input based on recipeNode recipe
            var inputNodeAmount = input.availableAmount
            
            // Convenience product.
            let product = internalState.selectedInputItems[productIndex]
            
            /// Calculate input amount without fixed recipe proportions.
            /// This amount will be used as base amount for fraction proportions.
            ///
            /// Example:
            /// Item amount is 563
            /// Item has 4 recipes:
            ///   Recipe1: .fixed(100)
            ///   Recipe2: .fixed(125)
            ///   Recipe3: .fraction(0.4)
            ///   Recipe4: .auto
            /// Returned amount will be: 563 - 100 - 125 = 338.
            let inputAmountForFractionProportions = product.recipes.reduce(inputNodeAmount) { partialResult, productionRecipe in
                guard case let .fixed(amount) = productionRecipe.proportion else {
                    return partialResult
                }
                
                return partialResult - amount
            }
            
            /// Calculate input amount for auto recipe proportions.
            /// This amount will be used as base amount for auto proportions.
            ///
            /// Example:
            /// Item amount is 563
            /// Item has 4 recipes:
            ///   Recipe1: .fixed(100)
            ///   Recipe2: .fixed(125)
            ///   Recipe3: .fraction(0.4)
            ///   Recipe4: .auto
            /// Returned amount will be: 563 - 100 - 125 - (338 x 0.4) = 202.8 (0.6 of available amount for fractions)
            let inputAmountForAutoProportions = product.recipes.reduce(inputAmountForFractionProportions) { partialResult, productionRecipe in
                guard case let .fraction(fraction) = productionRecipe.proportion else {
                    return partialResult
                }
                
                return partialResult - inputAmountForFractionProportions * fraction
            }
            
            let autoCount = product.recipes.filter { $0.proportion == .auto }.count
            
            for (productionRecipeIndex, productionRecipe) in product.recipes.enumerated() {
                // Update tree node amount value based on production recipe proportion value.
                switch productionRecipe.proportion {
                case let .fixed(amount):
                    guard amount > 0 else { continue }
                    
                    if inputNodeAmount >= amount {
                        /// This node requires bigger amount of product than proportion amount can provide.
                        /// In this case we just reduce node amount by proportion amount.
                        ///
                        /// Example:
                        /// Input requires 420 items/min.
                        /// Proportion provides 310 items/min.
                        ///   Tree node will get 310.
                        inputNodeAmount = amount
                        
                        // Also update production recipe proportion to acomodate deduction for tree node.
                        // From previous example available 420 items/min is deducted to 110 items/min.
                        internalState.selectedInputItems[productIndex].recipes[productionRecipeIndex].proportion = .fixed(inputNodeAmount - amount)
                    } else {
                        // This node requires less items/min than current production recipe can provide.
                        // Do not modify tree node amount, but update production recipe proportion value
                        internalState.selectedInputItems[productIndex].recipes[productionRecipeIndex].proportion = .fixed(amount - inputNodeAmount)
                    }
                    
                case let .fraction(fraction):
                    // Fractions are simple. Take available for fractions amoun and multiply it by fraction value.
                    // Production recipe proportion does not have to change.
                    inputNodeAmount = inputAmountForFractionProportions * fraction
                    
                case .auto:
                    // Auto take amount of item left after fixed and fraction and devide it equally between themselves.
                    inputNodeAmount = inputAmountForAutoProportions / Double(autoCount)
                }
                
                // In case amount for next tree node is 0, we do not include this node.
                guard inputNodeAmount > 0 else { continue }
                
                // Check if there is an input node with current recipe. If this happens, this is logical error.
                if !node.inputContains(productionRecipe.recipe) {
                    guard productionRecipe.recipe.id != node.parentRecipeNode?.recipe.id else {
                        // Trying to add recipe which is a parent recipe for current recipe node.
                        // This might happen when upackaged/packaged recipes can infinitely point to each other.
                        // In this case we break recursion.
                        continue
                    }
                    
                    let inputNode = Node(item: input.item, recipe: productionRecipe.recipe, amount: inputNodeAmount)
                    node.add(inputNode)
                }
            }
        }
        
        // Repeat process for each input node
        for node in node.inputNodes {
            guard !balancingState.shouldRebalance else { return }
            
            buildNode(node)
        }
    }
    
    func update(foundByproduct: inout Byproduct, producingNode: Node) {
        for node in rootNodes {
            update(node, with: &foundByproduct, producingNode: producingNode)
        }
        
        func update(_ node: Node, with foundByproduct: inout Byproduct, producingNode: Node) {
            if
                // Check if this node's recipe is registered as consumer for found producing byproduct.
                let consumingRecipeIndex = foundByproduct.consumers.firstIndex(where: { $0.recipeID == node.recipe.id }),
                // Find an input which should consume a specified item.
                let (inputIndex, input) = node.inputs.enumerated().first(where: { $0.1.item.id == foundByproduct.item.id })
            {
                // Determine how much of a product this input can consume
                let availableAmount = min(input.availableAmount, foundByproduct.amount)
                // Update consumed value
                if let index = node.inputs[inputIndex].byproductProducers.firstIndex(where: { foundByproduct.recipeID == $0.recipeID }) {
                    node.inputs[inputIndex].byproductProducers[index].amount += availableAmount
                } else {
                    node.inputs[inputIndex].byproductProducers.append(Node.Input.ByproductProducer(recipeID: foundByproduct.recipeID, amount: availableAmount))
                }
                // Update node's children
                node.updateInputs()
                // Store consumed value in found producing byproduct
                foundByproduct.consumers[consumingRecipeIndex].amount = availableAmount
                // Update producing node as well
                for (byproductIndex, byproduct) in producingNode.byproducts.enumerated() {
                    if let consumerIndex = byproduct.consumers.firstIndex(where: { $0.recipeID == node.recipe.id }) {
                        producingNode.byproducts[byproductIndex].consumers[consumerIndex].amount += availableAmount
                    } else {
                        producingNode.byproducts[byproductIndex].consumers.append(Node.Byproduct.Consumer(recipeID: node.recipe.id, amount: availableAmount))
                    }
                }
            }
            
            // Check if there are still not found consumers for found producing recipe (i.e. if any consumer has 0.0 amount).
            guard foundByproduct.consumers.reduce(false, { $0 || $1.amount.isZero }) else { return }
            
            // Repeat for children
            for inputNode in node.inputNodes {
                update(inputNode, with: &foundByproduct, producingNode: producingNode)
            }
        }
    }
    
    /// Updates root nodes with new byproduct amounts.
    ///
    /// This happens when primary item is used as byproduct and during calculation it is established, that amount of consumed byproduct is lower,
    /// than amount of produced.
    /// - Parameter primaryByproducts: An updated value of primary item byproducts which is used to adjust primary item byproduct amount.
    func updateRootNodesWithByproductAmount(_ primaryItemByproducts: [Byproduct]) {
        let totalAmount = primaryItemByproducts.reduce(0.0) { $0 + $1.totalConsumingAmount }
        
        for node in rootNodes {
            let multiplier = node.output.amount / self.amount
            node.output.asByproduct.amount = totalAmount * multiplier
            if let index = primaryItemByproducts.firstIndex(where: { $0.item.id == node.output.item.id }) {
                node.output.asByproduct.consumers = primaryItemByproducts[index].consumers.map {
                    Node.Output.Consumer(recipeID: $0.recipeID, amount: $0.amount)
                }
            }
            node.update()
            node.removeInputNodes()
        }
    }
    
    func buildOutput() {
        var nodes = rootNodes
        var unselectedItems = [any Item]()
        var outputItems = [OutputItem]()
        var ingredientConverter = IngredientConverter()
        
        func isSelected(_ input: Node.Input, node: Node) -> Bool {
            let isByproduct = internalState.byproducts
                .first { $0.item.id == input.item.id }?
                .consumers
                .contains { $0.recipeID == node.recipe.id } == true
            
            let isInputNode = node.inputNodes.contains { $0.output.item.id == input.item.id }
            
            return isByproduct || isInputNode
        }
        
        while !nodes.isEmpty {
            for node in nodes {
                // If there is already an product in output.
                if let productIndex = outputItems.firstIndex(where: { $0.item.id == node.output.item.id }) {
                    // And if there is already a recipe for a product in output.
                    if let recipeIndex = outputItems[productIndex].recipes.firstIndex(where: { $0.recipe.id == node.recipe.id }) {
                        // Accumulate saved values with new values.
                        var recipe = outputItems[productIndex].recipes[recipeIndex]
                        recipe.output.amount += node.output.amount
                        recipe.output.byproducts.merge(with: node.output.asByproduct.consumers.map {
                            ingredientConverter.byproductConverter.convert(producingRecipeID: node.recipe.id, outputConsumer: $0)
                        })
                        recipe.byproducts.merge(with: node.byproducts.map {
                            ingredientConverter.convert(producingRecipeID: recipe.recipe.id, byproduct: $0)
                        })
                        recipe.inputs.merge(with: node.inputs.map { input in
                            ingredientConverter.convert(
                                input: input,
                                isSelected: isSelected(input, node: node)
                            )
                        })
                        outputItems[productIndex].recipes[recipeIndex] = recipe
                    } else {
                        // If a recipe is new, add this to output product.
                        let proportion = input
                            .inputItems
                            .first(item: outputItems[productIndex].item)?
                            .recipes
                            .first(where: { $0.recipe == node.recipe })?
                            .proportion ?? .auto
                        
                        outputItems[productIndex].recipes.append(
                            OutputRecipe(
                                recipe: node.recipe,
                                output: ingredientConverter.convert(producingRecipeID: node.recipe.id, output: node.output),
                                byproducts: node.byproducts.map { ingredientConverter.convert(producingRecipeID: node.recipe.id, byproduct: $0) },
                                inputs: node.inputs.map { input in
                                    ingredientConverter.convert(
                                        input: input,
                                        isSelected: isSelected(input, node: node)
                                    )
                                },
                                proportion: proportion
                            )
                        )
                    }
                } else {
                    // If a product is new, add it.
                    let proportion = input
                        .inputItems
                        .first(item: node.output.item)?
                        .recipes
                        .first(where: { $0.recipe == node.recipe })?
                        .proportion ?? .auto
                    
                    let product = OutputItem(
                        item: node.output.item,
                        recipes: [OutputRecipe(
                            recipe: node.recipe,
                            output: ingredientConverter.convert(producingRecipeID: node.recipe.id, output: node.output),
                            byproducts: node.byproducts.map { ingredientConverter.convert(producingRecipeID: node.recipe.id, byproduct: $0) },
                            inputs: node.inputs.map { input in
                                ingredientConverter.convert(
                                    input: input,
                                    isSelected: isSelected(input, node: node)
                                )
                            },
                            proportion: proportion
                        )]
                    )
                    
                    // Populate producingProductID field for inputs with a newly created product
                    for productIndex in outputItems.indices {
                        for (recipeIndex, recipe) in outputItems[productIndex].recipes.enumerated() {
                            for (inputIndex, input) in recipe.inputs.enumerated() {
                                if input.item.id == product.item.id {
                                    outputItems[productIndex].recipes[recipeIndex].inputs[inputIndex].producingProductID = product.id
                                }
                            }
                        }
                    }
                    
                    outputItems.append(product)
                }
                
                for input in node.inputs {
                    @Dependency(\.storageService)
                    var storageService
                    
                    if node.inputNodes.contains(where: { $0.output.item.id == input.item.id }) {
                        if let index = unselectedItems.firstIndex(where: { $0.id == input.item.id }) {
                            unselectedItems.remove(at: index)
                        }
                    } else if 
                        !unselectedItems.contains(where: { $0.id == input.item.id }),
                        !storageService.recipes(for: input.item, as: [.output, .byproduct]).isEmpty
                    {
                        unselectedItems.append(input.item)
                    }
                }
            }
            
            nodes = nodes.flatMap(\.inputNodes)
        }
        
        output = Output(outputItems: outputItems, unselectedItems: unselectedItems, hasByproducts: !internalState.byproducts.isEmpty)
    }
}

// MARK: PrimaryByproductBalancingState
extension SHSingleItemProduction {
    enum BalancingState {
        case unchecked
        case notNeeded
        case balancing(primaryItemByproducts: [Byproduct])
        case restart
        case balanced
        
        var shouldRebalance: Bool {
            switch self {
            case .unchecked: true
            case .notNeeded: false
            case .balancing: false
            case .restart: true
            case .balanced: false
            }
        }
    }
}

// MARK: InternalState
extension SHSingleItemProduction {
    private struct InternalState {
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

// MARK: Print format
extension SHSingleItemProduction: CustomStringConvertible {
    public var description: String {
        var nodeDescription = ""
        var nodes = rootNodes
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

private extension SHSingleItemProduction {
    struct IngredientConverter {
        var byproductConverter = ByproductConverter()
        
        mutating func convert(producingRecipeID: String, output: SHSingleItemProduction.Node.Output) -> SHSingleItemProduction.OutputRecipe.OutputIngredient {
            SHSingleItemProduction.OutputRecipe.OutputIngredient(
                item: output.item,
                amount: output.amount,
                byproducts: output.asByproduct.consumers.map {
                    byproductConverter.convert(producingRecipeID: producingRecipeID, outputConsumer: $0)
                },
                isSelected: false
            )
        }
        
        mutating func convert(producingRecipeID: String, byproduct: SHSingleItemProduction.Node.Byproduct) -> SHSingleItemProduction.OutputRecipe.OutputIngredient {
            SHSingleItemProduction.OutputRecipe.OutputIngredient(
                item: byproduct.item,
                amount: byproduct.amount,
                byproducts: byproduct.consumers.map {
                    byproductConverter.convert(producerRecipeID: producingRecipeID, byproductConsumer: $0)
                },
                isSelected: !byproduct.consumers.isEmpty
            )
        }
        
        mutating func convert(
            input: SHSingleItemProduction.Node.Input,
            isSelected: Bool
        ) -> SHSingleItemProduction.OutputRecipe.InputIngredient {
            SHSingleItemProduction.OutputRecipe.InputIngredient(
                item: input.item,
                amount: input.amount,
                byproducts: input.byproductProducers.map {
                    byproductConverter.convert(inputProducer: $0)
                },
                isSelected: isSelected
            )
        }
    }
    
    struct ByproductConverter {
        private var recipeIDs = [String]()
        
        mutating func convert(
            producingRecipeID: String,
            outputConsumer: SHSingleItemProduction.Node.Output.Consumer
        ) -> SHSingleItemProduction.OutputRecipe.Byproduct {
            OutputRecipe.Byproduct(index: index(for: producingRecipeID), amount: outputConsumer.amount)
        }
        
        mutating func convert(
            producerRecipeID: String,
            byproductConsumer: SHSingleItemProduction.Node.Byproduct.Consumer
        ) -> SHSingleItemProduction.OutputRecipe.Byproduct {
            OutputRecipe.Byproduct(index: index(for: producerRecipeID), amount: byproductConsumer.amount)
        }
        
        mutating func convert(
            inputProducer: SHSingleItemProduction.Node.Input.ByproductProducer
        ) -> SHSingleItemProduction.OutputRecipe.Byproduct {
            OutputRecipe.Byproduct(index: index(for: inputProducer.recipeID), amount: inputProducer.amount)
        }

        mutating func index(for recipeID: String) -> Int {
            if let index = recipeIDs.firstIndex(of: recipeID) {
                return index
            } else {
                recipeIDs.append(recipeID)
                return recipeIDs.indices.last!
            }
        }
    }
}

private extension [SHSingleItemProduction.OutputRecipe.OutputIngredient] {
    mutating func merge(with other: Self) {
        merge(with: other) {
            $0.item.id == $1.item.id
        } merging: {
            $0.amount += $1.amount
            $0.isSelected = $0.isSelected || $1.isSelected
            $0.byproducts.merge(with: $1.byproducts)
        }
    }
}

private extension [SHSingleItemProduction.OutputRecipe.InputIngredient] {
    mutating func merge(with other: Self) {
        merge(with: other) {
            $0.item.id == $1.item.id
        } merging: {
            $0.amount += $1.amount
            $0.isSelected = $0.isSelected || $1.isSelected
            $0.byproducts.merge(with: $1.byproducts)
        }
    }
}

private extension [SHSingleItemProduction.OutputRecipe.Byproduct] {
    mutating func merge(with other: Self) {
        merge(with: other) {
            $0.index == $1.index
        } merging: {
            $0.amount += $1.amount
        }
    }
}
