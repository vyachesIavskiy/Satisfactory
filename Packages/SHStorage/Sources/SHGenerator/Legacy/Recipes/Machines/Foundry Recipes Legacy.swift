import Models
import StaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        name: String,
        input: [Ingredient],
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            name: name,
            input: input,
            output: [output],
            machines: [Legacy.Buildings.foundry.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // Ingots
    static let steelIngotRecipe = Recipe.Static.Legacy(
        id: "steel-ingot",
        name: "Steel Ingot",
        input: [
            .init(Legacy.Parts.ironOre, amount: 3),
            .init(Legacy.Parts.coal, amount: 3)
        ],
        output: .init(Legacy.Parts.steelIngot, amount: 3),
        duration: 4
    )

    static let steelIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-solid-steel-ingot",
        name: "Alternate: Solid Steel Ingot",
        input: [
            .init(Legacy.Parts.ironIngot, amount: 2),
            .init(Legacy.Parts.coal, amount: 2)
        ],
        output: .init(Legacy.Parts.steelIngot, amount: 3),
        duration: 3,
        isDefault: false
    )

    static let steelIngotRecipe2 = Recipe.Static.Legacy(
        id: "alternate-compacted-steel-ingot",
        name: "Alternate: Compacted Steel Ingot",
        input: [
            .init(Legacy.Parts.ironOre, amount: 6),
            .init(Legacy.Parts.compactedCoal, amount: 3)
        ],
        output: .init(Legacy.Parts.steelIngot, amount: 10),
        duration: 16,
        isDefault: false
    )

    static let steelIngotRecipe3 = Recipe.Static.Legacy(
        id: "alternate-coke-steel-ingot",
        name: "Alternate: Coke Steel Ingot",
        input: [
            .init(Legacy.Parts.ironOre, amount: 15),
            .init(Legacy.Parts.petroleumCoke, amount: 15)
        ],
        output: .init(Legacy.Parts.steelIngot, amount: 20),
        duration: 12,
        isDefault: false
    )

    static let ironIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-iron-alloy-ingot",
        name: "Alternate: Iron Alloy Ingot",
        input: [
            .init(Legacy.Parts.ironOre, amount: 2),
            .init(Legacy.Parts.copperOre, amount: 2)
        ],
        output: .init(Legacy.Parts.ironIngot, amount: 5),
        duration: 6,
        isDefault: false
    )

    static let copperIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-copper-alloy-ingot",
        name: "Alternate: Copper Alloy Ingot",
        input: [
            .init(Legacy.Parts.copperOre, amount: 10),
            .init(Legacy.Parts.ironOre, amount: 5)
        ],
        output: .init(Legacy.Parts.copperIngot, amount: 20),
        duration: 12,
        isDefault: false
    )

    static let aluminumIngotRecipe = Recipe.Static.Legacy(
        id: "aluminum-ingot",
        name: "Aluminum Ingot",
        input: [
            .init(Legacy.Parts.aluminumScrap, amount: 6),
            .init(Legacy.Parts.silica, amount: 5)
        ],
        output: .init(Legacy.Parts.aluminumIngot, amount: 4),
        duration: 4
    )

    static let foundryRecipes = [
        // Ingots
        steelIngotRecipe,
        steelIngotRecipe1,
        steelIngotRecipe2,
        steelIngotRecipe3,
        ironIngotRecipe1,
        copperIngotRecipe1,
        aluminumIngotRecipe,
    ]
}
