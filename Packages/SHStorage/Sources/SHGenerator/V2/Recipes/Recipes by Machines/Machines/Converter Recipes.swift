import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproducts: [Ingredient]? = nil,
        duration: Double,
        powerConsumption: PowerConsumption,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: byproducts,
            machine: V2.Buildings.converter,
            duration: duration,
            powerConsumption: powerConsumption,
            isDefault: isDefault
        )
    }
}

// MARK: - Quantum Technology
extension V2.Recipes {
    static let timeCrystalRecipe = Recipe.Static(
        id: "recipe-time-crystal",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.diamonds, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.timeCrystal, amount: 1),
        duration: 10,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let excitedPhotonicMatterRecipe = Recipe.Static(
        id: "recipe-excited-photonic-matter",
        inputs: [],
        output: Recipe.Static.Ingredient(V2.Parts.excitedPhotonicMatter, amount: 10),
        duration: 3,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let darkMatterResidueRecipe = Recipe.Static(
        id: "recipe-dark-matter-residue",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.darkMatterResidue, amount: 10),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    fileprivate static let quantumTechnologyRecipes = [
        timeCrystalRecipe,
        excitedPhotonicMatterRecipe,
        darkMatterResidueRecipe,
    ]
}

// MARK: - Advanced Refinement
extension V2.Recipes {
    static let pinkDiamondsRecipe = Recipe.Static(
        id: "recipe-alternate-pink-diamonds",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.quartzCrystal, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.diamonds, amount: 1),
        duration: 4,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let darkIonFuelRecipe = Recipe.Static(
        id: "recipe-alternate-dark-ion-fuel",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.packagedRocketFuel, amount: 12),
            Recipe.Static.Ingredient(V2.Parts.darkMatterCrystal, amount: 4)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ionizedFuel, amount: 10),
        byproducts: [
            Recipe.Static.Ingredient(V2.Parts.compactedCoal, amount: 2)
        ],
        duration: 3,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400),
        isDefault: false
    )
    
    fileprivate static let advancedRefinementRecipes = [
        pinkDiamondsRecipe,
        darkIonFuelRecipe,
    ]
}

// MARK: - Ingots
extension V2.Recipes {
    static let ficsiteIngtoIronRecipe = Recipe.Static(
        id: "recipe-ficsite-ingot-iron",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 24)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ficsiteIngot, amount: 1),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let ficsiteIngtoCateriumRecipe = Recipe.Static(
        id: "recipe-ficsite-ingot-caterium",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.cateriumIngot, amount: 4)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ficsiteIngot, amount: 1),
        duration: 4,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let ficsiteIngtoAluminumRecipe = Recipe.Static(
        id: "recipe-ficsite-ingot-aluminum",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.aluminumIngot, amount: 4)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ficsiteIngot, amount: 1),
        duration: 2,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    fileprivate static let ingotsRecipes = [
        ficsiteIngtoIronRecipe,
        ficsiteIngtoCateriumRecipe,
        ficsiteIngtoAluminumRecipe,
    ]
}

// MARK: - Raw Resource Conversion
extension V2.Recipes {
    static let ironOreLimestoneRecipe = Recipe.Static(
        id: "recipe-iron-ore-limestone",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.limestone, amount: 24)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let copperOreSulfurRecipe = Recipe.Static(
        id: "recipe-copper-ore-sulfur",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let copperOreQuartzRecipe = Recipe.Static(
        id: "recipe-copper-ore-quartz",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.rawQuartz, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let limestoneSulfurRecipe = Recipe.Static(
        id: "recipe-limestone-sulfur",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.limestone, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let coalLimestoneRecipe = Recipe.Static(
        id: "recipe-coal-limestone",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.limestone, amount: 36)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.coal, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let coalIronRecipe = Recipe.Static(
        id: "recipe-coal-iron",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 18)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.coal, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let sulfurIronRecipe = Recipe.Static(
        id: "recipe-sulfur-iron",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.ironOre, amount: 30)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let sulfurCoalRecipe = Recipe.Static(
        id: "recipe-sulfur-coal",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let cateriumOreCopperRecipe = Recipe.Static(
        id: "recipe-caterium-ore-copper",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 15)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.cateriumOre, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let cateriumOreQuartzRecipe = Recipe.Static(
        id: "recipe-caterium-ore-quartz",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.rawQuartz, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.cateriumOre, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let rawQuartzCoalRecipe = Recipe.Static(
        id: "recipe-raw-quartz-coal",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 24)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.rawQuartz, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let rawQuartzBauxiteRecipe = Recipe.Static(
        id: "recipe-raw-quartz-bauxite",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.bauxite, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.rawQuartz, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let bauxiteCopperRecipe = Recipe.Static(
        id: "recipe-bauxite-copper",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.copperOre, amount: 18)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.bauxite, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let bauxiteCateriumRecipe = Recipe.Static(
        id: "recipe-bauxite-caterium",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.cateriumOre, amount: 15)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.bauxite, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let nitrogenGasCateriumRecipe = Recipe.Static(
        id: "recipe-nitrogen-gas-caterium",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.cateriumOre, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let nitrogenGasBauxiteRecipe = Recipe.Static(
        id: "recipe-nitrogen-gas-bauxite",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.bauxite, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nitrogenGas, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    static let uraniumBauxiteRecipe = Recipe.Static(
        id: "recipe-uranium-bauxite",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.bauxite, amount: 48)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.uranium, amount: 12),
        duration: 6,
        powerConsumption: Recipe.Static.PowerConsumption(min: 100, max: 400)
    )
    
    fileprivate static let rawResourceConversionRecipes = [
        ironOreLimestoneRecipe,
        copperOreSulfurRecipe,
        copperOreQuartzRecipe,
        limestoneSulfurRecipe,
        coalLimestoneRecipe,
        coalIronRecipe,
        sulfurIronRecipe,
        sulfurCoalRecipe,
        cateriumOreCopperRecipe,
        cateriumOreQuartzRecipe,
        rawQuartzCoalRecipe,
        rawQuartzBauxiteRecipe,
        bauxiteCopperRecipe,
        bauxiteCateriumRecipe,
        nitrogenGasCateriumRecipe,
        nitrogenGasBauxiteRecipe,
        uraniumBauxiteRecipe
    ]
}

// MARK: Converter recipes
extension V2.Recipes {
    static let converterRecipes =
    quantumTechnologyRecipes +
    advancedRefinementRecipes +
    ingotsRecipes +
    rawResourceConversionRecipes
}
