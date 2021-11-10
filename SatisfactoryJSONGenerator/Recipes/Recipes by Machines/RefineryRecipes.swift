// MARK: - Ingots
let ironIngotRecipe2 = Recipe(
    name: "Alternate: Pure Iron Ingot",
    input: [
        .init(ironOre, amount: 7),
        .init(water, amount: 4)
    ],
    output: [
        .init(ironIngot, amount: 13)
    ],
    machines: [refinery],
    duration: 12,
    isDefault: false
)

let copperIngotRecipe2 = Recipe(
    name: "Alternate: Pure Copper Ingot",
    input: [
        .init(copperOre, amount: 6),
        .init(water, amount: 4)
    ],
    output: [
        .init(copperIngot, amount: 15)
    ],
    machines: [refinery],
    duration: 24,
    isDefault: false
)

let cateriumIngotRecipe1 = Recipe(
    name: "Alternate: Pure Caterium Ingot",
    input: [
        .init(cateriumOre, amount: 2),
        .init(water, amount: 2)
    ],
    output: [
        .init(cateriumIngot, amount: 1)
    ],
    machines: [refinery],
    duration: 5,
    isDefault: false
)

// MARK: - Minerals
let concreteRecipe3 = Recipe(
    name: "Alternate: Wet Concrete",
    input: [
        .init(limestone, amount: 6),
        .init(water, amount: 5)
    ],
    output: [
        .init(concrete, amount: 4)
    ],
    machines: [refinery],
    duration: 3,
    isDefault: false
)

let quartzCrystalRecipe1 = Recipe(
    name: "Alternate: Pure Quartz Crystal",
    input: [
        .init(rawQuartz, amount: 9),
        .init(water, amount: 5)
    ],
    output: [
        .init(quartzCrystal, amount: 7)
    ],
    machines: [refinery],
    duration: 8,
    isDefault: false
)

// MARK: - Biomass
let fabricRecipe1 = Recipe(
    name: "Alternate: Polyester Fabric",
    input: [
        .init(polymerResin, amount: 16),
        .init(water, amount: 10)
    ],
    output: [
        .init(fabric, amount: 1)
    ],
    machines: [refinery],
    duration: 12,
    isDefault: false
)

// MARK: - Standart Parts
let copperSheetRecipe1 = Recipe(
    name: "Alternate: Steamed Copper Sheet",
    input: [
        .init(copperIngot, amount: 3),
        .init(water, amount: 3)
    ],
    output: [
        .init(copperSheet, amount: 3)
    ],
    machines: [refinery],
    duration: 8,
    isDefault: false
)

// MARK: - Electronics
let cableRecipe3 = Recipe(
    name: "Alternate: Coated Cable",
    input: [
        .init(wire, amount: 5),
        .init(heavyOilResidue, amount: 2)
    ],
    output: [
        .init(cable, amount: 9)
    ],
    machines: [refinery],
    duration: 8,
    isDefault: false
)

// MARK: - Advanced Refinement
let aluminumScrapRecipe = Recipe(
    name: "Aluminum Scrap",
    input: [
        .init(aluminaSolution, amount: 4),
        .init(coal, amount: 2)
    ],
    output: [
        .init(aluminumScrap, amount: 6),
        .init(water, amount: 2)
    ],
    machines: [refinery],
    duration: 1
)

let aluminumScrapRecipe1 = Recipe(
    name: "Alternate: Electrode - Aluminum Scrap",
    input: [
        .init(aluminaSolution, amount: 12),
        .init(petroleumCoke, amount: 4)
    ],
    output: [
        .init(aluminumScrap, amount: 20),
        .init(water, amount: 7)
    ],
    machines: [refinery],
    duration: 4,
    isDefault: false
)

let aluminaSolutionRecipe = Recipe(
    name: "Alumina Solution",
    input: [
        .init(bauxite, amount: 12),
        .init(water, amount: 18)
    ],
    output: [
        .init(aluminaSolution, amount: 12),
        .init(silica, amount: 5)
    ],
    machines: [refinery],
    duration: 6
)

let aluminaSolutionRecipe1 = Recipe(
    name: "Alternate: Sloppy Alumina",
    input: [
        .init(bauxite, amount: 10),
        .init(water, amount: 10)
    ],
    output: [
        .init(aluminaSolution, amount: 12)
    ],
    machines: [refinery],
    duration: 3,
    isDefault: false
)

let sulfuricAcidRecipe = Recipe(
    name: "Sulfuric Acid",
    input: [
        .init(sulfur, amount: 5),
        .init(water, amount: 5)
    ],
    output: [
        .init(sulfuricAcid, amount: 10)
    ],
    machines: [refinery],
    duration: 6
)



// MARK: - Oil Products
let plasticRecipe = Recipe(
    name: "Plastic",
    input: [
        .init(crudeOil, amount: 3)
    ],
    output: [
        .init(plastic, amount: 2),
        .init(heavyOilResidue, amount: 1)
    ],
    machines: [refinery],
    duration: 6
)

let residualPlasticRecipe = Recipe(
    name: "Residual Plastic",
    input: [
        .init(polymerResin, amount: 6),
        .init(water, amount: 2)
    ],
    output: [
        .init(plastic, amount: 2)
    ],
    machines: [refinery],
    duration: 6
)

let plasticRecipe1 = Recipe(
    name: "Alternate: Recycled Plastic",
    input: [
        .init(rubber, amount: 6),
        .init(fuel, amount: 6)
    ],
    output: [
        .init(plastic, amount: 12)
    ],
    machines: [refinery],
    duration: 12,
    isDefault: false
)

let rubberRecipe = Recipe(
    name: "Rubber",
    input: [
        .init(crudeOil, amount: 3)
    ],
    output: [
        .init(rubber, amount: 2),
        .init(heavyOilResidue, amount: 2)
    ],
    machines: [refinery],
    duration: 6
)

let residualRubberRecipe = Recipe(
    name: "Residual Rubber",
    input: [
        .init(polymerResin, amount: 4),
        .init(water, amount: 4)
    ],
    output: [
        .init(rubber, amount: 2)
    ],
    machines: [refinery],
    duration: 6
)

let rubberRecipe1 = Recipe(
    name: "Alternate: Recycled Rubber",
    input: [
        .init(plastic, amount: 6),
        .init(fuel, amount: 6)
    ],
    output: [
        .init(rubber, amount: 12)
    ],
    machines: [refinery],
    duration: 12,
    isDefault: false
)

let petroleumCokeRecipe = Recipe(
    name: "Petroleum Coke",
    input: [
        .init(heavyOilResidue, amount: 4)
    ],
    output: [
        .init(petroleumCoke, amount: 12)
    ],
    machines: [refinery],
    duration: 6
)

let polymerResinRecipe1 = Recipe(
    name: "Alternate: Polymer Resin",
    input: [
        .init(crudeOil, amount: 6)
    ],
    output: [
        .init(polymerResin, amount: 13),
        .init(heavyOilResidue, amount: 2)
    ],
    machines: [refinery],
    duration: 6,
    isDefault: false
)

let heavyOilResidueRecipe1 = Recipe(
    name: "Alternate: Heavy Oil Residue",
    input: [
        .init(crudeOil, amount: 3)
    ],
    output: [
        .init(heavyOilResidue, amount: 4),
        .init(polymerResin, amount: 2)
    ],
    machines: [refinery],
    duration: 6,
    isDefault: false
)

// MARK: - Fuel
let fuelRecipe = Recipe(
    name: "Fuel",
    input: [
        .init(crudeOil, amount: 6)
    ],
    output: [
        .init(fuel, amount: 4),
        .init(polymerResin, amount: 3)
    ],
    machines: [refinery],
    duration: 6
)

let residualFuelRecipe = Recipe(
    name: "Residual Fuel",
    input: [
        .init(heavyOilResidue, amount: 6)
    ],
    output: [
        .init(fuel, amount: 4)
    ],
    machines: [refinery],
    duration: 6
)

let fuelRecipe1 = Recipe(
    name: "Alternate: Diluted Packaged Fuel",
    input: [
        .init(heavyOilResidue, amount: 1),
        .init(packagedWater, amount: 2)
    ],
    output: [
        .init(fuel, amount: 2)
    ],
    machines: [refinery],
    duration: 2,
    isDefault: false
)

let liquidBiofuelRecipe = Recipe(
    name: "Liquid Biofuel",
    input: [
        .init(solidBiofuel, amount: 6),
        .init(water, amount: 3)
    ],
    output: [
        .init(liquidBiofuel, amount: 4)
    ],
    machines: [refinery],
    duration: 4
)

let turbofuelRecipe = Recipe(
    name: "Turbofuel",
    input: [
        .init(fuel, amount: 6),
        .init(compactedCoal, amount: 4)
    ],
    output: [
        .init(turbofuel, amount: 5)
    ],
    machines: [refinery],
    duration: 16,
    isDefault: false
)

let turbofuelRecipe1 = Recipe(
    name: "Alternate: Turbo Heavy Fuel",
    input: [
        .init(heavyOilResidue, amount: 5),
        .init(compactedCoal, amount: 4)
    ],
    output: [
        .init(turbofuel, amount: 4)
    ],
    machines: [refinery],
    duration: 8,
    isDefault: false
)

let RefineryRecipes = [
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
    turbofuelRecipe1
]
