import Dependencies
import SHModels

extension SHSingleItemProduction {
    final class Subproduction {
        let node: Node
        
        var internalState = InternalState()
        
        @Dependency(\.uuid)
        var uuid
        
        var input: Input
        
        init(item: any Item, recipe: Recipe, amount: Double, parentInput: Input) {
            @Dependency(\.uuid)
            var uuid
            
            node = Node(id: uuid(), item: item, recipe: recipe, amount: amount)
            input = parentInput
        }
        
        func update() {
            // Reseting internal state
            internalState.reset(input: input)
            
            // Build a tree
            buildNode(node)
        }
        
        func addToParentOutputItems(
            _ outputItems: inout [OutputItem],
            ingredientConverter: inout IngredientConverter,
            isSelected: (_ input: Node.Input, _ node: Node) -> Bool
        ) {
            // Handle additional trees to represent additional amounts in output ingredients.
            var nodes = [node]
            while !nodes.isEmpty {
                for node in nodes {
                    guard
                        let (outputIndex, output) = outputItems.enumerated().first(where: { $0.1.item.id == node.item.id }),
                        let recipeIndex = output.recipes.firstIndex(where: { $0.recipe.id == node.recipe.id })
                    else { continue }
                    
                    // Accumulate saved values with new values.
                    var recipe = output.recipes[recipeIndex]
                    
                    if self.node.id == node.id {
                        // If node is top node in additional nodes, append additional amount
                        recipe.output.additionalAmounts.append(node.amount)
                    } else {
                        // Otherwise accumulate normal amount
                        recipe.output.amount += node.amount
                    }
                    recipe.byproducts.merge(with: node.byproducts.map {
                        ingredientConverter.convert(producingRecipeID: recipe.recipe.id, byproduct: $0)
                    })
                    recipe.inputs.merge(with: node.inputs.map { input in
                        ingredientConverter.convert(
                            input: input,
                            isSelected: isSelected(input, node)
                        )
                    })
                    outputItems[outputIndex].recipes[recipeIndex] = recipe
                }
                
                nodes = nodes.flatMap(\.inputNodes)
            }
        }
    }
}

private extension SHSingleItemProduction.Subproduction {
    func buildNode(_ node: SHSingleItemProduction.Node) {
        registerByproducts(from: node)
        
        for (inputIndex, input) in node.inputs.enumerated() {
            buildInputNode(for: node, input: input, inputIndex: inputIndex)
        }
        
        // Repeat process for each input node
        for node in node.inputNodes {
            buildNode(node)
        }
    }
    
    private func buildInputNode(
        for node: SHSingleItemProduction.Node,
        input: SHSingleItemProduction.Node.Input,
        inputIndex: Int
    ) {
        addByproductConsumers(to: node, item: input.item, inputIndex: inputIndex)
        
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
        to node: SHSingleItemProduction.Node,
        input: SHSingleItemProduction.Node.Input,
        inputItem: SHSingleItemProduction.InputItem,
        inputRecipe: SHSingleItemProduction.InputRecipe
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
        let inputNode = SHSingleItemProduction.Node(
            id: uuid(),
            item: input.item,
            recipe: inputRecipe.recipe,
            amount: inputAmount
        )
        node.add(inputNode)
    }
}

private extension SHSingleItemProduction.Subproduction {
    func registerByproducts(from node: SHSingleItemProduction.Node) {
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
            var byproduct = SHSingleItemProduction.Byproduct(
                item: byproduct.item,
                recipeID: node.recipe.id,
                amount: byproduct.amount,
                consumers: registeredProducingRecipe.consumers.map {
                    SHSingleItemProduction.Byproduct.Consumer(recipeID: $0.id, amount: 0)
                }
            )
            
            // Update tree with found byproduct from the beginning.
            findConsumers(in: self.node, byproduct: &byproduct, producingNode: node)
            
            // Save created byproduct.
            internalState.byproducts.merge(with: [byproduct])
        }
    }
    
    func addByproductConsumers(to node: SHSingleItemProduction.Node, item: any Item, inputIndex: Int) {
        // Check if there are byproduct producers for an input item and input is consuming them.
        let producers: [SHSingleItemProduction.Node.Input.ByproductProducer] = internalState.byproducts
            .filter { $0.item.id == item.id }
            .compactMap {
                let consumed = $0.consumedAmount(of: node.recipe)
                guard consumed > 0 else { return nil }
                
                return SHSingleItemProduction.Node.Input.ByproductProducer(recipeID: $0.recipeID, amount: consumed)
            }

        if !producers.isEmpty {
            // If producers found and input is consuming, attach them.
            node.inputs[inputIndex].byproductProducers = producers
        }
    }
    
    func findConsumers(
        in node: SHSingleItemProduction.Node,
        byproduct: inout SHSingleItemProduction.Byproduct,
        producingNode: SHSingleItemProduction.Node
    ) {
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
                    SHSingleItemProduction.Node.Input.ByproductProducer(recipeID: byproduct.recipeID, amount: availableAmount)
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
                        SHSingleItemProduction.Node.Byproduct.Consumer(recipeID: node.recipe.id, amount: availableAmount)
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
