import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(id: String, output: Ingredient, input: [Ingredient]) {
        self.init(id: id, output: [output], input: input)
    }
}

extension Legacy.Recipes {
    // Ingots
    static let steelIngotRecipe = Recipe.Static.Legacy(
        id: "steel-ingot",
        output: .init(Legacy.Parts.steelIngot),
        input: [
            .init(Legacy.Parts.ironOre),
            .init(Legacy.Parts.coal)
        ]
    )

    static let steelIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-solid-steel-ingot",
        output: .init(Legacy.Parts.steelIngot),
        input: [
            .init(Legacy.Parts.ironIngot),
            .init(Legacy.Parts.coal)
        ]
    )

    static let steelIngotRecipe2 = Recipe.Static.Legacy(
        id: "alternate-compacted-steel-ingot",
        output: .init(Legacy.Parts.steelIngot),
        input: [
            .init(Legacy.Parts.ironOre),
            .init(Legacy.Parts.compactedCoal)
        ]
    )

    static let steelIngotRecipe3 = Recipe.Static.Legacy(
        id: "alternate-coke-steel-ingot",
        output: .init(Legacy.Parts.steelIngot),
        input: [
            .init(Legacy.Parts.ironOre),
            .init(Legacy.Parts.petroleumCoke)
        ]
    )

    static let ironIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-iron-alloy-ingot",
        output: .init(Legacy.Parts.ironIngot),
        input: [
            .init(Legacy.Parts.ironOre),
            .init(Legacy.Parts.copperOre)
        ]
    )

    static let copperIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-copper-alloy-ingot",
        output: .init(Legacy.Parts.copperIngot),
        input: [
            .init(Legacy.Parts.copperOre),
            .init(Legacy.Parts.ironOre)
        ]
    )

    static let aluminumIngotRecipe = Recipe.Static.Legacy(
        id: "aluminum-ingot",
        output: .init(Legacy.Parts.aluminumIngot),
        input: [
            .init(Legacy.Parts.aluminumScrap),
            .init(Legacy.Parts.silica)
        ]
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
