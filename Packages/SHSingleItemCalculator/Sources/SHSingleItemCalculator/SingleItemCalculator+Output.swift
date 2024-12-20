import Dependencies

extension SingleItemCalculator {
    func buildOutput() {
        var ingredientConverter = IngredientConverter()
        
        func isSelected(_ input: Node.Input, node: Node) -> Bool {
            self.production.inputParts.contains(part: input.part)
        }
        
        var outputParts = buildOutputParts(
            ingredientConverter: &ingredientConverter,
            isSelected: isSelected
        )
        
        addAdditionalOutputItems(
            updating: &outputParts,
            ingredientConverter: &ingredientConverter,
            isSelected: isSelected
        )
        
        self.outputParts = outputParts
    }
    
    private func buildOutputParts(
        ingredientConverter: inout IngredientConverter,
        isSelected: (_ input: Node.Input, _ node: Node) -> Bool
    ) -> [OutputPart] {
        var nodes = mainNodes
        var outputParts = [OutputPart]()
        
        while !nodes.isEmpty {
            for node in nodes {
                // If there is already an product in output.
                if let productIndex = outputParts.firstIndex(where: { $0.part == node.part }) {
                    // And if there is already a recipe for a product in output.
                    if let recipeIndex = outputParts[productIndex].recipes.firstIndex(where: { $0.recipe.id == node.recipe.id }) {
                        // Accumulate saved values with new values.
                        var recipe = outputParts[productIndex].recipes[recipeIndex]
                        recipe.output.amount += node.amount
                        recipe.byproducts.merge(with: node.byproducts.map {
                            ingredientConverter.convert(producingRecipeID: recipe.recipe.id, byproduct: $0)
                        })
                        recipe.inputs.merge(with: node.inputs.map { input in
                            ingredientConverter.convert(
                                input: input,
                                isSelected: isSelected(input, node)
                            )
                        })
                        outputParts[productIndex].recipes[recipeIndex] = recipe
                    } else {
                        // If a recipe is new, add this to output product.
                        let proportion = production
                            .inputParts
                            .first(part: outputParts[productIndex].part)?
                            .recipes
                            .first(where: { $0.recipe == node.recipe })?
                            .proportion ?? .auto
                        
                        outputParts[productIndex].recipes.append(
                            OutputRecipe(
                                id: uuid(),
                                recipe: node.recipe,
                                output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                                    id: uuid(),
                                    part: node.part,
                                    amount: node.amount
                                ),
                                byproducts: node.byproducts.map { ingredientConverter.convert(producingRecipeID: node.recipe.id, byproduct: $0) },
                                inputs: node.inputs.map { input in
                                    ingredientConverter.convert(
                                        input: input,
                                        isSelected: isSelected(input, node)
                                    )
                                },
                                proportion: proportion
                            )
                        )
                    }
                } else {
                    // If a product is new, add it.
                    let proportion = production
                        .inputParts
                        .first(part: node.part)?
                        .recipes
                        .first(where: { $0.recipe == node.recipe })?
                        .proportion ?? .auto
                    
                    let product = OutputPart(
                        id: uuid(),
                        part: node.part,
                        recipes: [OutputRecipe(
                            id: uuid(),
                            recipe: node.recipe,
                            output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                                id: uuid(),
                                part: node.part,
                                amount: node.amount
                            ),
                            byproducts: node.byproducts.map { ingredientConverter.convert(producingRecipeID: node.recipe.id, byproduct: $0) },
                            inputs: node.inputs.map { input in
                                ingredientConverter.convert(
                                    input: input,
                                    isSelected: isSelected(input, node)
                                )
                            },
                            proportion: proportion
                        )]
                    )
                    
                    // Populate producingProductID field for inputs with a newly created product
                    for productIndex in outputParts.indices {
                        for (recipeIndex, recipe) in outputParts[productIndex].recipes.enumerated() {
                            for (inputIndex, input) in recipe.inputs.enumerated() {
                                if input.part == product.part {
                                    outputParts[productIndex].recipes[recipeIndex].inputs[inputIndex].producingProductID = product.id
                                }
                            }
                        }
                    }
                    
                    outputParts.append(product)
                }
            }
            
            nodes = nodes.flatMap(\.inputNodes)
        }
        
        return outputParts
    }
    
    private func addAdditionalOutputItems(
        updating outputItems: inout [OutputPart],
        ingredientConverter: inout IngredientConverter,
        isSelected: (_ input: Node.Input, _ node: Node) -> Bool
    ) {
        // Handle additional trees to represent additional amounts in output ingredients.
        var nodes = additionalNodes
        while !nodes.isEmpty {
            for node in nodes {
                guard
                    let (outputIndex, output) = outputItems.enumerated().first(where: { $0.1.part == node.part }),
                    let recipeIndex = output.recipes.firstIndex(where: { $0.recipe.id == node.recipe.id })
                else { continue }
                
                // Accumulate saved values with new values.
                var recipe = output.recipes[recipeIndex]
                
                if additionalNodes.contains(where: { $0.id == node.id }) {
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

// MARK: Ingredient convertion
extension SingleItemCalculator {
    private struct IngredientConverter {
        var byproductConverter = ByproductConverter()
        
        @Dependency(\.uuid)
        private var uuid
        
        mutating func convert(producingRecipeID: String, byproduct: SingleItemCalculator.Node.Byproduct) -> SingleItemCalculator.OutputRecipe.ByproductIngredient {
            SingleItemCalculator.OutputRecipe.ByproductIngredient(
                id: uuid(),
                part: byproduct.part,
                amount: byproduct.availableAmount,
                byproducts: byproduct.consumers.map {
                    byproductConverter.convert(producerRecipeID: producingRecipeID, byproductConsumer: $0)
                },
                isSelected: !byproduct.consumers.isEmpty
            )
        }
        
        mutating func convert(
            input: SingleItemCalculator.Node.Input,
            isSelected: Bool
        ) -> SingleItemCalculator.OutputRecipe.InputIngredient {
            SingleItemCalculator.OutputRecipe.InputIngredient(
                id: uuid(),
                part: input.part,
                amount: input.availableAmount,
                byproducts: input.byproductProducers.map {
                    byproductConverter.convert(inputProducer: $0)
                },
                isSelected: isSelected
            )
        }
    }
    
    private struct ByproductConverter {
        private var recipeIDs = [String]()
        
        mutating func convert(
            producerRecipeID: String,
            byproductConsumer: SingleItemCalculator.Node.Byproduct.Consumer
        ) -> SingleItemCalculator.OutputRecipe.Byproduct {
            OutputRecipe.Byproduct(index: index(for: producerRecipeID), amount: byproductConsumer.amount)
        }
        
        mutating func convert(
            inputProducer: SingleItemCalculator.Node.Input.ByproductProducer
        ) -> SingleItemCalculator.OutputRecipe.Byproduct {
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
private extension [SingleItemCalculator.OutputRecipe.OutputIngredient] {
    mutating func merge(with other: Self) {
        merge(with: other) {
            $0.part == $1.part
        } merging: {
            $0.amount += $1.amount
        }
    }
}

private extension [SingleItemCalculator.OutputRecipe.ByproductIngredient] {
    mutating func merge(with other: Self) {
        merge(with: other) {
            $0.part == $1.part
        } merging: {
            $0.amount += $1.amount
            $0.isSelected = $0.isSelected || $1.isSelected
            $0.byproducts.merge(with: $1.byproducts)
        }
    }
}

private extension [SingleItemCalculator.OutputRecipe.InputIngredient] {
    mutating func merge(with other: Self) {
        merge(with: other) {
            $0.part == $1.part
        } merging: {
            $0.amount += $1.amount
            $0.isSelected = $0.isSelected || $1.isSelected
            $0.byproducts.merge(with: $1.byproducts)
        }
    }
}

private extension [SingleItemCalculator.OutputRecipe.Byproduct] {
    mutating func merge(with other: Self) {
        merge(with: other) {
            $0.index == $1.index
        } merging: {
            $0.amount += $1.amount
        }
    }
}
