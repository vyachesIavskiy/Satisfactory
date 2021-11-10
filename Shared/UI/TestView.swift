import SwiftUI

extension View {
    func frame(_ squareSize: CGFloat) -> some View {
        frame(width: squareSize, height: squareSize)
    }
}

struct TestRecipeView: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            ForEach(recipe.input) { input in
                HStack {
                    Text(amountPerMinute(for: input))
                    Image(input.item.name)
                        .resizable()
                        .frame(30)
                }
            }
            Image(systemName: "arrowtriangle.right.square")
            ForEach(recipe.output) { output in
                HStack {
                    Text(amountPerMinute(for: output))
                    Image(output.item.name)
                        .resizable()
                        .frame(30)
                }
            }
        }
    }
    
    private func amountPerMinute(for recipePart: Recipe.RecipePartOld) -> String {
        let amount = 60.0 / Double(recipe.duration) * Double(recipePart.amount)
        let formatter = NumberFormatter()
        #if os(macOS)
        formatter.hasThousandSeparators = true
        #endif
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amount))!
    }
}

//struct TestView: View {
//    var selectedRecipes = [
//        Storage.shared[recipeName: "Iron Ingot"]!,
//        Storage.shared[recipeName: "Iron Rod"]!,
//        Storage.shared[recipeName: "Iron Plate"]!,
//        Storage.shared[recipeName: "Screw"]!,
//        Storage.shared[recipeName: "Reinforced Iron Plate"]!
//    ]
//
//    var productionChain: [RecipeTree] {
//        let rip = RecipeTree(recipe: selectedRecipes[4])
//        let ip = RecipeTree(recipe: selectedRecipes[2])
//        let screw = RecipeTree(recipe: selectedRecipes[3])
//        let ir = RecipeTree(recipe: selectedRecipes[1])
//        ip.production = [
//            RecipeTree(recipe: selectedRecipes[0])
//        ]
//        ir.production = [
//            RecipeTree(recipe: selectedRecipes[0])
//        ]
//        screw.production = [ir]
//        rip.production = [ip, screw]
//        return [rip]
//    }
//
//    var body: some View {
//        List(productionChain, children: \.production) { tree in
//            TestRecipeView(recipe: tree.recipe)
//        }
//    }
//}

//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}

//final class RecipeTree: Identifiable {
//    var id: UUID { recipe.id }
//    var recipe: Recipe
//    var production: [RecipeTree]?
//
//    init(recipe: Recipe) {
//        self.recipe = recipe
//    }
//}
//
//struct CalculatorRecipe {
//    var recipe: Recipe?
//    var amount = 1
//}
//
//class CalculationInput {
//    var item: Item
//    var multiplier: Int
//    var amount: Double
//    var totalAmount: Double { amount * Double(multiplier) }
//
//    init(item: Item, multiplier: Int, amount: Double) {
//        self.item = item
//        self.multiplier = multiplier
//        self.amount = amount
//    }
//}
//
//struct Production {
//    struct Part: Hashable, Equatable {
//        var item: Item
//        var recipe: Recipe?
//
//        func hash(into hasher: inout Hasher) {
//            hasher.combine(item.id)
//        }
//
//        static func == (lhs: Self, rhs: Self) -> Bool { lhs.item.id == rhs.item.id }
//    }
//
//    var parts = Set<Part>()
//}

//class A {
//    func a() {
//        var production = Production()
//        
//        // 1. Select item to produce
//        let item = Storage[itemName: "Reinforced Iron Plate"]!
//        
//        // 2. Select recipe for item
//        let recipe = Storage[recipesFor: item.id][0]
//        
//        let part = Production.Part(item: item, recipe: recipe)
//    }
//}
//
//struct ProductionSteps {
//    var item: Item
//    var recipe: Recipe?
//    var inputs = [Item]()
//    var multiplier = 1
//    
//    var amount: Double { recipe!.output[0].amountPerMinute }
//    var inputsPerMinute: [Double] { recipe!.input.map { $0.amountPerMinute } }
//    var totalAmount: Double { amount * Double(multiplier) }
//    var totalAmountOfInputs: [Double] { inputsPerMinute.map { $0 * Double(multiplier) } }
//}

//var rip = ProductionSteps(item: Storage[itemName: "Reinforced Iron Plate"]!, recipe: nil)
//let recipe = Storage[recipesFor: rip.item.id][0]
//rip.recipe = recipe
//rip.inputs = recipe.input.map(\.item)
//rip.multiplier = 2

// MARK: - Steps
// 1. Select item to produce
// 2. Select recipe for item
//  2.1 Fill amount of item to produce per minute
//  2.2 Fill inputs of item
//  2.3 Fill amount of inputs to take per minute
// 3. Fill desired amount of items to produce (number of machines to be used to produce item)
// 4. Fill total amount of items that will be produced
// 5. Fill total amount of inputs for total amount of items per minute
// 6. For each item from inputs perform steps 1-5.
// 7. For each item from inputs which does not have a recipe compute total amount of items needed
