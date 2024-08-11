
extension SHSingleItemProduction {
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
}
