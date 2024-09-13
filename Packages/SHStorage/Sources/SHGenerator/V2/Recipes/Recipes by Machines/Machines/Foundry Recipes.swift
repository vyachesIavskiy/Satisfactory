import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Double,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            machine: V2.Buildings.foundry,
            duration: duration,
            powerConsumption: PowerConsumption(16),
            isDefault: isDefault
        )
    }
}

// MARK: - Ingots
extension V2.Recipes {
    static let ironAlloyIngotRecipe = Recipe.Static(
        id: "recipe-alternate-iron-alloy-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 15),
        duration: 12,
        isDefault: false
    )
    
    static let basicIronIngotRecipe = Recipe.Static(
        id: "recipe-alternate-basic-iron-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.limestone, amount: 8)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 10),
        duration: 12,
        isDefault: false
    )
    
    static let copperAlloyIngotRecipe = Recipe.Static(
        id: "recipe-alternate-copper-alloy-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 10),
        duration: 6,
        isDefault: false
    )
    
    static let temperedCopperIngotRecipe = Recipe.Static(
        id: "recipe-alternate-tempered-copper-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.petroleumCoke, amount: 8)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 12),
        duration: 12,
        isDefault: false
    )
    
    static let steelIngotRecipe = Recipe.Static(
        id: "recipe-steel-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 3),
        duration: 4
    )
    
    static let solidSteelIngotRecipe = Recipe.Static(
        id: "recipe-alternate-solid-steel-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 3),
        duration: 3,
        isDefault: false
    )
    
    static let cokeSteelIngotRecipe = Recipe.Static(
        id: "recipe-alternate-coke-steel-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.petroleumCoke, amount: 15)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 20),
        duration: 12,
        isDefault: false
    )
    
    static let compactedSteelIngotRecipe = Recipe.Static(
        id: "recipe-alternate-compacted-steel-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.compactedCoal, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 4),
        duration: 24,
        isDefault: false
    )
    
    static let temperedCateriumIngotRecipe = Recipe.Static(
        id: "recipe-alternate-tempered-caterium-ingot",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.cateriumOre, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.petroleumCoke, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.cateriumIngot, amount: 3),
        duration: 8,
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
    
    private static let ingotsRecipes = [
        ironAlloyIngotRecipe,
        basicIronIngotRecipe,
        copperAlloyIngotRecipe,
        temperedCopperIngotRecipe,
        steelIngotRecipe,
        solidSteelIngotRecipe,
        cokeSteelIngotRecipe,
        compactedSteelIngotRecipe,
        temperedCateriumIngotRecipe,
        aluminumIngotRecipe,
    ]
}

// MARK: - Standard parts
extension V2.Recipes {
    static let steelCastPlateRecipe = Recipe.Static(
        id: "recipe-alternate-steel-cast-plate",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 3),
        duration: 4,
        isDefault: false
    )
    
    static let moldedBeamRecipe = Recipe.Static(
        id: "recipe-alternate-molded-beam",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 24),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 16)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 9),
        duration: 12,
        isDefault: false
    )
    
    static let moldedSteelPipeRecipe = Recipe.Static(
        id: "recipe-alternate-molded-steel-pipe",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelIngot, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 5),
        duration: 6,
        isDefault: false
    )
    
    private static let standardRecipes = [
        steelCastPlateRecipe,
        moldedBeamRecipe,
        moldedSteelPipeRecipe,
    ]
}

// MARK: - Compounds
extension V2.Recipes {
    static let fusedQuartzCrystalRecipe = Recipe.Static(
        id: "recipe-alternate-fused-quartz-crystal",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rawQuartz, amount: 25),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 18),
        duration: 20,
        isDefault: false
    )
    
    private static let compoundsRecipes = [
        fusedQuartzCrystalRecipe,
    ]
}

// MARK: - FICSMAS
extension V2.Recipes {
    static let copperFicsmasOrnamentRecipe = Recipe.Static(
        id: "recipe-copprt-ficsmas-ornament",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.redFicsmasOrnament, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.copperFicsmasOrnament, amount: 1),
        duration: 12
    )
    
    static let ironFicsmasOrnamentRecipe = Recipe.Static(
        id: "recipe-iron-ficsmas-ornament",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.blueFicsmasOrnament, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ironFicsmasOrnament, amount: 1),
        duration: 12
    )
    
    private static let ficsmasRecipes = [
        copperFicsmasOrnamentRecipe,
        ironFicsmasOrnamentRecipe
    ]
}

// MARK: Foundry recipes
extension V2.Recipes {
    static let foundryRecipes =
    ingotsRecipes +
    standardRecipes +
    compoundsRecipes +
    ficsmasRecipes
}
