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
                    item: itemPorivder($0.id),
                    recipes: $0.recipes.map {
                        InputRecipe(recipe: recipeProvider($0.id), proportion: $0.proportion)
                    }
                )
            },
            byproducts: v2.byproducts.map {
                InputByproduct(
                    item: itemPorivder($0.itemID),
                    producers: $0.producers.map {
                        InputByproductProducer(
                            recipe: recipeProvider($0.recipeID),
                            consumers: $0.consumerRecipeIDs.map(recipeProvider)
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
                InputItem(id: $0.item.id, recipes: $0.recipes.map {
                    InputItem.Recipe(id: $0.recipe.id, proportion: $0.proportion)
                })
            },
            byproducts: production.byproducts.map {
                Byproduct(itemID: $0.item.id, producers: $0.producers.map {
                    Byproduct.Producer(recipeID: $0.recipe.id, consumerRecipeIDs: $0.consumers.map(\.id))
                })
            }
        )
    }
}
