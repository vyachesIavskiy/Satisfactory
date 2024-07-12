import SHModels

extension SingleItemProduction {
    final class Node {
        /// A Recipe used to populate and recalculate this node.
        var recipe: Recipe
        
        var amount: Double {
            get {
                output.amount
            }
            set {
                output.amount = newValue
                updateAll()
            }
        }
        
        /// Primary output ingredient.
        ///
        /// This represents an ingredient which is primary output product for recipe node. Apart from Recipe, this can represent Recipe secondary output.
        var output: Output
        
        /// Seondary output (Byproducts) ingredients.
        ///
        /// These represent ingredients which are secondary output products for recipe node. Apart from Recipe, this can represent Recipe primary output.
        var byproducts = [Byproduct]()
        
        /// Primary input ingredient.
        ///
        /// These represent ingredients which are primary input products for recipe node. These inputs and Recipe inputs are always same.
        var inputs = [Input]()
        
        /// A link to a parent recipe node if this node's product is a parent recipe node inpput.
        weak var parentRecipeNode: Node?
        
        /// An array of input recipe nodes. Might be empty if a user did not select any recipe for an input product or if a product is a natural resource.
        var inputNodes = [Node]()
        
        init(item: any Item, recipe: Recipe, amount: Double, parentRecipeNode: Node? = nil) {
            self.recipe = recipe
            self.output = Output(item: item, amount: amount)
            self.parentRecipeNode = parentRecipeNode
            
            update()
        }
        
        /// Updates input nodes with input values crecursively.
        func updateInputs() {
            for input in inputs {
                guard
                    // Check if this input has a corresponding input node (i.e. a recipe for this input is selected).
                    let (inputNodeIndex, inputNode) = inputNodes.enumerated().first(where: { $0.1.output.item.id == input.item.id }),
                    // Check if amount is different. If not, do not update.
                    input.availableAmount != inputNode.amount
                else { continue }
                
                if input.availableAmount > 0 {
                    // If amount is not zero, update node.
                    inputNode.amount = input.availableAmount
                } else {
                    // If amount is zero, remove this node, it's obsolete.
                    inputNodes.remove(at: inputNodeIndex)
                }
            }
        }
        
        /// Updates byproducts and inputs based on output.
        func update() {
            let outputIngredients = recipe.byproducts + CollectionOfOne(recipe.output)
            let producingIngredient = outputIngredients.first { $0.item.id == output.item.id }
            
            guard let producingIngredient else {
                fatalError("Could not find ingredient for '\(output.item.localizedName)' in '\(recipe.localizedName)'")
            }
            
            let amountPerRecipe = recipe.amountPerMinute(for: producingIngredient)
            let multiplier = output.availableAmount / amountPerRecipe
            
            byproducts = outputIngredients.filter { $0.item.id != output.item.id }.map { ingredient in
                let amountPerRecipe = recipe.amountPerMinute(for: ingredient)
                return Byproduct(item: ingredient.item, amount: amountPerRecipe * multiplier)
            }
            
            inputs = recipe.input.map { ingredient in
                let amountPerRecipe = recipe.amountPerMinute(for: ingredient)
                return Input(item: ingredient.item, amount: amountPerRecipe * multiplier)
            }
        }
        
        /// Updates byproduct and input based on output, then updates input nodes with input values crecursively.
        private func updateAll() {
            update()
            
            updateInputs()
        }
        
        func removeInputNodes() {
            inputNodes.removeAll()
        }
        
        func inputNodes(contain predicate: (Node) -> Bool) -> Bool {
            inputNodes.contains(where: predicate)
        }
        
        func inputNodes(contain recipe: Recipe) -> Bool {
            inputNodes { $0.recipe == recipe }
        }
        
//        func first(where predicate: (Node) -> Bool) -> Node? {
//            inputRecipeNodes.first(where: predicate)
//        }
//        
//        func first(where predicate: (Node) -> Bool) -> Int? {
//            inputRecipeNodes.firstIndex(where: predicate)
//        }
//        
        func add(_ node: Node) {
            node.parentRecipeNode = self
            inputNodes.append(node)
        }
//        
//        func updateInput(for item: any Item, amount: Double) {
//            guard let index = inputRecipeNodes.firstIndex(where: { $0.output.item.id == item.id }) else { return }
//            
//            inputRecipeNodes[index].amount = amount
//        }
//        
//        func removeAll(where predicate: (Node) -> Bool) {
//            inputRecipeNodes.removeAll(where: predicate)
//        }
//        
//        typealias NextPartialResult<Value> = (_ partialResult: Value, _ recipe: Node) -> Value
//        func reduce<Value>(_ initialValue: Value, nextPartialResult: NextPartialResult<Value>) -> Value {
//            reduce(recipeNode: self, currentResult: initialValue, nextPartialResult: nextPartialResult)
//        }
//        
//        typealias UpdatingAccumulatingResult<Value> = (_ accumulatingResult: inout Value, _ recipe: Node) -> Void
//        func reduce<Value>(into value: Value, updatingAccumulatingResult: UpdatingAccumulatingResult<Value>) -> Value {
//            var result = value
//            reduce(recipeNode: self, into: &result, updatingAccumulatingResult: updatingAccumulatingResult)
//            return result
//        }
    }
}

// MARK: Output
extension SingleItemProduction.Node {
    struct Output {
        let item: any Item
        var amount: Double
        var asByproduct = Byproduct(amount: 0.0)
        
        var availableAmount: Double {
            amount + asByproduct.amount
        }
        
        struct Byproduct {
            var amount: Double
            var consumers = [Consumer]()
        }
        
        struct Consumer {
            var recipeID: String
            var amount: Double
        }
    }
}

// MARK: Byproduct
extension SingleItemProduction.Node {
    struct Byproduct {
        let item: any Item
        var amount: Double
        var consumers = [Consumer]()
        
        var availableAmount: Double {
            amount - consumers.reduce(0.0) { $0 + $1.amount }
        }
        
        struct Consumer {
            var recipeID: String
            var amount: Double
        }
    }
}

// MARK: Input
extension SingleItemProduction.Node {
    struct Input {
        let item: any Item
        var amount: Double
        var byproductProducers = [ByproductProducer]()
        
        var availableAmount: Double {
            amount - byproductProducers.reduce(0.0) { $0 + $1.amount }
        }
        
        struct ByproductProducer {
            var recipeID: String
            var amount: Double
        }
    }
}

//private extension SingleItemProduction.Node {
//    func reduce<Value>(
//        recipeNode: SingleItemProduction.Node,
//        currentResult: Value,
//        nextPartialResult: NextPartialResult<Value>
//    ) -> Value {
//        var result = nextPartialResult(currentResult, recipeNode)
//        for inputRecipeNode in recipeNode.inputRecipeNodes {
//            result = reduce(recipeNode: inputRecipeNode, currentResult: result, nextPartialResult: nextPartialResult)
//        }
//        
//        return result
//    }
//    
//    func reduce<Value>(
//        recipeNode: SingleItemProduction.Node,
//        into currentResult: inout Value,
//        updatingAccumulatingResult: UpdatingAccumulatingResult<Value>
//    ) {
//        updatingAccumulatingResult(&currentResult, recipeNode)
//        for inputRecipe in recipeNode.inputRecipeNodes {
//            reduce(recipeNode: inputRecipe, into: &currentResult, updatingAccumulatingResult: updatingAccumulatingResult)
//        }
//    }
//}

// MARK: Description for print
extension SingleItemProduction.Node {
    func description(with spacing: String) -> String {
        let name = output.item.localizedName
        let recipe = "[R: \(recipe.localizedName)]"
        let amount = "\(amount.formatted(.fractionFromZeroToFour))"
        let byproductAmount = "\(output.asByproduct.amount.formatted(.fractionFromZeroToFour))"
        
        let joinedAmount = if byproductAmount.isEmpty {
            "(\(amount))"
        } else {
            "(\(amount) [\(byproductAmount)])"
        }
        
        let byproducts = byproducts.map { byproduct in
            let name = byproduct.item.localizedName
            let amount = "\(byproduct.amount.formatted(.fractionFromZeroToFour))"
            let consumedAmount = byproduct.consumers.map {
                "\($0.amount.formatted(.fractionFromZeroToFour))"
            }.joined(separator: ", ")
            
            let joinedAmount = if consumedAmount.isEmpty {
                "(\(amount))"
            } else {
                "(\(amount) [\(consumedAmount)])"
            }
            
            return """
            \(spacing)◼︎ \(name) \(joinedAmount)
            """
        }.joined(separator: "\n")
        
        let resolvedByproducts = if byproducts.isEmpty {
            ""
        } else {
            "\n\(byproducts)"
        }
        
        let inputs = inputs.map { input in
            let name = input.item.localizedName
            let amount = "\(input.amount.formatted(.fractionFromZeroToFour))"
            let providedByByproductsAmount = input.byproductProducers.map {
                "\($0.amount.formatted(.fractionFromZeroToFour))"
            }.joined(separator: ", ")
            
            let joinedAmount = if providedByByproductsAmount.isEmpty {
                "(\(amount))"
            } else {
                "(\(amount) [\(providedByByproductsAmount)])"
            }
            
            return """
            \(spacing)● \(name) \(joinedAmount)
            """
        }.joined(separator: "\n")
        
        let resolvedInputs = if inputs.isEmpty {
            ""
        } else {
            "\n\(inputs)"
        }
        
        return """
        \(spacing)▶︎ \(name) \(recipe) \(joinedAmount)\(resolvedByproducts)\(resolvedInputs)
        
        """
    }
}
