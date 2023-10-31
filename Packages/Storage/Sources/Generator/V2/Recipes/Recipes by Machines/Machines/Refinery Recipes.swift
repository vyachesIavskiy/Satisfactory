import StaticModels

private extension Recipe {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        byproduct: Ingredient? = nil,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            byproducts: byproduct.map { [$0] },
            machines: [V2.Buildings.refinery],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Ingots
    static let ironIngotRecipe2 = Recipe(
        id: "recipe-alternate-pure-iron-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironOre, amount: 7),
            Recipe.Ingredient(V2.Parts.water, amount: 4)
        ],
        output: Recipe.Ingredient(V2.Parts.ironIngot, amount: 13),
        duration: 12,
        isDefault: false
    )
    
    static let copperIngotRecipe2 = Recipe(
        id: "recipe-alternate-pure-copper-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.copperOre, amount: 6),
            Recipe.Ingredient(V2.Parts.water, amount: 4)
        ],
        output: Recipe.Ingredient(V2.Parts.copperIngot, amount: 15),
        duration: 24,
        isDefault: false
    )
    
    static let cateriumIngotRecipe1 = Recipe(
        id: "recipe-alternate-pure-caterium-ingot",
        inputs: [
            Recipe.Ingredient(V2.Parts.cateriumOre, amount: 2),
            Recipe.Ingredient(V2.Parts.water, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.cateriumIngot, amount: 1),
        duration: 5,
        isDefault: false
    )
    
    // MARK: - Minerals
    static let concreteRecipe3 = Recipe(
        id: "recipe-alternate-wet-concrete",
        inputs: [
            Recipe.Ingredient(V2.Parts.limestone, amount: 6),
            Recipe.Ingredient(V2.Parts.water, amount: 5)
        ],
        output: Recipe.Ingredient(V2.Parts.concrete, amount: 4),
        duration: 3,
        isDefault: false
    )
    
    static let quartzCrystalRecipe1 = Recipe(
        id: "recipe-alternate-pure-quartz-crystal",
        inputs: [
            Recipe.Ingredient(V2.Parts.rawQuartz, amount: 9),
            Recipe.Ingredient(V2.Parts.water, amount: 5)
        ],
        output: Recipe.Ingredient(V2.Parts.quartzCrystal, amount: 7),
        duration: 8,
        isDefault: false
    )
    
    // MARK: - Biomass
    static let fabricRecipe1 = Recipe(
        id: "recipe-alternate-polyester-fabric",
        inputs: [
            Recipe.Ingredient(V2.Parts.polymerResin, amount: 16),
            Recipe.Ingredient(V2.Parts.water, amount: 10)
        ],
        output: Recipe.Ingredient(V2.Parts.fabric, amount: 1),
        duration: 12,
        isDefault: false
    )
    
    // MARK: - Standard Parts
    static let copperSheetRecipe1 = Recipe(
        id: "recipe-alternate-steamed-copper-sheet",
        inputs: [
            Recipe.Ingredient(V2.Parts.copperIngot, amount: 3),
            Recipe.Ingredient(V2.Parts.water, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.copperSheet, amount: 3),
        duration: 8,
        isDefault: false
    )
    
    // MARK: - Electronics
    static let cableRecipe3 = Recipe(
        id: "recipe-alternate-coated-cable",
        inputs: [
            Recipe.Ingredient(V2.Parts.wire, amount: 5),
            Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.cable, amount: 9),
        duration: 8,
        isDefault: false
    )
    
    // MARK: - Advanced Refinement
    static let aluminumScrapRecipe = Recipe(
        id: "recipe-aluminum-scrap",
        inputs: [
            Recipe.Ingredient(V2.Parts.aluminaSolution, amount: 4),
            Recipe.Ingredient(V2.Parts.coal, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.aluminumScrap, amount: 6),
        byproduct: Recipe.Ingredient(V2.Parts.water, amount: 2),
        duration: 1
    )
    
    static let aluminumScrapRecipe1 = Recipe(
        id: "recipe-alternate-electrode-aluminum-scrap",
        inputs: [
            Recipe.Ingredient(V2.Parts.aluminaSolution, amount: 12),
            Recipe.Ingredient(V2.Parts.petroleumCoke, amount: 4)
        ],
        output: Recipe.Ingredient(V2.Parts.aluminumScrap, amount: 20),
        byproduct: Recipe.Ingredient(V2.Parts.water, amount: 7),
        duration: 4,
        isDefault: false
    )
    
    static let aluminaSolutionRecipe = Recipe(
        id: "recipe-alumina-solution",
        inputs: [
            Recipe.Ingredient(V2.Parts.bauxite, amount: 12),
            Recipe.Ingredient(V2.Parts.water, amount: 18)
        ],
        output: Recipe.Ingredient(V2.Parts.aluminaSolution, amount: 12),
        byproduct: Recipe.Ingredient(V2.Parts.silica, amount: 5),
        duration: 6
    )
    
    static let aluminaSolutionRecipe1 = Recipe(
        id: "recipe-alternate-sloppy-alumina",
        inputs: [
            Recipe.Ingredient(V2.Parts.bauxite, amount: 10),
            Recipe.Ingredient(V2.Parts.water, amount: 10)
        ],
        output: Recipe.Ingredient(V2.Parts.aluminaSolution, amount: 12),
        duration: 3,
        isDefault: false
    )
    
    static let sulfuricAcidRecipe = Recipe(
        id: "recipe-sulfuric-acid",
        inputs: [
            Recipe.Ingredient(V2.Parts.sulfur, amount: 5),
            Recipe.Ingredient(V2.Parts.water, amount: 5)
        ],
        output: Recipe.Ingredient(V2.Parts.sulfuricAcid, amount: 10),
        duration: 6
    )
    
    // MARK: - Oil Products
    static let plasticRecipe = Recipe(
        id: "recipe-plastic",
        inputs: [
            Recipe.Ingredient(V2.Parts.crudeOil, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.plastic, amount: 2),
        byproduct: Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 1),
        duration: 6
    )
    
    static let residualPlasticRecipe = Recipe(
        id: "recipe-residual-plastic",
        inputs: [
            Recipe.Ingredient(V2.Parts.polymerResin, amount: 6),
            Recipe.Ingredient(V2.Parts.water, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.plastic, amount: 2),
        duration: 6,
        isDefault: false
    )
    
    static let plasticRecipe1 = Recipe(
        id: "recipe-alternate-recycled-plastic",
        inputs: [
            Recipe.Ingredient(V2.Parts.rubber, amount: 6),
            Recipe.Ingredient(V2.Parts.fuel, amount: 6)
        ],
        output: Recipe.Ingredient(V2.Parts.plastic, amount: 12),
        duration: 12,
        isDefault: false
    )
    
    static let rubberRecipe = Recipe(
        id: "recipe-rubber",
        inputs: [
            Recipe.Ingredient(V2.Parts.crudeOil, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.rubber, amount: 2),
        byproduct: Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 2),
        duration: 6
    )
    
    static let residualRubberRecipe = Recipe(
        id: "recipe-residual-rubber",
        inputs: [
            Recipe.Ingredient(V2.Parts.polymerResin, amount: 4),
            Recipe.Ingredient(V2.Parts.water, amount: 4)
        ],
        output: Recipe.Ingredient(V2.Parts.rubber, amount: 2),
        duration: 6,
        isDefault: false
    )
    
    static let rubberRecipe1 = Recipe(
        id: "recipe-alternate-recycled-rubber",
        inputs: [
            Recipe.Ingredient(V2.Parts.plastic, amount: 6),
            Recipe.Ingredient(V2.Parts.fuel, amount: 6)
        ],
        output: Recipe.Ingredient(V2.Parts.rubber, amount: 12),
        duration: 12,
        isDefault: false
    )
    
    static let petroleumCokeRecipe = Recipe(
        id: "recipe-petroleum-coke",
        inputs: [
            Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 4)
        ],
        output: Recipe.Ingredient(V2.Parts.petroleumCoke, amount: 12),
        duration: 6
    )
    
    static let polymerResinRecipe1 = Recipe(
        id: "recipe-alternate-polymer-resin",
        inputs: [
            Recipe.Ingredient(V2.Parts.crudeOil, amount: 6)
        ],
        output: Recipe.Ingredient(V2.Parts.polymerResin, amount: 13),
        byproduct: Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 2),
        duration: 6,
        isDefault: false
    )
    
    static let heavyOilResidueRecipe1 = Recipe(
        id: "recipe-alternate-heavy-oil-residue",
        inputs: [
            Recipe.Ingredient(V2.Parts.crudeOil, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 4),
        byproduct: Recipe.Ingredient(V2.Parts.polymerResin, amount: 2),
        duration: 6,
        isDefault: false
    )
    
    // MARK: - Fuel
    static let fuelRecipe = Recipe(
        id: "recipe-fuel",
        inputs: [
            Recipe.Ingredient(V2.Parts.crudeOil, amount: 6)
        ],
        output: Recipe.Ingredient(V2.Parts.fuel, amount: 4),
        byproduct: Recipe.Ingredient(V2.Parts.polymerResin, amount: 3),
        duration: 6
    )
    
    static let residualFuelRecipe = Recipe(
        id: "recipe-residual-fuel",
        inputs: [
            Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 6)
        ],
        output: Recipe.Ingredient(V2.Parts.fuel, amount: 4),
        duration: 6,
        isDefault: false
    )
    
    static let packagedFuelRecipe1 = Recipe(
        id: "recipe-alternate-diluted-packaged-fuel",
        inputs: [
            Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 1),
            Recipe.Ingredient(V2.Parts.packagedWater, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.fuel, amount: 2),
        duration: 2,
        isDefault: false
    )
    
    static let liquidBiofuelRecipe = Recipe(
        id: "recipe-liquid-biofuel",
        inputs: [
            Recipe.Ingredient(V2.Parts.solidBiofuel, amount: 6),
            Recipe.Ingredient(V2.Parts.water, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.liquidBiofuel, amount: 4),
        duration: 4
    )
    
    static let turbofuelRecipe = Recipe(
        id: "recipe-turbofuel",
        inputs: [
            Recipe.Ingredient(V2.Parts.fuel, amount: 6),
            Recipe.Ingredient(V2.Parts.compactedCoal, amount: 4)
        ],
        output: Recipe.Ingredient(V2.Parts.turbofuel, amount: 5),
        duration: 16,
        isDefault: false
    )
    
    static let turbofuelRecipe1 = Recipe(
        id: "recipe-alternate-turbo-heavy-fuel",
        inputs: [
            Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 5),
            Recipe.Ingredient(V2.Parts.compactedCoal, amount: 4)
        ],
        output: Recipe.Ingredient(V2.Parts.turbofuel, amount: 4),
        duration: 8,
        isDefault: false
    )
    
    // MARK: - Ammunition
    static let smokelessPowderRecipe = Recipe(
        id: "recipe-smokeless-powder",
        inputs: [
            Recipe.Ingredient(V2.Parts.blackPowder, amount: 2),
            Recipe.Ingredient(V2.Parts.heavyOilResidue, amount: 1)
        ],
        output: Recipe.Ingredient(V2.Parts.smokelessPowder, amount: 2),
        duration: 6
    )
    
    static let refineryRecipes = [
        ironIngotRecipe2,
        copperIngotRecipe2,
        cateriumIngotRecipe1,
        concreteRecipe3,
        quartzCrystalRecipe1,
        fabricRecipe1,
        copperSheetRecipe1,
        cableRecipe3,
        aluminumScrapRecipe,
        aluminumScrapRecipe1,
        aluminaSolutionRecipe,
        aluminaSolutionRecipe1,
        sulfuricAcidRecipe,
        plasticRecipe,
        residualPlasticRecipe,
        plasticRecipe1,
        rubberRecipe,
        residualRubberRecipe,
        rubberRecipe1,
        petroleumCokeRecipe,
        polymerResinRecipe1,
        heavyOilResidueRecipe1,
        fuelRecipe,
        residualFuelRecipe,
        packagedFuelRecipe1,
        liquidBiofuelRecipe,
        turbofuelRecipe,
        turbofuelRecipe1,
        smokelessPowderRecipe
    ]
}
