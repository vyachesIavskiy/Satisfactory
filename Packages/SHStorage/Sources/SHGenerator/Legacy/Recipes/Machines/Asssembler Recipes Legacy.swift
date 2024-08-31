import SHModels
import SHStaticModels

private extension Recipe.Static.Legacy {
    init(id: String, output: Ingredient, input: [Ingredient]) {
        self.init(id: id, output: [output], input: input)
    }
}

extension Legacy.Recipes {
    // Standard Parts
    static let reinforcedIronPlateRecipe = Recipe.Static.Legacy(
        id: "reinforced-iron-plate",
        output: .init(Legacy.Parts.reinforcedIronPlate),
        input: [
            .init(Legacy.Parts.ironPlate),
            .init(Legacy.Parts.screw)
        ]
    )

    static let reinforcedIronPlateRecipe1 = Recipe.Static.Legacy(
        id: "alternate-adhered-iron-plate",
        output: .init(Legacy.Parts.reinforcedIronPlate),
        input: [
            .init(Legacy.Parts.ironPlate),
            .init(Legacy.Parts.rubber)
        ]
    )

    static let reinforcedIronPlateRecipe2 = Recipe.Static.Legacy(
        id: "alternate-bolted-iron-plate",
        output: .init(Legacy.Parts.reinforcedIronPlate),
        input: [
            .init(Legacy.Parts.ironPlate),
            .init(Legacy.Parts.screw)
        ]
    )

    static let reinforcedIronPlateRecipe3 = Recipe.Static.Legacy(
        id: "alternate-stitched-iron-plate",
        output: .init(Legacy.Parts.reinforcedIronPlate),
        input: [
            .init(Legacy.Parts.ironPlate),
            .init(Legacy.Parts.wire)
        ]
    )

    static let modularFrameRecipe = Recipe.Static.Legacy(
        id: "modular-frame",
        output: .init(Legacy.Parts.modularFrame),
        input: [
            .init(Legacy.Parts.reinforcedIronPlate),
            .init(Legacy.Parts.ironRod)
        ]
    )

    static let modularFrameRecipe1 = Recipe.Static.Legacy(
        id: "alternate-bolted-frame",
        output: .init(Legacy.Parts.modularFrame),
        input: [
            .init(Legacy.Parts.reinforcedIronPlate),
            .init(Legacy.Parts.screw)
        ]
    )

    static let modularFrameRecipe2 = Recipe.Static.Legacy(
        id: "alternate-steeled-frame",
        output: .init(Legacy.Parts.modularFrame),
        input: [
            .init(Legacy.Parts.reinforcedIronPlate),
            .init(Legacy.Parts.steelPipe)
        ]
    )

    static let encasedIndustrialBeamRecipe = Recipe.Static.Legacy(
        id: "encased-industrial-beam",
        output: .init(Legacy.Parts.encasedIndustrialBeam),
        input: [
            .init(Legacy.Parts.steelBeam),
            .init(Legacy.Parts.concrete)
        ]
    )

    static let encasedIndustrialBeamRecipe1 = Recipe.Static.Legacy(
        id: "alternate-encased-industrial-pipe",
        output: .init(Legacy.Parts.encasedIndustrialBeam),
        input: [
            .init(Legacy.Parts.steelPipe),
            .init(Legacy.Parts.concrete)
        ]
    )

    static let alcladAluminumSheetRecipe = Recipe.Static.Legacy(
        id: "alclad-aluminum-sheet",
        output: .init(Legacy.Parts.alcladAluminumSheet),
        input: [
            .init(Legacy.Parts.aluminumIngot),
            .init(Legacy.Parts.copperIngot)
        ]
    )

    static let ironPlateRecipe1 = Recipe.Static.Legacy(
        id: "alternate-coated-iron-plate",
        output: .init(Legacy.Parts.ironPlate),
        input: [
            .init(Legacy.Parts.ironIngot),
            .init(Legacy.Parts.plastic)
        ]
    )

    static let ironPlateRecipe2 = Recipe.Static.Legacy(
        id: "alternate-steel-coated-plate",
        output: .init(Legacy.Parts.ironPlate),
        input: [
            .init(Legacy.Parts.steelIngot),
            .init(Legacy.Parts.plastic)
        ]
    )

    static let aluminumCasingRecipe1 = Recipe.Static.Legacy(
        id: "alternate-alclad-casing",
        output: .init(Legacy.Parts.aluminumCasing),
        input: [
            .init(Legacy.Parts.aluminumIngot),
            .init(Legacy.Parts.copperIngot)
        ]
    )

    // Industrial Parts
    static let rotorRecipe = Recipe.Static.Legacy(
        id: "rotor",
        output: .init(Legacy.Parts.rotor),
        input: [
            .init(Legacy.Parts.ironRod),
            .init(Legacy.Parts.screw)
        ]
    )

    static let rotorRecipe1 = Recipe.Static.Legacy(
        id: "alternate-copper-rotor",
        output: .init(Legacy.Parts.rotor),
        input: [
            .init(Legacy.Parts.copperSheet),
            .init(Legacy.Parts.screw)
        ]
    )

    static let rotorRecipe2 = Recipe.Static.Legacy(
        id: "alternate-steel-rotor",
        output: .init(Legacy.Parts.rotor),
        input: [
            .init(Legacy.Parts.steelPipe),
            .init(Legacy.Parts.wire)
        ]
    )

    static let statorRecipe = Recipe.Static.Legacy(
        id: "stator",
        output: .init(Legacy.Parts.stator),
        input: [
            .init(Legacy.Parts.steelPipe),
            .init(Legacy.Parts.wire)
        ]
    )

    static let statorRecipe1 = Recipe.Static.Legacy(
        id: "alternate-quickwire-stator",
        output: .init(Legacy.Parts.stator),
        input: [
            .init(Legacy.Parts.steelPipe),
            .init(Legacy.Parts.quickwire)
        ]
    )

    static let motorRecipe = Recipe.Static.Legacy(
        id: "motor",
        output: .init(Legacy.Parts.motor),
        input: [
            .init(Legacy.Parts.rotor),
            .init(Legacy.Parts.stator)
        ]
    )

    static let motorRecipe1 = Recipe.Static.Legacy(
        id: "alternate-electric-motor",
        output: .init(Legacy.Parts.motor),
        input: [
            .init(Legacy.Parts.electromagneticControlRod),
            .init(Legacy.Parts.rotor)
        ]
    )

    static let heatSinkRecipe = Recipe.Static.Legacy(
        id: "heat-sink",
        output: .init(Legacy.Parts.heatSink),
        input: [
            .init(Legacy.Parts.alcladAluminumSheet),
            .init(Legacy.Parts.copperSheet)
        ]
    )

    static let heatSinkRecipe1 = Recipe.Static.Legacy(
        id: "alternate-heat-exchanger",
        output: .init(Legacy.Parts.heatSink),
        input: [
            .init(Legacy.Parts.aluminumCasing),
            .init(Legacy.Parts.rubber)
        ]
    )

    // Electronics
    static let circuitBoardRecipe = Recipe.Static.Legacy(
        id: "circuit-board",
        output: .init(Legacy.Parts.circuitBoard),
        input: [
            .init(Legacy.Parts.copperSheet),
            .init(Legacy.Parts.plastic)
        ]
    )

    static let circuitBoardRecipe1 = Recipe.Static.Legacy(
        id: "alternate-electrode-circuit-board",
        output: .init(Legacy.Parts.circuitBoard),
        input: [
            .init(Legacy.Parts.rubber),
            .init(Legacy.Parts.petroleumCoke)
        ]
    )

    static let circuitBoardRecipe2 = Recipe.Static.Legacy(
        id: "alternate-silicone-circuit-board",
        output: .init(Legacy.Parts.circuitBoard),
        input: [
            .init(Legacy.Parts.copperSheet),
            .init(Legacy.Parts.silica)
        ]
    )

    static let circuitBoardRecipe3 = Recipe.Static.Legacy(
        id: "alternate-caterium-circuit-board",
        output: .init(Legacy.Parts.circuitBoard),
        input: [
            .init(Legacy.Parts.plastic),
            .init(Legacy.Parts.quickwire)
        ]
    )

    static let aiLimiterRecipe = Recipe.Static.Legacy(
        id: "ai-limiter",
        output: .init(Legacy.Parts.aiLimiter),
        input: [
            .init(Legacy.Parts.copperSheet),
            .init(Legacy.Parts.quickwire)
        ]
    )

    static let wireRecipe3 = Recipe.Static.Legacy(
        id: "alternate-fused-wire",
        output: .init(Legacy.Parts.wire),
        input: [
            .init(Legacy.Parts.copperIngot),
            .init(Legacy.Parts.cateriumIngot)
        ]
    )

    static let cableRecipe1 = Recipe.Static.Legacy(
        id: "alternate-insulated-cable",
        output: .init(Legacy.Parts.cable),
        input: [
            .init(Legacy.Parts.wire),
            .init(Legacy.Parts.rubber)
        ]
    )

    static let cableRecipe2 = Recipe.Static.Legacy(
        id: "alternate-quickwire-cable",
        output: .init(Legacy.Parts.cable),
        input: [
            .init(Legacy.Parts.quickwire),
            .init(Legacy.Parts.rubber)
        ]
    )

    static let quickwireRecipe1 = Recipe.Static.Legacy(
        id: "alternate-fused-quickwire",
        output: .init(Legacy.Parts.quickwire),
        input: [
            .init(Legacy.Parts.cateriumIngot),
            .init(Legacy.Parts.copperIngot)
        ]
    )

    static let computerRecipe1 = Recipe.Static.Legacy(
        id: "alternate-crystal-computer",
        output: .init(Legacy.Parts.computer),
        input: [
            .init(Legacy.Parts.circuitBoard),
            .init(Legacy.Parts.crystalOscillator)
        ]
    )

    static let supercomputerRecipe2 = Recipe.Static.Legacy(
        id: "alternate-oc-supercomputer",
        output: .init(Legacy.Parts.supercomputer),
        input: [
            .init(Legacy.Parts.radioControlUnit),
            .init(Legacy.Parts.coolingSystem)
        ]
    )

    // Minerals
    static let concreteRecipe1 = Recipe.Static.Legacy(
        id: "alternate-rubber-concrete",
        output: .init(Legacy.Parts.concrete),
        input: [
            .init(Legacy.Parts.limestone),
            .init(Legacy.Parts.rubber)
        ]
    )

    static let concreteRecipe2 = Recipe.Static.Legacy(
        id: "alternate-fine-concrete",
        output: .init(Legacy.Parts.concrete),
        input: [
            .init(Legacy.Parts.silica),
            .init(Legacy.Parts.limestone)
        ]
    )

    static let compactedCoalRecipe = Recipe.Static.Legacy(
        id: "alternate-compacted-coal",
        output: .init(Legacy.Parts.compactedCoal),
        input: [
            .init(Legacy.Parts.coal),
            .init(Legacy.Parts.sulfur)
        ]
    )

    static let silicaRecipe1 = Recipe.Static.Legacy(
        id: "alternate-cheap-silica",
        output: .init(Legacy.Parts.silica),
        input: [
            .init(Legacy.Parts.rawQuartz),
            .init(Legacy.Parts.limestone)
        ]
    )

    // Nuclear
    static let electromagneticControlRodRecipe = Recipe.Static.Legacy(
        id: "electromagnetic-control-rod",
        output: .init(Legacy.Parts.electromagneticControlRod),
        input: [
            .init(Legacy.Parts.stator),
            .init(Legacy.Parts.aiLimiter)
        ]
    )

    static let electromagneticControlRodRecipe1 = Recipe.Static.Legacy(
        id: "alternate-electromagnetic-connection-rod",
        output: .init(Legacy.Parts.electromagneticControlRod),
        input: [
            .init(Legacy.Parts.stator),
            .init(Legacy.Parts.highSpeedConnector)
        ]
    )

    static let encasedPlutoniumCellRecipe = Recipe.Static.Legacy(
        id: "encased-plutonium-cell",
        output: .init(Legacy.Parts.encasedPlutoniumCell),
        input: [
            .init(Legacy.Parts.plutoniumPellet),
            .init(Legacy.Parts.concrete)
        ]
    )

    static let plutoniumFuelRodRecipe1 = Recipe.Static.Legacy(
        id: "alternate-plutonium-fuel-unit",
        output: .init(Legacy.Parts.plutoniumFuelRod),
        input: [
            .init(Legacy.Parts.encasedPlutoniumCell),
            .init(Legacy.Parts.pressureConversionCube)
        ]
    )

    // Consumed
    static let blackPowderRecipe = Recipe.Static.Legacy(
        id: "black-powder",
        output: .init(Legacy.Parts.blackPowder),
        input: [
            .init(Legacy.Parts.coal),
            .init(Legacy.Parts.sulfur)
        ]
    )

    static let blackPowderRecipe1 = Recipe.Static.Legacy(
        id: "alternate-fine-black-powder",
        output: .init(Legacy.Parts.blackPowder),
        input: [
            .init(Legacy.Parts.sulfur),
            .init(Legacy.Parts.compactedCoal)
        ]
    )

    static let stunRebarRecipe = Recipe.Static.Legacy(
        id: "stun-rebar",
        output: .init(Legacy.Parts.stunRebar),
        input: [
            .init(Legacy.Parts.ironRebar),
            .init(Legacy.Parts.quickwire)
        ]
    )

    static let shatterRebarRecipe = Recipe.Static.Legacy(
        id: "shutter-rebar",
        output: .init(Legacy.Parts.shatterRebar),
        input: [
            .init(Legacy.Parts.ironRebar),
            .init(Legacy.Parts.quartzCrystal)
        ]
    )

    static let nobeliskRecipe = Recipe.Static.Legacy(
        id: "nobelisk",
        output: .init(Legacy.Parts.nobelisk),
        input: [
            .init(Legacy.Parts.blackPowder),
            .init(Legacy.Parts.steelPipe)
        ]
    )

    static let gasNobeliskRecipe = Recipe.Static.Legacy(
        id: "gas-nobelisk",
        output: .init(Legacy.Parts.gasNobelisk),
        input: [
            .init(Legacy.Parts.nobelisk),
            .init(Legacy.Parts.biomass)
        ]
    )

    static let pulseNobeliskRecipe = Recipe.Static.Legacy(
        id: "pulse-nobelisk",
        output: .init(Legacy.Parts.pulseNobelisk),
        input: [
            .init(Legacy.Parts.nobelisk),
            .init(Legacy.Parts.crystalOscillator)
        ]
    )

    static let clusterNobeliskRecipe = Recipe.Static.Legacy(
        id: "cluster-nobelisk",
        output: .init(Legacy.Parts.clusterNobelisk),
        input: [
            .init(Legacy.Parts.nobelisk),
            .init(Legacy.Parts.smokelessPowder)
        ]
    )

    // Space Elevator
    static let smartPlatingRecipe = Recipe.Static.Legacy(
        id: "smart-plating",
        output: .init(Legacy.Parts.smartPlating),
        input: [
            .init(Legacy.Parts.reinforcedIronPlate),
            .init(Legacy.Parts.rotor)
        ]
    )

    static let versatileFrameworkRecipe = Recipe.Static.Legacy(
        id: "versatile-framework",
        output: .init(Legacy.Parts.versatileFramework),
        input: [
            .init(Legacy.Parts.modularFrame),
            .init(Legacy.Parts.steelBeam)
        ]
    )

    static let automatedWiringRecipe = Recipe.Static.Legacy(
        id: "automated-wiring",
        output: .init(Legacy.Parts.automatedWiring),
        input: [
            .init(Legacy.Parts.stator),
            .init(Legacy.Parts.cable)
        ]
    )

    static let assemblyDirectorSystemRecipe = Recipe.Static.Legacy(
        id: "assembly-director-system",
        output: .init(Legacy.Parts.assemblyDirectorSystem),
        input: [
            .init(Legacy.Parts.adaptiveControlUnit),
            .init(Legacy.Parts.supercomputer)
        ]
    )

    // Biomass
    static let fabricRecipe = Recipe.Static.Legacy(
        id: "fabric",
        output: .init(Legacy.Parts.fabric),
        input: [
            .init(Legacy.Parts.mycelia),
            .init(Legacy.Parts.biomass)
        ]
    )

    // Containers
    static let pressureConversionCubeRecipe = Recipe.Static.Legacy(
        id: "pressure-conversion-cube",
        output: .init(Legacy.Parts.pressureConversionCube),
        input: [
            .init(Legacy.Parts.fusedModularFrame),
            .init(Legacy.Parts.radioControlUnit)
        ]
    )

    static let emptyCanisterRecipe2 = Recipe.Static.Legacy(
        id: "alternate-coated-iron-canister",
        output: .init(Legacy.Parts.emptyCanister),
        input: [
            .init(Legacy.Parts.ironPlate),
            .init(Legacy.Parts.copperSheet)
        ]
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
