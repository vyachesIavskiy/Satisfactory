import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .spaceElevator, form: .solid)
    }
}

extension V2.Parts {
    static let smartPlating = Part.Static(id: "part-smart-plating")
    static let versatileFramework = Part.Static(id: "part-versatile-framework")
    static let automatedWiring = Part.Static(id: "part-automated-wiring")
    static let modularEngine = Part.Static(id: "part-modular-engine")
    static let adaptiveControlUnit = Part.Static(id: "part-adaptive-control-unit")
    static let assemblyDirectorSystem = Part.Static(id: "part-assembly-director-system")
    static let magneticFieldGenerator = Part.Static(id: "part-magnetic-field-generator")
    static let thermalPropulsionRocket = Part.Static(id: "part-thermal-propulsion-rocket")
    static let nuclearPasta = Part.Static(id: "part-nuclear-pasta")
    static let biochemicalSculptor = Part.Static(id: "part-biochemical-sculptor")
    static let aiExpansionServer = Part.Static(id: "part-ai-expansion-server")
    static let ballisticWarpDrive = Part.Static(id: "part-ballistic-warp-drive")
    
    static let spaceElevatorParts = [
        smartPlating,
        versatileFramework,
        automatedWiring,
        modularEngine,
        adaptiveControlUnit,
        assemblyDirectorSystem,
        magneticFieldGenerator,
        thermalPropulsionRocket,
        nuclearPasta,
        biochemicalSculptor,
        ballisticWarpDrive,
        aiExpansionServer,
    ]
}
