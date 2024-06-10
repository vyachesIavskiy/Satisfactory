import SHModels

struct ProductionRecipeEntry {
    var item: any Item
    var recipe: Recipe
    var amounts: ProductionAmounts
    var byproducts = [Byproduct]()
    
    func desiredAmount(for item: some Item) -> Double {
        let multiplier = recipe.multiplier(for: self.item, amount: amounts.desiredAmount)
        return amount(for: item, with: multiplier)
    }
    
    func actualAmount(for item: some Item) -> Double {
        let multiplier = recipe.multiplier(for: self.item, amount: amounts.actualAmount)
        return amount(for: item, with: multiplier)
    }
    
    mutating func resetActualAmount() {
        amounts.actualAmount = amounts.desiredAmount
    }
    
    func amount(ofByproduct item: some Item) -> Double? {
        byproducts.first(of: item)?.amount
    }
    
    func inputPresent(_ item: some Item) -> Bool {
        recipe.input.contains { $0.id == item.id }
    }
}

// MARK: - Private
private extension ProductionRecipeEntry {
    func amount(for item: some Item, with multiplier: Double) -> Double {
//        if item.id == recipe.output.item.id {
//            recipe.output.amountPerMinute * multiplier
//        } else if let byproduct = recipe.byproducts.first(where: { $0.id == item.id }) {
//            byproduct.amountPerMinute * multiplier
//        } else if let input = recipe.input.first(where: { $0.id == item.id }) {
//            input.amountPerMinute * multiplier
//        } else {
//            0.0
//        }
        1.0
    }
}

// MARK: - Identifiable
extension ProductionRecipeEntry: Identifiable {
    var id: String { recipe.id }
}

// MARK: - Byproduct
extension ProductionRecipeEntry {
    struct Byproduct {
        var item: any Item
        var amount: Double
        var direction: Direction
    }
}

// MARK: - Direction
extension ProductionRecipeEntry.Byproduct {
    enum Direction {
        case inside
        case outside
    }
}

// MARK: - ProductionRecipeEntry | Array
extension Array where Element == ProductionRecipeEntry {
    func first(of recipe: Recipe) -> Element? {
        first { $0.id == recipe.id }
    }
    
    func firstIndex(of recipe: Recipe) -> Index? {
        firstIndex { $0.id == recipe.id }
    }
}

// MARK: - Byproduct | Array
extension Array where Element == ProductionRecipeEntry.Byproduct {
    func first(of item: some Item) -> Element? {
        first { $0.item.id == item.id }
    }
    
    func firstIndex(of item: some Item) -> Index? {
        firstIndex { $0.item.id == item.id }
    }
    
    func contains(_ item: some Item) -> Bool {
        contains { $0.item.id == item.id }
    }
    
    mutating func append(item: some Item, amount: Double, direction: ProductionRecipeEntry.Byproduct.Direction) {
        append(ProductionRecipeEntry.Byproduct(item: item, amount: amount, direction: direction))
    }
}
