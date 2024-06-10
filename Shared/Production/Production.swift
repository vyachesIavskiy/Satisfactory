import SHModels

final class Production: ObservableObject {
    var itemEntries: ItemEntries
    var item: any Item { tree.element.item }
    var amount: Double {
        didSet {
            tree.element.amounts = (amount, amount)
            recalculate()
        }
    }
    var name: String
    var factoryName: String
    
    private var selectedRecipes: SelectedRecipes
    private var proportions: ProductionProportions
    private var byproducts = Byproducts()
    private var tree: ProductionTree
    
    init(item: some Item, recipe: Recipe, amount: Double) {
        itemEntries = ItemEntries(item: item)
        self.amount = amount
        self.name = "\(item.localizedName) \(amount.formatted(.fractionFromZeroToFour))"
        factoryName = ""
        selectedRecipes = SelectedRecipes(item: item, recipe: recipe)
        proportions = ProductionProportions(recipe: recipe)
        tree = ProductionTree(item: item, recipe: recipe, amount: amount)
        
        buildItemEntries()
    }
    
    init(
        name: String,
        factoryName: String,
        item: some Item,
        recipe: Recipe,
        amount: Double,
        items: ItemEntries,
        selectedRecipes: SelectedRecipes,
        proportions: ProductionProportions,
        byproducts: Byproducts
    ) {
        self.name = name
        self.factoryName = factoryName
        self.amount = amount
        self.itemEntries = items
        self.selectedRecipes = selectedRecipes
        self.proportions = proportions
        self.byproducts = byproducts
        
        tree = ProductionTree(item: item, recipe: recipe, amount: amount)
        
        recalculate()
    }
    
    func add(recipe: Recipe, for item: some Item, proportion: ProductionProportion = .default) {
        itemEntries.add(item)
        selectedRecipes.add(recipe: recipe, for: item)
        proportions.set(proportion, for: recipe)

        recalculate()
    }
    
    func remove(item: some Item) {
        itemEntries.remove(item)
        let removedRecipes = selectedRecipes.remove(item: item)
        proportions.remove(for: removedRecipes)

        recalculate()
    }
    
    func remove(recipe: Recipe, from item: some Item) {
        proportions.remove(for: recipe)
        selectedRecipes.remove(recipe, from: item)
        removeFromItemListIfNeeded(item)

        for input in recipe.input {
            byproducts.remove(input.item, recipe: recipe)
        }

        for byproduct in recipe.byproducts {
            byproducts.remove(byproduct.item, recipe: recipe)
        }

        byproducts.remove(recipe.output.item, recipe: recipe)

        recalculate()
    }
    
    func change(recipe: Recipe, to proportion: ProductionProportion) {
        proportions.set(proportion, for: recipe)

        recalculate()
    }
    
    func add(byproduct item: some Item, from fromRecipe: Recipe, to toRecipe: Recipe) {
        byproducts.add(item, from: fromRecipe, to: toRecipe)

        recalculate()
    }
    
    func remove(byproduct item: some Item, from recipe: Recipe) {
        byproducts.remove(item, recipe: recipe)

        recalculate()
    }
    
    func isItemPresent(_ item: some Item) -> Bool {
        if (item as? Part)?.isNaturalResource == true {
            return true
        }
        
        return itemEntries.dropFirst().contains(item)
    }
    
    func byproductIndex(for item: some Item) -> Int? {
        byproducts.firstIndex(of: item)
    }
    
    func selectedRecipes(for item: some Item) -> [Recipe] {
        selectedRecipes.recipes(for: item)
    }
    
    func selectedRecipes(forInput item: some Item) -> [Recipe] {
        selectedRecipes.recipes(forInput: item)
    }
    
    func selectedRecipes(forByproduct item: some Item) -> [Recipe] {
        selectedRecipes.recipes(forByproduct: item)
    }
    
    func proportions(for item: some Item) -> [(recipe: Recipe, proportion: ProductionProportion)] {
        selectedRecipes.recipes(for: item).compactMap { recipe in
            proportions[recipe.id].map { (recipe, $0) }
        }
    }
    
    func amount(for item: some Item) -> Double {
        itemEntries.first(of: item)?.amount ?? 0
    }
}

// MARK: - Private
private extension Production {
    func removeFromItemListIfNeeded(_ item: some Item) {
        guard selectedRecipes.recipes(for: item).isEmpty else { return }

        itemEntries.remove(item)
    }
    
    func buildTree() {
        var proportionsForTree = proportions
        tree.element.resetActualAmount()
        build(tree: tree, proportions: &proportionsForTree)
    }
    
    func build(tree: ProductionTree, proportions: inout ProductionProportions) {
        addByproducts(to: tree)

        buildInputs(for: tree, proportions: &proportions)

        // Remove all leaves where we have deleted recipes
        tree.removeAll { !selectedRecipes.item($0.item, contains: $0.recipe) }

        // Go deeper in the tree
        for leaf in tree.leaves {
            build(tree: leaf, proportions: &proportions)
        }
    }
    
    func buildInputs(for tree: ProductionTree, proportions: inout ProductionProportions) {
        // Go through all inputs
        for input in tree.element.recipe.input {
            // If we have a recipe for input item
            guard let inputRecipes = selectedRecipes[input.item.id] else { continue }

            // Get amount without calculation mode
            let desiredParentAmount = tree.element.desiredAmount(for: input.item)
            let actualParentAmount = tree.element.actualAmount(for: input.item)

            let parentAmounts = (desiredParentAmount, actualParentAmount)

            // Get amount without static amounts for this recipe to use for fractions
            let fractionsAmounts = fractionsAmounts(from: parentAmounts, recipes: inputRecipes, proportions: proportions)

            for recipe in inputRecipes {
                let amounts = calculateAmounts(
                    for: recipe,
                    parentAmounts: parentAmounts,
                    fractionsAmounts: fractionsAmounts,
                    proportions: &proportions
                )

                guard let amounts else { continue }

                // In case we have 0 amount for next branch, we do not include it
                guard amounts.actualAmount > 0 else { continue }

                if !tree.leaf(containsRecipe: recipe) {
                    // We must check for infinite recursion of such recipes as packaged/unpackaged
                    if recipe != tree.parent?.element.recipe {
                        tree.add(item: input.item, recipe: recipe, amounts: amounts)
                    }
                } else if let leaf = tree.first(of: recipe) {
                    leaf.element.amounts = amounts
                }
            }
        }
    }
    
    func fractionsAmounts(from parentAmounts: ProductionAmounts, recipes: [Recipe], proportions: ProductionProportions) -> ProductionAmounts {
        recipes.reduce(parentAmounts) { partialResult, recipe in
            guard let proportion = proportions[recipe.id], proportion.mode == .amount else {
                return partialResult
            }

            return (
                desiredAmount: partialResult.desiredAmount - proportion.value,
                actualAmount: partialResult.actualAmount - proportion.value
            )
        }
    }
    
    func calculateAmounts(for recipe: Recipe, parentAmounts: ProductionAmounts, fractionsAmounts: ProductionAmounts, proportions: inout ProductionProportions) -> ProductionAmounts? {
        guard let proportion = proportions[recipe.id] else { return nil }

        // This will be a final amount for leaf
        var amounts = parentAmounts

        switch proportion.mode {
        // If we have a strict amount for this recipe, spread it by branches until amount is zero
        case .amount:
            calculateAmount(amounts: &amounts, recipe: recipe, proportionValue: proportion.value, proportions: &proportions)

        // Fractions divide amount for fractions between them respectively
        case .fraction:
            calculateFraction(amounts: &amounts, fractionsAmounts: fractionsAmounts, proportionValue: proportion.value)
        }

        return amounts
    }
    
    func calculateAmount(amounts: inout ProductionAmounts, recipe: Recipe, proportionValue: Double, proportions: inout ProductionProportions) {
        // If static amount is zero, do not include this branch anymore
        guard proportionValue > 0 else { return }

        // If this branch can have more than static amount, assign only needed static amount
        if amounts.actualAmount >= proportionValue {
            amounts.desiredAmount = proportionValue
            amounts.actualAmount = proportionValue
            proportions[recipe.id]?.value = amounts.actualAmount - proportionValue
        }
        // If this branch can't have more than static amount, leave it as it is
        else {
            proportions[recipe.id]?.value = proportionValue - amounts.actualAmount
        }
    }
    
    func calculateFraction(amounts: inout ProductionAmounts, fractionsAmounts: ProductionAmounts, proportionValue: Double) {
        amounts.desiredAmount = fractionsAmounts.desiredAmount * proportionValue
        amounts.actualAmount = fractionsAmounts.actualAmount * proportionValue
    }
    
    func addByproducts(to tree: ProductionTree) {
        // Calculate amount of byproducts for the recipe in this node (byproduct + output)
        for byproduct in tree.element.recipe.byproducts + CollectionOfOne(tree.element.recipe.output) {
            // If we have an item selected to be a byproduct and current recipe is producing it
            if let itemByproduct = byproducts.first(of: byproduct.item),
               itemByproduct.produced.contains(tree.element.recipe) {
                // Calculate byproduct amount
                let byproductAmount = tree.element.actualAmount(for: byproduct.item)

                // If this byproduct is aleready in production tree
                if let index = tree.element.byproducts.firstIndex(of: byproduct.item) {
                    // Update amount of byproduct in tree
                    tree.element.byproducts[index].amount = byproductAmount
                } else {
                    // Otherwise, add byproduct to the tree
                    tree.element.byproducts.append(ProductionRecipeEntry.Byproduct(
                        item: byproduct.item,
                        amount: byproductAmount,
                        direction: .outside
                    ))
                }
            } else {
                // If we removed a byproduct from a production chain, we need to update tree for it
                if let index = tree.element.byproducts.firstIndex(of: byproduct.item) {
                    tree.element.byproducts.remove(at: index)
                }
            }
        }
    }
    
    func calculateProducedByproducts() {
        // Reset all byproduct amounts
        byproducts.reset()

        byproducts = tree.reduce(into: byproducts) { partialResult, element in
            // For each byproduct that is producing item
            for byproduct in element.byproducts where byproduct.direction == .outside {
                // If current elemnt is producing the required item
                if let byproductIndex = partialResult.firstIndex(of: byproduct.item),
                   let producedIndex = partialResult[byproductIndex].produced.firstIndex(of: element.recipe) {
                    // Accumulate amount of produced byproduct from every branch
                    partialResult[byproductIndex].produced[producedIndex].amount += byproduct.amount
                }
            }
        }
    }
    
    func resolveInputsWithByproducts() {
        var workingByproducts = byproducts
        resolveInputs(with: &workingByproducts, tree: tree)
        // Save required amounts for next calculations
        for (byproductIndex, byproduct) in workingByproducts.enumerated() {
            for (producedIndex, produced) in byproduct.produced.enumerated() {
                for (requiredIndex, `required`) in produced.required.enumerated() {
                    byproducts[byproductIndex].produced[producedIndex].required[requiredIndex].amount = `required`.amount
                }
            }
        }
    }
    
    func resolveInputs(with byproducts: inout Byproducts, tree: ProductionTree) {
        // For every input in recipe
        for input in tree.element.recipe.input {
            resolve(input: input, tree: tree, byproducts: &byproducts)
        }

        // Repeat fot the whole tree
        for leaf in tree.leaves {
            resolveInputs(with: &byproducts, tree: leaf)
        }
    }
    
    func resolve(input: Recipe.Ingredient, tree: ProductionTree, byproducts: inout Byproducts) {
        // If this item is a byproduct from other recipe
        guard let byproductIndex = byproducts.firstIndex(of: input.item),
           // If we have a recipe that produces this item
              let producedIndex = byproducts[byproductIndex].produced.firstIndex(where: { $0.recipe.byproducts.contains { $0.id == input.item.id } || $0.recipe.output.item.id == input.item.id }),
           // If node recipe is the destination for the byproduct
           let requiredIndex = byproducts[byproductIndex].produced[producedIndex].required.firstIndex(of: tree.element.recipe) else {
            // Remove byproduct from node that is no longer present in production
            removeByproductsFromNodeIfNeeded(node: tree, byproducts: byproducts)
            return
        }

        // Calculate original amount
        let inputAmount = tree.element.actualAmount(for: input.item)
        // Get remaining byproduct amount
        let byproductAmount = byproducts[byproductIndex].produced[producedIndex].amount

        var amount = 0.0
        // If input amount is lower that byproduct amount, set amount of byproduct as input amount and substract input amount from byproduct amount
        if inputAmount < byproductAmount {
            amount = inputAmount
            byproducts[byproductIndex].produced[producedIndex].amount -= inputAmount
        } else {
            // Otherwise set byproduct amount as input byproduct amount
            amount = byproductAmount
            byproducts[byproductIndex].produced[producedIndex].amount = 0
        }

        // Accumulate amount we used for this recipe
        byproducts[byproductIndex].produced[producedIndex].required[requiredIndex].amount += amount

        // If we already have a byproduct for this item, just adjust it's amount
        if let index = tree.element.byproducts.firstIndex(of: input.item) {
            tree.element.byproducts[index].amount = amount
        } else {
            // Otherwise, add a new byproduct to production
            tree.element.byproducts.append(
                item: input.item,
                amount: amount,
                direction: .inside
            )
        }
    }
    
    func removeByproductsFromNodeIfNeeded(node: ProductionTree, byproducts: Byproducts) {
        for (index, byproduct) in node.element.byproducts.enumerated() {
            if !byproducts.contains(byproduct.item) {
                node.element.byproducts.remove(at: index)
            }
        }
    }
    
    func reduceOutputsByByproducts() {
        reduceOutputsByByproducts(node: tree)
    }
    
    func reduceOutputsByByproducts(node: ProductionTree) {
        defer {
            for leaf in node.leaves {
                reduceOutputsByByproducts(node: leaf)
            }
        }

        if let byproductAmount = amountUsed(ofByproduct: node.element.item, for: node.element.recipe), byproductAmount > 0 {
            let desiredAmount = node.element.amounts.desiredAmount
            let actualAmount = node.element.amounts.actualAmount - byproductAmount
            let difference = desiredAmount - actualAmount
            
            guard !difference.isZero else { return }

            node.element.amounts.actualAmount += difference

            // recalculate tree from this branch
            var proportions = proportions
            build(tree: node, proportions: &proportions)
            buildByproducts()
            reduceOutputsByByproducts(node: node)
        }
    }
    
    func buildItemEntries() {
        itemEntries.indices.forEach { itemEntries[$0].recipeEntries = [] }

        itemEntries = tree.reduce(into: itemEntries) { partialResult, element in
            // Find index of leaf in item list
            guard let itemIndex = partialResult.firstIndex(of: element.item) else { return }

            // Find index of recipe of leaf in item list entries
            guard let recipeIndex = partialResult[itemIndex].recipeEntries.firstIndex(of: element.recipe) else {
                // Recipe is not found, append
                partialResult[itemIndex].recipeEntries.append(element)
                return
            }
            
            partialResult[itemIndex].recipeEntries[recipeIndex].amounts += element.amounts
        }
        
        itemEntries.removeAll(where: \.recipeEntries.isEmpty)

        // We prioritize byproduct over input
        for byproduct in byproducts {
            // Search for an item that is byproduct
            guard let itemIndex = itemEntries.firstIndex(of: byproduct.item) else { continue }

            let itemIsByproduct = itemEntries[itemIndex].recipeEntries.contains { $0.byproducts.contains { $0.item.id == byproduct.item.id && $0.direction == .outside } }

            guard !itemIsByproduct else { continue }

            // Get amount of byproduct used in production
            let totalAmount = byproduct.amountUsed

            // For every selected recipe with that item
            for recipeIndex in itemEntries[itemIndex].recipeEntries.indices {
                let entry = itemEntries[itemIndex].recipeEntries[recipeIndex]

                guard let proportion = proportions[entry.recipe.id] else { continue }

                var amountToRemove = 0.0

                // Calculate the amount needed to be removed from the production
                switch proportion.mode {
                case .fraction:
                    amountToRemove = totalAmount * proportion.value

                case .amount:
                    amountToRemove = min(totalAmount, proportion.value)
                }

                // Subsctract the amount of byproduct from this recipe
                itemEntries[itemIndex].recipeEntries[recipeIndex].amounts.actualAmount -= amountToRemove

                if itemEntries[itemIndex].recipeEntries[recipeIndex].amounts.actualAmount.isZero {
                    // If this recipe is no longer needed in production, remove it from the list
                    itemEntries[itemIndex].recipeEntries.remove(at: recipeIndex)
                }

                // If this item does not have any production recipe anymore, remove it from the list
                if itemEntries[itemIndex].recipeEntries.isEmpty {
                    itemEntries.remove(at: itemIndex)
                }
            }
        }
    }
    
    func buildByproducts() {
        calculateProducedByproducts()
        resolveInputsWithByproducts()
    }
    
    func recalculate() {
        buildTree()
        buildByproducts()
        reduceOutputsByByproducts()
        buildItemEntries()
        
        objectWillChange.send()
    }
    
    func amountUsed(ofByproduct item: some Item, for recipe: Recipe) -> Double? {
        byproducts.first { $0.item.id == item.id }.map { byproduct in
            if let produced = byproduct.produced.first(of: recipe) {
                return produced.amountUsed
            } else {
                return byproduct.produced.flatMap { $0.required }.filter { $0.recipe == recipe }.reduce(0) { $0 + $1.amount }
            }
        }
    }
}

extension Production: Identifiable {
    var id: String { item.id }
}

#if DEBUG
import SwiftUI
import SHStorage

struct ProductionViewTest: View {
    private var production: Production = {
//        let heavyModularFrame = Self.item("part-heavy-modular-frame")
//        let modularFrame = Self.item("part-modular-frame")
//        let reinforcedIronPlate = Self.item("part-reinforced-iron-plate")
//        let screw = Self.item("part-screw")
//        let ironRod = Self.item("part-iron-rod")
//
//        let heavyModularFrameRecipe = Self.recipe("recipe-heavy-modular-frame")
//        let modularFrameRecipe = Self.recipe("recipe-modular-frame")
//        let reinforcedIronPlateRecipe = Self.recipe("recipe-reinforced-iron-plate")
//        let screwRecipe = Self.recipe("recipe-screw")
//        let screwRecipe2 = Self.recipe("recipe-alternate-cast-screw")
//        let ironRodRecipe = Self.recipe("recipe-iron-rod")
//        let ironRodRecipe2 = Self.recipe("recipe-alternate-steel-rod")
//
//
//        var production = Production(
//            item: heavyModularFrame,
//            recipe: heavyModularFrameRecipe,
//            amount: 10
//        )
//
//        production.add(recipe: modularFrameRecipe, for: modularFrame)
//        production.add(recipe: screwRecipe, for: screw)
//        production.change(recipe: screwRecipe, toCalculationMode: .amount(1000))
//        production.add(recipe: screwRecipe2, for: screw)
//        production.add(recipe: reinforcedIronPlateRecipe, for: reinforcedIronPlate)
//        production.add(recipe: ironRodRecipe, for: ironRod)
//        production.change(recipe: ironRodRecipe, toCalculationMode: .fraction(0.6))
//        production.add(recipe: ironRodRecipe2, for: ironRod, mode: .fraction(0.4))
//
//        production.amount = 12
//
//        production.remove(recipe: ironRodRecipe, from: ironRod)
//        production.change(recipe: ironRodRecipe2, toCalculationMode: .fraction(1))
//        production.remove(recipe: ironRodRecipe2, from: ironRod)
//
//        production.remove(item: screw)
//
//        production.add(recipe: screwRecipe, for: screw)
//        production.add(recipe: screwRecipe2, for: screw, mode: .fraction(0.8))
//        production.change(recipe: screwRecipe, toCalculationMode: .fraction(0.2))
        
//        let packagedWater = Self.item("part-packaged-water")
//        let water = Self.item("fluid-water")
//        let emptyCanister = Self.item("part-empty-canister")
//
//        let packagedWaterRecipe = Self.recipe("recipe-packaged-water")
//        let unpackedWaterRecipe = Self.recipe("recipe-unpackaged-water")
//
//        let production = Production(
//            item: packagedWater,
//            recipe: packagedWaterRecipe,
//            amount: 60
//        )
//
//        production.add(recipe: unpackedWaterRecipe, for: water)
//
//        production.add(byproduct: emptyCanister, from: unpackedWaterRecipe, to: packagedWaterRecipe)
//        production.remove(byproduct: emptyCanister, from: packagedWaterRecipe)
        
//        let aluminumIngot = Self.item("part-aluminum-ingot")
//        let aluminumScrap = Self.item("part-aluminum-scrap")
//        let water = Self.item("fluid-water")
//        let silica = Self.item("part-silica")
//        let quartz = Self.item("part-raw-quartz")
//        let aluminaSolution = Self.item("fluid-alumina-solution")
//        let coal = Self.item("part-coal")
//
//        let aluminumIngotRecipe = Self.recipe("recipe-aluminum-ingot")
//        let aluminumIngotRecipe2 = Self.recipe("recipe-alternate-pure-aluminum-ingot")
//        let aluminumScrapRecipe = Self.recipe("recipe-aluminum-scrap")
//        let silicaRecipe = Self.recipe("recipe-silica")
//        let aluminaSolutionRecipe = Self.recipe("recipe-alumina-solution")
//
//        let production = Production(
//            item: aluminumIngot,
//            recipe: aluminumIngotRecipe,
//            amount: 60
//        )
//
//        production.add(recipe: aluminumScrapRecipe, for: aluminumScrap)
//        production.add(recipe: silicaRecipe, for: silica)
//        production.add(recipe: aluminaSolutionRecipe, for: aluminaSolution)
//        production.add(byproduct: silica, from: aluminaSolutionRecipe, to: aluminumIngotRecipe)
//        production.add(byproduct: water, from: aluminumScrapRecipe, to: aluminaSolutionRecipe)
        
        let plastic = Self.item("part-plastic")
        let rubber = Self.item("part-rubber")
        let fuel = Self.item("part-fuel")
        let heavyOilResidue = Self.item("part-heavy-oil-residue")
        let polymerResin = Self.item("part-polymer-resin")

        let plasticRecipe = Self.recipe("recipe-alternate-recycled-plastic")
        let rubberRecipe1 = Self.recipe("recipe-alternate-recycled-rubber")
        let rubberRecipe2 = Self.recipe("recipe-residual-rubber")
        let fuelRecipe = Self.recipe("recipe-alternate-diluted-fuel")
        let heavyOilResidueRecipe = Self.recipe("recipe-alternate-heavy-oil-residue")
        let polymerResinRecipe = Self.recipe("recipe-alternate-polymer-resin")

        let production = Production(
            item: plastic,
            recipe: plasticRecipe,
            amount: 60
        )

        production.add(recipe: rubberRecipe1, for: rubber)
        production.add(recipe: rubberRecipe2, for: rubber, proportion: ProductionProportion(mode: .fraction, value: 0.5))
        production.change(recipe: rubberRecipe1, to: ProductionProportion(mode: .fraction, value: 0.5))
        production.add(byproduct: plastic, from: plasticRecipe, to: rubberRecipe1)
        production.add(recipe: polymerResinRecipe, for: polymerResin)
        production.add(recipe: fuelRecipe, for: fuel)
        production.add(recipe: heavyOilResidueRecipe, for: heavyOilResidue)
        production.add(byproduct: polymerResin, from: heavyOilResidueRecipe, to: rubberRecipe2)
        production.amount = 90
        production.change(recipe: rubberRecipe1, to: ProductionProportion(mode: .fraction, value: 1))
        production.change(recipe: rubberRecipe2, to: ProductionProportion(mode: .amount, value: 10))
        
//        let emptyCanister = Self.item("part-empty-canister")
//        let plastic = Self.item("part-plastic")
//        let rubber = Self.item("part-rubber")
//        let fuel = Self.item("fluid-fuel")
//        let heavyOilResidue = Self.item("fluid-heavy-oil-residue")
//        let polymerResin = Self.item("part-polymer-resin")
//
//        let emptyCanisterRecipe = Self.recipe("recipe-empty-canister")
//        let plasticRecipe = Self.recipe("recipe-alternate-recycled-plastic")
//        let rubberRecipe1 = Self.recipe("recipe-alternate-recycled-rubber")
//        let rubberRecipe2 = Self.recipe("recipe-residual-rubber")
//        let fuelRecipe = Self.recipe("recipe-alternate-diluted-fuel")
//        let heavyOilResidueRecipe = Self.recipe("recipe-alternate-heavy-oil-residue")
//
//        let production = Production(
//            item: emptyCanister,
//            recipe: emptyCanisterRecipe,
//            amount: 1800
//        )
//
//        production.add(recipe: plasticRecipe, for: plastic)
//        production.add(recipe: rubberRecipe1, for: rubber)
//        production.add(recipe: fuelRecipe, for: fuel)
//        production.add(recipe: heavyOilResidueRecipe, for: polymerResin)
//        production.add(recipe: rubberRecipe2, for: rubber, mode: .amount(100))
//        production.add(byproduct: heavyOilResidue, from: heavyOilResidueRecipe, to: fuelRecipe)
//        production.add(byproduct: plastic, from: plasticRecipe, to: rubberRecipe1)
        
//        production.amount = 900
//        production.change(recipe: rubberRecipe2, toCalculationMode: .amount(50))
        
        return production
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(production.itemEntries, id: \.item.id) { itemEntry in
                    Section(itemEntry.item.localizedName) {
                        ForEach(itemEntry.recipeEntries) { recipeEntry in
                            recipeRow(recipeEntry: recipeEntry)
                            
                            Rectangle()
                                .foregroundColor(.green)
                                .frame(height: 1)
                        }
                    }
                    Rectangle()
                        .foregroundColor(.brown)
                        .frame(height: 1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
    
    static func item(_ id: String) -> any Item {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.item(for: id)!
    }
    
    static func recipe(_ id: String) -> Recipe {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.recipes().first(id: id)!
    }
    
    @ViewBuilder private func recipeRow(recipeEntry: ProductionRecipeEntry) -> some View {
        RecipeProductionView(viewModel: RecipeProductionViewModel(entry: recipeEntry))
    }
}

#Preview {
    ProductionViewTest()
}
#endif
