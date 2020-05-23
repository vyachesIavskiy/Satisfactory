// MARK: - Ingots
let ironIngotRecipe2 = Recipe(input: [
    .init(ironOre, amount: 35),
    .init(water, amount: 20)
    ], output: [
        .init(ironIngot, amount: 65)
], machine: refinery, isDefault: false)

let copperIngotRecipe2 = Recipe(input: [
    .init(copperOre, amount: 15),
    .init(water, amount: 10)
    ], output: [
        .init(copperIngot, amount: 37.5)
], machine: refinery, isDefault: false)

let cateriumIngotRecipe1 = Recipe(input: [
    .init(cateriumOre, amount: 24),
    .init(water, amount: 24)
    ], output: [
        .init(cateriumIngot, amount: 12)
], machine: refinery, isDefault: false)

// MARK: - Minerals
let concreteRecipe3 = Recipe(input: [
    .init(limestone, amount: 120),
    .init(water, amount: 100)
    ], output: [
        .init(concrete, amount: 80)
], machine: refinery, isDefault: false)

let quartzCrystalRecipe1 = Recipe(input: [
    .init(rawQuartz, amount: 67.5),
    .init(water, amount: 37.5)
    ], output: [
        .init(quartzCrystal, amount: 52.2)
], machine: refinery, isDefault: false)

// MARK: - Biomass
let fabricRecipe1 = Recipe(input: [
    .init(polymerResin, amount: 80),
    .init(water, amount: 50)
    ], output: [
        .init(fabric, amount: 5)
], machine: refinery, isDefault: false)

// MARK: - Standart Parts
let copperSheetRecipe1 = Recipe(input: [
    .init(copperIngot, amount: 22.5),
    .init(water, amount: 22.5)
    ], output: [
        .init(copperSheet, amount: 22.5)
], machine: refinery, isDefault: false)

// MARK: - Electronics
let cableRecipe3 = Recipe(input: [
    .init(wire, amount: 37.5),
    .init(heavyOilResidue, amount: 15)
    ], output: [
        .init(cable, amount: 67.5)
], machine: refinery, isDefault: false)

// MARK: - Packaging
let packagedFuelRecipe = Recipe(input: [
    .init(fuel, amount: 20),
    .init(emptyCanister, amount: 20)
    ], output: [
        .init(packagedFuel, amount: 20)
], machine: refinery)

let packagedFuelRecipe1 = Recipe(input: [
    .init(heavyOilResidue, amount: 30),
    .init(packagedWater, amount: 60)
    ], output: [
        .init(fuel, amount: 60)
], machine: refinery, isDefault: false)

let packagedTurbofuelRecipe = Recipe(input: [
    .init(turbofuel, amount: 20),
    .init(emptyCanister, amount: 20)
    ], output: [
        .init(packagedTurbofuel, amount: 20)
], machine: refinery, isDefault: false)

let packagedWaterRecipe = Recipe(input: [
    .init(water, amount: 30),
    .init(emptyCanister, amount: 30)
    ], output: [
        .init(packagedWater, amount: 30)
], machine: refinery)

let packagedOilRecipe = Recipe(input: [
    .init(crudeOil, amount: 12),
    .init(emptyCanister, amount: 12)
    ], output: [
        .init(packagedOil, amount: 12)
], machine: refinery)

let packagedHeavyOilResidueRecipe = Recipe(input: [
    .init(heavyOilResidue, amount: 10),
    .init(emptyCanister, amount: 10)
    ], output: [
        .init(packagedHeavyOilResidue, amount: 10)
], machine: refinery)

let packagedBiofuelRecipe = Recipe(input: [
    .init(liquidBiofuel, amount: 15),
    .init(emptyCanister, amount: 15)
    ], output: [
        .init(packagedLiquidBiofuel, amount: 15)
], machine: refinery)

// MARK: - Unpackaging
let unpackagedHeavyOilResidueRecipe = Recipe(input: [
    .init(packagedHeavyOilResidue, amount: 10)
    ], output: [
        .init(heavyOilResidue, amount: 10),
        .init(emptyCanister, amount: 10)
], machine: refinery)

let unpackagedWaterRecipe = Recipe(input: [
    .init(packagedWater, amount: 60)
    ], output: [
        .init(water, amount: 60),
        .init(emptyCanister, amount: 60)
], machine: refinery)

let unpackagedOilRecipe = Recipe(input: [
    .init(packagedOil, amount: 30)
    ], output: [
        .init(crudeOil, amount: 30),
        .init(emptyCanister, amount: 30)
], machine: refinery)

let unpackagedTurbofuelRecipe = Recipe(input: [
    .init(packagedTurbofuel, amount: 20)
    ], output: [
        .init(turbofuel, amount: 20),
        .init(emptyCanister, amount: 20)
], machine: refinery)

let unpackagedFuelRecipe = Recipe(input: [
    .init(packagedFuel, amount: 30)
    ], output: [
        .init(fuel, amount: 30),
        .init(emptyCanister, amount: 30)
], machine: refinery)

let unpackagedBiofuelRecipe = Recipe(input: [
    .init(packagedLiquidBiofuel, amount: 30)
    ], output: [
        .init(liquidBiofuel, amount: 30),
        .init(emptyCanister, amount: 30)
], machine: refinery)

// MARK: - Advanced Refinement
let aluminumScrapRecipe = Recipe(input: [
    .init(aluminaSolution, amount: 240),
    .init(petroleumCoke, amount: 60)
    ], output: [
        .init(aluminumScrap, amount: 360),
        .init(water, amount: 60)
], machine: refinery)

let aluminumScrapRecipe1 = Recipe(input: [
    .init(aluminaSolution, amount: 90),
    .init(coal, amount: 30)
    ], output: [
        .init(aluminumScrap, amount: 150),
        .init(water, amount: 30)
], machine: refinery, isDefault: false)

let aluminaSolutionRecipe = Recipe(input: [
    .init(bauxite, amount: 70),
    .init(water, amount: 100)
    ], output: [
        .init(aluminaSolution, amount: 80),
        .init(silica, amount: 20)
], machine: refinery)

let uraniumPelletRecipe = Recipe(input: [
    .init(uranium, amount: 50),
    .init(sulfuricAcid, amount: 80)
    ], output: [
        .init(uraniumPellet, amount: 50),
        .init(sulfuricAcid, amount: 20)
], machine: refinery)

let sulfuricAcidRecipe = Recipe(input: [
    .init(sulfur, amount: 50),
    .init(water, amount: 50)
    ], output: [
        .init(sulfuricAcid, amount: 100)
], machine: refinery)

let heavyOilResidueRecipe = Recipe(input: [
    .init(crudeOil, amount: 30)
    ], output: [
        .init(heavyOilResidue, amount: 40),
        .init(polymerResin, amount: 20)
], machine: refinery, isDefault: false)

// MARK: - Solid Oil Products
let plasticRecipe = Recipe(input: [
    .init(crudeOil, amount: 30)
    ], output: [
        .init(plastic, amount: 20),
        .init(heavyOilResidue, amount: 10)
], machine: refinery)

let residualPlasticRecipe = Recipe(input: [
    .init(polymerResin, amount: 60),
    .init(water, amount: 20)
    ], output: [
        .init(plastic, amount: 20)
], machine: refinery)

let plasticRecipe1 = Recipe(input: [
    .init(rubber, amount: 30),
    .init(fuel, amount: 30)
    ], output: [
        .init(plastic, amount: 60)
], machine: refinery, isDefault: false)

let rubberRecipe = Recipe(input: [
    .init(crudeOil, amount: 30)
    ], output: [
        .init(plastic, amount: 20),
        .init(heavyOilResidue, amount: 20)
], machine: refinery)

let residualRubberRecipe = Recipe(input: [
    .init(polymerResin, amount: 40),
    .init(water, amount: 40)
    ], output: [
        .init(plastic, amount: 20)
], machine: refinery)

let rubberRecipe1 = Recipe(input: [
    .init(plastic, amount: 30),
    .init(fuel, amount: 30)
    ], output: [
        .init(plastic, amount: 60)
], machine: refinery, isDefault: false)

let petroleumCokeRecipe = Recipe(input: [
    .init(heavyOilResidue, amount: 40)
    ], output: [
        .init(petroleumCoke, amount: 120)
], machine: refinery)

// MARK: - Fuel
let turbofuelRecipe = Recipe(input: [
    .init(fuel, amount: 22.5),
    .init(compactedCoal, amount: 15)
    ], output: [
        .init(turbofuel, amount: 18.8)
], machine: refinery, isDefault: false)

let turbofuelRecipe1 = Recipe(input: [
    .init(heavyOilResidue, amount: 37.5),
    .init(compactedCoal, amount: 30)
    ], output: [
        .init(turbofuel, amount: 30)
], machine: refinery, isDefault: false)

let fuelRecipe = Recipe(input: [
    .init(crudeOil, amount: 60)
    ], output: [
        .init(fuel, amount: 40),
        .init(polymerResin, amount: 30)
], machine: refinery)

let residualFuelRecipe = Recipe(input: [
    .init(heavyOilResidue, amount: 30)
    ], output: [
        .init(fuel, amount: 20)
], machine: manufacturer)

let liquidBiofuelRecipe = Recipe(input: [
    .init(solidBiofuel, amount: 90),
    .init(water, amount: 45)
    ], output: [
        .init(liquidBiofuel, amount: 60)
], machine: refinery)

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
    unpackagedHeavyOilResidueRecipe,
    unpackagedWaterRecipe,
    unpackagedOilRecipe,
    unpackagedTurbofuelRecipe,
    unpackagedFuelRecipe,
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
    
    // fuel
    turbofuelRecipe,
    turbofuelRecipe1,
    fuelRecipe,
    residualFuelRecipe,
    liquidBiofuelRecipe
]
