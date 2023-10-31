import StaticModels

private extension PartLegacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.spaceElevatorParts.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let smartPlating = PartLegacy(id: "smart-plating")
    static let versatileFramework = PartLegacy(id: "versatile-framework")
    static let automatedWiring = PartLegacy(id: "automated-wiring")
    static let modularEngine = PartLegacy(id: "modular-engine")
    static let adaptiveControlUnit = PartLegacy(id: "adaptive-control-unit")
    static let assemblyDirectorSystem = PartLegacy(id: "assembly-director-system")
    static let magneticFieldGenerator = PartLegacy(id: "magnetic-field-generator")
    static let thermalPropulsionRocket = PartLegacy(id: "thermal-propulsion-rocket")
    static let nuclearPasta = PartLegacy(id: "nuclear-pasta")
    
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
