import SHModels

extension SHSingleItemProduction {
    @dynamicMemberLookup
    public struct InputRecipe: Equatable {
        /// A recipe used to produce product.
        let recipe: Recipe
        
        /// A proportion of total amount of product.
        ///
        /// This is used when more than one recipe produce a single intermediate product.
        /// This can be also used to calculate final product.
        public var proportion: SHProductionProportion
        
        public subscript<Member>(dynamicMember keyPath: KeyPath<Recipe, Member>) -> Member {
            recipe[keyPath: keyPath]
        }
    }
}

extension Sequence<SHSingleItemProduction.InputRecipe> {
    func first(recipe: Recipe) -> Element? {
        first(where: { $0.recipe.id == recipe.id })
    }
    
    func contains(recipe: Recipe) -> Bool {
        contains { $0.recipe.id == recipe.id }
    }
}

extension Collection<SHSingleItemProduction.InputRecipe> {
    func firstIndex(recipe: Recipe) -> Index? {
        firstIndex { $0.recipe.id == recipe.id }
    }
}
