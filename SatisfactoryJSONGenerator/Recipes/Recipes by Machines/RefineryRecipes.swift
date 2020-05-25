// MARK: - Ingots
let ironIngotRecipe2 = Recipe(input: [
    .init(ironOre, amount: 7),
    .init(water, amount: 4)
    ], output: [
        .init(ironIngot, amount: 13)
], machine: refinery, duration: 12, isDefault: false)

let copperIngotRecipe2 = Recipe(input: [
    .init(copperOre, amount: 6),
    .init(water, amount: 4)
    ], output: [
        .init(copperIngot, amount: 15)
], machine: refinery, duration: 24, isDefault: false)

let cateriumIngotRecipe1 = Recipe(input: [
    .init(cateriumOre, amount: 2),
    .init(water, amount: 2)
    ], output: [
        .init(cateriumIngot, amount: 1)
], machine: refinery, duration: 5, isDefault: false)

// MARK: - Minerals
let concreteRecipe3 = Recipe(input: [
    .init(limestone, amount: 6),
    .init(water, amount: 5)
    ], output: [
        .init(concrete, amount: 4)
], machine: refinery, duration: 3, isDefault: false)

let quartzCrystalRecipe1 = Recipe(input: [
    .init(rawQuartz, amount: 9),
    .init(water, amount: 5)
    ], output: [
        .init(quartzCrystal, amount: 7)
], machine: refinery, duration: 8, isDefault: false)

// MARK: - Biomass
let fabricRecipe1 = Recipe(input: [
    .init(polymerResin, amount: 16),
    .init(water, amount: 10)
    ], output: [
        .init(fabric, amount: 1)
], machine: refinery, duration: 12, isDefault: false)

// MARK: - Standart Parts
let copperSheetRecipe1 = Recipe(input: [
    .init(copperIngot, amount: 3),
    .init(water, amount: 3)
    ], output: [
        .init(copperSheet, amount: 3)
], machine: refinery, duration: 8, isDefault: false)

// MARK: - Electronics
let cableRecipe3 = Recipe(input: [
    .init(wire, amount: 5),
    .init(heavyOilResidue, amount: 2)
    ], output: [
        .init(cable, amount: 9)
], machine: refinery, duration: 8, isDefault: false)

// MARK: - Packaging
let packagedFuelRecipe = Recipe(input: [
    .init(fuel, amount: 2),
    .init(emptyCanister, amount: 2)
    ], output: [
        .init(packagedFuel, amount: 2)
], machine: refinery, duration: 3)

let packagedFuelRecipe1 = Recipe(input: [
    .init(heavyOilResidue, amount: 1),
    .init(packagedWater, amount: 2)
    ], output: [
        .init(fuel, amount: 2)
], machine: refinery, duration: 2, isDefault: false)

let packagedTurbofuelRecipe = Recipe(input: [
    .init(turbofuel, amount: 2),
    .init(emptyCanister, amount: 2)
    ], output: [
        .init(packagedTurbofuel, amount: 2)
], machine: refinery, duration: 6, isDefault: false)

let packagedWaterRecipe = Recipe(input: [
    .init(water, amount: 2),
    .init(emptyCanister, amount: 2)
    ], output: [
        .init(packagedWater, amount: 2)
], machine: refinery, duration: 2)

let packagedOilRecipe = Recipe(input: [
    .init(crudeOil, amount: 2),
    .init(emptyCanister, amount: 2)
    ], output: [
        .init(packagedOil, amount: 2)
], machine: refinery, duration: 4)

let packagedHeavyOilResidueRecipe = Recipe(input: [
    .init(heavyOilResidue, amount: 2),
    .init(emptyCanister, amount: 2)
    ], output: [
        .init(packagedHeavyOilResidue, amount: 2)
], machine: refinery, duration: 4)

let packagedBiofuelRecipe = Recipe(input: [
    .init(liquidBiofuel, amount: 2),
    .init(emptyCanister, amount: 2)
    ], output: [
        .init(packagedLiquidBiofuel, amount: 2)
], machine: refinery, duration: 3)

// MARK: - Unpackaging
let unpackagedFuelRecipe = Recipe(input: [
    .init(packagedFuel, amount: 2)
    ], output: [
        .init(fuel, amount: 2),
        .init(emptyCanister, amount: 2)
], machine: refinery, duration: 2)

let unpackagedTurbofuelRecipe = Recipe(input: [
    .init(packagedTurbofuel, amount: 2)
    ], output: [
        .init(turbofuel, amount: 2),
        .init(emptyCanister, amount: 2)
], machine: refinery, duration: 6)

let unpackagedWaterRecipe = Recipe(input: [
    .init(packagedWater, amount: 2)
    ], output: [
        .init(water, amount: 2),
        .init(emptyCanister, amount: 2)
], machine: refinery, duration: 1)

let unpackagedOilRecipe = Recipe(input: [
    .init(packagedOil, amount: 2)
    ], output: [
        .init(crudeOil, amount: 2),
        .init(emptyCanister, amount: 2)
], machine: refinery, duration: 2)

let unpackagedHeavyOilResidueRecipe = Recipe(input: [
    .init(packagedHeavyOilResidue, amount: 2)
    ], output: [
        .init(heavyOilResidue, amount: 2),
        .init(emptyCanister, amount: 2)
], machine: refinery, duration: 6)

let unpackagedBiofuelRecipe = Recipe(input: [
    .init(packagedLiquidBiofuel, amount: 2)
    ], output: [
        .init(liquidBiofuel, amount: 2),
        .init(emptyCanister, amount: 2)
], machine: refinery, duration: 2)

// MARK: - Advanced Refinement
let aluminumScrapRecipe = Recipe(input: [
    .init(aluminaSolution, amount: 4),
    .init(petroleumCoke, amount: 1)
    ], output: [
        .init(aluminumScrap, amount: 6),
        .init(water, amount: 1)
], machine: refinery, duration: 1)

let aluminumScrapRecipe1 = Recipe(input: [
    .init(aluminaSolution, amount: 3),
    .init(coal, amount: 1)
    ], output: [
        .init(aluminumScrap, amount: 5),
        .init(water, amount: 1)
], machine: refinery, duration: 2, isDefault: false)

let aluminaSolutionRecipe = Recipe(input: [
    .init(bauxite, amount: 7),
    .init(water, amount: 10)
    ], output: [
        .init(aluminaSolution, amount: 8),
        .init(silica, amount: 2)
], machine: refinery, duration: 6)

let uraniumPelletRecipe = Recipe(input: [
    .init(uranium, amount: 5),
    .init(sulfuricAcid, amount: 8)
    ], output: [
        .init(uraniumPellet, amount: 5),
        .init(sulfuricAcid, amount: 2)
], machine: refinery, duration: 6)

let sulfuricAcidRecipe = Recipe(input: [
    .init(sulfur, amount: 5),
    .init(water, amount: 5)
    ], output: [
        .init(sulfuricAcid, amount: 10)
], machine: refinery, duration: 6)

let heavyOilResidueRecipe = Recipe(input: [
    .init(crudeOil, amount: 3)
    ], output: [
        .init(heavyOilResidue, amount: 4),
        .init(polymerResin, amount: 2)
], machine: refinery, duration: 6, isDefault: false)

// MARK: - Solid Oil Products
let plasticRecipe = Recipe(input: [
    .init(crudeOil, amount: 3)
    ], output: [
        .init(plastic, amount: 2),
        .init(heavyOilResidue, amount: 1)
], machine: refinery, duration: 6)

let residualPlasticRecipe = Recipe(input: [
    .init(polymerResin, amount: 6),
    .init(water, amount: 2)
    ], output: [
        .init(plastic, amount: 2)
], machine: refinery, duration: 6)

let plasticRecipe1 = Recipe(input: [
    .init(rubber, amount: 6),
    .init(fuel, amount: 6)
    ], output: [
        .init(plastic, amount: 12)
], machine: refinery, duration: 12, isDefault: false)

let rubberRecipe = Recipe(input: [
    .init(crudeOil, amount: 3)
    ], output: [
        .init(plastic, amount: 2),
        .init(heavyOilResidue, amount: 2)
], machine: refinery, duration: 6)

let residualRubberRecipe = Recipe(input: [
    .init(polymerResin, amount: 4),
    .init(water, amount: 4)
    ], output: [
        .init(plastic, amount: 2)
], machine: refinery, duration: 6)

let rubberRecipe1 = Recipe(input: [
    .init(plastic, amount: 6),
    .init(fuel, amount: 6)
    ], output: [
        .init(plastic, amount: 12)
], machine: refinery, duration: 12, isDefault: false)

let petroleumCokeRecipe = Recipe(input: [
    .init(heavyOilResidue, amount: 4)
    ], output: [
        .init(petroleumCoke, amount: 12)
], machine: refinery, duration: 6)

let polymerResinRecipe1 = Recipe(input: [
    .init(crudeOil, amount: 6)
], output: [
    .init(polymerResin, amount: 13),
    .init(heavyOilResidue, amount: 2)
], machine: refinery, duration: 6, isDefault: false)

// MARK: - Fuel
let fuelRecipe = Recipe(input: [
    .init(crudeOil, amount: 6)
    ], output: [
        .init(fuel, amount: 4),
        .init(polymerResin, amount: 3)
], machine: refinery, duration: 6)

let residualFuelRecipe = Recipe(input: [
    .init(heavyOilResidue, amount: 6)
    ], output: [
        .init(fuel, amount: 4)
], machine: manufacturer, duration: 6)

let turbofuelRecipe = Recipe(input: [
    .init(fuel, amount: 6),
    .init(compactedCoal, amount: 4)
    ], output: [
        .init(turbofuel, amount: 5)
], machine: refinery, duration: 16, isDefault: false)

let turbofuelRecipe1 = Recipe(input: [
    .init(heavyOilResidue, amount: 5),
    .init(compactedCoal, amount: 4)
    ], output: [
        .init(turbofuel, amount: 4)
], machine: refinery, duration: 8, isDefault: false)

let liquidBiofuelRecipe = Recipe(input: [
    .init(solidBiofuel, amount: 6),
    .init(water, amount: 3)
    ], output: [
        .init(liquidBiofuel, amount: 4)
], machine: refinery, duration: 4)

let refineryRecipes = [
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
    
    // packagins
    packagedFuelRecipe,
    packagedFuelRecipe1,
    packagedTurbofuelRecipe,
    packagedWaterRecipe,
    packagedOilRecipe,
    packagedHeavyOilResidueRecipe,
    packagedBiofuelRecipe,
    
    // unpackaging
    unpackagedFuelRecipe,
    unpackagedTurbofuelRecipe,
    unpackagedWaterRecipe,
    unpackagedOilRecipe,
    unpackagedHeavyOilResidueRecipe,
    unpackagedBiofuelRecipe,
    
    // advanced refinement
    aluminumScrapRecipe,
    aluminumScrapRecipe1,
    aluminaSolutionRecipe,
    uraniumPelletRecipe,
    sulfuricAcidRecipe,
    heavyOilResidueRecipe,
    
    // solid oil products
    plasticRecipe,
    residualPlasticRecipe,
    plasticRecipe1,
    rubberRecipe,
    residualRubberRecipe,
    rubberRecipe1,
    petroleumCokeRecipe,
    polymerResinRecipe1,
    
    // fuel
    fuelRecipe,
    residualFuelRecipe,
    turbofuelRecipe,
    turbofuelRecipe1,
    liquidBiofuelRecipe
]
