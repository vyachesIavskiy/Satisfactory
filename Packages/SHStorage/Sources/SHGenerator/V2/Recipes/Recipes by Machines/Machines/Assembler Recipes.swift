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
            machine: V2.Buildings.assembler,
            duration: duration,
            powerConsumption: PowerConsumption(15),
            isDefault: isDefault
        )
    }
}

// MARK: - Space Elevator
extension V2.Recipes {
    static let smartPlatingRecipe = Recipe.Static(
        id: "recipe-smart-plating",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.smartPlating, amount: 1),
        duration: 30
    )
    
    static let versatileFrameworkRecipe = Recipe.Static(
        id: "recipe-versatile-framework",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.versatileFramework, amount: 2),
        duration: 24
    )
    
    static let automatedWiringRecipe = Recipe.Static(
        id: "recipe-automated-wiring",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.stator, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.cable, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.automatedWiring, amount: 1),
        duration: 24
    )
    
    static let assemblyDirectorSystemRecipe = Recipe.Static(
        id: "recipe-assembly-director-system",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.adaptiveControlUnit, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.assemblyDirectorSystem, amount: 1),
        duration: 80
    )
    
    static let magneticFieldGeneratorRecipe = Recipe.Static(
        id: "recipe-magnetic-field-generator",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.versatileFramework, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 2),
        ],
        output: Recipe.Static.Ingredient(V2.Parts.magneticFieldGenerator, amount: 2),
        duration: 120
    )
    
    fileprivate static let spaceElevatorRecipes = [
        smartPlatingRecipe,
        versatileFrameworkRecipe,
        automatedWiringRecipe,
        assemblyDirectorSystemRecipe,
        magneticFieldGeneratorRecipe,
    ]
}

// MARK: - Standard Parts
extension V2.Recipes {
    static let coatedIronPlateRecipe = Recipe.Static(
        id: "recipe-alternate-coated-iron-plate",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironIngot, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 10),
        duration: 8,
        isDefault: false
    )
    
    static let reinforcedIronPlateRecipe = Recipe.Static(
        id: "recipe-reinforced-iron-plate",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.screw, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 1),
        duration: 12
    )
    
    static let boltedIronPlateRecipe = Recipe.Static(
        id: "recipe-alternate-bolted-iron-plate",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 18),
            Recipe.Static.Ingredient(V2.Parts.screw, amount: 50)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 3),
        duration: 12,
        isDefault: false
    )
    
    static let stichedIronPlateRecipe = Recipe.Static(
        id: "recipe-alternate-stitched-iron-plate",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 3),
        duration: 32,
        isDefault: false
    )
    
    static let adheredIronPlateRecipe = Recipe.Static(
        id: "recipe-alternate-adhered-iron-plate",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 1),
        duration: 16,
        isDefault: false
    )
    
    static let modularFrameRecipe = Recipe.Static(
        id: "recipe-modular-frame",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 2),
        duration: 60
    )
    
    static let boltedFrameRecipe = Recipe.Static(
        id: "recipe-alternate-bolted-frame",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.screw, amount: 56)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 2),
        duration: 24,
        isDefault: false
    )
    
    static let steeledFrameRecipe = Recipe.Static(
        id: "recipe-alternate-steeled-frame",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.reinforcedIronPlate, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.modularFrame, amount: 3),
        duration: 60,
        isDefault: false
    )
    
    static let encasedIndustrialBeamRecipe = Recipe.Static(
        id: "recipe-encased-industrial-beam",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelBeam, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 6)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 1),
        duration: 10
    )
    
    static let encasedIndustrialPipeRecipe = Recipe.Static(
        id: "recipe-alternate-encased-industrial-pipe",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.encasedIndustrialBeam, amount: 1),
        duration: 15,
        isDefault: false
    )
    
    static let alcladAluminumSheetRecipe = Recipe.Static(
        id: "recipe-alclad-aluminum-sheet",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.aluminumIngot, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.alcladAluminumSheet, amount: 3),
        duration: 6
    )
    
    static let alcladCasingRecipe = Recipe.Static(
        id: "recipe-alternate-alclad-casing",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.aluminumIngot, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 15),
        duration: 8,
        isDefault: false
    )
    
    fileprivate static let standardPartsRecipes = [
        coatedIronPlateRecipe,
        reinforcedIronPlateRecipe,
        boltedIronPlateRecipe,
        stichedIronPlateRecipe,
        adheredIronPlateRecipe,
        modularFrameRecipe,
        boltedFrameRecipe,
        steeledFrameRecipe,
        encasedIndustrialBeamRecipe,
        encasedIndustrialPipeRecipe,
        alcladAluminumSheetRecipe,
        alcladCasingRecipe,
    ]
}

// MARK: - Electronics
extension V2.Recipes {
    static let fusedWireRecipe = Recipe.Static(
        id: "recipe-alternate-fused-wire",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.cateriumIngot, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.wire, amount: 30),
        duration: 20,
        isDefault: false
    )
    
    static let insulatedCableRecipe = Recipe.Static(
        id: "recipe-alternate-insulated-cable",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 9),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 6)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.cable, amount: 20),
        duration: 12,
        isDefault: false
    )
    
    static let quickwireCableRecipe = Recipe.Static(
        id: "recipe-alternate-quickwire-cable",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.cable, amount: 11),
        duration: 24,
        isDefault: false
    )
    
    static let circuitBoardRecipe = Recipe.Static(
        id: "recipe-circuit-board",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 4)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 1),
        duration: 8
    )
    
    static let electrodeCircuitBoardRecipe = Recipe.Static(
        id: "recipe-alternate-electrode-circuit-board",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.petroleumCoke, amount: 8)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 1),
        duration: 12,
        isDefault: false
    )
    
    static let cateriumCircuitBoardRecipe = Recipe.Static(
        id: "recipe-alternate-caterium-circuit-board",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 30)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 7),
        duration: 48,
        isDefault: false
    )
    
    static let siliconCircuitBoardRecipe = Recipe.Static(
        id: "recipe-alternate-silicon-circuit-board",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 11),
            Recipe.Static.Ingredient(V2.Parts.silica, amount: 11)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 5),
        duration: 24,
        isDefault: false
    )
    static let fusedQuickwireRecipe = Recipe.Static(
        id: "recipe-alternate-fused-quickwire",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.cateriumIngot, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.copperIngot, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 12),
        duration: 8,
        isDefault: false
    )
    
    static let aiLimiterRecipe = Recipe.Static(
        id: "recipe-ai-limiter",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.aiLimiter, amount: 1),
        duration: 12
    )
    
    static let plasticAILimiterRecipe = Recipe.Static(
        id: "recipe-alternate-plastic-ai-limiter",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 30),
            Recipe.Static.Ingredient(V2.Parts.plastic, amount: 7)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.aiLimiter, amount: 2),
        duration: 15,
        isDefault: false
    )
    
    static let crystalComputerRecipe = Recipe.Static(
        id: "recipe-alternate-crystal-computer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.circuitBoard, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.computer, amount: 2),
        duration: 36,
        isDefault: false
    )
    
    static let ocSupercomputerRecipe = Recipe.Static(
        id: "recipe-alternate-oc-supercomputer",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.coolingSystem, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.supercomputer, amount: 1),
        duration: 20,
        isDefault: false
    )
    
    fileprivate static let electronicsRecipes = [
        fusedWireRecipe,
        insulatedCableRecipe,
        quickwireCableRecipe,
        circuitBoardRecipe,
        electrodeCircuitBoardRecipe,
        cateriumCircuitBoardRecipe,
        siliconCircuitBoardRecipe,
        fusedQuickwireRecipe,
        aiLimiterRecipe,
        plasticAILimiterRecipe,
        crystalComputerRecipe,
        ocSupercomputerRecipe,
    ]
}

// MARK: - Compounds
extension V2.Recipes {
    static let fineConcreteRecipe = Recipe.Static(
        id: "recipe-alternate-fine-concrete",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.silica, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.limestone, amount: 12)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.concrete, amount: 10),
        duration: 12,
        isDefault: false
    )
    
    static let rubberConcreteRecipe = Recipe.Static(
        id: "recipe-alternate-rubber-concrete",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.limestone, amount: 10),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.concrete, amount: 9),
        duration: 6,
        isDefault: false
    )
    
    static let compactedCoalRecipe = Recipe.Static(
        id: "recipe-alternate-compacted-coal",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.compactedCoal, amount: 5),
        duration: 12,
        isDefault: false
    )
    
    static let cheapSilicaRecipe = Recipe.Static(
        id: "recipe-alternate-cheap-silica",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rawQuartz, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.limestone, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.silica, amount: 7),
        duration: 8,
        isDefault: false
    )
    
    fileprivate static let compoundsRecipes = [
        fineConcreteRecipe,
        rubberConcreteRecipe,
        compactedCoalRecipe,
        cheapSilicaRecipe,
    ]
}

// MARK: - Biomass
extension V2.Recipes {
    static let fabricRecipe = Recipe.Static(
        id: "recipe-fabric",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.mycelia, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.biomass, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.fabric, amount: 1),
        duration: 4
    )
    
    fileprivate static let biomassRecipes = [
        fabricRecipe
    ]
}

// MARK: - Industrial Parts
extension V2.Recipes {
    static let rotorRecipe = Recipe.Static(
        id: "recipe-rotor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironRod, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.screw, amount: 25)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.rotor, amount: 1),
        duration: 15
    )
    
    static let copperRotorRecipe = Recipe.Static(
        id: "recipe-alternate-copper-rotor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 6),
            Recipe.Static.Ingredient(V2.Parts.screw, amount: 52)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.rotor, amount: 3),
        duration: 16,
        isDefault: false
    )
    
    static let steelRotorRecipe = Recipe.Static(
        id: "recipe-alternate-steel-rotor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 6)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.rotor, amount: 1),
        duration: 12,
        isDefault: false
    )
    
    static let statorRecipe = Recipe.Static(
        id: "recipe-stator",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.wire, amount: 8)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.stator, amount: 1),
        duration: 12
    )
    
    static let quickwireStatorRecipe = Recipe.Static(
        id: "recipe-alternate-quickwire-stator",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 15)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.stator, amount: 2),
        duration: 15,
        isDefault: false
    )
    
    static let motorRecipe = Recipe.Static(
        id: "recipe-motor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.stator, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.motor, amount: 1),
        duration: 12
    )
    
    static let electricMotorRecipe = Recipe.Static(
        id: "recipe-alternate-electric-motor",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.rotor, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.motor, amount: 2),
        duration: 16,
        isDefault: false
    )
    
    static let heatSinkRecipe = Recipe.Static(
        id: "recipe-heat-sink",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.alcladAluminumSheet, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.heatSink, amount: 1),
        duration: 8
    )
    
    static let heatExchangerRecipe = Recipe.Static(
        id: "recipe-alternate-heat-exchanger",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.aluminumCasing, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.rubber, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.heatSink, amount: 1),
        duration: 6,
        isDefault: false
    )
    
    fileprivate static let industrialPartsRecipes = [
        rotorRecipe,
        copperRotorRecipe,
        steelRotorRecipe,
        statorRecipe,
        quickwireStatorRecipe,
        motorRecipe,
        electricMotorRecipe,
        heatSinkRecipe,
        heatExchangerRecipe,
    ]
}

// MARK: - Containers
extension V2.Recipes {
    static let coatedIronCanisterRecipe = Recipe.Static(
        id: "recipe-alternate-coated-iron-canister",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.emptyCanister, amount: 4),
        duration: 4,
        isDefault: false
    )
    
    static let pressureConversionCubeRecipe = Recipe.Static(
        id: "recipe-pressure-conversion-cube",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.fusedModularFrame, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.radioControlUnit, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.pressureConversionCube, amount: 1),
        duration: 60
    )
    
    fileprivate static let containersRecipes = [
        coatedIronCanisterRecipe,
        pressureConversionCubeRecipe,
    ]
}

// MARK: - Nuclear
extension V2.Recipes {
    static let electromagneticControlRodRecipe = Recipe.Static(
        id: "recipe-electromagnetic-control-rod",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.stator, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.aiLimiter, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 2),
        duration: 30
    )
    
    static let encasedPlutoniumCellRecipe = Recipe.Static(
        id: "recipe-encased-plutonium-cell",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.plutoniumPellet, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.concrete, amount: 4)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.encasedPlutoniumCell, amount: 1),
        duration: 12
    )
    
    static let electromagneticConnectionRodRecipe = Recipe.Static(
        id: "recipe-alternate-electromagnetic-connection-rod",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.stator, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.highSpeedConnector, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.electromagneticControlRod, amount: 2),
        duration: 15,
        isDefault: false
    )
    
    static let plutoniumFuelUnitRecipe = Recipe.Static(
        id: "recipe-alternate-plutonium-fuel-unit",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.encasedPlutoniumCell, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.pressureConversionCube, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.plutoniumFuelRod, amount: 1),
        duration: 120,
        isDefault: false
    )
    
    fileprivate static let nuclearRecipes = [
        electromagneticControlRodRecipe,
        encasedPlutoniumCellRecipe,
        electromagneticConnectionRodRecipe,
        plutoniumFuelUnitRecipe,
    ]
}

// MARK: - Tools
extension V2.Recipes {
    static let automatedMinerRecipe = Recipe.Static(
        id: "recipe-alternate-automated-miner",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 4),
            Recipe.Static.Ingredient(V2.Parts.ironPlate, amount: 4)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.portableMiner, amount: 1),
        duration: 60,
        isDefault: false
    )
    
    fileprivate static let toolsRecipes = [
        automatedMinerRecipe
    ]
}

// MARK: - Ammunition
extension V2.Recipes {
    static let blackPowderRecipe = Recipe.Static(
        id: "recipe-black-powder",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.coal, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.blackPowder, amount: 2),
        duration: 4
    )
    
    static let fineBlackPowderRecipe = Recipe.Static(
        id: "recipe-alternate-fine-black-powder",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.sulfur, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.compactedCoal, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.blackPowder, amount: 6),
        duration: 8,
        isDefault: false
    )
    
    static let stunRebarRecipe = Recipe.Static(
        id: "recipe-stun-rebar",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironRebar, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.quickwire, amount: 5)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.stunRebar, amount: 1),
        duration: 6
    )
    
    static let shatterRebarRecipe = Recipe.Static(
        id: "recipe-shatter-rebar",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ironRebar, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.quartzCrystal, amount: 3)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.shatterRebar, amount: 1),
        duration: 12
    )
    
    static let nobeliskRecipe = Recipe.Static(
        id: "recipe-nobelisk",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.blackPowder, amount: 2),
            Recipe.Static.Ingredient(V2.Parts.steelPipe, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.nobelisk, amount: 1),
        duration: 6
    )
    
    static let gasNobeliskRecipe = Recipe.Static(
        id: "recipe-gas-nobelisk",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nobelisk, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.biomass, amount: 10)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.gasNobelisk, amount: 1),
        duration: 12
    )
    
    static let clusterNobeliskRecipe = Recipe.Static(
        id: "recipe-cluster-nobelisk",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nobelisk, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.smokelessPowder, amount: 4)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.clusterNobelisk, amount: 1),
        duration: 24
    )
    
    static let pulseNobeliskRecipe = Recipe.Static(
        id: "recipe-pulse-nobelisk",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.nobelisk, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.crystalOscillator, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.pulseNobelisk, amount: 5),
        duration: 60
    )
    
    static let rifleAmmoRecipe = Recipe.Static(
        id: "recipe-rifle-ammo",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperSheet, amount: 3),
            Recipe.Static.Ingredient(V2.Parts.smokelessPowder, amount: 2)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.rifleAmmo, amount: 15),
        duration: 12
    )
    
    static let homingRifleAmmoRecipe = Recipe.Static(
        id: "recipe-homing-rifle-ammo",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.rifleAmmo, amount: 20),
            Recipe.Static.Ingredient(V2.Parts.highSpeedConnector, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.homingRifleAmmo, amount: 10),
        duration: 24
    )
    
    fileprivate static let amunitionRecipes = [
        blackPowderRecipe,
        fineBlackPowderRecipe,
        stunRebarRecipe,
        shatterRebarRecipe,
        nobeliskRecipe,
        gasNobeliskRecipe,
        clusterNobeliskRecipe,
        pulseNobeliskRecipe,
        rifleAmmoRecipe,
        homingRifleAmmoRecipe
    ]
}

// MARK: - FICSMAS
extension V2.Recipes {
    static let ficsmasOrnamentBundleRecipe = Recipe.Static(
        id: "recipe-ficsmas-ornament-bundle",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.copperFicsmasOrnament, amount: 1),
            Recipe.Static.Ingredient(V2.Parts.ironFicsmasOrnament, amount: 1)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ficsmasOrnamentBundle, amount: 1),
        duration: 12
    )
    
    static let ficsmasDecorationRecipe = Recipe.Static(
        id: "recipe-ficsmas-decoration",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ficsmasTreeBranch, amount: 15),
            Recipe.Static.Ingredient(V2.Parts.ficsmasOrnamentBundle, amount: 6)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ficsmasDecoration, amount: 2),
        duration: 60
    )
    
    static let ficsmasWonderStarRecipe = Recipe.Static(
        id: "recipe-ficsmas-wonder-star",
        inputs: [
            Recipe.Static.Ingredient(V2.Parts.ficsmasDecoration, amount: 5),
            Recipe.Static.Ingredient(V2.Parts.candyCanePart, amount: 20)
        ],
        output: Recipe.Static.Ingredient(V2.Parts.ficsmasWonderStar, amount: 1),
        duration: 60
    )
    
    fileprivate static let ficsmasRecipes = [
        ficsmasOrnamentBundleRecipe,
        ficsmasDecorationRecipe,
        ficsmasWonderStarRecipe,
    ]
}

// MARK: - Assembler recipes
extension V2.Recipes {
    static let assemblerRecipes =
    spaceElevatorRecipes +
    standardPartsRecipes +
    electronicsRecipes +
    compoundsRecipes +
    biomassRecipes +
    industrialPartsRecipes +
    containersRecipes +
    nuclearRecipes +
    toolsRecipes +
    amunitionRecipes +
    ficsmasRecipes
}
