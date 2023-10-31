
extension LegacyToV2.Parts {
    static let rotor = Migration.IDs(old: Legacy.Parts.rotor, new: V2.Parts.rotor)
    static let stator = Migration.IDs(old: Legacy.Parts.stator, new: V2.Parts.stator)
    static let motor = Migration.IDs(old: Legacy.Parts.motor, new: V2.Parts.motor)
    static let heatSink = Migration.IDs(old: Legacy.Parts.heatSink, new: V2.Parts.heatSink)
    static let coolingSystem = Migration.IDs(old: Legacy.Parts.coolingSystem, new: V2.Parts.coolingSystem)
    static let fusedModularFrame = Migration.IDs(old: Legacy.Parts.fusedModularFrame, new: V2.Parts.fusedModularFrame)
    static let battery = Migration.IDs(old: Legacy.Parts.battery, new: V2.Parts.battery)
    static let turboMotor = Migration.IDs(old: Legacy.Parts.turboMotor, new: V2.Parts.turboMotor)
    
    static let industrialParts = [
        rotor,
        stator,
        motor,
        heatSink,
        coolingSystem,
        fusedModularFrame,
        battery,
        turboMotor
    ]
}
