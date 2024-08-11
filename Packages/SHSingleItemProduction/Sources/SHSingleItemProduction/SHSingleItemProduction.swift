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
    
    private var mainNodes = [Node]()
    private var additionalNodes = [Node]()
    
    private var internalState = InternalState()
    
    @Dependency(\.uuid)
    private var uuid
    
    // MARK: Observed properties
    public var input: Input
    public private(set) var outputItems = [OutputItem]()
    
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
        additionalNodes = []
        
        // Create nodes for final product recipes
        buildMainNodes()
        
        // Build a tree
        buildMainTree()
        
        // Build additional trees
        buildAdditionalTrees()
        
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

// MARK: Private
private extension SHSingleItemProduction {
    /// Creates root recipes nodes for production product.
    func buildMainNodes() {
        guard let productionProduct = internalState.selectedInputItem(with: item.id) else { return }
        
        // Get amounts without auto
        var amounts: [Double?] = productionProduct.recipes.map { productionRecipe in
            switch productionRecipe.proportion {
            case let .fixed(fixedAmount): fixedAmount
            case let .fraction(fraction): amount * fraction
            case .auto: nil
            }
        }
        
        // Calculate how many auto there are
        let autoCount = amounts.filter { $0 == nil }.count
        
        // Get amount left for auto
        let unusedAmount = amount - amounts.reduce(0.0) { partialResult, amount in
            if let amount {
                partialResult + amount
            } else {
                partialResult
            }
        }
        
        // Update auto amounts from what is left
        for index in amounts.indices {
            if amounts[index] == nil {
                amounts[index] = unusedAmount / Double(autoCount)
            }
        }
        
        mainNodes = zip(productionProduct.recipes, amounts).compactMap { productionRecipe, amount in
            guard let amount else { return nil }
            
            return Node(id: uuid(), item: item, recipe: productionRecipe.recipe, amount: amount)
        }
    }
    
    func buildMainTree() {
        for node in mainNodes {
            // Build tree node by node.
            buildNode(node)
        }
    }
    
    func buildAdditionalTrees() {
        for node in additionalNodes {
            buildAdditionalNode(node)
        }
    }
    
    /// Populates a recipe node with recipe, amounts and collects producing byproducts from recipe node. Recursively does the same for input recipe nodes.
    /// - Parameter recipeNode: A recipe node in question.
    func buildNode(_ node: Node) {
        registerByproducts(from: node)
        
        for (inputIndex, input) in node.inputs.enumerated() {
            buildInputNode(for: node, input: input, inputIndex: inputIndex)
        }
        
        // Repeat process for each input node
        for node in node.inputNodes {
            buildNode(node)
        }
    }
    
    func buildInputNode(for node: Node, input: Node.Input, inputIndex: Int) {
        addByproductConsumers(to: node, item: input.item, inputIndex: inputIndex)
        
        // Check if user selected a recipe for an input.
        guard let inputItemIndex = internalState.index(of: input.item) else { return }
        
        // Convenience selected item.
        let inputItem = internalState.selectedInputItems[inputItemIndex]
        
        // Get available amount of input based on recipeNode recipe
        let inputAmount = input.availableAmount
        
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
        let amountForFractions = inputItem.recipes.reduce(inputAmount) { partialResult, productionRecipe in
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
        let amountForAutos = inputItem.recipes.reduce(amountForFractions) { partialResult, productionRecipe in
            guard case let .fraction(fraction) = productionRecipe.proportion else {
                return partialResult
            }
            
            return partialResult - amountForFractions * fraction
        }
        
        let amountOfAutoRecipes = inputItem.recipes.filter { $0.proportion == .auto }.count
        
        for (inputRecipeIndex, inputRecipe) in inputItem.recipes.enumerated() {
            buildInputRecipeNode(
                to: node,
                input: input,
                inputItem: inputItem,
                inputItemIndex: inputItemIndex,
                inputRecipe: inputRecipe,
                inputRecipeIndex: inputRecipeIndex,
                inputAmount: inputAmount,
                amountForFractions: amountForFractions,
                amountForAutos: amountForAutos,
                amountOfAutoRecipes: amountOfAutoRecipes
            )
        }
    }
    
    func buildInputRecipeNode(
        to node: Node,
        input: Node.Input,
        inputItem: InputItem,
        inputItemIndex: Int,
        inputRecipe: InputRecipe,
        inputRecipeIndex: Int,
        inputAmount: Double,
        amountForFractions: Double,
        amountForAutos: Double,
        amountOfAutoRecipes: Int
    ) {
        // Safety check if input node contains selected recipe. If this happens, this is logical error.
        guard !node.inputContains(inputRecipe.recipe) else { return }
        
        var inputAmount = inputAmount
        
        if inputRecipe.recipe.id == node.parentRecipeNode?.recipe.id {
            // If input recipe is the same as parent recipe (recycled plastic/rubber, packaged/unpackaged recipes)
            guard
                let parentRecipeNode = node.parentRecipeNode,
                let input = parentRecipeNode.inputs.first(where: { $0.item.id == node.item.id })
            else { return }
            
            // If selected recipe (and parent node recipe) has fixed proportion, do not spawn additional node.
            let proportion = inputRecipe.proportion
            switch proportion {
            case .fixed: return
            case .auto, .fraction: break
            }
            
            // Calculate difference between amount of item produced by parent recipe for input and amount of item in the input.
            var nodeAmountForFractions = input.amount
            if let nodeItemIndex = self.input.inputItems.firstIndex(item: node.item) {
                let nodeItem = self.input.inputItems[nodeItemIndex]
                nodeAmountForFractions = nodeItem.recipes.reduce(input.amount) { partialResult, productionRecipe in
                    guard case let .fixed(amount) = productionRecipe.proportion else {
                        return partialResult
                    }
                    
                    return partialResult - amount
                }
            }
            
            let nodeMultiplier = nodeAmountForFractions / inputAmount
            let parentMultiplier = parentRecipeNode.amount / input.amount
            let producedParentAmount = inputAmount * nodeMultiplier * parentMultiplier
            let producedDifference = producedParentAmount - inputAmount
            
            // If parent produces the same amount as input, we have a packaged/unpackaged situation, which cannot be reduced.
            // Ignore such cases.
            guard producedDifference > 0 else { return }
            
            // In any other case we can calculate an additional amount of item which can be used an current input.
            let producedParentMultiplier = producedParentAmount / producedDifference
            let additionalAmount = (producedParentAmount * producedParentMultiplier) - producedParentAmount
            
            // Accumulate additional node. This will be calculated later.
            let additionalNode = Node(
                id: uuid(),
                item: parentRecipeNode.item,
                recipe: parentRecipeNode.recipe,
                amount: additionalAmount
            )
            additionalNodes.append(additionalNode)
        } else if inputItem.item.id != node.parentRecipeNode?.item.id {
            // If input item is not the same as parent output item.
            
            // Update tree node amount value based on production recipe proportion value.
            switch inputRecipe.proportion {
            case let .fixed(amount):
                guard amount > 0 else { return }
                
                if inputAmount >= amount {
                    /// This node requires bigger amount of product than proportion amount can provide.
                    /// In this case we just reduce node amount by proportion amount.
                    ///
                    /// Example:
                    /// Input requires 420 items/min.
                    /// Proportion provides 310 items/min.
                    ///   Tree node will get 310.
                    inputAmount = amount
                    
                    // Also update production recipe proportion to acomodate deduction for tree node.
                    // From previous example available 420 items/min is deducted to 110 items/min.
                    internalState.selectedInputItems[inputItemIndex].recipes[inputRecipeIndex].proportion = .fixed(inputAmount - amount)
                } else {
                    // This node requires less items/min than current production recipe can provide.
                    // Do not modify tree node amount, but update production recipe proportion value
                    internalState.selectedInputItems[inputItemIndex].recipes[inputRecipeIndex].proportion = .fixed(amount - inputAmount)
                }
                
            case let .fraction(fraction):
                // Fractions are simple. Take available for fractions amoun and multiply it by fraction value.
                // Production recipe proportion does not have to change.
                inputAmount = amountForFractions * fraction
                
            case .auto:
                // Auto take amount of item left after fixed and fraction and devide it equally between themselves.
                inputAmount = amountForAutos / Double(amountOfAutoRecipes)
            }
            
            // Do not create input nodes for inputs with zero or lower amount.
            guard inputAmount > 0 else { return }
            
            let inputNode = Node(
                id: uuid(),
                item: input.item,
                recipe: inputRecipe.recipe,
                amount: inputAmount
            )
            node.add(inputNode)
        }
    }
    
    func buildAdditionalNode(_ node: Node) {
        registerByproducts(from: node)
        
        for (inputIndex, input) in node.inputs.enumerated() {
            buildAdditionalInputNode(for: node, input: input, inputIndex: inputIndex)
        }
        
        // Repeat process for each input node
        for node in node.inputNodes {
            buildAdditionalNode(node)
        }
    }
    
    func buildAdditionalInputNode(for node: Node, input: Node.Input, inputIndex: Int) {
        addByproductConsumers(to: node, item: input.item, inputIndex: inputIndex)
        
        // If input item is a top-level additional item, do not handle inputs for it.
        guard !additionalNodes.contains(where: { $0.item.id == input.item.id }) else { return }
        
        // Check if user selected a recipe for an input.
        guard let inputItemIndex = internalState.index(of: input.item) else { return }
        
        // Convenience selected item.
        let inputItem = internalState.selectedInputItems[inputItemIndex]
        
        for inputRecipe in inputItem.recipes {
            buildAdditionalInputRecipeNode(
                to: node,
                input: input,
                inputItem: inputItem,
                inputRecipe: inputRecipe
            )
        }
    }
    
    func buildAdditionalInputRecipeNode(
        to node: Node,
        input: Node.Input,
        inputItem: InputItem,
        inputRecipe: InputRecipe
    ) {
        // Safety check if input node contains selected recipe. If this happens, this is logical error.
        guard !node.inputContains(inputRecipe.recipe) else { return }
        
        // Do not handle fixed recipes in additional nodes. This will be calculated completely in main nodes.
        switch inputRecipe.proportion {
        case .fixed: return
        case .auto, .fraction: break
        }
        
        var inputAmount = input.availableAmount
        
        // Since fixed recipes are not allowed in additional nodes, amount for fractions will be the whole amount available for input.
        let amountForFractions = inputAmount
        
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
        let amountForAutos = inputItem.recipes.reduce(amountForFractions) { partialResult, productionRecipe in
            guard case let .fraction(fraction) = productionRecipe.proportion else {
                return partialResult
            }
            
            return partialResult - amountForFractions * fraction
        }
        
        let amountOfAutoRecipes = inputItem.recipes.filter { $0.proportion == .auto }.count
        
        // Update tree node amount value based on production recipe proportion value.
        switch inputRecipe.proportion {
        case .fixed:
            // We should never be here, but if we still are somehow, just return.
            return
            
        case let .fraction(fraction):
            // Fractions are simple. Take available for fractions amoun and multiply it by fraction value.
            // Production recipe proportion does not have to change.
            inputAmount = amountForFractions * fraction
            
        case .auto:
            // Auto take amount of item left after fixed and fraction and devide it equally between themselves.
            inputAmount = amountForAutos / Double(amountOfAutoRecipes)
        }
        
        // Do not create input nodes for inputs with zero or lower amount.
        guard inputAmount > 0 else { return }
        
        // Additional nodes do not handle cases where input recipe is the same as parent recipe (recycled plastic/rubber, packaged/unpackaged recipes).
        guard inputRecipe.id != node.parentRecipeNode?.recipe.id else { return }
        
        // Input is new, item is not the same as parent output item and recipe is not fixed propotion. Add it.
        let inputNode = Node(
            id: uuid(),
            item: input.item,
            recipe: inputRecipe.recipe,
            amount: inputAmount
        )
        node.add(inputNode)
    }
    
    func registerByproducts(from node: Node) {
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
    }
    
    func addByproductConsumers(to node: Node, item: any Item, inputIndex: Int) {
        // Check if there are byproduct producers for an input item and input is consuming them.
        let producers = internalState.byproducts
            .filter { $0.item.id == item.id }
            .map {
                let consumed = $0.consumedAmount(of: node.recipe)
                return Node.Input.ByproductProducer(recipeID: $0.recipeID, amount: consumed)
            }

        if !producers.isEmpty {
            // If producers found and input is consuming, attach them.
            node.inputs[inputIndex].byproductProducers = producers
        }
    }
    
    func update(foundByproduct: inout Byproduct, producingNode: Node) {
        for node in mainNodes {
            guard !foundByproduct.consumedCompletely else { return }
            
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
                    node.inputs[inputIndex].byproductProducers.append(
                        Node.Input.ByproductProducer(recipeID: foundByproduct.recipeID, amount: availableAmount)
                    )
                }
                
                // Store consumed value in found producing byproduct
                foundByproduct.consumers[consumingRecipeIndex].amount = availableAmount
                // Update producing node as well
                for (byproductIndex, byproduct) in producingNode.byproducts.enumerated() {
                    if let consumerIndex = byproduct.consumers.firstIndex(where: { $0.recipeID == node.recipe.id }) {
                        producingNode.byproducts[byproductIndex].consumers[consumerIndex].amount += availableAmount
                    } else {
                        producingNode.byproducts[byproductIndex].consumers.append(
                            Node.Byproduct.Consumer(recipeID: node.recipe.id, amount: availableAmount)
                        )
                    }
                }
            }
            
            // Check if there are still not found consumers for found producing recipe (i.e. if any consumer has 0.0 amount).
            guard !foundByproduct.consumedCompletely else { return }
            
            // Repeat for children
            for inputNode in node.inputNodes {
                update(inputNode, with: &foundByproduct, producingNode: producingNode)
            }
        }
    }
    
    func buildOutput() {
        var nodes = mainNodes
        var outputItems = [OutputItem]()
        var ingredientConverter = IngredientConverter()
        
        func isSelected(_ input: Node.Input, node: Node) -> Bool {
            self.input.inputItems.contains(input.item)
        }
        
        while !nodes.isEmpty {
            for node in nodes {
                // If there is already an product in output.
                if let productIndex = outputItems.firstIndex(where: { $0.item.id == node.item.id }) {
                    // And if there is already a recipe for a product in output.
                    if let recipeIndex = outputItems[productIndex].recipes.firstIndex(where: { $0.recipe.id == node.recipe.id }) {
                        // Accumulate saved values with new values.
                        var recipe = outputItems[productIndex].recipes[recipeIndex]
                        recipe.output.amount += node.amount
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
                                id: uuid(),
                                recipe: node.recipe,
                                output: SHSingleItemProduction.OutputRecipe.OutputIngredient(
                                    id: uuid(),
                                    item: node.item,
                                    amount: node.amount
                                ),
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
                        .first(item: node.item)?
                        .recipes
                        .first(where: { $0.recipe == node.recipe })?
                        .proportion ?? .auto
                    
                    let product = OutputItem(
                        id: uuid(),
                        item: node.item,
                        recipes: [OutputRecipe(
                            id: uuid(),
                            recipe: node.recipe,
                            output: SHSingleItemProduction.OutputRecipe.OutputIngredient(
                                id: uuid(),
                                item: node.item,
                                amount: node.amount
                            ),
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
            }
            
            nodes = nodes.flatMap(\.inputNodes)
        }
        
        // Handle additional trees to represent additional amounts in output ingredients.
        nodes = additionalNodes
        while !nodes.isEmpty {
            for node in nodes {
                guard
                    let (outputIndex, output) = outputItems.enumerated().first(where: { $0.1.item.id == node.item.id }),
                    let recipeIndex = output.recipes.firstIndex(where: { $0.recipe.id == node.recipe.id })
                else { continue }
                
                // Accumulate saved values with new values.
                var recipe = output.recipes[recipeIndex]
                
                if additionalNodes.contains(where: { $0.id == node.id }) {
                    // If node is top node in additional nodes, append additional amount
                    recipe.output.additionalAmounts.append(node.amount)
                } else if !additionalNodes.contains(where: { $0.item.id == node.item.id }) {
                    // Otherwise accumulate normal amount
                    recipe.output.amount += node.amount
                }
                recipe.byproducts.merge(with: node.byproducts.map {
                    ingredientConverter.convert(producingRecipeID: recipe.recipe.id, byproduct: $0)
                })
                recipe.inputs.merge(with: node.inputs.map { input in
                    ingredientConverter.convert(
                        input: input,
                        isSelected: isSelected(input, node: node)
                    )
                })
                outputItems[outputIndex].recipes[recipeIndex] = recipe
            }
            
            nodes = nodes.flatMap(\.inputNodes)
        }
        
        self.outputItems = outputItems
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
        var nodes = mainNodes
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

// MARK: Ingredient convertion
private extension SHSingleItemProduction {
    struct IngredientConverter {
        var byproductConverter = ByproductConverter()
        
        @Dependency(\.uuid)
        private var uuid
        
        mutating func convert(producingRecipeID: String, byproduct: SHSingleItemProduction.Node.Byproduct) -> SHSingleItemProduction.OutputRecipe.ByproductIngredient {
            SHSingleItemProduction.OutputRecipe.ByproductIngredient(
                id: uuid(),
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
                id: uuid(),
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

// MARK: Merging
private extension [SHSingleItemProduction.OutputRecipe.OutputIngredient] {
    mutating func merge(with other: Self) {
        merge(with: other) {
            $0.item.id == $1.item.id
        } merging: {
            $0.amount += $1.amount
        }
    }
}

private extension [SHSingleItemProduction.OutputRecipe.ByproductIngredient] {
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
