import Foundation

struct Recipe: Codable {
    let id = UUID()
    let input: [RecipePart]
    let output: [RecipePart]
    let machine: RecipeMachine
    let isDefault: Bool
    
    init(input: [RecipePart], output: [RecipePart], machine: RecipeMachine, isDefault: Bool = true) {
        self.input = input
        self.output = output
        self.machine = machine
        self.isDefault = isDefault
    }
}

extension Recipe: CustomStringConvertible {
    var description: String {
        let inputs = input.map { "\($0.name): \($0.amount)" }.joined(separator: ", ")
        let outputs = output.map { "\($0.name): \($0.amount)" }.joined(separator: ", ")
        return "\(machine): [\(inputs) -> \(outputs)]"
    }
}

extension Recipe {
    var requirements: [String: Double] {
        print(input.map { $0.resource.recipes })
        
        
        
        return [:]
    }
}

// MARK: - Smelter
let ironIngotRecipe = Recipe(input: [
    .init(id: ironOre.id, amount: 30)
    ], output: [
        .init(id: ironIngot.id, amount: 30)
], machine: .smelter)

let copperIngotRecipe = Recipe(input: [
    .init(id: copperOre.id, amount: 30)
    ], output: [
        .init(id: copperIngot.id, amount: 30)
], machine: .smelter)

let cateriumIngotRecipe = Recipe(input: [
    .init(id: cateriumOre.id, amount: 45)
    ], output: [
        .init(id: cateriumIngot.id, amount: 15)
], machine: .smelter)

// MARK: - Foundry
let steelIngotRecipe = Recipe(input: [
    .init(id: ironOre.id, amount: 45),
    .init(id: coal.id, amount: 45)
    ], output: [
        .init(id: steelIngot.id, amount: 45)
], machine: .foundry)

let ironIngotRecipe1 = Recipe(input: [
    .init(id: ironOre.id, amount: 20),
    .init(id: copperOre.id, amount: 20)
    ], output: [
        .init(id: ironIngot.id, amount: 50)
], machine: .foundry, isDefault: false)

// MARK: - Constructor
let ironPlateRecipe = Recipe(input: [
    .init(id: ironIngot.id, amount: 30)
    ], output: [
        .init(id: ironPlate.id, amount: 20)
], machine: .constructor)

let ironRodRecipe = Recipe(input: [
    .init(id: ironIngot.id, amount: 15)
    ], output: [
        .init(id: ironRod.id, amount: 15)
], machine: .constructor)

let screwRecipe = Recipe(input: [
    .init(id: ironRod.id, amount: 10)
    ], output: [
        .init(id: screw.id, amount: 40)
], machine: .constructor)

let screwRecipe1 = Recipe(input: [
    .init(id: ironIngot.id, amount: 12.5)
    ], output: [
        .init(id: screw.id, amount: 50)
], machine: .constructor, isDefault: false)

let copperSheetRecipe = Recipe(input: [
    .init(id: copperIngot.id, amount: 20)
    ], output: [
        .init(id: copperSheet.id, amount: 10)
], machine: .constructor)

let steelBeamRecipe = Recipe(input: [
    .init(id: steelIngot.id, amount: 60)
    ], output: [
        .init(id: steelBeam.id, amount: 15)
], machine: .constructor)

let steelPipeRecipe = Recipe(input: [
    .init(id: steelIngot.id, amount: 30)
    ], output: [
        .init(id: steelPipe.id, amount: 20)
], machine: .constructor)

let wireRecipe = Recipe(input: [
    .init(id: copperIngot.id, amount: 15)
    ], output: [
        .init(id: wire.id, amount: 30)
], machine: .constructor)

let wireRecipe1 = Recipe(input: [
    .init(id: ironIngot.id, amount: 12.5)
    ], output: [
        .init(id: wire.id, amount: 22.5)
], machine: .constructor, isDefault: false)

let cableRecipe = Recipe(input: [
    .init(id: wire.id, amount: 60)
    ], output: [
        .init(id: cable.id, amount: 30)
], machine: .constructor)

let quickWireRecipe = Recipe(input: [
    .init(id: cateriumIngot.id, amount: 12)
    ], output: [
        .init(id: quickWire.id, amount: 60)
], machine: .constructor)

let concreteRecipe = Recipe(input: [
    .init(id: limestone.id, amount: 45)
    ], output: [
        .init(id: concrete.id, amount: 15)
], machine: .constructor)

let quartzCrystalRecipe = Recipe(input: [
    .init(id: rawQuartz.id, amount: 37.5)
    ], output: [
        .init(id: quartzCrystal.id, amount: 22.5)
], machine: .constructor)

let silicaRecipe = Recipe(input: [
    .init(id: rawQuartz.id, amount: 22.5)
    ], output: [
        .init(id: silica.id, amount: 37.5)
], machine: .constructor)

let biomassWoodRecipe = Recipe(input: [
    .init(id: wood.id, amount: 60)
    ], output: [
        .init(id: biomass.id, amount: 300)
], machine: .constructor)

let biomassLeavesRecipe = Recipe(input: [
    .init(id: leaves.id, amount: 120)
    ], output: [
        .init(id: biomass.id, amount: 60)
], machine: .constructor)

let biomassAlienCarapaceRecipe = Recipe(input: [
    .init(id: alienCarapace.id, amount: 15)
    ], output: [
        .init(id: biomass.id, amount: 1_500)
], machine: .constructor)

let biomassAlienOrgansRecipe = Recipe(input: [
    .init(id: alienOrgans.id, amount: 7.5)
    ], output: [
        .init(id: biomass.id, amount: 1_500)
], machine: .constructor)

let biomassMyceliaRecipe = Recipe(input: [
    .init(id: mycelia.id, amount: 150)
    ], output: [
        .init(id: biomass.id, amount: 150)
], machine: .constructor)

let solidBiofuelRecipe = Recipe(input: [
    .init(id: biomass.id, amount: 120)
], output: [
    .init(id: solidBiofuel.id, amount: 60)
], machine: .constructor)

let powerShard1Recipe = Recipe(input: [
    .init(id: greenPowerSlug.id, amount: 6)
    ], output: [
        .init(id: powerShard.id, amount: 6)
], machine: .constructor)

let powerShard2Recipe = Recipe(input: [
    .init(id: yellowPowerSlug.id, amount: 4)
    ], output: [
        .init(id: powerShard.id, amount: 8)
], machine: .constructor)

let powerShard5Recipe = Recipe(input: [
    .init(id: purplePowerSlug.id, amount: 3)
    ], output: [
        .init(id: powerShard.id, amount: 15)
], machine: .constructor)

let colorCartridgeRecipe = Recipe(input: [
    .init(id: flowerPetals.id, amount: 37.5)
    ], output: [
        .init(id: colorCartridge.id, amount: 75)
], machine: .constructor)

let emptyCanisterRecipe = Recipe(input: [
    .init(id: plastic.id, amount: 30)
    ], output: [
        .init(id: emptyCanister.id, amount: 10)
], machine: .constructor)

// MARK: - Assembler
let reinforcedIronPlateRecipe = Recipe(input: [
    .init(id: ironPlate.id, amount: 30),
    .init(id: screw.id, amount: 60)
    ], output: [
        .init(id: reinforcedIronPlate.id, amount: 5)
], machine: .assembler)

let modularFrameRecipe = Recipe(input: [
    .init(id: reinforcedIronPlate.id, amount: 3),
    .init(id: ironRod.id, amount: 12)
    ], output: [
        .init(id: modularFrame.id, amount: 2)
], machine: .assembler)

let encasedIndustrialBeamRecipe = Recipe(input: [
    .init(id: steelBeam.id, amount: 24),
    .init(id: concrete.id, amount: 30)
    ], output: [
        .init(id: encasedIndustrialBeam.id, amount: 6)
], machine: .assembler)

let rotorRecipe = Recipe(input: [
    .init(id: ironRod.id, amount: 20),
    .init(id: screw.id, amount: 100)
    ], output: [
        .init(id: rotor.id, amount: 4)
], machine: .assembler)

let statorRecipe = Recipe(input: [
    .init(id: steelPipe.id, amount: 15),
    .init(id: wire.id, amount: 40)
    ], output: [
        .init(id: stator.id, amount: 5)
], machine: .assembler)

let motorRecipe = Recipe(input: [
    .init(id: rotor.id, amount: 10),
    .init(id: stator.id, amount: 10)
    ], output: [
        .init(id: motor.id, amount: 5)
], machine: .assembler)

let smartPlatingRecipe = Recipe(input: [
    .init(id: reinforcedIronPlate.id, amount: 2),
    .init(id: rotor.id, amount: 2)
    ], output: [
        .init(id: smartPlating.id, amount: 2)
], machine: .assembler)

let versatileFrameworkRecipe = Recipe(input: [
    .init(id: modularFrame.id, amount: 2.5),
    .init(id: steelBeam.id, amount: 30)
    ], output: [
        .init(id: versatileFramework.id, amount: 5)
], machine: .assembler)

let automatedWiringRecipe = Recipe(input: [
    .init(id: stator.id, amount: 2.5),
    .init(id: cable.id, amount: 50)
    ], output: [
        .init(id: automatedWiring.id, amount: 2.5)
], machine: .assembler)

let blackPowderRecipe = Recipe(input: [
    .init(id: coal.id, amount: 7.5),
    .init(id: sulfur.id, amount: 15)
    ], output: [
        .init(id: blackPowder.id, amount: 7.5)
], machine: .assembler)

let nobeliskRecipe = Recipe(input: [
    .init(id: blackPowder.id, amount: 15),
    .init(id: steelPipe.id, amount: 30)
    ], output: [
        .init(id: nobelisk.id, amount: 3)
], machine: .assembler)

let quickWireRecipe1 = Recipe(input: [
    .init(id: cateriumIngot.id, amount: 7.5),
    .init(id: copperIngot.id, amount: 37.5)
    ], output: [
        .init(id: quickWire.id, amount: 90)
], machine: .assembler, isDefault: false)

let circuitBoardRecipe = Recipe(input: [
    .init(id: copperSheet.id, amount: 15),
    .init(id: plastic.id, amount: 30)
    ], output: [
        .init(id: circuitBoard.id, amount: 7.5)
], machine: .assembler)

let aiLimiterRecipe = Recipe(input: [
    .init(id: copperSheet.id, amount: 25),
    .init(id: quickWire.id, amount: 100)
    ], output: [
        .init(id: aiLimiter.id, amount: 5)
], machine: .assembler)

let fabricRecipe = Recipe(input: [
    .init(id: mycelia.id, amount: 15),
    .init(id: biomass.id, amount: 75)
    ], output: [
        .init(id: fabric.id, amount: 15)
], machine: .assembler)

let computerRecipe1 = Recipe(input: [
    .init(id: circuitBoard.id, amount: 7.5),
    .init(id: crystalOscillator.id, amount: 2.813)
    ], output: [
        .init(id: computer.id, amount: 2.8)
], machine: .assembler, isDefault: false)

// MARK: - Manufacturer
let beaconRecipe = Recipe(input: [
    .init(id: ironPlate.id, amount: 22.5),
    .init(id: ironRod.id, amount: 7.5),
    .init(id: wire.id, amount: 112.5),
    .init(id: cable.id, amount: 15)
    ], output: [
        .init(id: beacon.id, amount: 7.5)
], machine: .manufacturer)

let crystalOscillatorRecipe = Recipe(input: [
    .init(id: quartzCrystal.id, amount: 18),
    .init(id: cable.id, amount: 14),
    .init(id: reinforcedIronPlate.id, amount: 2.5)
    ], output: [
        .init(id: crystalOscillator.id, amount: 1)
], machine: .manufacturer)

let computerRecipe = Recipe(input: [
    .init(id: circuitBoard.id, amount: 25),
    .init(id: cable.id, amount: 22.5),
    .init(id: plastic.id, amount: 45),
    .init(id: screw.id, amount: 130)
    ], output: [
        .init(id: computer.id, amount: 2.5)
], machine: .manufacturer)

let heavyModularFrameRecipe = Recipe(input: [
    .init(id: modularFrame.id, amount: 10),
    .init(id: steelPipe.id, amount: 30),
    .init(id: encasedIndustrialBeam.id, amount: 10),
    .init(id: screw.id, amount: 200)
    ], output: [
        .init(id: heavyModularFrame.id, amount: 2)
], machine: .manufacturer)

let modularEngineRecipe = Recipe(input: [
    .init(id: motor.id, amount: 2),
    .init(id: rubber.id, amount: 15),
    .init(id: smartPlating.id, amount: 2)
    ], output: [
        .init(id: modularEngine.id, amount: 1)
], machine: .manufacturer)

let adaptiveControlUnitRecipe = Recipe(input: [
    .init(id: automatedWiring.id, amount: 7.5),
    .init(id: circuitBoard.id, amount: 5),
    .init(id: heavyModularFrame.id, amount: 1),
    .init(id: computer.id, amount: 1)
    ], output: [
        .init(id: adaptiveControlUnit.id, amount: 1)
], machine: .manufacturer)

let filterRecipe = Recipe(input: [
    .init(id: coal.id, amount: 37.5),
    .init(id: rubber.id, amount: 15),
    .init(id: fabric.id, amount: 15)
], output: [
    .init(id: filter.id, amount: 7.5)
], machine: .manufacturer)

// MARK: - Refinery
let fuelResidualRecipe = Recipe(input: [
    .init(id: heavyOilResidue.id, amount: 30)
    ], output: [
        .init(id: fuel.id, amount: 20)
], machine: .manufacturer)

let fuelRecipe = Recipe(input: [
    .init(id: crudeOil.id, amount: 60)
    ], output: [
        .init(id: fuel.id, amount: 40),
        .init(id: polymerResin.id, amount: 30)
], machine: .refinery)

let liquidBiofuelRecipe = Recipe(input: [
    .init(id: solidBiofuel.id, amount: 90),
    .init(id: water.id, amount: 45)
    ], output: [
        .init(id: liquidBiofuel.id, amount: 60)
], machine: .refinery)

let fuelUnpackedRecipe = Recipe(input: [
    .init(id: packagedFuel.id, amount: 30)
    ], output: [
        .init(id: fuel.id, amount: 30),
        .init(id: emptyCanister.id, amount: 30)
], machine: .refinery)

let biofuelUnpackedRecipe = Recipe(input: [
    .init(id: packagedLiquidBiofuel.id, amount: 30)
    ], output: [
        .init(id: liquidBiofuel.id, amount: 30),
        .init(id: emptyCanister.id, amount: 30)
], machine: .refinery)

let rebbuerResidualRecipe = Recipe(input: [
    .init(id: polymerResin.id, amount: 20),
    .init(id: water.id, amount: 40)
    ], output: [
        .init(id: rubber.id, amount: 10)
], machine: .refinery)

let plasticResidualRecipe = Recipe(input: [
    .init(id: polymerResin.id, amount: 30),
    .init(id: water.id, amount: 20)
    ], output: [
        .init(id: plastic.id, amount: 10)
], machine: .refinery)

let petrolumCokeRecipe = Recipe(input: [
    .init(id: heavyOilResidue.id, amount: 20),
    ], output: [
        .init(id: petroleumCoke.id, amount: 60)
], machine: .refinery)

let rubberRecipe = Recipe(input: [
    .init(id: crudeOil.id, amount: 30)
    ], output: [
        .init(id: rubber.id, amount: 20),
        .init(id: heavyOilResidue.id, amount: 10)
], machine: .refinery)

let plasticRecipe = Recipe(input: [
    .init(id: crudeOil.id, amount: 30)
    ], output: [
        .init(id: plastic.id, amount: 20),
        .init(id: heavyOilResidue.id, amount: 20)
], machine: .refinery)

let packagedWaterRecipe = Recipe(input: [
    .init(id: water.id, amount: 30),
    .init(id: emptyCanister.id, amount: 30)
    ], output: [
        .init(id: packagedWater.id, amount: 30)
], machine: .refinery)

let packagedOilRecipe = Recipe(input: [
    .init(id: crudeOil.id, amount: 12),
    .init(id: emptyCanister.id, amount: 12)
    ], output: [
        .init(id: packagedOil.id, amount: 12)
], machine: .refinery)

let packagedFuelRecipe = Recipe(input: [
    .init(id: fuel.id, amount: 20),
    .init(id: emptyCanister.id, amount: 20)
    ], output: [
        .init(id: packagedFuel.id, amount: 20)
], machine: .refinery)

let packagedHeavyOilResidueRecipe = Recipe(input: [
    .init(id: heavyOilResidue.id, amount: 10),
    .init(id: emptyCanister.id, amount: 10)
    ], output: [
        .init(id: packagedHeavyOilResidue.id, amount: 10)
], machine: .refinery)

let packagedBiofuelRecipe = Recipe(input: [
    .init(id: liquidBiofuel.id, amount: 15),
    .init(id: emptyCanister.id, amount: 15)
    ], output: [
        .init(id: packagedLiquidBiofuel.id, amount: 15)
], machine: .refinery)

let unpackagedWaterRecipe = Recipe(input: [
    .init(id: packagedWater.id, amount: 60)
    ], output: [
        .init(id: water.id, amount: 60),
        .init(id: emptyCanister.id, amount: 60)
], machine: .refinery)

let unpackagedOilRecipe = Recipe(input: [
    .init(id: packagedOil.id, amount: 30)
    ], output: [
        .init(id: crudeOil.id, amount: 30),
        .init(id: emptyCanister.id, amount: 30)
], machine: .refinery)

let unpackagedHeavyOilResidueRecipe = Recipe(input: [
    .init(id: packagedHeavyOilResidue.id, amount: 10)
    ], output: [
        .init(id: heavyOilResidue.id, amount: 10),
        .init(id: emptyCanister.id, amount: 10)
], machine: .refinery)

let Recipes = [
    ironIngotRecipe,
    copperIngotRecipe,
    cateriumIngotRecipe,
    
    steelIngotRecipe,
    ironIngotRecipe1,
    
    ironPlateRecipe,
    ironRodRecipe,
    screwRecipe,
    screwRecipe1,
    copperSheetRecipe,
    steelBeamRecipe,
    steelPipeRecipe,
    wireRecipe,
    wireRecipe1,
    cableRecipe,
    quickWireRecipe,
    concreteRecipe,
    quartzCrystalRecipe,
    silicaRecipe,
    biomassWoodRecipe,
    biomassLeavesRecipe,
    biomassAlienCarapaceRecipe,
    biomassAlienOrgansRecipe,
    biomassMyceliaRecipe,
    solidBiofuelRecipe,
    powerShard1Recipe,
    powerShard2Recipe,
    powerShard5Recipe,
    colorCartridgeRecipe,
    emptyCanisterRecipe,
    
    reinforcedIronPlateRecipe,
    modularFrameRecipe,
    encasedIndustrialBeamRecipe,
    rotorRecipe,
    statorRecipe,
    motorRecipe,
    smartPlatingRecipe,
    versatileFrameworkRecipe,
    automatedWiringRecipe,
    blackPowderRecipe,
    nobeliskRecipe,
    quickWireRecipe1,
    circuitBoardRecipe,
    aiLimiterRecipe,
    fabricRecipe,
    computerRecipe1,
    
    beaconRecipe,
    crystalOscillatorRecipe,
    computerRecipe,
    heavyModularFrameRecipe,
    modularEngineRecipe,
    adaptiveControlUnitRecipe,
    filterRecipe,
    
    fuelResidualRecipe,
    fuelRecipe,
    liquidBiofuelRecipe,
    fuelUnpackedRecipe,
    biofuelUnpackedRecipe,
    rebbuerResidualRecipe,
    plasticResidualRecipe,
    petrolumCokeRecipe,
    rubberRecipe,
    plasticRecipe,
    packagedWaterRecipe,
    packagedOilRecipe,
    packagedFuelRecipe,
    packagedHeavyOilResidueRecipe,
    packagedBiofuelRecipe,
    unpackagedWaterRecipe,
    unpackagedOilRecipe,
    unpackagedHeavyOilResidueRecipe
]
