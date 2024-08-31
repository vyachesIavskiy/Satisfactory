import SHModels
import SHStaticModels

extension Legacy.Parts {
    static let smartPlating = Part.Static.Legacy(id: "smart-plating")
    static let versatileFramework = Part.Static.Legacy(id: "versatile-framework")
    static let automatedWiring = Part.Static.Legacy(id: "automated-wiring")
    static let modularEngine = Part.Static.Legacy(id: "modular-engine")
    static let adaptiveControlUnit = Part.Static.Legacy(id: "adaptive-control-unit")
    static let assemblyDirectorSystem = Part.Static.Legacy(id: "assembly-director-system")
    static let magneticFieldGenerator = Part.Static.Legacy(id: "magnetic-field-generator")
    static let thermalPropulsionRocket = Part.Static.Legacy(id: "thermal-propulsion-rocket")
    static let nuclearPasta = Part.Static.Legacy(id: "nuclear-pasta")
    
    static let spaceElevatorParts = [
        smartPlating,
        versatileFramework,
        automatedWiring,
        modularEngine,
        adaptiveControlUnit,
        assemblyDirectorSystem,
        magneticFieldGenerator,
        thermalPropulsionRocket,
        nuclearPasta
    ]
}
