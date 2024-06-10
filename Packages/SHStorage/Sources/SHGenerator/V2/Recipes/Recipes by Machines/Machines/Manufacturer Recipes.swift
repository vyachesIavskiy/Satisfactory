import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true,
        manuallyCraftable: Bool = true,
        additionalManualCrafting: Building.Static? = nil
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            machine: V2.Buildings.manufacturer,
            manualCrafting: isDefault ? [V2.Buildings.craftBench] : [],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Standard Parts
    static let heavyModularFrameRecipe = Recipe.Static(
        id: "recipe-heavy-modular-frame",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.screw, amount: 100)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 1),
        duration: 30
    )
    
    static let heavyModularFrameRecipe1 = Recipe.Static(
        id: "recipe-alternate-heavy-flexible-frame",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.screw, amount: 104)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 1),
        duration: 16,
        isDefault: false
    )
    
    static let heavyModularFrameRecipe2 = Recipe.Static(
        id: "recipe-alternate-heavy-encased-frame",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 36),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 22)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 3),
        duration: 64,
        isDefault: false
    )
    
    // MARK: - Industrial Parts
    static let turboMotorRecipe = Recipe.Static(
        id: "recipe-turbo-motor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.coolingSystem, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 24)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.turboMotor, amount: 1),
        duration: 32
    )
    
    static let turboMotorRecipe1 = Recipe.Static(
        id: "recipe-alternate-turbo-electric-motor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 7),
            Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 9),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 7)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.turboMotor, amount: 3),
        duration: 64,
        isDefault: false
    )
    
    static let turboMotorRecipe2 = Recipe.Static(
        id: "recipe-alternate-turbo-pressure-motor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.pressureConversionCube, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.packagedNitrogenGas, amount: 24),
            Recipe.Static.Ingredient(V2.Parts.stator, amount: 8)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.turboMotor, amount: 2),
        duration: 32,
        isDefault: false
    )
    
    static let motorRecipe2 = Recipe.Static(
        id: "recipe-alternate-rigour-motor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.stator, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.motor, amount: 6),
        duration: 48,
        isDefault: false
    )
    
    static let batteryRecipe1 = Recipe.Static(
        id: "recipe-alternate-classic-battery",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.alcladAluminumSheet, amount: 7),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.battery, amount: 4),
        duration: 8,
        isDefault: false
    )
    
    // MARK: - Electronics
    static let highSpeedConnectorRecipe = Recipe.Static(
        id: "recipe-high-speed-connector",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 56),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.highSpeedConnector, amount: 1),
        duration: 16
    )
    
    static let highSpeedConnectorRecipe1 = Recipe.Static(
        id: "recipe-alternate-silicon-high-speed-connector",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 60),
            Recipe.Static.Ingredient(V2.Parts.silica, amount: 25),
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.highSpeedConnector, amount: 2),
        duration: 40,
        isDefault: false
    )
    
    // MARK: - Communications
    static let computerRecipe = Recipe.Static(
        id: "recipe-computer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 9),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 18),
            Recipe.Static.Ingredient(V2.Parts.screw, amount: 52)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.computer, amount: 1),
        duration: 24
    )
    
    static let computerRecipe2 = Recipe.Static(
        id: "recipe-alternate-caterium-computer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 7),
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 28),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.computer, amount: 1),
        duration: 16,
        isDefault: false
    )
    
    static let crystalOscillatorRecipe = Recipe.Static(
        id: "recipe-crystal-oscillator",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.quartzCrystal, amount: 36),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 28),
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 2),
        duration: 120
    )
    
    static let crystalOscillatorRecipe1 = Recipe.Static(
        id: "recipe-alternate-insulated-crystal-oscillator",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.quartzCrystal, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 7),
            Recipe.Static.Ingredient(V2.Parts.aiLimiter, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 1),
        duration: 32,
        isDefault: false
    )
    
    static let supercomputerRecipe = Recipe.Static(
        id: "recipe-supercomputer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.computer, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.aiLimiter, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.highSpeedConnector, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 28)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 1),
        duration: 32
    )
    
    static let supercomputerRecipe1 = Recipe.Static(
        id: "recipe-alternate-super-state-computer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.computer, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.battery, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 45)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 2),
        duration: 50,
        isDefault: false
    )
    
    static let radioControlUnitRecipe = Recipe.Static(
        id: "recipe-radio-control-unit",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 32),
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.computer, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 2),
        duration: 48
    )
    
    static let radioControlUnitRecipe1 = Recipe.Static(
        id: "recipe-alternate-radio-connection-unit",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.heatSink, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.highSpeedConnector, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.quartzCrystal, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 1),
        duration: 16,
        isDefault: false
    )
    
    static let radioControlUnitRecipe2 = Recipe.Static(
        id: "recipe-alternate-radio-control-system",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 60),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 30)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 3),
        duration: 40,
        isDefault: false
    )
    
    // MARK: - Nuclear
    static let uraniumFuelRodRecipe = Recipe.Static(
        id: "recipe-uranium-fuel-rod",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.encasedUraniumCell, amount: 50),
            Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.uraniumFuelRod, amount: 1),
        duration: 150
    )
    
    static let uraniumFuelRodRecipe1 = Recipe.Static(
        id: "recipe-alternate-uranium-fuel-unit",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.encasedUraniumCell, amount: 100),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 3),
            Recipe.Static.Ingredient(V2.Equipment.beacon, amount: 6)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.uraniumFuelRod, amount: 3),
        duration: 300,
        isDefault: false
    )
    
    static let encasedUraniumCellRecipe1 = Recipe.Static(
        id: "recipe-alternate-infused-uranium-cell",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.uranium, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.silica, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 15)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.encasedUraniumCell, amount: 4),
        duration: 12,
        isDefault: false
    )
    
    static let plutoniumFuelRodRecipe = Recipe.Static(
        id: "recipe-plutonium-fuel-rod",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.encasedPlutoniumCell, amount: 30),
            Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 18),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.heatSink, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.plutoniumFuelRod, amount: 1),
        duration: 240
    )
    
    // MARK: - Consumed
    static let gasFilterRecipe = Recipe.Static(
        id: "recipe-gas-filter",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.fabric, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.gasFilter, amount: 1),
        duration: 8,
        additionalManualCrafting: V2.Buildings.equipmentWorkshop
    )
    
    static let iodineInfusedFilterRecipe = Recipe.Static(
        id: "recipe-iodine-infused-filter",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.gasFilter, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.iodineInfusedFilter, amount: 1),
        duration: 16,
        additionalManualCrafting: V2.Buildings.equipmentWorkshop
    )
    
    static let rifleCartridgeRecipe = Recipe.Static(
        id: "recipe-rifle-cartridge",
        inputs: [
            Recipe.Static.Ingredient(V2.Equipment.beacon, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.blackPowder, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.rifleAmmo, amount: 5),
        duration: 20,
        additionalManualCrafting: V2.Buildings.equipmentWorkshop
    )
    
    // MARK: - Space Elevator
    static let modularEngineRecipe = Recipe.Static(
        id: "recipe-modular-engine",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.smartPlating, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.modularEngine, amount: 1),
        duration: 60,
        manuallyCraftable: false
    )
    
    static let adaptiveControlUnitRecipe = Recipe.Static(
        id: "recipe-adaptive-control-unit",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.automatedWiring, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.computer, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.adaptiveControlUnit, amount: 2),
        duration: 120,
        manuallyCraftable: false
    )
    
    static let magneticFieldGeneratorRecipe = Recipe.Static(
        id: "recipe-magnetic-field-generator",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.versatileFramework, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.battery, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.magneticFieldGenerator, amount: 2),
        duration: 120,
        manuallyCraftable: false
    )
    
    static let thermalPropulsionRocketRecipe = Recipe.Static(
        id: "recipe-thermal-propulsion-rocket",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.modularEngine, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.turboMotor, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.coolingSystem, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.fusedModularFrame, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.thermalPropulsionRocket, amount: 2),
        duration: 120,
        manuallyCraftable: false
    )
    
    static let smartPlatingRecipe1 = Recipe.Static(
        id: "recipe-alternate-plastic-smart-plating",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.smartPlating, amount: 2),
        duration: 24,
        isDefault: false,
        manuallyCraftable: false
    )
    
    static let versatileFrameworkRecipe1 = Recipe.Static(
        id: "recipe-alternate-flexible-framework",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 8)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.versatileFramework, amount: 2),
        duration: 16,
        isDefault: false,
        manuallyCraftable: false
    )
    
    static let automatedWiringRecipe1 = Recipe.Static(
        id: "recipe-alternate-automated-speed-wiring",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.stator, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 40),
            Recipe.Static.Ingredient(V2.Parts.highSpeedConnector, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.automatedWiring, amount: 4),
        duration: 32,
        isDefault: false,
        manuallyCraftable: false
    )
    
    // MARK: - Hands
    static let beaconRecipe = Recipe.Static(
        id: "recipe-beacon",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Equipment.beacon, amount: 1),
        duration: 8,
        additionalManualCrafting: V2.Buildings.equipmentWorkshop
    )
    
    static let beaconRecipe1 = Recipe.Static(
        id: "recipe-alternate-crystal-beacon",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 16),
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Equipment.beacon, amount: 20),
        duration: 120,
        isDefault: false
    )
    
    static let portableMinerRecipe1 = Recipe.Static(
        id: "recipe-alternate-automated-miner",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Equipment.portableMiner, amount: 1),
        duration: 60,
        isDefault: false
    )
    
    // MARK: - Ammunition
    static let explosiveRebarRecipe = Recipe.Static(
        id: "recipe-explosive-rebar",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironRebar, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.smokelessPowder, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.explosiveRebar, amount: 1),
        duration: 12,
        additionalManualCrafting: V2.Buildings.equipmentWorkshop
    )
    
    static let nukeNobeliskRecipe = Recipe.Static(
        id: "recipe-nuke-nobelisk",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nobelisk, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.encasedUraniumCell, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.smokelessPowder, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.aiLimiter, amount: 6)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nukeNobelisk, amount: 1),
        duration: 120,
        additionalManualCrafting: V2.Buildings.equipmentWorkshop
    )
    
    static let turboRifleAmmoRecipe = Recipe.Static(
        id: "recipe-turbo-rifle-ammo",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rifleAmmo, amount: 25),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.packagedTurbofuel, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.turboRifleAmmo, amount: 50),
        duration: 12,
        additionalManualCrafting: V2.Buildings.equipmentWorkshop
    )
    
    static let manufacturerRecipes = [
        heavyModularFrameRecipe,
        heavyModularFrameRecipe1,
        heavyModularFrameRecipe2,
        turboMotorRecipe,
        turboMotorRecipe1,
        turboMotorRecipe2,
        motorRecipe2,
        batteryRecipe1,
        highSpeedConnectorRecipe,
        highSpeedConnectorRecipe1,
        computerRecipe,
        computerRecipe2,
        crystalOscillatorRecipe,
        crystalOscillatorRecipe1,
        supercomputerRecipe,
        supercomputerRecipe1,
        radioControlUnitRecipe,
        radioControlUnitRecipe1,
        radioControlUnitRecipe2,
        uraniumFuelRodRecipe,
        uraniumFuelRodRecipe1,
        encasedUraniumCellRecipe1,
        plutoniumFuelRodRecipe,
        gasFilterRecipe,
        iodineInfusedFilterRecipe,
        rifleCartridgeRecipe,
        modularEngineRecipe,
        adaptiveControlUnitRecipe,
        magneticFieldGeneratorRecipe,
        thermalPropulsionRocketRecipe,
        smartPlatingRecipe1,
        versatileFrameworkRecipe1,
        automatedWiringRecipe1,
        beaconRecipe,
        beaconRecipe1,
        portableMinerRecipe1,
        explosiveRebarRecipe,
        nukeNobeliskRecipe,
        turboRifleAmmoRecipe
    ]
}
