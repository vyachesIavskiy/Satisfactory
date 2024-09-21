import SHModels
import SHStaticModels

private extension Recipe.Static {
    init(
        id: String,
        inputs: [Ingredient],
        output: Ingredient,
        duration: Double,
        isDefault: Bool = true
    ) {
        self.init(
            id: id,
            inputs: inputs,
            output: output,
            machine: V2.Buildings.manufacturer,
            duration: duration,
            powerConsumption: PowerConsumption(55),
            isDefault: isDefault
        )
    }
}

// MARK: - Space Elevator
extension V2.Recipes {
    static let plasticSmartPlatingRecipe = Recipe.Static(
        id: "recipe-alternate-plastic-smart-plating",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.smartPlating, amount: 2),
        duration: 24,
        isDefault: false
    )
    
    static let flexibleFrameworkRecipe = Recipe.Static(
        id: "recipe-alternate-flexible-framework",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 8)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.versatileFramework, amount: 2),
        duration: 16,
        isDefault: false
    )
    
    static let automatedSpeedWiringRecipe = Recipe.Static(
        id: "recipe-alternate-automated-speed-wiring",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.stator, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 40),
            Recipe.Static.Ingredient(V2.Parts.highSpeedConnector, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.automatedWiring, amount: 4),
        duration: 32,
        isDefault: false
    )
    
    static let modularEngineRecipe = Recipe.Static(
        id: "recipe-modular-engine",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.motor, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.smartPlating, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.modularEngine, amount: 1),
        duration: 60
    )
    
    static let adaptiveControlUnitRecipe = Recipe.Static(
        id: "recipe-adaptive-control-unit",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.automatedWiring, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.computer, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.adaptiveControlUnit, amount: 1),
        duration: 60
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
        duration: 120
    )
    
    static let ballisticWarpDriveRecipe = Recipe.Static(
        id: "recipe-ballistic-warp-drive",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.thermalPropulsionRocket, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.singularityCell, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.superpositionOscillator, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.darkMatterCrystal, amount: 40)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ballisticWarpDrive, amount: 1),
        duration: 60
    )
    
    private static let spaceElevatorRecipes = [
        plasticSmartPlatingRecipe,
        flexibleFrameworkRecipe,
        automatedSpeedWiringRecipe,
        modularEngineRecipe,
        adaptiveControlUnitRecipe,
        thermalPropulsionRocketRecipe,
        ballisticWarpDriveRecipe,
    ]
}

// MARK: - Standard Parts
extension V2.Recipes {
    static let heavyModularFrameRecipe = Recipe.Static(
        id: "recipe-heavy-modular-frame",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.screw, amount: 120)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.heavyModularFrame, amount: 1),
        duration: 30
    )
    
    static let heavyEncasedFrameRecipe = Recipe.Static(
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
    
    static let heavyFlexibleFrameRecipe = Recipe.Static(
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
    
    private static let standardPartsRecipes = [
        heavyModularFrameRecipe,
        heavyEncasedFrameRecipe,
        heavyFlexibleFrameRecipe,
    ]
}

// MARK: - Electronics
extension V2.Recipes {
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
    
    static let siliconHighSpeedConnectorRecipe = Recipe.Static(
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
    
    static let singularityCellRecipe = Recipe.Static(
        id: "recipe-singularity-cell",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nuclearPasta, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.darkMatterCrystal, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 100),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 200)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.singularityCell, amount: 10),
        duration: 60
    )
    
    static let samFluctuatorRecipe = Recipe.Static(
        id: "recipe-sam-fluctuator",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reanimatedSAM, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 3),
        ],
        output: Recipe.Static.Ingredient(V2.Parts.samFluctuator, amount: 1),
        duration: 6
    )
    
    private static let electronicsRecipes = [
        highSpeedConnectorRecipe,
        siliconHighSpeedConnectorRecipe,
        singularityCellRecipe,
        samFluctuatorRecipe
    ]
}

// MARK: - Industrial Parts
extension V2.Recipes {
    static let rigorMotorRecipe = Recipe.Static(
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
    
    static let turboElectricMotorRecipe = Recipe.Static(
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
    
    static let turboPressureMotorRecipe = Recipe.Static(
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
    
    static let classicBatteryRecipe = Recipe.Static(
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
    
    private static let industrialPartsRecipes = [
        rigorMotorRecipe,
        turboMotorRecipe,
        turboElectricMotorRecipe,
        turboPressureMotorRecipe,
        classicBatteryRecipe,
    ]
}

// MARK: - Communications
extension V2.Recipes {
    static let computerRecipe = Recipe.Static(
        id: "recipe-computer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 16)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.computer, amount: 1),
        duration: 24
    )
    
    static let cateriumComputerRecipe = Recipe.Static(
        id: "recipe-alternate-caterium-computer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 14),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 6)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.computer, amount: 1),
        duration: 16,
        isDefault: false
    )
    
    static let supercomputerRecipe = Recipe.Static(
        id: "recipe-supercomputer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.computer, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.aiLimiter, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.highSpeedConnector, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 28)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 1),
        duration: 32
    )
    
    static let superStateComputerRecipe = Recipe.Static(
        id: "recipe-alternate-super-state-computer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.computer, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.battery, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 25)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 1),
        duration: 25,
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
    
    static let insulatedCrystalOscillatorRecipe = Recipe.Static(
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
    
    static let radioControlUnitRecipe = Recipe.Static(
        id: "recipe-radio-control-unit",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 32),
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.computer, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 2),
        duration: 48
    )
    
    static let radioConnectionUnitRecipe = Recipe.Static(
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
    
    static let radioControlSystemRecipe = Recipe.Static(
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
    
    private static let communicationsRecipes = [
        computerRecipe,
        cateriumComputerRecipe,
        supercomputerRecipe,
        superStateComputerRecipe,
        crystalOscillatorRecipe,
        insulatedCrystalOscillatorRecipe,
        radioControlUnitRecipe,
        radioConnectionUnitRecipe,
        radioControlSystemRecipe,
    ]
}

// MARK: - Nuclear
extension V2.Recipes {
    static let infusedUraniumCellRecipe = Recipe.Static(
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
    
    static let uraniumFuelUnitRecipe = Recipe.Static(
        id: "recipe-alternate-uranium-fuel-unit",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.encasedUraniumCell, amount: 100),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.uraniumFuelRod, amount: 3),
        duration: 300,
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
    
    private static let nuclearRecipes = [
        infusedUraniumCellRecipe,
        uraniumFuelRodRecipe,
        uraniumFuelUnitRecipe,
        plutoniumFuelRodRecipe,
    ]
}

// MARK: - Consumables
extension V2.Recipes {
    static let gasFilterRecipe = Recipe.Static(
        id: "recipe-gas-filter",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.fabric, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 2),
        ],
        output: Recipe.Static.Ingredient(V2.Parts.gasFilter, amount: 1),
        duration: 8
    )
    
    static let iodineInfusedFilterRecipe = Recipe.Static(
        id: "recipe-iodine-infused-filter",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.gasFilter, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 8),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.iodineInfusedFilter, amount: 1),
        duration: 16
    )
    
    private static let consumablesRecipes = [
        gasFilterRecipe,
        iodineInfusedFilterRecipe,
    ]
}

// MARK: - Ammunition
extension V2.Recipes {
    static let explosiveRebarRecipe = Recipe.Static(
        id: "recipe-explosive-rebar",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironRebar, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.smokelessPowder, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.explosiveRebar, amount: 1),
        duration: 12
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
        duration: 120
    )
    
    static let manufacturerTurboRifleAmmoRecipe = Recipe.Static(
        id: "recipe-turbo-rifle-ammo-manufacturer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rifleAmmo, amount: 25),
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.packagedTurbofuel, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.turboRifleAmmo, amount: 50),
        duration: 12
    )
    
    private static let ammunitionRecipes = [
        explosiveRebarRecipe,
        nukeNobeliskRecipe,
        manufacturerTurboRifleAmmoRecipe
    ]
}

// MARK: - Manufacturer recipes
extension V2.Recipes {
    static let manufacturerRecipes =
    spaceElevatorRecipes +
    standardPartsRecipes +
    electronicsRecipes +
    industrialPartsRecipes +
    communicationsRecipes +
    nuclearRecipes +
    consumablesRecipes +
    ammunitionRecipes
}
