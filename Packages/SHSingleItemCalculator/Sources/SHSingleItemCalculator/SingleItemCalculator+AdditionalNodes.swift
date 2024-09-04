import SHModels

extension SingleItemCalculator {
    func buildAdditionalTrees() {
        for node in additionalNodes {
            buildAdditionalNode(node)
        }
    }
    
    private func buildAdditionalNode(_ node: SingleItemCalculator.Node) {
        for (inputIndex, input) in node.inputs.enumerated() {
            buildAdditionalInputNode(for: node, input: input, inputIndex: inputIndex)
        }
        
        // Repeat process for each input node
        for node in node.inputNodes {
            buildAdditionalNode(node)
        }
    }
    
    private func buildAdditionalInputNode(
        for node: SingleItemCalculator.Node,
        input: SingleItemCalculator.Node.Input,
        inputIndex: Int
    ) {
        // If input item is a top-level additional item, do not handle inputs for it.
        guard node.item.id != input.item.id else { return }
        
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
    
    private func buildAdditionalInputRecipeNode(
        to node: SingleItemCalculator.Node,
        input: SingleItemCalculator.Node.Input,
        inputItem: SingleItemProduction.InputItem,
        inputRecipe: SingleItemProduction.InputRecipe
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
        guard inputRecipe.recipe != node.parentRecipeNode?.recipe else { return }
        
        // Input is new, item is not the same as parent output item and recipe is not fixed propotion. Add it.
        let inputNode = SingleItemCalculator.Node(
            id: uuid(),
            item: input.item,
            recipe: inputRecipe.recipe,
            amount: inputAmount
        )
        node.add(inputNode)
    }
}
