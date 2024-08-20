import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true,
        manuallyCraftable: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            machine: V2.Buildings.foundry,
            manualCrafting: (isDefault && manuallyCraftable) ? [V2.Buildings.craftBench] : [],
            duration: duration,
            electricityConsumption: ElectricityConsumption(min: 16, max: 16),
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Ingots
    static let steelIngotRecipe = Recipe.Static(
        id: "recipe-steel-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 3),
        duration: 4
    )
    
    static let steelIngotRecipe1 = Recipe.Static(
        id: "recipe-alternate-solid-steel-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 3),
        duration: 3,
        isDefault: false
    )
    
    static let steelIngotRecipe2 = Recipe.Static(
        id: "recipe-alternate-compacted-steel-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.compactedCoal, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 10),
        duration: 16,
        isDefault: false
    )
    
    static let steelIngotRecipe3 = Recipe.Static(
        id: "recipe-alternate-coke-steel-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.petroleumCoke, amount: 15)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 20),
        duration: 12,
        isDefault: false
    )
    
    static let ironIngotRecipe1 = Recipe.Static(
        id: "recipe-alternate-iron-alloy-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 5),
        duration: 6,
        isDefault: false
    )
    
    static let copperIngotRecipe1 = Recipe.Static(
        id: "recipe-alternate-copper-alloy-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 20),
        duration: 12,
        isDefault: false
    )
    
    static let aluminumIngotRecipe = Recipe.Static(
        id: "recipe-aluminum-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.aluminumScrap, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.silica, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.aluminumIngot, amount: 4),
        duration: 4
    )
    
    // MARK: - FICSMAS
    static let copperFicsmasOrnamentRecipe = Recipe.Static(
        id: "recipe-copprt-ficsmas-ornament",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.redFicsmasOrnament, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.copperFicsmasOrnament, amount: 1),
        duration: 12,
        manuallyCraftable: false
    )
    
    static let ironFicsmasOrnamentRecipe = Recipe.Static(
        id: "recipe-iron-ficsmas-ornament",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.blueFicsmasOrnament, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ironFicsmasOrnament, amount: 1),
        duration: 12,
        manuallyCraftable: false
    )
    
    static let foundryRecipes = [
        steelIngotRecipe,
        steelIngotRecipe1,
        steelIngotRecipe2,
        steelIngotRecipe3,
        ironIngotRecipe1,
        copperIngotRecipe1,
        aluminumIngotRecipe,
        copperFicsmasOrnamentRecipe,
        ironFicsmasOrnamentRecipe
    ]
}
