import Foundation

struct RecipeElement: Identifiable {
    var id = UUID()
    let item: Item
    var recipe: Recipe
    var amount: Double
    
    var numberOfMachines: Double {
        guard let output = recipe.output.first(contains: item) else { return 1 }
        
        return amount / output.amountPerMinute
    }
    
    func amount(for inputItem: Item) -> Double {
        guard let output = recipe.output.first(contains: item) else { return 0 }
        guard let input = recipe.input.first(contains: inputItem) else { return 0 }

        let multiplier = amount / output.amountPerMinute
        return input.amountPerMinute * multiplier
    }
}

extension RecipeElement: Hashable {
    static func == (lhs: RecipeElement, rhs: RecipeElement) -> Bool {
        lhs.id == rhs.id && lhs.item.id == rhs.item.id && lhs.recipe == rhs.recipe && lhs.amount == rhs.amount
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(item.id)
        hasher.combine(recipe)
        hasher.combine(amount)
    }
}
