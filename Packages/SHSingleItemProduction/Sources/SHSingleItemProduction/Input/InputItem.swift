import SHModels

extension SHSingleItemProduction {
    public struct InputItem {
        /// A product used in Product Calculator.
        public let item: any Item
        
        /// Recipes for selected product with corresponding proportions.
        public var recipes: [SHSingleItemProduction.InputRecipe]
        
        public mutating func addProductRecipe(_ recipe: SHSingleItemProduction.InputRecipe) {
            guard !recipes.contains(where: { $0.recipe == recipe.recipe }) else { return }
            
            recipes.append(recipe)
        }
    }
}

// MARK: Hashable
extension SHSingleItemProduction.InputItem: Hashable {
    public static func == (lhs: SHSingleItemProduction.InputItem, rhs: SHSingleItemProduction.InputItem) -> Bool {
        lhs.item.id == rhs.item.id &&
        lhs.recipes == rhs.recipes
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(item.id)
        hasher.combine(recipes)
    }
}

extension Sequence<SHSingleItemProduction.InputItem> {
    func first(item: any Item) -> Element? {
        first { $0.item.id == item.id }
    }
    
    func contains(_ item: any Item) -> Bool {
        contains { $0.item.id == item.id }
    }
    
    func contains(_ inputItem: Element) -> Bool {
        contains(inputItem.item)
    }
}

extension Collection<SHSingleItemProduction.InputItem> {
    func firstIndex(item: any Item) -> Index? {
        firstIndex { $0.item.id == item.id }
    }
    
    func firstIndex(of inputItem: Element) -> Index? {
        firstIndex(item: inputItem.item)
    }
}
