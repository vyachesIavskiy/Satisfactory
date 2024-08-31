import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        output: Ingredient,
        input: [Ingredient]
    ) {
        self.init(
            id: id,
            output: [output],
            input: input
        )
    }
}

extension Legacy.Recipes {
    // Nuclear
    static let plutoniumPelletRecipe = Recipe.Static.Legacy(
        id: "plutonium-pellet",
        output: .init(Legacy.Parts.plutoniumPellet),
        input: [
            .init(Legacy.Parts.nonFissileUranium),
            .init(Legacy.Parts.uraniumWaste)
        ]
    )

    static let encasedPlutoniumCellRecipe1 = Recipe.Static.Legacy(
        id: "alternate-instant-plutonium-cell",
        output: .init(Legacy.Parts.encasedPlutoniumCell),
        input: [
            .init(Legacy.Parts.nonFissileUranium),
            .init(Legacy.Parts.aluminumCasing)
        ]
    )

    // Quantum Technology
    static let nuclearPastaRecipe = Recipe.Static.Legacy(
        id: "nuclear-pasta",
        output: .init(Legacy.Parts.nuclearPasta),
        input: [
            .init(Legacy.Parts.copperPowder),
            .init(Legacy.Parts.pressureConversionCube)
        ]
    )

    static let particleAcceleratorRecipes = [
        // Nuclear
        plutoniumPelletRecipe,
        encasedPlutoniumCellRecipe1,
        
        // Quantum Technology
        nuclearPastaRecipe
    ]
}
