import SHModels
import SHPersistentModels

extension SingleItemProduction {
    init(
        _ v2: Persistent.V2,
        partProvider: (String) -> Part,
        recipeProvider: (String) -> Recipe
    ) {
        self.init(
            id: v2.id,
            name: v2.name,
            creationDate: v2.creationDate,
            part: partProvider(v2.partID),
            amount: v2.amount,
            inputParts: v2.inputParts.map {
                InputPart(
                    id: $0.id,
                    part: partProvider($0.partID),
                    recipes: $0.recipes.map {
                        InputRecipe(id: $0.id, recipe: recipeProvider($0.recipeID), proportion: $0.proportion)
                    }
                )
            },
            byproducts: v2.byproducts.map {
                InputByproduct(
                    id: $0.id,
                    part: partProvider($0.partID),
                    producers: $0.producers.map {
                        InputByproductProducer(
                            id: $0.id,
                            recipe: recipeProvider($0.recipeID),
                            consumers: $0.consumers.map {
                                InputByproductConsumer(id: $0.id, recipe: recipeProvider($0.recipeID))
                            }
                        )
                    }
                )
            },
            statistics: Statistics(
                parts: v2.statistics.parts.map {
                    StatisticPart(part: partProvider($0.partID), recipes: $0.recipes.map {
                        StatisticRecipe(recipe: recipeProvider($0.recipeID), amount: $0.amount)
                    })
                },
                naturalResources: v2.statistics.naturalResources.map {
                    StatisticNaturalResource(part: partProvider($0.partID), amount: $0.amount)
                }
            )
        )
    }
}

extension SingleItemProduction.Persistent.V2 {
    init(_ production: SingleItemProduction) {
        self.init(
            id: production.id,
            name: production.name,
            creationDate: production.creationDate,
            partID: production.part.id,
            amount: production.amount,
            inputParts: production.inputParts.map {
                InputPart(id: $0.id, partID: $0.part.id, recipes: $0.recipes.map {
                    InputPart.Recipe(id: $0.id, recipeID: $0.recipe.id, proportion: $0.proportion)
                })
            },
            byproducts: production.byproducts.map {
                Byproduct(id: $0.id, partID: $0.part.id, producers: $0.producers.map {
                    Byproduct.Producer(id: $0.id, recipeID: $0.recipe.id, consumers: $0.consumers.map {
                        Byproduct.Producer.Consumer(id: $0.id, recipeID: $0.recipe.id)
                    })
                })
            },
            statistics: Statistics(
                parts: production.statistics.parts.map {
                    StatisticPart(partID: $0.part.id, recipes: $0.recipes.map {
                        StatisticRecipe(recipeID: $0.recipe.id, amount: $0.amount)
                    })
                },
                naturalResources: production.statistics.naturalResources.map {
                    StatisticNaturalResource(partID: $0.part.id, amount: $0.amount)
                }
            )
        )
    }
}
