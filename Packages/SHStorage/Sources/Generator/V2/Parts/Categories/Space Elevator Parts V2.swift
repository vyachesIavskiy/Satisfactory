import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .spaceElevatorParts, form: .solid)
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
