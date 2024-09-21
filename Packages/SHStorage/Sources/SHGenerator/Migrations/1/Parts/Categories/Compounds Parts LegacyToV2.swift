
extension LegacyToV2.Parts {
    static let concrete = Migration.IDs(old: Legacy.Parts.concrete, new: V2.Parts.concrete)
    static let compactedCoal = Migration.IDs(old: Legacy.Parts.compactedCoal, new: V2.Parts.compactedCoal)
    static let quartzCrystal = Migration.IDs(old: Legacy.Parts.quartzCrystal, new: V2.Parts.quartzCrystal)
    static let silica = Migration.IDs(old: Legacy.Parts.silica, new: V2.Parts.silica)
    static let aluminumScrap = Migration.IDs(old: Legacy.Parts.aluminumScrap, new: V2.Parts.aluminumScrap)
    static let copperPowder = Migration.IDs(old: Legacy.Parts.copperPowder, new: V2.Parts.copperPowder)
    
    static let compoundsParts = [
        concrete,
        compactedCoal,
        quartzCrystal,
        silica,
        aluminumScrap,
        copperPowder,
    ]
}
