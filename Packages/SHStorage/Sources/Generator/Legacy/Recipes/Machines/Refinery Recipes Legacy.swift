import Models
import StaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        name: String,
        input: [Ingredient],
        output: [Ingredient],
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            name: name,
            input: input,
            output: output,
            machines: [Legacy.Buildings.refinery.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // Ingots
    static let ironIngotRecipe2 = Recipe.Static.Legacy(
        id: "alternate-pure-iron-ingot",
        name: "Alternate: Pure Iron Ingot",
        input: [
            .init(Legacy.Parts.ironOre, amount: 7),
            .init(Legacy.Parts.water, amount: 4)
        ],
        output: [
            .init(Legacy.Parts.ironIngot, amount: 13)
        ],
        duration: 12,
        isDefault: false
    )

    static let copperIngotRecipe2 = Recipe.Static.Legacy(
        id: "alternate-pure-copper-ingot",
        name: "Alternate: Pure Copper Ingot",
        input: [
            .init(Legacy.Parts.copperOre, amount: 6),
            .init(Legacy.Parts.water, amount: 4)
        ],
        output: [
            .init(Legacy.Parts.copperIngot, amount: 15)
        ],
        duration: 24,
        isDefault: false
    )

    static let cateriumIngotRecipe1 = Recipe.Static.Legacy(
        id: "alternate-pure-caterium-ingot",
        name: "Alternate: Pure Caterium Ingot",
        input: [
            .init(Legacy.Parts.cateriumOre, amount: 2),
            .init(Legacy.Parts.water, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.cateriumIngot, amount: 1)
        ],
        duration: 5,
        isDefault: false
    )

    // Minerals
    static let concreteRecipe3 = Recipe.Static.Legacy(
        id: "alternate-wet-concrete",
        name: "Alternate: Wet Concrete",
        input: [
            .init(Legacy.Parts.limestone, amount: 6),
            .init(Legacy.Parts.water, amount: 5)
        ],
        output: [
            .init(Legacy.Parts.concrete, amount: 4)
        ],
        duration: 3,
        isDefault: false
    )

    static let quartzCrystalRecipe1 = Recipe.Static.Legacy(
        id: "alternate-pure-quartz-crystal",
        name: "Alternate: Pure Quartz Crystal",
        input: [
            .init(Legacy.Parts.rawQuartz, amount: 9),
            .init(Legacy.Parts.water, amount: 5)
        ],
        output: [
            .init(Legacy.Parts.quartzCrystal, amount: 7)
        ],
        duration: 8,
        isDefault: false
    )

    // Biomass
    static let fabricRecipe1 = Recipe.Static.Legacy(
        id: "alternate-polyester-fabric",
        name: "Alternate: Polyester Fabric",
        input: [
            .init(Legacy.Parts.polymerResin, amount: 1),
            .init(Legacy.Parts.water, amount: 1)
        ],
        output: [
            .init(Legacy.Parts.fabric, amount: 1)
        ],
        duration: 2,
        isDefault: false
    )

    // Standard Parts
    static let copperSheetRecipe1 = Recipe.Static.Legacy(
        id: "alternate-steamed-copper-sheet",
        name: "Alternate: Steamed Copper Sheet",
        input: [
            .init(Legacy.Parts.copperIngot, amount: 3),
            .init(Legacy.Parts.water, amount: 3)
        ],
        output: [
            .init(Legacy.Parts.copperSheet, amount: 3)
        ],
        duration: 8,
        isDefault: false
    )

    // Electronics
    static let cableRecipe3 = Recipe.Static.Legacy(
        id: "alternate-coated-cable",
        name: "Alternate: Coated Cable",
        input: [
            .init(Legacy.Parts.wire, amount: 5),
            .init(Legacy.Parts.heavyOilResidue, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.cable, amount: 9)
        ],
        duration: 8,
        isDefault: false
    )

    // Advanced Refinement
    static let aluminumScrapRecipe = Recipe.Static.Legacy(
        id: "aluminum-scrap",
        name: "Aluminum Scrap",
        input: [
            .init(Legacy.Parts.aluminaSolution, amount: 4),
            .init(Legacy.Parts.coal, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.aluminumScrap, amount: 6),
            .init(Legacy.Parts.water, amount: 2)
        ],
        duration: 1
    )

    static let aluminumScrapRecipe1 = Recipe.Static.Legacy(
        id: "alternate-electrode---aluminumscrap",
        name: "Alternate: Electrode - Aluminum Scrap",
        input: [
            .init(Legacy.Parts.aluminaSolution, amount: 12),
            .init(Legacy.Parts.petroleumCoke, amount: 4)
        ],
        output: [
            .init(Legacy.Parts.aluminumScrap, amount: 20),
            .init(Legacy.Parts.water, amount: 7)
        ],
        duration: 4,
        isDefault: false
    )

    static let aluminaSolutionRecipe = Recipe.Static.Legacy(
        id: "alumina-solution",
        name: "Alumina Solution",
        input: [
            .init(Legacy.Parts.bauxite, amount: 12),
            .init(Legacy.Parts.water, amount: 18)
        ],
        output: [
            .init(Legacy.Parts.aluminaSolution, amount: 12),
            .init(Legacy.Parts.silica, amount: 5)
        ],
        duration: 6
    )

    static let aluminaSolutionRecipe1 = Recipe.Static.Legacy(
        id: "alternate-sloppy-alumina",
        name: "Alternate: Sloppy Alumina",
        input: [
            .init(Legacy.Parts.bauxite, amount: 10),
            .init(Legacy.Parts.water, amount: 10)
        ],
        output: [
            .init(Legacy.Parts.aluminaSolution, amount: 12)
        ],
        duration: 3,
        isDefault: false
    )

    static let sulfuricAcidRecipe = Recipe.Static.Legacy(
        id: "sulfuric-acid",
        name: "Sulfuric Acid",
        input: [
            .init(Legacy.Parts.sulfur, amount: 5),
            .init(Legacy.Parts.water, amount: 5)
        ],
        output: [
            .init(Legacy.Parts.sulfuricAcid, amount: 10)
        ],
        duration: 6
    )



    // Oil Products
    static let plasticRecipe = Recipe.Static.Legacy(
        id: "plastic",
        name: "Plastic",
        input: [
            .init(Legacy.Parts.crudeOil, amount: 3)
        ],
        output: [
            .init(Legacy.Parts.plastic, amount: 2),
            .init(Legacy.Parts.heavyOilResidue, amount: 1)
        ],
        duration: 6
    )

    static let residualPlasticRecipe = Recipe.Static.Legacy(
        id: "residual-plastic",
        name: "Residual Plastic",
        input: [
            .init(Legacy.Parts.polymerResin, amount: 6),
            .init(Legacy.Parts.water, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.plastic, amount: 2)
        ],
        duration: 6
    )

    static let plasticRecipe1 = Recipe.Static.Legacy(
        id: "alternate-recycled-plastic",
        name: "Alternate: Recycled Plastic",
        input: [
            .init(Legacy.Parts.rubber, amount: 6),
            .init(Legacy.Parts.fuel, amount: 6)
        ],
        output: [
            .init(Legacy.Parts.plastic, amount: 12)
        ],
        duration: 12,
        isDefault: false
    )

    static let rubberRecipe = Recipe.Static.Legacy(
        id: "rubber",
        name: "Rubber",
        input: [
            .init(Legacy.Parts.crudeOil, amount: 3)
        ],
        output: [
            .init(Legacy.Parts.rubber, amount: 2),
            .init(Legacy.Parts.heavyOilResidue, amount: 2)
        ],
        duration: 6
    )

    static let residualRubberRecipe = Recipe.Static.Legacy(
        id: "residual-rubber",
        name: "Residual Rubber",
        input: [
            .init(Legacy.Parts.polymerResin, amount: 4),
            .init(Legacy.Parts.water, amount: 4)
        ],
        output: [
            .init(Legacy.Parts.rubber, amount: 2)
        ],
        duration: 6
    )

    static let rubberRecipe1 = Recipe.Static.Legacy(
        id: "alternate-recycled-rubber",
        name: "Alternate: Recycled Rubber",
        input: [
            .init(Legacy.Parts.plastic, amount: 6),
            .init(Legacy.Parts.fuel, amount: 6)
        ],
        output: [
            .init(Legacy.Parts.rubber, amount: 12)
        ],
        duration: 12,
        isDefault: false
    )

    static let petroleumCokeRecipe = Recipe.Static.Legacy(
        id: "petroleum-coke",
        name: "Petroleum Coke",
        input: [
            .init(Legacy.Parts.heavyOilResidue, amount: 4)
        ],
        output: [
            .init(Legacy.Parts.petroleumCoke, amount: 12)
        ],
        duration: 6
    )

    static let polymerResinRecipe1 = Recipe.Static.Legacy(
        id: "alternate-polymer-resin",
        name: "Alternate: Polymer Resin",
        input: [
            .init(Legacy.Parts.crudeOil, amount: 6)
        ],
        output: [
            .init(Legacy.Parts.polymerResin, amount: 13),
            .init(Legacy.Parts.heavyOilResidue, amount: 2)
        ],
        duration: 6,
        isDefault: false
    )

    static let heavyOilResidueRecipe1 = Recipe.Static.Legacy(
        id: "alternate-heavy-oil-residue",
        name: "Alternate: Heavy Oil Residue",
        input: [
            .init(Legacy.Parts.crudeOil, amount: 3)
        ],
        output: [
            .init(Legacy.Parts.heavyOilResidue, amount: 4),
            .init(Legacy.Parts.polymerResin, amount: 2)
        ],
        duration: 6,
        isDefault: false
    )

    // Fuel
    static let fuelRecipe = Recipe.Static.Legacy(
        id: "fuel",
        name: "Fuel",
        input: [
            .init(Legacy.Parts.crudeOil, amount: 6)
        ],
        output: [
            .init(Legacy.Parts.fuel, amount: 4),
            .init(Legacy.Parts.polymerResin, amount: 3)
        ],
        duration: 6
    )

    static let residualFuelRecipe = Recipe.Static.Legacy(
        id: "residual-fuel",
        name: "Residual Fuel",
        input: [
            .init(Legacy.Parts.heavyOilResidue, amount: 6)
        ],
        output: [
            .init(Legacy.Parts.fuel, amount: 4)
        ],
        duration: 6
    )

    static let fuelRecipe1 = Recipe.Static.Legacy(
        id: "alternate-diluted-packaged-fuel",
        name: "Alternate: Diluted Packaged Fuel",
        input: [
            .init(Legacy.Parts.heavyOilResidue, amount: 1),
            .init(Legacy.Parts.packagedWater, amount: 2)
        ],
        output: [
            .init(Legacy.Parts.fuel, amount: 2)
        ],
        duration: 2,
        isDefault: false
    )

    static let liquidBiofuelRecipe = Recipe.Static.Legacy(
        id: "liquid-biofuel",
        name: "Liquid Biofuel",
        input: [
            .init(Legacy.Parts.solidBiofuel, amount: 6),
            .init(Legacy.Parts.water, amount: 3)
        ],
        output: [
            .init(Legacy.Parts.liquidBiofuel, amount: 4)
        ],
        duration: 4
    )

    static let turbofuelRecipe = Recipe.Static.Legacy(
        id: "turbofuel",
        name: "Turbofuel",
        input: [
            .init(Legacy.Parts.fuel, amount: 6),
            .init(Legacy.Parts.compactedCoal, amount: 4)
        ],
        output: [
            .init(Legacy.Parts.turbofuel, amount: 5)
        ],
        duration: 16,
        isDefault: false
    )

    static let turbofuelRecipe1 = Recipe.Static.Legacy(
        id: "alternate-turbo-heavy-fuel",
        name: "Alternate: Turbo Heavy Fuel",
        input: [
            .init(Legacy.Parts.heavyOilResidue, amount: 5),
            .init(Legacy.Parts.compactedCoal, amount: 4)
        ],
        output: [
            .init(Legacy.Parts.turbofuel, amount: 4)
        ],
        duration: 8,
        isDefault: false
    )
    
    // Cosumed
    static let smokelessPowderRecipe = Recipe.Static.Legacy(
        id: "smokeless-powder",
        name: "Smokeless Powder",
        input: [
            .init(Legacy.Parts.blackPowder, amount: 2),
            .init(Legacy.Parts.heavyOilResidue, amount: 1)
        ],
        output: [
            .init(Legacy.Parts.smokelessPowder, amount: 2)
        ],
        duration: 6,
        isDefault: false
    )

    static let refineryRecipes = [
        // ingots
        ironIngotRecipe2,
        copperIngotRecipe2,
        cateriumIngotRecipe1,
        
        // minerals
        concreteRecipe3,
        quartzCrystalRecipe1,
        
        // biomass
        fabricRecipe1,
        
        // standart parts
        copperSheetRecipe1,
        
        // electronics
        cableRecipe3,
        
        // advanced refinement
        aluminumScrapRecipe,
        aluminumScrapRecipe1,
        aluminaSolutionRecipe,
        aluminaSolutionRecipe1,
        sulfuricAcidRecipe,
        
        // oil products
        plasticRecipe,
        residualPlasticRecipe,
        plasticRecipe1,
        rubberRecipe,
        residualRubberRecipe,
        rubberRecipe1,
        petroleumCokeRecipe,
        polymerResinRecipe1,
        heavyOilResidueRecipe1,
        
        // fuel
        fuelRecipe,
        residualFuelRecipe,
        fuelRecipe1,
        liquidBiofuelRecipe,
        turbofuelRecipe,
        turbofuelRecipe1,
        
        // Consumed
        smokelessPowderRecipe,
    ]
}
