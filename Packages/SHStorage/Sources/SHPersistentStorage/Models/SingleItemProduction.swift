import SHModels
import SHPersistentModels

extension SingleItemProduction {
    init(
        _ v2: Persistent.V2,
        itemPorivder: (String) -> any Item,
        recipeProvider: (String) -> Recipe
    ) {
        self.init(
            id: v2.id,
            name: v2.name,
            item: itemPorivder(v2.itemID),
            amount: v2.amount,
            inputItems: v2.inputItems.map {
                InputItem(
                    id: $0.id,
                    item: itemPorivder($0.itemID),
                    recipes: $0.recipes.map {
                        InputRecipe(id: $0.id, recipe: recipeProvider($0.recipeID), proportion: $0.proportion)
                    }
                )
            },
            byproducts: v2.byproducts.map {
                InputByproduct(
                    id: $0.id,
                    item: itemPorivder($0.itemID),
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
            }
        )
    }
}

extension SingleItemProduction.Persistent.V2 {
    init(_ production: SingleItemProduction) {
        self.init(
            id: production.id,
            name: production.name,
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
            }
        )
    }
}
