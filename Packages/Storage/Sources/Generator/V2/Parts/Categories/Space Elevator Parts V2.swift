import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .spaceElevatorParts, form: .solid)
    }
}

extension V2.Parts {
    static let smartPlating = Part(id: "part-smart-plating")
    static let versatileFramework = Part(id: "part-versatile-framework")
    static let automatedWiring = Part(id: "part-automated-wiring")
    static let modularEngine = Part(id: "part-modular-engine")
    static let adaptiveControlUnit = Part(id: "part-adaptive-control-unit")
    static let assemblyDirectorSystem = Part(id: "part-assembly-director-system")
    static let magneticFieldGenerator = Part(id: "part-magnetic-field-generator")
    static let thermalPropulsionRocket = Part(id: "part-thermal-propulsion-rocket")
    static let nuclearPasta = Part(id: "part-nuclear-pasta")
    
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
