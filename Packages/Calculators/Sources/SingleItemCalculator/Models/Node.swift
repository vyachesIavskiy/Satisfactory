import Foundation
import SHModels
import SHUtils

extension SingleItemCalculator {
    final class Node {
        let id: UUID
        
        /// A node output item. This can be recipe output or recipe byproduct ingredient.
        var item: any Item
        
        /// A Recipe used to populate and recalculate this node.
        var recipe: Recipe
        
        /// Output amount for a subnode.
        ///
        /// This represents an ingredient which is primary output product for recipe node. Apart from Recipe, this can represent Recipe secondary output.
        var amount: Double {
            didSet {
                update()
            }
        }
        
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
        
        init(id: UUID, item: any Item, recipe: Recipe, amount: Double, parentRecipeNode: Node? = nil) {
            self.id = id
            self.item = item
            self.recipe = recipe
            self.amount = amount
            self.parentRecipeNode = parentRecipeNode
            
            update()
        }
        
        func update() {
            let outputIngredients = recipe.byproducts + CollectionOfOne(recipe.output)
            let producingIngredient = outputIngredients.first { $0.item.id == item.id }
            
            guard let producingIngredient else {
                fatalError("Could not find ingredient for '\(item.localizedName)' in '\(recipe.localizedName)'")
            }
            
            let amountPerRecipe = recipe.amountPerMinute(for: producingIngredient)
            let multiplier = amount / amountPerRecipe
            
            byproducts = outputIngredients.filter { $0.item.id != item.id }.map { ingredient in
                let amountPerRecipe = recipe.amountPerMinute(for: ingredient)
                return Byproduct(item: ingredient.item, amount: amountPerRecipe * multiplier)
            }
            
            inputs = recipe.inputs.map { ingredient in
                let amountPerRecipe = recipe.amountPerMinute(for: ingredient)
                return Input(item: ingredient.item, amount: amountPerRecipe * multiplier)
            }
        }
        
        func updateInputs() {
            for input in inputs {
                guard
                    // Check if this input has a corresponding input node (i.e. a recipe for this input is selected).
                    let (inputNodeIndex, inputNode) = inputNodes.enumerated().first(where: { $0.1.item.id == input.item.id }),
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
            
            for inputNode in inputNodes {
                inputNode.updateInputs()
            }
        }
        
        func inputContains(_ predicate: (Node) -> Bool) -> Bool {
            inputNodes.contains(where: predicate)
        }
        
        func inputContains(_ recipe: Recipe) -> Bool {
            inputContains { $0.recipe == recipe }
        }
        
        func add(_ node: Node) {
            node.parentRecipeNode = self
            inputNodes.append(node)
        }
    }
}

extension [SingleItemCalculator.Node] {
    func containsRecurcievly(where predicate: (SingleItemCalculator.Node) throws -> Bool) rethrows -> Bool {
        var nodes = self
        var result = false
        while !nodes.isEmpty {
            result = try nodes.contains(where: predicate)
            guard !result else { break }
            
            nodes = nodes.flatMap(\.inputNodes)
        }
        
        return result
    }
    
    func contains(id: UUID) -> Bool {
        containsRecurcievly(where: { $0.id == id })
    }
}

extension SingleItemCalculator.Node {
    func anyParentContains(where predicate: (SingleItemCalculator.Node) throws -> Bool) rethrows -> Bool {
        var parentNode = parentRecipeNode
        while parentNode != nil {
            if let parentNode, try predicate(parentNode) {
                return true
            }
            
            parentNode = parentNode?.parentRecipeNode
        }
        
        return false
    }
}

// MARK: Byproduct
extension SingleItemCalculator.Node {
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
extension SingleItemCalculator.Node {
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

// MARK: Description for print
extension SingleItemCalculator.Node {
    func description(with spacing: String) -> String {
        let name = item.localizedName
        let recipe = "[R: \(recipe.localizedName)]"
        let amount = "\(amount.formatted(.shNumber))"
        
        let joinedAmount = "(\(amount))"
        
        let byproducts = byproducts.map { byproduct in
            let name = byproduct.item.localizedName
            let amount = "\(byproduct.amount.formatted(.shNumber))"
            let consumedAmount = byproduct.consumers.map {
                "\($0.amount.formatted(.shNumber))"
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
            let amount = "\(input.amount.formatted(.shNumber))"
            let providedByByproductsAmount = input.byproductProducers.map {
                "\($0.amount.formatted(.shNumber))"
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
