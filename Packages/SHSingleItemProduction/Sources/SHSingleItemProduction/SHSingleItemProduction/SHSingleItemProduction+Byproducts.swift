import SHModels

extension SHSingleItemProduction {
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
    
    private func update(foundByproduct: inout Byproduct, producingNode: Node) {
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
}
