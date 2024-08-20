import SHModels

extension SingleItemCalculator {
    func updateStatistics() {
        let items = outputItems.map { outputItem in
            StatisticItem(item: outputItem.item, recipes: outputItem.recipes.map { outputRecipe in
                StatisticRecipe(recipe: outputRecipe.recipe, amount: outputRecipe.output.amount)
            })
        }
        
        let naturalResources = outputItems
            .flatMap { $0.recipes.flatMap(\.inputs) }
            .filter { inputIngredient in
                (inputIngredient.item as? Part)?.isNaturalResource == true &&
                !outputItems.contains { $0.item.id == inputIngredient.item.id }
            }
            .reduce(into: [StatisticNaturalResource]()) { partialResult, inputIngredient in
                if let index = partialResult.firstIndex(where: { $0.item.id == inputIngredient.item.id }) {
                    partialResult[index].amount += inputIngredient.amount
                } else {
                    partialResult.append(StatisticNaturalResource(item: inputIngredient.item, amount: inputIngredient.amount))
                }
            }
        
        production.statistics = Statistics(items: items, naturalResources: naturalResources)
    }
}
