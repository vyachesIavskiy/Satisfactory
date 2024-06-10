import SHModels
import SHStaticModels

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
            machines: [Legacy.Buildings.particleAccelerator.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // Nuclear
    static let plutoniumPelletRecipe = Recipe.Static.Legacy(
        id: "plutonium-pellet",
        name: "Plutonium Pellet",
        input: [
            .init(Legacy.Parts.nonFissileUranium, amount: 100),
            .init(Legacy.Parts.uraniumWaste, amount: 25)
        ],
        output: .init(Legacy.Parts.plutoniumPellet, amount: 30),
        duration: 60
    )

    static let encasedPlutoniumCellRecipe1 = Recipe.Static.Legacy(
        id: "alternate-instant-plutonium-cell",
        name: "Alternate: Instant Plutonium Cell",
        input: [
            .init(Legacy.Parts.nonFissileUranium, amount: 150),
            .init(Legacy.Parts.aluminumCasing, amount: 20)
        ],
        output: .init(Legacy.Parts.encasedPlutoniumCell, amount: 20),
        duration: 120,
        isDefault: false
    )

    // Quantum Technology
    static let nuclearPastaRecipe = Recipe.Static.Legacy(
        id: "nuclear-pasta",
        name: "Nuclear Pasta",
        input: [
            .init(Legacy.Parts.copperPowder, amount: 200),
            .init(Legacy.Parts.pressureConversionCube, amount: 1)
        ],
        output: .init(Legacy.Parts.nuclearPasta, amount: 1),
        duration: 120
    )

    static let particleAcceleratorRecipes = [
        // Nuclear
        plutoniumPelletRecipe,
        encasedPlutoniumCellRecipe1,
        
        // Quantum Technology
        nuclearPastaRecipe
    ]
}
