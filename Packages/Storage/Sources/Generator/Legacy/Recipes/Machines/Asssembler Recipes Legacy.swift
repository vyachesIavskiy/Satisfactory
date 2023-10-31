import StaticModels

private extension RecipeLegacy {
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
            machines: [Legacy.Buildings.assembler.id],
            duration: duration,
            isDefault: isDefault
        )
    }
}

extension Legacy.Recipes {
    // Standard Parts
    static let reinforcedIronPlateRecipe = RecipeLegacy(
        id: "reinforced-iron-plate",
        name: "Reinforced Iron Plate",
        input: [
            .init(Legacy.Parts.ironPlate, amount: 6),
            .init(Legacy.Parts.screw, amount: 12)
        ],
        output: .init(Legacy.Parts.reinforcedIronPlate, amount: 1),
        duration: 12
    )

    static let reinforcedIronPlateRecipe1 = RecipeLegacy(
        id: "alternate-adhered-iron-plate",
        name: "Alternate: Adhered Iron Plate",
        input: [
            .init(Legacy.Parts.ironPlate, amount: 3),
            .init(Legacy.Parts.rubber, amount: 1)
        ],
        output: .init(Legacy.Parts.reinforcedIronPlate, amount: 1),
        duration: 16,
        isDefault: false
    )

    static let reinforcedIronPlateRecipe2 = RecipeLegacy(
        id: "alternate-bolted-iron-plate",
        name: "Alternate: Bolted Iron Plate",
        input: [
            .init(Legacy.Parts.ironPlate, amount: 18),
            .init(Legacy.Parts.screw, amount: 50)
        ],
        output: .init(Legacy.Parts.reinforcedIronPlate, amount: 3),
        duration: 12,
        isDefault: false
    )

    static let reinforcedIronPlateRecipe3 = RecipeLegacy(
        id: "alternate-stitched-iron-plate",
        name: "Alternate: Stitched Iron Plate",
        input: [
            .init(Legacy.Parts.ironPlate, amount: 10),
            .init(Legacy.Parts.wire, amount: 20)
        ],
        output: .init(Legacy.Parts.reinforcedIronPlate, amount: 3),
        duration: 32,
        isDefault: false
    )

    static let modularFrameRecipe = RecipeLegacy(
        id: "modular-frame",
        name: "Modular Frame",
        input: [
            .init(Legacy.Parts.reinforcedIronPlate, amount: 3),
            .init(Legacy.Parts.ironRod, amount: 12)
        ],
        output: .init(Legacy.Parts.modularFrame, amount: 2),
        duration: 60
    )

    static let modularFrameRecipe1 = RecipeLegacy(
        id: "alternate-bolted-frame",
        name: "Alternate: Bolted Frame",
        input: [
            .init(Legacy.Parts.reinforcedIronPlate, amount: 3),
            .init(Legacy.Parts.screw, amount: 56)
        ],
        output: .init(Legacy.Parts.modularFrame, amount: 2),
        duration: 24,
        isDefault: false
    )

    static let modularFrameRecipe2 = RecipeLegacy(
        id: "alternate-steeled-frame",
        name: "Alternate: Steeled Frame",
        input: [
            .init(Legacy.Parts.reinforcedIronPlate, amount: 2),
            .init(Legacy.Parts.steelPipe, amount: 10)
        ],
        output: .init(Legacy.Parts.modularFrame, amount: 3),
        duration: 60,
        isDefault: false
    )

    static let encasedIndustrialBeamRecipe = RecipeLegacy(
        id: "encased-industrial-beam",
        name: "Encased Industrial Beam",
        input: [
            .init(Legacy.Parts.steelBeam, amount: 4),
            .init(Legacy.Parts.concrete, amount: 5)
        ],
        output: .init(Legacy.Parts.encasedIndustrialBeam, amount: 1),
        duration: 10
    )

    static let encasedIndustrialBeamRecipe1 = RecipeLegacy(
        id: "alternate-encased-industrial-pipe",
        name: "Alternate: Encased Industrial Pipe",
        input: [
            .init(Legacy.Parts.steelPipe, amount: 7),
            .init(Legacy.Parts.concrete, amount: 5)
        ],
        output: .init(Legacy.Parts.encasedIndustrialBeam, amount: 1),
        duration: 15,
        isDefault: false
    )

    static let alcladAluminumSheetRecipe = RecipeLegacy(
        id: "alclad-aluminum-sheet",
        name: "Alclad Aluminum Sheet",
        input: [
            .init(Legacy.Parts.aluminumIngot, amount: 3),
            .init(Legacy.Parts.copperIngot, amount: 1)
        ],
        output: .init(Legacy.Parts.alcladAluminumSheet, amount: 3),
        duration: 6
    )

    static let ironPlateRecipe1 = RecipeLegacy(
        id: "alternate-coated-iron-plate",
        name: "Alternate: Coated Iron Plate",
        input: [
            .init(Legacy.Parts.ironIngot, amount: 10),
            .init(Legacy.Parts.plastic, amount: 2)
        ],
        output: .init(Legacy.Parts.ironPlate, amount: 15),
        duration: 12,
        isDefault: false
    )

    static let ironPlateRecipe2 = RecipeLegacy(
        id: "alternate-steel-coated-plate",
        name: "Alternate: Steel Coated Plate",
        input: [
            .init(Legacy.Parts.steelIngot, amount: 3),
            .init(Legacy.Parts.plastic, amount: 2)
        ],
        output: .init(Legacy.Parts.ironPlate, amount: 18),
        duration: 24,
        isDefault: false
    )

    static let aluminumCasingRecipe1 = RecipeLegacy(
        id: "alternate-alclad-casing",
        name: "Alternate: Alclad Casing",
        input: [
            .init(Legacy.Parts.aluminumIngot, amount: 20),
            .init(Legacy.Parts.copperIngot, amount: 10)
        ],
        output: .init(Legacy.Parts.aluminumCasing, amount: 15),
        duration: 8,
        isDefault: false
    )

    // Industrial Parts
    static let rotorRecipe = RecipeLegacy(
        id: "rotor",
        name: "Rotor",
        input: [
            .init(Legacy.Parts.ironRod, amount: 5),
            .init(Legacy.Parts.screw, amount: 25)
        ],
        output: .init(Legacy.Parts.rotor, amount: 1),
        duration: 15
    )

    static let rotorRecipe1 = RecipeLegacy(
        id: "alternate-copper-rotor",
        name: "Alternate: Copper Rotor",
        input: [
            .init(Legacy.Parts.copperSheet, amount: 6),
            .init(Legacy.Parts.screw, amount: 52)
        ],
        output: .init(Legacy.Parts.rotor, amount: 3),
        duration: 16,
        isDefault: false
    )

    static let rotorRecipe2 = RecipeLegacy(
        id: "alternate-steel-rotor",
        name: "Alternate: Steel Rotor",
        input: [
            .init(Legacy.Parts.steelPipe, amount: 2),
            .init(Legacy.Parts.wire, amount: 6)
        ],
        output: .init(Legacy.Parts.rotor, amount: 1),
        duration: 12,
        isDefault: false
    )

    static let statorRecipe = RecipeLegacy(
        id: "stator",
        name: "Stator",
        input: [
            .init(Legacy.Parts.steelPipe, amount: 3),
            .init(Legacy.Parts.wire, amount: 8)
        ],
        output: .init(Legacy.Parts.stator, amount: 1),
        duration: 12
    )

    static let statorRecipe1 = RecipeLegacy(
        id: "alternate-quickwire-stator",
        name: "Alternate: Quickwire Stator",
        input: [
            .init(Legacy.Parts.steelPipe, amount: 4),
            .init(Legacy.Parts.quickwire, amount: 15)
        ],
        output: .init(Legacy.Parts.stator, amount: 2),
        duration: 15,
        isDefault: false
    )

    static let motorRecipe = RecipeLegacy(
        id: "motor",
        name: "Motor",
        input: [
            .init(Legacy.Parts.rotor, amount: 2),
            .init(Legacy.Parts.stator, amount: 2)
        ],
        output: .init(Legacy.Parts.motor, amount: 1),
        duration: 12
    )

    static let motorRecipe1 = RecipeLegacy(
        id: "alternate-electric-motor",
        name: "Alternate: Electric Motor",
        input: [
            .init(Legacy.Parts.electromagneticControlRod, amount: 1),
            .init(Legacy.Parts.rotor, amount: 2)
        ],
        output: .init(Legacy.Parts.motor, amount: 2),
        duration: 16,
        isDefault: false
    )

    static let heatSinkRecipe = RecipeLegacy(
        id: "heat-sink",
        name: "Heat Sink",
        input: [
            .init(Legacy.Parts.alcladAluminumSheet, amount: 5),
            .init(Legacy.Parts.copperSheet, amount: 3)
        ],
        output: .init(Legacy.Parts.heatSink, amount: 1),
        duration: 8
    )

    static let heatSinkRecipe1 = RecipeLegacy(
        id: "alternate-heat-exchanger",
        name: "Alternate: Heat Exchanger",
        input: [
            .init(Legacy.Parts.aluminumCasing, amount: 3),
            .init(Legacy.Parts.rubber, amount: 3)
        ],
        output: .init(Legacy.Parts.heatSink, amount: 1),
        duration: 6,
        isDefault: false
    )

    // Electronics
    static let circuitBoardRecipe = RecipeLegacy(
        id: "circuit-board",
        name: "Circuit Board",
        input: [
            .init(Legacy.Parts.copperSheet, amount: 2),
            .init(Legacy.Parts.plastic, amount: 4)
        ],
        output: .init(Legacy.Parts.circuitBoard, amount: 1),
        duration: 8
    )

    static let circuitBoardRecipe1 = RecipeLegacy(
        id: "alternate-electrode-circuit-board",
        name: "Alternate: Electrode Circuit Board",
        input: [
            .init(Legacy.Parts.rubber, amount: 6),
            .init(Legacy.Parts.petroleumCoke, amount: 9)
        ],
        output: .init(Legacy.Parts.circuitBoard, amount: 1),
        duration: 12,
        isDefault: false
    )

    static let circuitBoardRecipe2 = RecipeLegacy(
        id: "alternate-silicone-circuit-board",
        name: "Alternate: Silicone Circuit Board",
        input: [
            .init(Legacy.Parts.copperSheet, amount: 11),
            .init(Legacy.Parts.silica, amount: 11)
        ],
        output: .init(Legacy.Parts.circuitBoard, amount: 5),
        duration: 24,
        isDefault: false
    )

    static let circuitBoardRecipe3 = RecipeLegacy(
        id: "alternate-caterium-circuit-board",
        name: "Alternate: Caterium Circuit Board",
        input: [
            .init(Legacy.Parts.plastic, amount: 10),
            .init(Legacy.Parts.quickwire, amount: 30)
        ],
        output: .init(Legacy.Parts.circuitBoard, amount: 7),
        duration: 48,
        isDefault: false
    )

    static let aiLimiterRecipe = RecipeLegacy(
        id: "ai-limiter",
        name: "AI Limiter",
        input: [
            .init(Legacy.Parts.copperSheet, amount: 5),
            .init(Legacy.Parts.quickwire, amount: 20)
        ],
        output: .init(Legacy.Parts.aiLimiter, amount: 1),
        duration: 12
    )

    static let wireRecipe3 = RecipeLegacy(
        id: "alternate-fused-wire",
        name: "Alternate: Fused Wire",
        input: [
            .init(Legacy.Parts.copperIngot, amount: 4),
            .init(Legacy.Parts.cateriumIngot, amount: 1)
        ],
        output: .init(Legacy.Parts.wire, amount: 30),
        duration: 20,
        isDefault: false
    )

    static let cableRecipe1 = RecipeLegacy(
        id: "alternate-insulated-cable",
        name: "Alternate: Insulated Cable",
        input: [
            .init(Legacy.Parts.wire, amount: 9),
            .init(Legacy.Parts.rubber, amount: 6)
        ],
        output: .init(Legacy.Parts.cable, amount: 20),
        duration: 12,
        isDefault: false
    )

    static let cableRecipe2 = RecipeLegacy(
        id: "alternate-quickwire-cable",
        name: "Alternate: Quickwire Cable",
        input: [
            .init(Legacy.Parts.quickwire, amount: 3),
            .init(Legacy.Parts.rubber, amount: 2)
        ],
        output: .init(Legacy.Parts.cable, amount: 11),
        duration: 24,
        isDefault: false
    )

    static let quickwireRecipe1 = RecipeLegacy(
        id: "alternate-fused-quickwire",
        name: "Alternate: Fused Quickwire",
        input: [
            .init(Legacy.Parts.cateriumIngot, amount: 1),
            .init(Legacy.Parts.copperIngot, amount: 5)
        ],
        output: .init(Legacy.Parts.quickwire, amount: 12),
        duration: 8,
        isDefault: false
    )

    static let computerRecipe1 = RecipeLegacy(
        id: "alternate-crystal-computer",
        name: "Alternate: Crystal Computer",
        input: [
            .init(Legacy.Parts.circuitBoard, amount: 8),
            .init(Legacy.Parts.crystalOscillator, amount: 3)
        ],
        output: .init(Legacy.Parts.computer, amount: 3),
        duration: 64,
        isDefault: false
    )

    static let supercomputerRecipe2 = RecipeLegacy(
        id: "alternate-oc-supercomputer",
        name: "Alternate: OC Supercomputer",
        input: [
            .init(Legacy.Parts.radioControlUnit, amount: 3),
            .init(Legacy.Parts.coolingSystem, amount: 3)
        ],
        output: .init(Legacy.Parts.supercomputer, amount: 1),
        duration: 20,
        isDefault: false
    )

    // Minerals
    static let concreteRecipe1 = RecipeLegacy(
        id: "alternate-rubber-concrete",
        name: "Alternate: Rubber Concrete",
        input: [
            .init(Legacy.Parts.limestone, amount: 10),
            .init(Legacy.Parts.rubber, amount: 2)
        ],
        output: .init(Legacy.Parts.concrete, amount: 9),
        duration: 12,
        isDefault: false
    )

    static let concreteRecipe2 = RecipeLegacy(
        id: "alternate-fine-concrete",
        name: "Alternate: Fine Concrete",
        input: [
            .init(Legacy.Parts.silica, amount: 3),
            .init(Legacy.Parts.limestone, amount: 12)
        ],
        output: .init(Legacy.Parts.concrete, amount: 10),
        duration: 24,
        isDefault: false
    )

    static let compactedCoalRecipe = RecipeLegacy(
        id: "alternate-compacted-coal",
        name: "Alternate: Compacted Coal",
        input: [
            .init(Legacy.Parts.coal, amount: 5),
            .init(Legacy.Parts.sulfur, amount: 5)
        ],
        output: .init(Legacy.Parts.compactedCoal, amount: 5),
        duration: 12,
        isDefault: false
    )

    static let silicaRecipe1 = RecipeLegacy(
        id: "alternate-cheap-silica",
        name: "Alternate: Cheap Silica",
        input: [
            .init(Legacy.Parts.rawQuartz, amount: 3),
            .init(Legacy.Parts.limestone, amount: 5)
        ],
        output: .init(Legacy.Parts.silica, amount: 7),
        duration: 16,
        isDefault: false
    )

    // Nuclear
    static let electromagneticControlRodRecipe = RecipeLegacy(
        id: "electromagnetic-control-rod",
        name: "Electromagnetic Control Rod",
        input: [
            .init(Legacy.Parts.stator, amount: 3),
            .init(Legacy.Parts.aiLimiter, amount: 2)
        ],
        output: .init(Legacy.Parts.electromagneticControlRod, amount: 2),
        duration: 30
    )

    static let electromagneticControlRodRecipe1 = RecipeLegacy(
        id: "alternate-electromagnetic-connection-rod",
        name: "Alternate: Electromagnetic Connection Rod",
        input: [
            .init(Legacy.Parts.stator, amount: 2),
            .init(Legacy.Parts.highSpeedConnector, amount: 1)
        ],
        output: .init(Legacy.Parts.electromagneticControlRod, amount: 2),
        duration: 15,
        isDefault: false
    )

    static let encasedPlutoniumCellRecipe = RecipeLegacy(
        id: "encased-plutonium-cell",
        name: "Encased Plutonium Cell",
        input: [
            .init(Legacy.Parts.plutoniumPellet, amount: 2),
            .init(Legacy.Parts.concrete, amount: 4)
        ],
        output: .init(Legacy.Parts.encasedPlutoniumCell, amount: 1),
        duration: 12
    )

    static let plutoniumFuelRodRecipe1 = RecipeLegacy(
        id: "alternate-plutonium-fuel-unit",
        name: "Alternate: Plutonium Fuel Unit",
        input: [
            .init(Legacy.Parts.encasedPlutoniumCell, amount: 20),
            .init(Legacy.Parts.pressureConversionCube, amount: 1)
        ],
        output: .init(Legacy.Parts.plutoniumFuelRod, amount: 1),
        duration: 120,
        isDefault: false
    )

    // Consumed
    static let blackPowderRecipe = RecipeLegacy(
        id: "black-powder",
        name: "Black Powder",
        input: [
            .init(Legacy.Parts.coal, amount: 1),
            .init(Legacy.Parts.sulfur, amount: 1)
        ],
        output: .init(Legacy.Parts.blackPowder, amount: 1),
        duration: 4
    )

    static let blackPowderRecipe1 = RecipeLegacy(
        id: "alternate-fine-black-powder",
        name: "Alternate: Fine Black Powder",
        input: [
            .init(Legacy.Parts.sulfur, amount: 2),
            .init(Legacy.Parts.compactedCoal, amount: 1)
        ],
        output: .init(Legacy.Parts.blackPowder, amount: 4),
        duration: 16,
        isDefault: false
    )

    static let stunRebarRecipe = RecipeLegacy(
        id: "stun-rebar",
        name: "Stun Rebar",
        input: [
            .init(Legacy.Parts.ironRebar, amount: 1),
            .init(Legacy.Parts.quickwire, amount: 5)
        ],
        output: .init(Legacy.Parts.stunRebar, amount: 1),
        duration: 6
    )

    static let shatterRebarRecipe = RecipeLegacy(
        id: "shutter-rebar",
        name: "Shatter Rebar",
        input: [
            .init(Legacy.Parts.ironRebar, amount: 2),
            .init(Legacy.Parts.quartzCrystal, amount: 3)
        ],
        output: .init(Legacy.Parts.shatterRebar, amount: 1),
        duration: 12
    )

    static let nobeliskRecipe = RecipeLegacy(
        id: "nobelisk",
        name: "Nobelisk",
        input: [
            .init(Legacy.Parts.blackPowder, amount: 2),
            .init(Legacy.Parts.steelPipe, amount: 2)
        ],
        output: .init(Legacy.Parts.nobelisk, amount: 1),
        duration: 6
    )

    static let gasNobeliskRecipe = RecipeLegacy(
        id: "gas-nobelisk",
        name: "Gas Nobelisk",
        input: [
            .init(Legacy.Parts.nobelisk, amount: 1),
            .init(Legacy.Parts.biomass, amount: 10)
        ],
        output: .init(Legacy.Parts.gasNobelisk, amount: 1),
        duration: 12
    )

    static let pulseNobeliskRecipe = RecipeLegacy(
        id: "pulse-nobelisk",
        name: "Pulse Nobelisk",
        input: [
            .init(Legacy.Parts.nobelisk, amount: 5),
            .init(Legacy.Parts.crystalOscillator, amount: 1)
        ],
        output: .init(Legacy.Parts.pulseNobelisk, amount: 5),
        duration: 60
    )

    static let clusterNobeliskRecipe = RecipeLegacy(
        id: "cluster-nobelisk",
        name: "Cluster Nobelisk",
        input: [
            .init(Legacy.Parts.nobelisk, amount: 3),
            .init(Legacy.Parts.smokelessPowder, amount: 4)
        ],
        output: .init(Legacy.Parts.clusterNobelisk, amount: 1),
        duration: 24
    )

    // Space Elevator
    static let smartPlatingRecipe = RecipeLegacy(
        id: "smart-plating",
        name: "Smart Plating",
        input: [
            .init(Legacy.Parts.reinforcedIronPlate, amount: 1),
            .init(Legacy.Parts.rotor, amount: 1)
        ],
        output: .init(Legacy.Parts.smartPlating, amount: 1),
        duration: 30
    )

    static let versatileFrameworkRecipe = RecipeLegacy(
        id: "versatile-framework",
        name: "Versatile Framework",
        input: [
            .init(Legacy.Parts.modularFrame, amount: 1),
            .init(Legacy.Parts.steelBeam, amount: 12)
        ],
        output: .init(Legacy.Parts.versatileFramework, amount: 2),
        duration: 24
    )

    static let automatedWiringRecipe = RecipeLegacy(
        id: "automated-wiring",
        name: "Automated Wiring",
        input: [
            .init(Legacy.Parts.stator, amount: 1),
            .init(Legacy.Parts.cable, amount: 20)
        ],
        output: .init(Legacy.Parts.automatedWiring, amount: 1),
        duration: 24
    )

    static let assemblyDirectorSystemRecipe = RecipeLegacy(
        id: "assembly-director-system",
        name: "Assembly Director System",
        input: [
            .init(Legacy.Parts.adaptiveControlUnit, amount: 2),
            .init(Legacy.Parts.supercomputer, amount: 1)
        ],
        output: .init(Legacy.Parts.assemblyDirectorSystem, amount: 1),
        duration: 80
    )

    // Biomass
    static let fabricRecipe = RecipeLegacy(
        id: "fabric",
        name: "Fabric",
        input: [
            .init(Legacy.Parts.mycelia, amount: 1),
            .init(Legacy.Parts.biomass, amount: 5)
        ],
        output: .init(Legacy.Parts.fabric, amount: 1),
        duration: 4
    )

    // Containers
    static let pressureConversionCubeRecipe = RecipeLegacy(
        id: "pressure-conversion-cube",
        name: "Pressure Conversion Cube",
        input: [
            .init(Legacy.Parts.fusedModularFrame, amount: 1),
            .init(Legacy.Parts.radioControlUnit, amount: 2)
        ],
        output: .init(Legacy.Parts.pressureConversionCube, amount: 1),
        duration: 60
    )

    static let emptyCanisterRecipe2 = RecipeLegacy(
        id: "alternate-coated-iron-canister",
        name: "Alternate: Coated Iron Canister",
        input: [
            .init(Legacy.Parts.ironPlate, amount: 2),
            .init(Legacy.Parts.copperSheet, amount: 1)
        ],
        output: .init(Legacy.Parts.emptyCanister, amount: 4),
        duration: 4,
        isDefault: false
    )

    static let assemblerRecipes = [
        // Standard Parts
        reinforcedIronPlateRecipe,
        reinforcedIronPlateRecipe1,
        reinforcedIronPlateRecipe2,
        reinforcedIronPlateRecipe3,
        modularFrameRecipe,
        modularFrameRecipe1,
        modularFrameRecipe2,
        ironPlateRecipe1,
        ironPlateRecipe2,
        encasedIndustrialBeamRecipe,
        encasedIndustrialBeamRecipe1,
        alcladAluminumSheetRecipe,
        aluminumCasingRecipe1,
        
        // Industrial Parts
        rotorRecipe,
        rotorRecipe1,
        rotorRecipe2,
        statorRecipe,
        statorRecipe1,
        motorRecipe,
        heatSinkRecipe,
        heatSinkRecipe1,
        
        // Electronics
        circuitBoardRecipe,
        circuitBoardRecipe1,
        circuitBoardRecipe2,
        circuitBoardRecipe3,
        aiLimiterRecipe,
        wireRecipe3,
        cableRecipe1,
        cableRecipe2,
        quickwireRecipe1,
        computerRecipe1,
        supercomputerRecipe2,
        
        // Minerals
        concreteRecipe1,
        concreteRecipe2,
        compactedCoalRecipe,
        silicaRecipe1,
        
        // Nuclear
        electromagneticControlRodRecipe,
        electromagneticControlRodRecipe1,
        encasedPlutoniumCellRecipe,
        plutoniumFuelRodRecipe1,
        
        // Consumed
        blackPowderRecipe,
        blackPowderRecipe1,
        stunRebarRecipe,
        shatterRebarRecipe,
        nobeliskRecipe,
        gasNobeliskRecipe,
        pulseNobeliskRecipe,
        clusterNobeliskRecipe,
        
        // Space Elevator
        smartPlatingRecipe,
        versatileFrameworkRecipe,
        automatedWiringRecipe,
        assemblyDirectorSystemRecipe,
        
        // Biomass
        fabricRecipe,
        
        // Containers
        pressureConversionCubeRecipe,
        emptyCanisterRecipe2,
    ]
}
