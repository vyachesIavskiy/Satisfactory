
extension LegacyToV2.Parts {
    static let crystalOscillator = Migration.IDs(old: Legacy.Parts.crystalOscillator, new: V2.Parts.crystalOscillator)
    static let computer = Migration.IDs(old: Legacy.Parts.computer, new: V2.Parts.computer)
    static let radioControlUnit = Migration.IDs(old: Legacy.Parts.radioControlUnit, new: V2.Parts.radioControlUnit)
    static let supercomputer = Migration.IDs(old: Legacy.Parts.supercomputer, new: V2.Parts.supercomputer)
    
    static let communicationParts = [
        crystalOscillator,
        computer,
        radioControlUnit,
        supercomputer
    ]
}
