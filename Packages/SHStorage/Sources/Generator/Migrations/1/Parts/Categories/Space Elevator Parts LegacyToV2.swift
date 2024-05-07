
extension LegacyToV2.Parts {
    static let smartPlating = Migration.IDs(old: Legacy.Parts.smartPlating, new: V2.Parts.smartPlating)
    static let versatileFramework = Migration.IDs(old: Legacy.Parts.versatileFramework, new: V2.Parts.versatileFramework)
    static let automatedWiring = Migration.IDs(old: Legacy.Parts.automatedWiring, new: V2.Parts.automatedWiring)
    static let modularEngine = Migration.IDs(old: Legacy.Parts.modularEngine, new: V2.Parts.modularEngine)
    static let adaptiveControlUnit = Migration.IDs(old: Legacy.Parts.adaptiveControlUnit, new: V2.Parts.adaptiveControlUnit)
    static let assemblyDirectorSystem = Migration.IDs(old: Legacy.Parts.assemblyDirectorSystem, new: V2.Parts.assemblyDirectorSystem)
    static let magneticFieldGenerator = Migration.IDs(old: Legacy.Parts.magneticFieldGenerator, new: V2.Parts.magneticFieldGenerator)
    static let thermalPropulsionRocket = Migration.IDs(old: Legacy.Parts.thermalPropulsionRocket, new: V2.Parts.thermalPropulsionRocket)
    static let nuclearPasta = Migration.IDs(old: Legacy.Parts.nuclearPasta, new: V2.Parts.nuclearPasta)
    
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
