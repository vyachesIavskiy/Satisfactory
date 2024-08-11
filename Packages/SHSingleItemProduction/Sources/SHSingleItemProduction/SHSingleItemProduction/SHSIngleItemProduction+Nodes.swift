import SHModels

extension SHSingleItemProduction {
    /// Creates root recipes nodes for production product.
    func buildNodes() {
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
        
        nodes = zip(productionProduct.recipes, amounts).compactMap { productionRecipe, amount in
            guard let amount else { return nil }
            
            return Node(id: uuid(), item: item, recipe: productionRecipe.recipe, amount: amount)
        }
    }
    
    func buildTree() {
        for node in nodes {
            // Build tree node by node.
            buildNode(node)
        }
    }
    
    /// Populates a recipe node with recipe, amounts and collects producing byproducts from recipe node. Recursively does the same for input recipe nodes.
    /// - Parameter recipeNode: A recipe node in question.
    private func buildNode(_ node: Node) {
        registerByproducts(from: node)
        
        for (inputIndex, input) in node.inputs.enumerated() {
            buildInputNode(for: node, input: input, inputIndex: inputIndex)
        }
        
        // Repeat process for each input node
        for node in node.inputNodes {
            buildNode(node)
        }
    }
    
    private func buildInputNode(for node: Node, input: Node.Input, inputIndex: Int) {
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
    
    private func buildInputRecipeNode(
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
            
            // Spawn a new subproduction. This will be calculated after a main production.
            subproductions.append(
                Subproduction(
                    item: parentRecipeNode.item,
                    recipe: parentRecipeNode.recipe,
                    amount: additionalAmount,
                    parentInput: self.input
                )
            )
        } else if !node.anyParentContains(where: { $0.item.id == inputItem.item.id }) {
            // If input item is not an output item of any parent node.
            
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
}

// MARK: Byproducts
private extension SHSingleItemProduction {
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
            var byproduct = Byproduct(
                item: byproduct.item,
                recipeID: node.recipe.id,
                amount: byproduct.amount,
                consumers: registeredProducingRecipe.consumers.map {
                    Byproduct.Consumer(recipeID: $0.id, amount: 0)
                }
            )
            
            // Update tree with found byproduct from the beginning.
            findConsumers(for: &byproduct, producingNode: node)
            
            // Save created byproduct.
            internalState.byproducts.merge(with: [byproduct])
        }
    }
    
    func addByproductConsumers(to node: Node, item: any Item, inputIndex: Int) {
        // Check if there are byproduct producers for an input item and input is consuming them.
        let producers: [Node.Input.ByproductProducer] = internalState.byproducts
            .filter { $0.item.id == item.id }
            .compactMap {
                let consumed = $0.consumedAmount(of: node.recipe)
                guard consumed > 0 else { return nil }
                
                return Node.Input.ByproductProducer(recipeID: $0.recipeID, amount: consumed)
            }

        if !producers.isEmpty {
            // If producers found and input is consuming, attach them.
            node.inputs[inputIndex].byproductProducers = producers
        }
    }
    
    func findConsumers(for byproduct: inout Byproduct, producingNode: Node) {
        for node in nodes {
            guard !byproduct.consumedCompletely else { return }
            
            findConsumers(in: node, byproduct: &byproduct, producingNode: producingNode)
        }
        
        func findConsumers(in node: Node, byproduct: inout Byproduct, producingNode: Node) {
            if
                // Check if this node's recipe is registered as consumer for found producing byproduct.
                let consumingRecipeIndex = byproduct.consumers.firstIndex(where: { $0.recipeID == node.recipe.id }),
                // Find an input which should consume a specified item.
                let (inputIndex, input) = node.inputs.enumerated().first(where: { $0.1.item.id == byproduct.item.id })
            {
                // Determine how much of a product this input can consume
                let availableAmount = min(input.availableAmount, byproduct.amount)
                // Update consumed value
                if let index = node.inputs[inputIndex].byproductProducers.firstIndex(where: { byproduct.recipeID == $0.recipeID }) {
                    node.inputs[inputIndex].byproductProducers[index].amount += availableAmount
                } else {
                    node.inputs[inputIndex].byproductProducers.append(
                        Node.Input.ByproductProducer(recipeID: byproduct.recipeID, amount: availableAmount)
                    )
                }
                
                node.updateInputs()
                
                // Store consumed value in found producing byproduct
                byproduct.consumers[consumingRecipeIndex].amount = availableAmount
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
            guard !byproduct.consumedCompletely else { return }
            
            // Repeat for children
            for inputNode in node.inputNodes {
                findConsumers(in: inputNode, byproduct: &byproduct, producingNode: producingNode)
            }
        }
    }
}
