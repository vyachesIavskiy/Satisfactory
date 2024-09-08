import SHModels
import SHPersistentModels

extension SingleItemProduction {
    init(
        _ v2: Persistent.V2,
        itemProvider: (String) -> any Item,
        recipeProvider: (String) -> Recipe
    ) {
        self.init(
            id: v2.id,
            name: v2.name,
            creationDate: v2.creationDate,
            item: itemProvider(v2.itemID),
            amount: v2.amount,
            inputItems: v2.inputItems.map {
                InputItem(
                    id: $0.id,
                    item: itemProvider($0.itemID),
                    recipes: $0.recipes.map {
                        InputRecipe(id: $0.id, recipe: recipeProvider($0.recipeID), proportion: $0.proportion)
                    }
                )
            },
            byproducts: v2.byproducts.map {
                InputByproduct(
                    id: $0.id,
                    item: itemProvider($0.itemID),
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
                items: v2.statistics.items.map {
                    StatisticItem(item: itemProvider($0.itemID), recipes: $0.recipes.map {
                        StatisticRecipe(recipe: recipeProvider($0.recipeID), amount: $0.amount)
                    })
                },
                naturalResources: v2.statistics.naturalResources.map {
                    StatisticNaturalResource(item: itemProvider($0.itemID), amount: $0.amount)
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
            itemID: production.item.id,
            amount: production.amount,
            inputItems: production.inputItems.map {
                InputItem(id: $0.id, itemID: $0.item.id, recipes: $0.recipes.map {
                    InputItem.Recipe(id: $0.id, recipeID: $0.recipe.id, proportion: $0.proportion)
                })
            },
            byproducts: production.byproducts.map {
                Byproduct(id: $0.id, itemID: $0.item.id, producers: $0.producers.map {
                    Byproduct.Producer(id: $0.id, recipeID: $0.recipe.id, consumers: $0.consumers.map {
                        Byproduct.Producer.Consumer(id: $0.id, recipeID: $0.recipe.id)
                    })
                })
            },
            statistics: Statistics(
                items: production.statistics.items.map {
                    StatisticItem(itemID: $0.item.id, recipes: $0.recipes.map {
                        StatisticRecipe(recipeID: $0.recipe.id, amount: $0.amount)
                    })
                },
                naturalResources: production.statistics.naturalResources.map {
                    StatisticNaturalResource(itemID: $0.item.id, amount: $0.amount)
                }
            )
        )
    }
}
