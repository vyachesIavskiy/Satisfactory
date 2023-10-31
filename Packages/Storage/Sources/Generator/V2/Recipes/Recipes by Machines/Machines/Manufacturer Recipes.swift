import StaticModels

private extension Recipe {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            machines: isDefault ? [V2.Buildings.manufacturer, V2.Buildings.craftBench] : [V2.Buildings.manufacturer],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension V2.Recipes {
    // MARK: - Standard Parts
    static let heavyModularFrameRecipe = Recipe(
        id: "recipe-heavy-modular-frame",
        inputs: [
            Recipe.Ingredient(V2.Parts.modularFrame, amount: 5),
            Recipe.Ingredient(V2.Parts.steelPipe, amount: 15),
            Recipe.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 5),
            Recipe.Ingredient(V2.Parts.screw, amount: 100)
        ],
        output: Recipe.Ingredient(V2.Parts.heavyModularFrame, amount: 1),
        duration: 30
    )
    
    static let heavyModularFrameRecipe1 = Recipe(
        id: "recipe-alternate-heavy-flexible-frame",
        inputs: [
            Recipe.Ingredient(V2.Parts.modularFrame, amount: 5),
            Recipe.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 3),
            Recipe.Ingredient(V2.Parts.rubber, amount: 20),
            Recipe.Ingredient(V2.Parts.screw, amount: 104)
        ],
        output: Recipe.Ingredient(V2.Parts.heavyModularFrame, amount: 1),
        duration: 16,
        isDefault: false
    )
    
    static let heavyModularFrameRecipe2 = Recipe(
        id: "recipe-alternate-heavy-encased-frame",
        inputs: [
            Recipe.Ingredient(V2.Parts.modularFrame, amount: 8),
            Recipe.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 10),
            Recipe.Ingredient(V2.Parts.steelPipe, amount: 36),
            Recipe.Ingredient(V2.Parts.concrete, amount: 22)
        ],
        output: Recipe.Ingredient(V2.Parts.heavyModularFrame, amount: 3),
        duration: 64,
        isDefault: false
    )
    
    // MARK: - Industrial Parts
    static let turboMotorRecipe = Recipe(
        id: "recipe-turbo-motor",
        inputs: [
            Recipe.Ingredient(V2.Parts.coolingSystem, amount: 4),
            Recipe.Ingredient(V2.Parts.radioControlUnit, amount: 2),
            Recipe.Ingredient(V2.Parts.motor, amount: 4),
            Recipe.Ingredient(V2.Parts.rubber, amount: 24)
        ],
        output: Recipe.Ingredient(V2.Parts.turboMotor, amount: 1),
        duration: 32
    )
    
    static let turboMotorRecipe1 = Recipe(
        id: "recipe-alternate-turbo-electric-motor",
        inputs: [
            Recipe.Ingredient(V2.Parts.motor, amount: 7),
            Recipe.Ingredient(V2.Parts.radioControlUnit, amount: 9),
            Recipe.Ingredient(V2.Parts.electromagneticControlRod, amount: 5),
            Recipe.Ingredient(V2.Parts.rotor, amount: 7)
        ],
        output: Recipe.Ingredient(V2.Parts.turboMotor, amount: 3),
        duration: 64,
        isDefault: false
    )
    
    static let turboMotorRecipe2 = Recipe(
        id: "recipe-alternate-turbo-pressure-motor",
        inputs: [
            Recipe.Ingredient(V2.Parts.motor, amount: 4),
            Recipe.Ingredient(V2.Parts.pressureConversionCube, amount: 1),
            Recipe.Ingredient(V2.Parts.packagedNitrogenGas, amount: 24),
            Recipe.Ingredient(V2.Parts.stator, amount: 8)
        ],
        output: Recipe.Ingredient(V2.Parts.turboMotor, amount: 2),
        duration: 32,
        isDefault: false
    )
    
    static let motorRecipe2 = Recipe(
        id: "recipe-alternate-rigour-motor",
        inputs: [
            Recipe.Ingredient(V2.Parts.rotor, amount: 3),
            Recipe.Ingredient(V2.Parts.stator, amount: 3),
            Recipe.Ingredient(V2.Parts.crystalOscillator, amount: 1)
        ],
        output: Recipe.Ingredient(V2.Parts.motor, amount: 6),
        duration: 48,
        isDefault: false
    )
    
    static let batteryRecipe1 = Recipe(
        id: "recipe-alternate-classic-battery",
        inputs: [
            Recipe.Ingredient(V2.Parts.sulfur, amount: 6),
            Recipe.Ingredient(V2.Parts.alcladAluminumSheet, amount: 7),
            Recipe.Ingredient(V2.Parts.plastic, amount: 8),
            Recipe.Ingredient(V2.Parts.wire, amount: 12)
        ],
        output: Recipe.Ingredient(V2.Parts.battery, amount: 4),
        duration: 8,
        isDefault: false
    )
    
    // MARK: - Electronics
    static let highSpeedConnectorRecipe = Recipe(
        id: "recipe-high-speed-connector",
        inputs: [
            Recipe.Ingredient(V2.Parts.quickwire, amount: 56),
            Recipe.Ingredient(V2.Parts.cable, amount: 10),
            Recipe.Ingredient(V2.Parts.circuitBoard, amount: 1)
        ],
        output: Recipe.Ingredient(V2.Parts.highSpeedConnector, amount: 1),
        duration: 16
    )
    
    static let highSpeedConnectorRecipe1 = Recipe(
        id: "recipe-alternate-silicon-high-speed-connector",
        inputs: [
            Recipe.Ingredient(V2.Parts.quickwire, amount: 60),
            Recipe.Ingredient(V2.Parts.silica, amount: 25),
            Recipe.Ingredient(V2.Parts.circuitBoard, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.highSpeedConnector, amount: 2),
        duration: 40,
        isDefault: false
    )
    
    // MARK: - Communications
    static let computerRecipe = Recipe(
        id: "recipe-computer",
        inputs: [
            Recipe.Ingredient(V2.Parts.circuitBoard, amount: 10),
            Recipe.Ingredient(V2.Parts.cable, amount: 9),
            Recipe.Ingredient(V2.Parts.plastic, amount: 18),
            Recipe.Ingredient(V2.Parts.screw, amount: 52)
        ],
        output: Recipe.Ingredient(V2.Parts.computer, amount: 1),
        duration: 24
    )
    
    static let computerRecipe2 = Recipe(
        id: "recipe-alternate-caterium-computer",
        inputs: [
            Recipe.Ingredient(V2.Parts.circuitBoard, amount: 7),
            Recipe.Ingredient(V2.Parts.quickwire, amount: 28),
            Recipe.Ingredient(V2.Parts.rubber, amount: 12)
        ],
        output: Recipe.Ingredient(V2.Parts.computer, amount: 1),
        duration: 16,
        isDefault: false
    )
    
    static let crystalOscillatorRecipe = Recipe(
        id: "recipe-crystal-oscillator",
        inputs: [
            Recipe.Ingredient(V2.Parts.quartzCrystal, amount: 36),
            Recipe.Ingredient(V2.Parts.cable, amount: 28),
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 5)
        ],
        output: Recipe.Ingredient(V2.Parts.crystalOscillator, amount: 2),
        duration: 120
    )
    
    static let crystalOscillatorRecipe1 = Recipe(
        id: "recipe-alternate-insulated-crystal-oscillator",
        inputs: [
            Recipe.Ingredient(V2.Parts.quartzCrystal, amount: 10),
            Recipe.Ingredient(V2.Parts.rubber, amount: 7),
            Recipe.Ingredient(V2.Parts.aiLimiter, amount: 1)
        ],
        output: Recipe.Ingredient(V2.Parts.crystalOscillator, amount: 1),
        duration: 32,
        isDefault: false
    )
    
    static let supercomputerRecipe = Recipe(
        id: "recipe-supercomputer",
        inputs: [
            Recipe.Ingredient(V2.Parts.computer, amount: 2),
            Recipe.Ingredient(V2.Parts.aiLimiter, amount: 2),
            Recipe.Ingredient(V2.Parts.highSpeedConnector, amount: 3),
            Recipe.Ingredient(V2.Parts.plastic, amount: 28)
        ],
        output: Recipe.Ingredient(V2.Parts.supercomputer, amount: 1),
        duration: 32
    )
    
    static let supercomputerRecipe1 = Recipe(
        id: "recipe-alternate-super-state-computer",
        inputs: [
            Recipe.Ingredient(V2.Parts.computer, amount: 3),
            Recipe.Ingredient(V2.Parts.electromagneticControlRod, amount: 2),
            Recipe.Ingredient(V2.Parts.battery, amount: 20),
            Recipe.Ingredient(V2.Parts.wire, amount: 45)
        ],
        output: Recipe.Ingredient(V2.Parts.supercomputer, amount: 2),
        duration: 50,
        isDefault: false
    )
    
    static let radioControlUnitRecipe = Recipe(
        id: "recipe-radio-control-unit",
        inputs: [
            Recipe.Ingredient(V2.Parts.aluminumCasing, amount: 32),
            Recipe.Ingredient(V2.Parts.crystalOscillator, amount: 1),
            Recipe.Ingredient(V2.Parts.computer, amount: 1)
        ],
        output: Recipe.Ingredient(V2.Parts.radioControlUnit, amount: 2),
        duration: 48
    )
    
    static let radioControlUnitRecipe1 = Recipe(
        id: "recipe-alternate-radion-connection-unit",
        inputs: [
            Recipe.Ingredient(V2.Parts.heatSink, amount: 4),
            Recipe.Ingredient(V2.Parts.highSpeedConnector, amount: 2),
            Recipe.Ingredient(V2.Parts.quartzCrystal, amount: 12)
        ],
        output: Recipe.Ingredient(V2.Parts.radioControlUnit, amount: 1),
        duration: 16,
        isDefault: false
    )
    
    static let radioControlUnitRecipe2 = Recipe(
        id: "recipe-alternate-radio-control-system",
        inputs: [
            Recipe.Ingredient(V2.Parts.crystalOscillator, amount: 1),
            Recipe.Ingredient(V2.Parts.circuitBoard, amount: 10),
            Recipe.Ingredient(V2.Parts.aluminumCasing, amount: 60),
            Recipe.Ingredient(V2.Parts.rubber, amount: 30)
        ],
        output: Recipe.Ingredient(V2.Parts.radioControlUnit, amount: 3),
        duration: 40,
        isDefault: false
    )
    
    // MARK: - Nuclear
    static let uraniumFuelRodRecipe = Recipe(
        id: "recipe-uranium-fuel-rod",
        inputs: [
            Recipe.Ingredient(V2.Parts.encasedUraniumCell, amount: 50),
            Recipe.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 3),
            Recipe.Ingredient(V2.Parts.electromagneticControlRod, amount: 5)
        ],
        output: Recipe.Ingredient(V2.Parts.uraniumFuelRod, amount: 1),
        duration: 150
    )
    
    static let uraniumFuelRodRecipe1 = Recipe(
        id: "recipe-alternate-uranium-fuel-unit",
        inputs: [
            Recipe.Ingredient(V2.Parts.encasedUraniumCell, amount: 100),
            Recipe.Ingredient(V2.Parts.electromagneticControlRod, amount: 10),
            Recipe.Ingredient(V2.Parts.crystalOscillator, amount: 3),
            Recipe.Ingredient(V2.Equipment.beacon, amount: 6)
        ],
        output: Recipe.Ingredient(V2.Parts.uraniumFuelRod, amount: 3),
        duration: 300,
        isDefault: false
    )
    
    static let encasedUraniumCellRecipe1 = Recipe(
        id: "recipe-alternate-infused-uranium-cell",
        inputs: [
            Recipe.Ingredient(V2.Parts.uranium, amount: 5),
            Recipe.Ingredient(V2.Parts.silica, amount: 3),
            Recipe.Ingredient(V2.Parts.sulfur, amount: 5),
            Recipe.Ingredient(V2.Parts.quickwire, amount: 15)
        ],
        output: Recipe.Ingredient(V2.Parts.encasedUraniumCell, amount: 4),
        duration: 12,
        isDefault: false
    )
    
    static let plutoniumFuelRodRecipe = Recipe(
        id: "recipe-plutonium-fuel-rod",
        inputs: [
            Recipe.Ingredient(V2.Parts.encasedPlutoniumCell, amount: 30),
            Recipe.Ingredient(V2.Parts.steelBeam, amount: 18),
            Recipe.Ingredient(V2.Parts.electromagneticControlRod, amount: 6),
            Recipe.Ingredient(V2.Parts.heatSink, amount: 10)
        ],
        output: Recipe.Ingredient(V2.Parts.plutoniumFuelRod, amount: 1),
        duration: 240
    )
    
    // MARK: - Consumed
    static let gasFilterRecipe = Recipe(
        id: "recipe-gas-filter",
        inputs: [
            Recipe.Ingredient(V2.Parts.coal, amount: 5),
            Recipe.Ingredient(V2.Parts.rubber, amount: 2),
            Recipe.Ingredient(V2.Parts.fabric, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.gasFilter, amount: 1),
        duration: 8
    )
    
    static let iodineInfusedFilterRecipe = Recipe(
        id: "recipe-iodine-infused-filter",
        inputs: [
            Recipe.Ingredient(V2.Parts.gasFilter, amount: 1),
            Recipe.Ingredient(V2.Parts.quickwire, amount: 8),
            Recipe.Ingredient(V2.Parts.aluminumCasing, amount: 1)
        ],
        output: Recipe.Ingredient(V2.Parts.iodineInfusedFilter, amount: 1),
        duration: 16
    )
    
    static let rifleCartridgeRecipe = Recipe(
        id: "recipe-rifle-cartridge",
        inputs: [
            Recipe.Ingredient(V2.Equipment.beacon, amount: 1),
            Recipe.Ingredient(V2.Parts.steelPipe, amount: 10),
            Recipe.Ingredient(V2.Parts.blackPowder, amount: 10),
            Recipe.Ingredient(V2.Parts.rubber, amount: 10)
        ],
        output: Recipe.Ingredient(V2.Parts.rifleAmmo, amount: 5),
        duration: 20
    )
    
    // MARK: - Space Elevator
    static let modularEngineRecipe = Recipe(
        id: "recipe-modular-engine",
        inputs: [
            Recipe.Ingredient(V2.Parts.motor, amount: 2),
            Recipe.Ingredient(V2.Parts.rubber, amount: 15),
            Recipe.Ingredient(V2.Parts.smartPlating, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.modularEngine, amount: 1),
        duration: 60
    )
    
    static let adaptiveControlUnitRecipe = Recipe(
        id: "recipe-adaptive-control-unit",
        inputs: [
            Recipe.Ingredient(V2.Parts.automatedWiring, amount: 15),
            Recipe.Ingredient(V2.Parts.circuitBoard, amount: 10),
            Recipe.Ingredient(V2.Parts.heavyModularFrame, amount: 2),
            Recipe.Ingredient(V2.Parts.computer, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.adaptiveControlUnit, amount: 2),
        duration: 120
    )
    
    static let magneticFieldGeneratorRecipe = Recipe(
        id: "recipe-magnetic-field-generator",
        inputs: [
            Recipe.Ingredient(V2.Parts.versatileFramework, amount: 5),
            Recipe.Ingredient(V2.Parts.electromagneticControlRod, amount: 2),
            Recipe.Ingredient(V2.Parts.battery, amount: 10)
        ],
        output: Recipe.Ingredient(V2.Parts.magneticFieldGenerator, amount: 2),
        duration: 120
    )
    
    static let thermalPropulsionRocketRecipe = Recipe(
        id: "recipe-thermal-propulsion-rocket",
        inputs: [
            Recipe.Ingredient(V2.Parts.modularEngine, amount: 5),
            Recipe.Ingredient(V2.Parts.turboMotor, amount: 2),
            Recipe.Ingredient(V2.Parts.coolingSystem, amount: 6),
            Recipe.Ingredient(V2.Parts.fusedModularFrame, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.thermalPropulsionRocket, amount: 2),
        duration: 120
    )
    
    static let smartPlatingRecipe1 = Recipe(
        id: "recipe-alternate-plastic-smart-plating",
        inputs: [
            Recipe.Ingredient(V2.Parts.reinforcedIronPlate, amount: 1),
            Recipe.Ingredient(V2.Parts.rotor, amount: 1),
            Recipe.Ingredient(V2.Parts.plastic, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.smartPlating, amount: 2),
        duration: 24,
        isDefault: false
    )
    
    static let versatileFrameworkRecipe1 = Recipe(
        id: "recipe-alternate-flexible-framework",
        inputs: [
            Recipe.Ingredient(V2.Parts.modularFrame, amount: 1),
            Recipe.Ingredient(V2.Parts.steelBeam, amount: 6),
            Recipe.Ingredient(V2.Parts.rubber, amount: 8)
        ],
        output: Recipe.Ingredient(V2.Parts.versatileFramework, amount: 2),
        duration: 16,
        isDefault: false
    )
    
    static let automatedWiringRecipe1 = Recipe(
        id: "recipe-alternate-automated-speed-wiring",
        inputs: [
            Recipe.Ingredient(V2.Parts.stator, amount: 2),
            Recipe.Ingredient(V2.Parts.wire, amount: 40),
            Recipe.Ingredient(V2.Parts.highSpeedConnector, amount: 1)
        ],
        output: Recipe.Ingredient(V2.Parts.automatedWiring, amount: 4),
        duration: 32,
        isDefault: false
    )
    
    // MARK: - Hands
    static let beaconRecipe = Recipe(
        id: "recipe-beacon",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironPlate, amount: 3),
            Recipe.Ingredient(V2.Parts.ironRod, amount: 1),
            Recipe.Ingredient(V2.Parts.wire, amount: 15),
            Recipe.Ingredient(V2.Parts.cable, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Equipment.beacon, amount: 1),
        duration: 8
    )
    
    static let beaconRecipe1 = Recipe(
        id: "recipe-alternate-crystal-beacon",
        inputs: [
            Recipe.Ingredient(V2.Parts.steelBeam, amount: 4),
            Recipe.Ingredient(V2.Parts.steelPipe, amount: 16),
            Recipe.Ingredient(V2.Parts.crystalOscillator, amount: 1)
        ],
        output: Recipe.Ingredient(V2.Equipment.beacon, amount: 20),
        duration: 120,
        isDefault: false
    )
    
    static let portableMinerRecipe1 = Recipe(
        id: "recipe-alternate-automated-miner",
        inputs: [
            Recipe.Ingredient(V2.Parts.motor, amount: 1),
            Recipe.Ingredient(V2.Parts.steelPipe, amount: 4),
            Recipe.Ingredient(V2.Parts.ironRod, amount: 4),
            Recipe.Ingredient(V2.Parts.ironPlate, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Equipment.portableMiner, amount: 1),
        duration: 60,
        isDefault: false
    )
    
    // MARK: - Ammunition
    static let explosiveRebarRecipe = Recipe(
        id: "recipe-explosive-rebar",
        inputs: [
            Recipe.Ingredient(V2.Parts.ironRebar, amount: 2),
            Recipe.Ingredient(V2.Parts.smokelessPowder, amount: 2),
            Recipe.Ingredient(V2.Parts.steelPipe, amount: 2)
        ],
        output: Recipe.Ingredient(V2.Parts.explosiveRebar, amount: 1),
        duration: 12
    )
    
    static let nukeNobeliskRecipe = Recipe(
        id: "recipe-nuke-nobelisk",
        inputs: [
            Recipe.Ingredient(V2.Parts.nobelisk, amount: 5),
            Recipe.Ingredient(V2.Parts.encasedUraniumCell, amount: 20),
            Recipe.Ingredient(V2.Parts.smokelessPowder, amount: 10),
            Recipe.Ingredient(V2.Parts.aiLimiter, amount: 6)
        ],
        output: Recipe.Ingredient(V2.Parts.nukeNobelisk, amount: 1),
        duration: 120
    )
    
    static let turboRifleAmmoRecipe = Recipe(
        id: "recipe-turbo-rifle-ammo",
        inputs: [
            Recipe.Ingredient(V2.Parts.rifleAmmo, amount: 25),
            Recipe.Ingredient(V2.Parts.aluminumCasing, amount: 3),
            Recipe.Ingredient(V2.Parts.packagedTurbofuel, amount: 3)
        ],
        output: Recipe.Ingredient(V2.Parts.turboRifleAmmo, amount: 50),
        duration: 12
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
