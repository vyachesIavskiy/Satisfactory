import Foundation

extension Dictionary where Key == Recipe, Value == Int {
    mutating func merge(with other: Self) {
        other.forEach { key, value in
            self[key, default: 0] += value
        }
    }
    
    func merged(with other: Self) -> Self {
        var copy = self
        copy.merge(with: other)
        return copy
    }
}

extension Array where Element == Recipe {
    subscript (itemId itemId: UUID) -> Recipe? {
        first { Storage.shared[recipesFor: itemId].contains($0) }
    }
}

func calculateProduction(item: UUID, amount: Int, selectedRecipes: [Recipe]) -> [Recipe: Int] {
    guard let itemRecipe = selectedRecipes.first(where: { $0.output.contains(where: { $0.item.id == item }) }) else { return [:] }
    
    let inputs = itemRecipe.input
    var production = [(Recipe, Int)]()
    var internalResult = [Recipe: Int]()
    
    for input in inputs {
        guard
            let currentRecipe = selectedRecipes[itemId: input.item.id],
            let itemsProduced = currentRecipe.output.first(where: { $0 == input })?.amount else { break }
        
        let itemsNeeded = input.amount
        let deltaTime = Double(itemRecipe.duration) / Double(currentRecipe.duration)
        let machinesAmount = Int((Double(amount) * Double(itemsNeeded) / (Double(itemsProduced) * deltaTime)).rounded(.up))
        production.append((currentRecipe, machinesAmount))
        internalResult.merge(with: calculateProduction(item: input.item.id, amount: machinesAmount, selectedRecipes: selectedRecipes))
    }
    
    let allRecipes = Set(production.map(\.0))
    return allRecipes.reduce(into: [Recipe: Int]()) { result, recipe in
        result[recipe, default: 0] += production.filter { $0.0.id == recipe.id }.map(\.1).reduce(0, +)
    }.merged(with: internalResult)
}
