import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(
        id: String,
        output: Ingredient,
        input: [Ingredient]
    ) {
        self.init(
            id: id,
            output: [output],
            input: input
        )
    }
}

extension Legacy.Recipes {
    // Standard Parts
    static let heavyModularFrameRecipe = Recipe.Static.Legacy(
        id: "heavy-modular-frame",
        output: .init(Legacy.Parts.heavyModularFrame),
        input: [
            .init(Legacy.Parts.modularFrame),
            .init(Legacy.Parts.steelPipe),
            .init(Legacy.Parts.encasedIndustrialBeam),
            .init(Legacy.Parts.screw)
        ]
    )

    static let heavyModularFrameRecipe1 = Recipe.Static.Legacy(
        id: "alternate-heavy-flexible-frame",
        output: .init(Legacy.Parts.heavyModularFrame),
        input: [
            .init(Legacy.Parts.modularFrame),
            .init(Legacy.Parts.encasedIndustrialBeam),
            .init(Legacy.Parts.rubber),
            .init(Legacy.Parts.screw)
        ]
    )

    static let heavyModularFrameRecipe2 = Recipe.Static.Legacy(
        id: "alternate-heavy-encased-frame",
        output: .init(Legacy.Parts.heavyModularFrame),
        input: [
            .init(Legacy.Parts.modularFrame),
            .init(Legacy.Parts.encasedIndustrialBeam),
            .init(Legacy.Parts.steelPipe),
            .init(Legacy.Parts.concrete)
        ]
    )

    // Industrial Parts
    static let turboMotorRecipe = Recipe.Static.Legacy(
        id: "turbo-motor",
        output: .init(Legacy.Parts.turboMotor),
        input: [
            .init(Legacy.Parts.coolingSystem),
            .init(Legacy.Parts.radioControlUnit),
            .init(Legacy.Parts.motor),
            .init(Legacy.Parts.rubber)
        ]
    )

    static let turboMotorRecipe1 = Recipe.Static.Legacy(
        id: "alternate-turbo-electric-motor",
        output: .init(Legacy.Parts.turboMotor),
        input: [
            .init(Legacy.Parts.motor),
            .init(Legacy.Parts.radioControlUnit),
            .init(Legacy.Parts.electromagneticControlRod),
            .init(Legacy.Parts.rotor)
        ]
    )

    static let turboMotorRecipe2 = Recipe.Static.Legacy(
        id: "alternate-turbo-pressure-motor",
        output: .init(Legacy.Parts.turboMotor),
        input: [
            .init(Legacy.Parts.motor),
            .init(Legacy.Parts.pressureConversionCube),
            .init(Legacy.Parts.packagedNitrogenGas),
            .init(Legacy.Parts.stator)
        ]
    )

    static let motorRecipe2 = Recipe.Static.Legacy(
        id: "alternate-rigour-motor",
        output: .init(Legacy.Parts.motor),
        input: [
            .init(Legacy.Parts.rotor),
            .init(Legacy.Parts.stator),
            .init(Legacy.Parts.crystalOscillator)
        ]
    )

    static let batteryRecipe1 = Recipe.Static.Legacy(
        id: "alternate-classic-battery",
        output: .init(Legacy.Parts.battery),
        input: [
            .init(Legacy.Parts.sulfur),
            .init(Legacy.Parts.alcladAluminumSheet),
            .init(Legacy.Parts.plastic),
            .init(Legacy.Parts.wire)
        ]
    )

    // Electronics
    static let highSpeedConnectorRecipe = Recipe.Static.Legacy(
        id: "high-speed-connector",
        output: .init(Legacy.Parts.highSpeedConnector),
        input: [
            .init(Legacy.Parts.quickwire),
            .init(Legacy.Parts.cable),
            .init(Legacy.Parts.circuitBoard)
        ]
    )

    static let highSpeedConnectorRecipe1 = Recipe.Static.Legacy(
        id: "alternate-silicone-high-speed-connector",
        output: .init(Legacy.Parts.highSpeedConnector),
        input: [
            .init(Legacy.Parts.quickwire),
            .init(Legacy.Parts.silica),
            .init(Legacy.Parts.circuitBoard)
        ]
    )

    // Communications
    static let computerRecipe = Recipe.Static.Legacy(
        id: "computer",
        output: .init(Legacy.Parts.computer),
        input: [
            .init(Legacy.Parts.circuitBoard),
            .init(Legacy.Parts.cable),
            .init(Legacy.Parts.plastic),
            .init(Legacy.Parts.screw)
        ]
    )

    static let computerRecipe2 = Recipe.Static.Legacy(
        id: "alternate-caterium-computer",
        output: .init(Legacy.Parts.computer),
        input: [
            .init(Legacy.Parts.circuitBoard),
            .init(Legacy.Parts.quickwire),
            .init(Legacy.Parts.rubber)
        ]
    )

    static let crystalOscillatorRecipe = Recipe.Static.Legacy(
        id: "crystal-oscillator",
        output: .init(Legacy.Parts.crystalOscillator),
        input: [
            .init(Legacy.Parts.quartzCrystal),
            .init(Legacy.Parts.cable),
            .init(Legacy.Parts.reinforcedIronPlate)
        ]
    )

    static let crystalOscillatorRecipe1 = Recipe.Static.Legacy(
        id: "alternate-insulated-crystal-oscillator",
        output: .init(Legacy.Parts.crystalOscillator),
        input: [
            .init(Legacy.Parts.quartzCrystal),
            .init(Legacy.Parts.rubber),
            .init(Legacy.Parts.aiLimiter)
        ]
    )

    static let supercomputerRecipe = Recipe.Static.Legacy(
        id: "supercomputer",
        output: .init(Legacy.Parts.supercomputer),
        input: [
            .init(Legacy.Parts.computer),
            .init(Legacy.Parts.aiLimiter),
            .init(Legacy.Parts.highSpeedConnector),
            .init(Legacy.Parts.plastic)
        ]
    )

    static let supercomputerRecipe1 = Recipe.Static.Legacy(
        id: "alternate-super-state-computer",
        output: .init(Legacy.Parts.supercomputer),
        input: [
            .init(Legacy.Parts.computer),
            .init(Legacy.Parts.electromagneticControlRod),
            .init(Legacy.Parts.battery),
            .init(Legacy.Parts.wire)
        ]
    )

    static let radioControlUnitRecipe = Recipe.Static.Legacy(
        id: "radio-control-unit",
        output: .init(Legacy.Parts.radioControlUnit),
        input: [
            .init(Legacy.Parts.aluminumCasing),
            .init(Legacy.Parts.crystalOscillator),
            .init(Legacy.Parts.computer)
        ]
    )

    static let radioControlUnitRecipe1 = Recipe.Static.Legacy(
        id: "alternate-radio-connection-unit",
        output: .init(Legacy.Parts.radioControlUnit),
        input: [
            .init(Legacy.Parts.heatSink),
            .init(Legacy.Parts.highSpeedConnector),
            .init(Legacy.Parts.quartzCrystal)
        ]
    )

    static let radioControlUnitRecipe2 = Recipe.Static.Legacy(
        id: "alternate-radio-control-system",
        output: .init(Legacy.Parts.radioControlUnit),
        input: [
            .init(Legacy.Parts.crystalOscillator),
            .init(Legacy.Parts.circuitBoard),
            .init(Legacy.Parts.aluminumCasing),
            .init(Legacy.Parts.rubber)
        ]
    )

    // Nuclear
    static let uraniumFuelRodRecipe = Recipe.Static.Legacy(
        id: "uranium-fuel-rod",
        output: .init(Legacy.Parts.uraniumFuelRod),
        input: [
            .init(Legacy.Parts.encasedUraniumCell),
            .init(Legacy.Parts.encasedIndustrialBeam),
            .init(Legacy.Parts.electromagneticControlRod)
        ]
    )

    static let uraniumFuelRodRecipe1 = Recipe.Static.Legacy(
        id: "alternate-uranium-fuel-unit",
        output: .init(Legacy.Parts.uraniumFuelRod),
        input: [
            .init(Legacy.Parts.encasedUraniumCell),
            .init(Legacy.Parts.electromagneticControlRod),
            .init(Legacy.Parts.crystalOscillator),
            .init(Legacy.Equipment.beacon)
        ]
    )

    static let encasedUraniumCellRecipe1 = Recipe.Static.Legacy(
        id: "alternate-infused-uranium-cell",
        output: .init(Legacy.Parts.encasedUraniumCell),
        input: [
            .init(Legacy.Parts.uranium),
            .init(Legacy.Parts.silica),
            .init(Legacy.Parts.sulfur),
            .init(Legacy.Parts.quickwire)
        ]
    )

    static let plutoniumFuelRodRecipe = Recipe.Static.Legacy(
        id: "plutonium-fuel-rod",
        output: .init(Legacy.Parts.plutoniumFuelRod),
        input: [
            .init(Legacy.Parts.encasedPlutoniumCell),
            .init(Legacy.Parts.steelBeam),
            .init(Legacy.Parts.electromagneticControlRod),
            .init(Legacy.Parts.heatSink)
        ]
    )

    // Consumed
    static let gasFilterRecipe = Recipe.Static.Legacy(
        id: "gas-filter",
        output: .init(Legacy.Parts.gasFilter),
        input: [
            .init(Legacy.Parts.coal),
            .init(Legacy.Parts.rubber),
            .init(Legacy.Parts.fabric)
        ]
    )

    static let iodineInfusedFilterRecipe = Recipe.Static.Legacy(
        id: "iodine-infused-filter",
        output: .init(Legacy.Parts.iodineInfusedFilter),
        input: [
            .init(Legacy.Parts.gasFilter),
            .init(Legacy.Parts.quickwire),
            .init(Legacy.Parts.aluminumCasing)
        ]
    )

    static let explosiveRebarRecipe = Recipe.Static.Legacy(
        id: "explosive-rebar",
        output: .init(Legacy.Parts.explosiveRebar),
        input: [
            .init(Legacy.Parts.ironRebar),
            .init(Legacy.Parts.smokelessPowder),
            .init(Legacy.Parts.steelPipe)
        ]
    )

    static let turboRifleAmmoRecipe = Recipe.Static.Legacy(
        id: "turbo-rifle-ammo-manufacturer",
        output: .init(Legacy.Parts.turboRifleAmmo),
        input: [
            .init(Legacy.Parts.rifleAmmo),
            .init(Legacy.Parts.aluminumCasing),
            .init(Legacy.Parts.packagedTurbofuel)
        ]
    )

    static let nukeNobeliskRecipe = Recipe.Static.Legacy(
        id: "nuke-nobelisk",
        output: .init(Legacy.Parts.nukeNobelisk),
        input: [
            .init(Legacy.Parts.nobelisk),
            .init(Legacy.Parts.encasedUraniumCell),
            .init(Legacy.Parts.smokelessPowder),
            .init(Legacy.Parts.aiLimiter)
        ]
    )

    // Space Elevator
    static let modularEngineRecipe = Recipe.Static.Legacy(
        id: "modular-engine",
        output: .init(Legacy.Parts.modularEngine),
        input: [
            .init(Legacy.Parts.motor),
            .init(Legacy.Parts.rubber),
            .init(Legacy.Parts.smartPlating)
        ]
    )

    static let adaptiveControlUnitRecipe = Recipe.Static.Legacy(
        id: "adaptive-control-unit",
        output: .init(Legacy.Parts.adaptiveControlUnit),
        input: [
            .init(Legacy.Parts.automatedWiring),
            .init(Legacy.Parts.circuitBoard),
            .init(Legacy.Parts.heavyModularFrame),
            .init(Legacy.Parts.computer)
        ]
    )

    static let magneticFieldGeneratorRecipe = Recipe.Static.Legacy(
        id: "magnetic-field-generator",
        output: .init(Legacy.Parts.magneticFieldGenerator),
        input: [
            .init(Legacy.Parts.versatileFramework),
            .init(Legacy.Parts.electromagneticControlRod),
            .init(Legacy.Parts.battery)
        ]
    )

    static let thermalPropulsionRocketRecipe = Recipe.Static.Legacy(
        id: "thermal-propulsion-rocket",
        output: .init(Legacy.Parts.thermalPropulsionRocket),
        input: [
            .init(Legacy.Parts.modularEngine),
            .init(Legacy.Parts.turboMotor),
            .init(Legacy.Parts.coolingSystem),
            .init(Legacy.Parts.fusedModularFrame)
        ]
    )

    static let smartPlatingRecipe1 = Recipe.Static.Legacy(
        id: "alternate-plastic-smart-plating",
        output: .init(Legacy.Parts.smartPlating),
        input: [
            .init(Legacy.Parts.reinforcedIronPlate),
            .init(Legacy.Parts.rotor),
            .init(Legacy.Parts.plastic)
        ]
    )

    static let versatileFrameworkRecipe1 = Recipe.Static.Legacy(
        id: "alternate-flexible-framework",
        output: .init(Legacy.Parts.versatileFramework),
        input: [
            .init(Legacy.Parts.modularFrame),
            .init(Legacy.Parts.steelBeam),
            .init(Legacy.Parts.rubber)
        ]
    )

    static let automatedWiringRecipe1 = Recipe.Static.Legacy(
        id: "alternate-automated-speed-wiring",
        output: .init(Legacy.Parts.automatedWiring),
        input: [
            .init(Legacy.Parts.stator),
            .init(Legacy.Parts.wire),
            .init(Legacy.Parts.highSpeedConnector)
        ]
    )

    // Hands
    static let beaconRecipe = Recipe.Static.Legacy(
        id: "beacon",
        output: .init(Legacy.Equipment.beacon),
        input: [
            .init(Legacy.Parts.ironPlate),
            .init(Legacy.Parts.ironRod),
            .init(Legacy.Parts.wire),
            .init(Legacy.Parts.cable)
        ]
    )

    static let beaconRecipe1 = Recipe.Static.Legacy(
        id: "alternate-crystal-beacon",
        output: .init(Legacy.Equipment.beacon),
        input: [
            .init(Legacy.Parts.steelBeam),
            .init(Legacy.Parts.steelPipe),
            .init(Legacy.Parts.crystalOscillator)
        ]
    )

    static let portableMinerRecipe1 = Recipe.Static.Legacy(
        id: "alternate-automated-miner",
        output: .init(Legacy.Equipment.portableMiner),
        input: [
            .init(Legacy.Parts.motor),
            .init(Legacy.Parts.steelPipe),
            .init(Legacy.Parts.ironRod),
            .init(Legacy.Parts.ironPlate)
        ]
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
