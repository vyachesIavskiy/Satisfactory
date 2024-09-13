import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Double,
        powerConsumption: PowerConsumption,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            machine: V2.Buildings.particleAccelerator,
            duration: duration,
            powerConsumption: powerConsumption,
            isDefault: isDefault
        )
    }
}

// MARK: - Space Elevator
extension V2.Recipes {
    static let nuclearPastaRecipe = Recipe.Static(
        id: "recipe-nuclear-pasta",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperPowder, amount: 200),
            Recipe.Static.Ingredient(V2.Parts.pressureConversionCube, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nuclearPasta, amount: 1),
        duration: 120,
        powerConsumption: Recipe.Static.PowerConsumption(min: 500, max: 1500)
    )
    
    fileprivate static let spaceElevatorRecipes = [
        nuclearPastaRecipe
    ]
}

// MARK: - Quantum Technology
extension V2.Recipes {
    static let darkMatterCrystalRecipe = Recipe.Static(
        id: "recipe-dark-matter-crystal",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.diamonds, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.darkMatterCrystal, amount: 1),
        duration: 2,
        powerConsumption: Recipe.Static.PowerConsumption(min: 500, max: 1500)
    )
    
    static let darkMatterCrystallizationRecipe = Recipe.Static(
        id: "recipe-alternate-dark-matter-crystallization",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.darkMatterCrystal, amount: 1),
        duration: 3,
        powerConsumption: Recipe.Static.PowerConsumption(min: 500, max: 1500),
        isDefault: false
    )
    
    static let darkMatterTrapRecipe = Recipe.Static(
        id: "recipe-alternate-dark-matter-trap",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.timeCrystal, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.darkMatterCrystal, amount: 2),
        duration: 2,
        powerConsumption: Recipe.Static.PowerConsumption(min: 500, max: 1500),
        isDefault: false
    )
    
    fileprivate static let quantumTechnologyRecipes = [
        darkMatterCrystalRecipe,
        darkMatterCrystallizationRecipe,
        darkMatterTrapRecipe,
    ]
}

// MARK: - Advanced Refinement
extension V2.Recipes {
    static let diamondsRecipe = Recipe.Static(
        id: "recipe-diamonds",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.diamonds, amount: 1),
        duration: 2,
        powerConsumption: Recipe.Static.PowerConsumption(min: 250, max: 750)
    )
    
    static let cloudyDiamondsRecipe = Recipe.Static(
        id: "recipe-alternate-cloudy-diamonds",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 12),
            Recipe.Static.Ingredient(V2.Parts.limestone, amount: 24)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.diamonds, amount: 1),
        duration: 3,
        powerConsumption: Recipe.Static.PowerConsumption(min: 250, max: 750),
        isDefault: false
    )
    
    static let oilBasedDiamondsRecipe = Recipe.Static(
        id: "recipe-alternate-oil-based-diamonds",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.crudeOil, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.diamonds, amount: 2),
        duration: 3,
        powerConsumption: Recipe.Static.PowerConsumption(min: 250, max: 750),
        isDefault: false
    )
    
    static let petroleumDiamondsRecipe = Recipe.Static(
        id: "recipe-alternate-petroleum-diamonds",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.petroleumCoke, amount: 24)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.diamonds, amount: 1),
        duration: 2,
        powerConsumption: Recipe.Static.PowerConsumption(min: 250, max: 750),
        isDefault: false
    )
    
    static let turboDiamondsRecipe = Recipe.Static(
        id: "recipe-alternate-turbo-diamonds",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 30),
            Recipe.Static.Ingredient(V2.Parts.packagedTurbofuel, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.diamonds, amount: 3),
        duration: 3,
        powerConsumption: Recipe.Static.PowerConsumption(min: 250, max: 750),
        isDefault: false
    )
    
    fileprivate static let advancedRefinementRecipes = [
        diamondsRecipe,
        cloudyDiamondsRecipe,
        oilBasedDiamondsRecipe,
        petroleumDiamondsRecipe,
        turboDiamondsRecipe,
    ]
}

// MARK: - Nuclear
extension V2.Recipes {
    static let plutoniumPelletRecipe = Recipe.Static(
        id: "recipe-plutonium-pellet",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nonFissileUranium, amount: 100),
            Recipe.Static.Ingredient(V2.Parts.uraniumWaste, amount: 25)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.plutoniumPellet, amount: 30),
        duration: 60,
        powerConsumption: Recipe.Static.PowerConsumption(min: 250, max: 750)
    )
    
    static let instantPlutoniumCellRecipe = Recipe.Static(
        id: "recipe-alternate-instant-plutonium-cell",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nonFissileUranium, amount: 150),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.encasedPlutoniumCell, amount: 20),
        duration: 120,
        powerConsumption: Recipe.Static.PowerConsumption(min: 250, max: 750),
        isDefault: false
    )
    
    static let ficsoniumRecipe = Recipe.Static(
        id: "recipe-ficsonium",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.plutoniumWaste, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.singularityCell, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ficsonium, amount: 1),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 500, max: 1500)
    )
    
    fileprivate static let nuclearRecipes = [
        plutoniumPelletRecipe,
        instantPlutoniumCellRecipe,
        ficsoniumRecipe,
    ]
}

// MARK: Particle Accelerator recipes
extension V2.Recipes {
    static let particleAcceleratorRecipes =
    spaceElevatorRecipes +
    quantumTechnologyRecipes +
    advancedRefinementRecipes +
    nuclearRecipes
}
