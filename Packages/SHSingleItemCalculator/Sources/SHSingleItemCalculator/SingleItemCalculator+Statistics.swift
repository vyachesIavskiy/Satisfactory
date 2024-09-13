import SHModels

extension SingleItemCalculator {
    func updateStatistics() {
        let parts = outputParts.map { outputItem in
            StatisticPart(part: outputItem.part, recipes: outputItem.recipes.map { outputRecipe in
                StatisticRecipe(recipe: outputRecipe.recipe, amount: outputRecipe.output.amount)
            })
        }
        
        let naturalResources = outputParts
            .flatMap { $0.recipes.flatMap(\.inputs) }
            .filter { inputIngredient in
                inputIngredient.part.isNaturalResource &&
                !outputParts.contains { $0.part == inputIngredient.part }
            }
            .reduce(into: [StatisticNaturalResource]()) { partialResult, inputIngredient in
                if let index = partialResult.firstIndex(where: { $0.part == inputIngredient.part }) {
                    partialResult[index].amount += inputIngredient.amount
                } else {
                    partialResult.append(StatisticNaturalResource(part: inputIngredient.part, amount: inputIngredient.amount))
                }
            }
        
        production.statistics = Statistics(parts: parts, naturalResources: naturalResources)
    }
}
