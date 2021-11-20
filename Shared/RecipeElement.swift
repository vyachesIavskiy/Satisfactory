import Foundation

struct RecipeElement: Identifiable {
    var id = UUID()
    let item: Item
    var recipe: Recipe
    var amount: Double
    
    var numberOfMachines: Int {
        guard let output = recipe.output.first(contains: item) else { return 1 }
        
        return Int(ceil(amount / output.amountPerMinute))
    }
    
    func amount(for inputItem: Item) -> Double {
        guard let output = recipe.output.first(contains: item) else { return 0 }
        guard let input = recipe.input.first(contains: inputItem) else { return 0 }

        let multiplier = amount / output.amountPerMinute
        return input.amountPerMinute * multiplier
    }
}
