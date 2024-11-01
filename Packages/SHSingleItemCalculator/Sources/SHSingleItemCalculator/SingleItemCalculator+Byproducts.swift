
extension SingleItemCalculator {
    func applyByproducts() {
        let allNodes = mainNodes + additionalNodes
        for node in allNodes {
            applyByproducts(from: node)
        }
    }
    
    private func applyByproducts(from node: Node) {
        for byproduct in node.byproducts {
            guard
                // Check if this byproduct is registered as produced byproduct by user.
                let registeredByproduct = internalState.selectedByproduct(with: byproduct.part.id),
                // Check if the node recipe is registered as byproduct producer.
                let registeredProducingRecipe = registeredByproduct
                    .producers
                    .first(where: { $0.recipe == node.recipe })
            else { continue }
            
            // Create a byproduct
            var byproduct = Byproduct(
                part: byproduct.part,
                recipeID: node.recipe.id,
                amount: byproduct.amount,
                consumers: registeredProducingRecipe.consumers.map {
                    Byproduct.Consumer(recipeID: $0.recipe.id, amount: 0)
                }
            )
            
            // Update tree with found byproduct from the beginning.
            findConsumers(for: &byproduct, producingNode: node)
        }
        
        for node in node.inputNodes {
            applyByproducts(from: node)
        }
    }
    
    private func findConsumers(for byproduct: inout Byproduct, producingNode: Node) {
        let allNodes = mainNodes + additionalNodes
        for node in allNodes {
            guard !byproduct.consumedCompletely else { return }
            
            findConsumers(in: node, byproduct: &byproduct, producingNode: producingNode)
        }
        
        func findConsumers(in node: Node, byproduct: inout Byproduct, producingNode: Node) {
            if
                // Check if this node's recipe is registered as consumer for found producing byproduct.
                let consumingRecipeIndex = byproduct.consumers.firstIndex(where: { $0.recipeID == node.recipe.id }),
                // Find an input which should consume a specified item.
                let (inputIndex, input) = node.inputs.enumerated().first(where: { $0.1.part == byproduct.part })
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
