import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        name: String,
        input: [Ingredient],
        output: Ingredient,
        duration: Int,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            name: name,
            input: input,
            output: [output],
            machines: [Legacy.Buildings.manufacturer.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // Standard Parts
    static let heavyModularFrameRecipe = Recipe.Static.Legacy(
        id: "heavy-modular-frame",
        name: "Heavy Modular Frame",
        input: [
            .init(Legacy.Parts.modularFrame, amount: 5),
            .init(Legacy.Parts.steelPipe, amount: 15),
            .init(Legacy.Parts.encasedIndustrialBeam, amount: 5),
            .init(Legacy.Parts.screw, amount: 100)
        ],
        output: .init(Legacy.Parts.heavyModularFrame, amount: 1),
        duration: 30
    )

    static let heavyModularFrameRecipe1 = Recipe.Static.Legacy(
        id: "alternate-heavy-flexible-frame",
        name: "Alternate: Heavy Flexible Frame",
        input: [
            .init(Legacy.Parts.modularFrame, amount: 5),
            .init(Legacy.Parts.encasedIndustrialBeam, amount: 3),
            .init(Legacy.Parts.rubber, amount: 20),
            .init(Legacy.Parts.screw, amount: 104)
        ],
        output: .init(Legacy.Parts.heavyModularFrame, amount: 1),
        duration: 16,
        isDefault: false
    )

    static let heavyModularFrameRecipe2 = Recipe.Static.Legacy(
        id: "alternate-heavy-encased-frame",
        name: "Alternate: Heavy Encased Frame",
        input: [
            .init(Legacy.Parts.modularFrame, amount: 8),
            .init(Legacy.Parts.encasedIndustrialBeam, amount: 10),
            .init(Legacy.Parts.steelPipe, amount: 36),
            .init(Legacy.Parts.concrete, amount: 22)
        ],
        output: .init(Legacy.Parts.heavyModularFrame, amount: 3),
        duration: 64,
        isDefault: false
    )

    // Industrial Parts
    static let turboMotorRecipe = Recipe.Static.Legacy(
        id: "turbo-motor",
        name: "Turbo Motor",
        input: [
            .init(Legacy.Parts.coolingSystem, amount: 4),
            .init(Legacy.Parts.radioControlUnit, amount: 2),
            .init(Legacy.Parts.motor, amount: 4),
            .init(Legacy.Parts.rubber, amount: 24)
        ],
        output: .init(Legacy.Parts.turboMotor, amount: 1),
        duration: 32
    )

    static let turboMotorRecipe1 = Recipe.Static.Legacy(
        id: "alternate-turbo-electric-motor",
        name: "Alternate: Turbo Electric Motor",
        input: [
            .init(Legacy.Parts.motor, amount: 7),
            .init(Legacy.Parts.radioControlUnit, amount: 9),
            .init(Legacy.Parts.electromagneticControlRod, amount: 5),
            .init(Legacy.Parts.rotor, amount: 7)
        ],
        output: .init(Legacy.Parts.turboMotor, amount: 3),
        duration: 64,
        isDefault: false
    )

    static let turboMotorRecipe2 = Recipe.Static.Legacy(
        id: "alternate-turbo-pressure-motor",
        name: "Alternate: Turbo Pressure Motor",
        input: [
            .init(Legacy.Parts.motor, amount: 4),
            .init(Legacy.Parts.pressureConversionCube, amount: 1),
            .init(Legacy.Parts.packagedNitrogenGas, amount: 24),
            .init(Legacy.Parts.stator, amount: 8)
        ],
        output: .init(Legacy.Parts.turboMotor, amount: 2),
        duration: 32,
        isDefault: false
    )

    static let motorRecipe2 = Recipe.Static.Legacy(
        id: "alternate-rigour-motor",
        name: "Alternate: Rigour Motor",
        input: [
            .init(Legacy.Parts.rotor, amount: 3),
            .init(Legacy.Parts.stator, amount: 3),
            .init(Legacy.Parts.crystalOscillator, amount: 1)
        ],
        output: .init(Legacy.Parts.motor, amount: 6),
        duration: 48,
        isDefault: false
    )

    static let batteryRecipe1 = Recipe.Static.Legacy(
        id: "alternate-classic-battery",
        name: "Alternate: Classic Battery",
        input: [
            .init(Legacy.Parts.sulfur, amount: 6),
            .init(Legacy.Parts.alcladAluminumSheet, amount: 7),
            .init(Legacy.Parts.plastic, amount: 8),
            .init(Legacy.Parts.wire, amount: 12)
        ],
        output: .init(Legacy.Parts.battery, amount: 4),
        duration: 8,
        isDefault: false
    )

    // Electronics
    static let highSpeedConnectorRecipe = Recipe.Static.Legacy(
        id: "high-speed-connector",
        name: "High-Speed Connector",
        input: [
            .init(Legacy.Parts.quickwire, amount: 56),
            .init(Legacy.Parts.cable, amount: 10),
            .init(Legacy.Parts.circuitBoard, amount: 1)
        ],
        output: .init(Legacy.Parts.highSpeedConnector, amount: 1),
        duration: 16
    )

    static let highSpeedConnectorRecipe1 = Recipe.Static.Legacy(
        id: "alternate-silicone-high-speed-connector",
        name: "Alternate: Silicone High-Speed Connector",
        input: [
            .init(Legacy.Parts.quickwire, amount: 60),
            .init(Legacy.Parts.silica, amount: 25),
            .init(Legacy.Parts.circuitBoard, amount: 2)
        ],
        output: .init(Legacy.Parts.highSpeedConnector, amount: 2),
        duration: 40,
        isDefault: false
    )

    // Communications
    static let computerRecipe = Recipe.Static.Legacy(
        id: "computer",
        name: "Computer",
        input: [
            .init(Legacy.Parts.circuitBoard, amount: 10),
            .init(Legacy.Parts.cable, amount: 9),
            .init(Legacy.Parts.plastic, amount: 18),
            .init(Legacy.Parts.screw, amount: 52)
        ],
        output: .init(Legacy.Parts.computer, amount: 1),
        duration: 24
    )

    static let computerRecipe2 = Recipe.Static.Legacy(
        id: "alternate-caterium-computer",
        name: "Alternate: Caterium Computer",
        input: [
            .init(Legacy.Parts.circuitBoard, amount: 7),
            .init(Legacy.Parts.quickwire, amount: 28),
            .init(Legacy.Parts.rubber, amount: 12)
        ],
        output: .init(Legacy.Parts.computer, amount: 1),
        duration: 16,
        isDefault: false
    )

    static let crystalOscillatorRecipe = Recipe.Static.Legacy(
        id: "crystal-oscillator",
        name: "Crystal Oscillator",
        input: [
            .init(Legacy.Parts.quartzCrystal, amount: 36),
            .init(Legacy.Parts.cable, amount: 28),
            .init(Legacy.Parts.reinforcedIronPlate, amount: 5)
        ],
        output: .init(Legacy.Parts.crystalOscillator, amount: 2),
        duration: 120
    )

    static let crystalOscillatorRecipe1 = Recipe.Static.Legacy(
        id: "alternate-insulated-crystal-oscillator",
        name: "Alternate: Insulated Crystal Oscillator",
        input: [
            .init(Legacy.Parts.quartzCrystal, amount: 10),
            .init(Legacy.Parts.rubber, amount: 7),
            .init(Legacy.Parts.aiLimiter, amount: 1)
        ],
        output: .init(Legacy.Parts.crystalOscillator, amount: 1),
        duration: 32,
        isDefault: false
    )

    static let supercomputerRecipe = Recipe.Static.Legacy(
        id: "supercomputer",
        name: "Supercomputer",
        input: [
            .init(Legacy.Parts.computer, amount: 2),
            .init(Legacy.Parts.aiLimiter, amount: 2),
            .init(Legacy.Parts.highSpeedConnector, amount: 3),
            .init(Legacy.Parts.plastic, amount: 28)
        ],
        output: .init(Legacy.Parts.supercomputer, amount: 1),
        duration: 32
    )

    static let supercomputerRecipe1 = Recipe.Static.Legacy(
        id: "alternate-super-state-computer",
        name: "Alternate: Super-State Computer",
        input: [
            .init(Legacy.Parts.computer, amount: 3),
            .init(Legacy.Parts.electromagneticControlRod, amount: 2),
            .init(Legacy.Parts.battery, amount: 20),
            .init(Legacy.Parts.wire, amount: 45)
        ],
        output: .init(Legacy.Parts.supercomputer, amount: 2),
        duration: 50,
        isDefault: false
    )

    static let radioControlUnitRecipe = Recipe.Static.Legacy(
        id: "radio-control-unit",
        name: "Radio Control Unit",
        input: [
            .init(Legacy.Parts.aluminumCasing, amount: 32),
            .init(Legacy.Parts.crystalOscillator, amount: 1),
            .init(Legacy.Parts.computer, amount: 1)
        ],
        output: .init(Legacy.Parts.radioControlUnit, amount: 2),
        duration: 48
    )

    static let radioControlUnitRecipe1 = Recipe.Static.Legacy(
        id: "alternate-radio-connection-unit",
        name: "Alternate: Radio Connection Unit",
        input: [
            .init(Legacy.Parts.heatSink, amount: 4),
            .init(Legacy.Parts.highSpeedConnector, amount: 2),
            .init(Legacy.Parts.quartzCrystal, amount: 12)
        ],
        output: .init(Legacy.Parts.radioControlUnit, amount: 1),
        duration: 16,
        isDefault: false
    )

    static let radioControlUnitRecipe2 = Recipe.Static.Legacy(
        id: "alternate-radio-control-system",
        name: "Alternate: Radio Control System",
        input: [
            .init(Legacy.Parts.crystalOscillator, amount: 1),
            .init(Legacy.Parts.circuitBoard, amount: 10),
            .init(Legacy.Parts.aluminumCasing, amount: 60),
            .init(Legacy.Parts.rubber, amount: 30)
        ],
        output: .init(Legacy.Parts.radioControlUnit, amount: 3),
        duration: 40,
        isDefault: false
    )

    // Nuclear
    static let uraniumFuelRodRecipe = Recipe.Static.Legacy(
        id: "uranium-fuel-rod",
        name: "Uranium Fuel Rod",
        input: [
            .init(Legacy.Parts.encasedUraniumCell, amount: 50),
            .init(Legacy.Parts.encasedIndustrialBeam, amount: 3),
            .init(Legacy.Parts.electromagneticControlRod, amount: 5)
        ],
        output: .init(Legacy.Parts.uraniumFuelRod, amount: 1),
        duration: 150
    )

    static let uraniumFuelRodRecipe1 = Recipe.Static.Legacy(
        id: "alternate-uranium-fuel-unit",
        name: "Alternate: Uranium Fuel Unit",
        input: [
            .init(Legacy.Parts.encasedUraniumCell, amount: 100),
            .init(Legacy.Parts.electromagneticControlRod, amount: 10),
            .init(Legacy.Parts.crystalOscillator, amount: 3),
            .init(Legacy.Equipment.beacon, amount: 6)
        ],
        output: .init(Legacy.Parts.uraniumFuelRod, amount: 3),
        duration: 300,
        isDefault: false
    )

    static let encasedUraniumCellRecipe1 = Recipe.Static.Legacy(
        id: "alternate-infused-uranium-cell",
        name: "Alternate: Infused Uranium Cell",
        input: [
            .init(Legacy.Parts.uranium, amount: 5),
            .init(Legacy.Parts.silica, amount: 3),
            .init(Legacy.Parts.sulfur, amount: 5),
            .init(Legacy.Parts.quickwire, amount: 15)
        ],
        output: .init(Legacy.Parts.encasedUraniumCell, amount: 4),
        duration: 12,
        isDefault: false
    )

    static let plutoniumFuelRodRecipe = Recipe.Static.Legacy(
        id: "plutonium-fuel-rod",
        name: "Plutonium Fuel Rod",
        input: [
            .init(Legacy.Parts.encasedPlutoniumCell, amount: 30),
            .init(Legacy.Parts.steelBeam, amount: 18),
            .init(Legacy.Parts.electromagneticControlRod, amount: 6),
            .init(Legacy.Parts.heatSink, amount: 10)
        ],
        output: .init(Legacy.Parts.plutoniumFuelRod, amount: 1),
        duration: 240
    )

    // Consumed
    static let gasFilterRecipe = Recipe.Static.Legacy(
        id: "gas-filter",
        name: "Gas Filter",
        input: [
            .init(Legacy.Parts.coal, amount: 5),
            .init(Legacy.Parts.rubber, amount: 2),
            .init(Legacy.Parts.fabric, amount: 2)
        ],
        output: .init(Legacy.Parts.gasFilter, amount: 1),
        duration: 8
    )

    static let iodineInfusedFilterRecipe = Recipe.Static.Legacy(
        id: "iodine-infused-filter",
        name: "Iodine Infused Filter",
        input: [
            .init(Legacy.Parts.gasFilter, amount: 1),
            .init(Legacy.Parts.quickwire, amount: 8),
            .init(Legacy.Parts.aluminumCasing, amount: 1)
        ],
        output: .init(Legacy.Parts.iodineInfusedFilter, amount: 1),
        duration: 16
    )

    static let explosiveRebarRecipe = Recipe.Static.Legacy(
        id: "explosive-rebar",
        name: "Explosive Rebar",
        input: [
            .init(Legacy.Parts.ironRebar, amount: 2),
            .init(Legacy.Parts.smokelessPowder, amount: 2),
            .init(Legacy.Parts.steelPipe, amount: 2)
        ],
        output: .init(Legacy.Parts.explosiveRebar, amount: 1),
        duration: 12
    )

    static let turboRifleAmmoRecipe = Recipe.Static.Legacy(
        id: "turbo-rifle-ammo-manufacturer",
        name: "Turbo-Rifle Ammo",
        input: [
            .init(Legacy.Parts.rifleAmmo, amount: 25),
            .init(Legacy.Parts.aluminumCasing, amount: 3),
            .init(Legacy.Parts.packagedTurbofuel, amount: 3)
        ],
        output: .init(Legacy.Parts.turboRifleAmmo, amount: 15),
        duration: 24
    )

    static let nukeNobeliskRecipe = Recipe.Static.Legacy(
        id: "nuke-nobelisk",
        name: "Nuke Nobelisk",
        input: [
            .init(Legacy.Parts.nobelisk, amount: 5),
            .init(Legacy.Parts.encasedUraniumCell, amount: 20),
            .init(Legacy.Parts.smokelessPowder, amount: 10),
            .init(Legacy.Parts.aiLimiter, amount: 6)
        ],
        output: .init(Legacy.Parts.nukeNobelisk, amount: 1),
        duration: 120
    )

    // Space Elevator
    static let modularEngineRecipe = Recipe.Static.Legacy(
        id: "modular-engine",
        name: "Modular Engine",
        input: [
            .init(Legacy.Parts.motor, amount: 2),
            .init(Legacy.Parts.rubber, amount: 15),
            .init(Legacy.Parts.smartPlating, amount: 2)
        ],
        output: .init(Legacy.Parts.modularEngine, amount: 1),
        duration: 60
    )

    static let adaptiveControlUnitRecipe = Recipe.Static.Legacy(
        id: "adaptive-control-unit",
        name: "Adaptive Control Unit",
        input: [
            .init(Legacy.Parts.automatedWiring, amount: 15),
            .init(Legacy.Parts.circuitBoard, amount: 10),
            .init(Legacy.Parts.heavyModularFrame, amount: 2),
            .init(Legacy.Parts.computer, amount: 2)
        ],
        output: .init(Legacy.Parts.adaptiveControlUnit, amount: 2),
        duration: 120
    )

    static let magneticFieldGeneratorRecipe = Recipe.Static.Legacy(
        id: "magnetic-field-generator",
        name: "Magnetic Field Generator",
        input: [
            .init(Legacy.Parts.versatileFramework, amount: 5),
            .init(Legacy.Parts.electromagneticControlRod, amount: 2),
            .init(Legacy.Parts.battery, amount: 10)
        ],
        output: .init(Legacy.Parts.magneticFieldGenerator, amount: 2),
        duration: 120
    )

    static let thermalPropulsionRocketRecipe = Recipe.Static.Legacy(
        id: "thermal-propulsion-rocket",
        name: "Thermal Propulsion Rocket",
        input: [
            .init(Legacy.Parts.modularEngine, amount: 5),
            .init(Legacy.Parts.turboMotor, amount: 2),
            .init(Legacy.Parts.coolingSystem, amount: 6),
            .init(Legacy.Parts.fusedModularFrame, amount: 2)
        ],
        output: .init(Legacy.Parts.thermalPropulsionRocket, amount: 2),
        duration: 120
    )

    static let smartPlatingRecipe1 = Recipe.Static.Legacy(
        id: "alternate-plastic-smart-plating",
        name: "Alternate: Plastic Smart Plating",
        input: [
            .init(Legacy.Parts.reinforcedIronPlate, amount: 1),
            .init(Legacy.Parts.rotor, amount: 1),
            .init(Legacy.Parts.plastic, amount: 3)
        ],
        output: .init(Legacy.Parts.smartPlating, amount: 2),
        duration: 24,
        isDefault: false
    )

    static let versatileFrameworkRecipe1 = Recipe.Static.Legacy(
        id: "alternate-flexible-framework",
        name: "Alternate: Flexible Framework",
        input: [
            .init(Legacy.Parts.modularFrame, amount: 1),
            .init(Legacy.Parts.steelBeam, amount: 6),
            .init(Legacy.Parts.rubber, amount: 8)
        ],
        output: .init(Legacy.Parts.versatileFramework, amount: 2),
        duration: 16,
        isDefault: false
    )

    static let automatedWiringRecipe1 = Recipe.Static.Legacy(
        id: "alternate-automated-speed-wiring",
        name: "Alternate: Automated Speed Wiring",
        input: [
            .init(Legacy.Parts.stator, amount: 2),
            .init(Legacy.Parts.wire, amount: 40),
            .init(Legacy.Parts.highSpeedConnector, amount: 1)
        ],
        output: .init(Legacy.Parts.automatedWiring, amount: 4),
        duration: 32,
        isDefault: false
    )

    // Hands
    static let beaconRecipe = Recipe.Static.Legacy(
        id: "beacon",
        name: "Beacon",
        input: [
            .init(Legacy.Parts.ironPlate, amount: 3),
            .init(Legacy.Parts.ironRod, amount: 1),
            .init(Legacy.Parts.wire, amount: 15),
            .init(Legacy.Parts.cable, amount: 2)
        ],
        output: .init(Legacy.Equipment.beacon, amount: 1),
        duration: 8
    )

    static let beaconRecipe1 = Recipe.Static.Legacy(
        id: "alternate-crystal-beacon",
        name: "Alternate: Crystal Beacon",
        input: [
            .init(Legacy.Parts.steelBeam, amount: 4),
            .init(Legacy.Parts.steelPipe, amount: 16),
            .init(Legacy.Parts.crystalOscillator, amount: 1)
        ],
        output: .init(Legacy.Equipment.beacon, amount: 20),
        duration: 120,
        isDefault: false
    )

    static let portableMinerRecipe1 = Recipe.Static.Legacy(
        id: "alternate-automated-miner",
        name: "Alternate: Automated Miner",
        input: [
            .init(Legacy.Parts.motor, amount: 1),
            .init(Legacy.Parts.steelPipe, amount: 4),
            .init(Legacy.Parts.ironRod, amount: 4),
            .init(Legacy.Parts.ironPlate, amount: 2)
        ],
        output: .init(Legacy.Equipment.portableMiner, amount: 1),
        duration: 60,
        isDefault: false
    )

    static let manufacturerRecipes = [
        // Standard parts
        heavyModularFrameRecipe,
        heavyModularFrameRecipe1,
        heavyModularFrameRecipe2,
        
        // industrial parts
        turboMotorRecipe,
        turboMotorRecipe1,
        turboMotorRecipe2,
        motorRecipe2,
        batteryRecipe1,
        
        // Electronics
        highSpeedConnectorRecipe,
        highSpeedConnectorRecipe1,
        
        // Comunications
        computerRecipe,
        computerRecipe2,
        crystalOscillatorRecipe,
        crystalOscillatorRecipe1,
        supercomputerRecipe,
        supercomputerRecipe2,
        radioControlUnitRecipe,
        radioControlUnitRecipe1,
        radioControlUnitRecipe2,
        
        // Nuclear
        uraniumFuelRodRecipe,
        uraniumFuelRodRecipe1,
        encasedUraniumCellRecipe1,
        plutoniumFuelRodRecipe,
        
        // Consumed
        gasFilterRecipe,
        iodineInfusedFilterRecipe,
        explosiveRebarRecipe,
        turboRifleAmmoRecipe,
        nukeNobeliskRecipe,
        
        // Space Elevator
        modularEngineRecipe,
        adaptiveControlUnitRecipe,
        magneticFieldGeneratorRecipe,
        thermalPropulsionRocketRecipe,
        smartPlatingRecipe1,
        versatileFrameworkRecipe1,
        automatedWiringRecipe1,
        
        // Hands
        beaconRecipe,
        beaconRecipe1,
        portableMinerRecipe1
    ]
}
