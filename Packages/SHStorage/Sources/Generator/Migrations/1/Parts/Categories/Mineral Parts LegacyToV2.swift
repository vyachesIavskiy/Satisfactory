
extension LegacyToV2.Parts {
    static let concrete = Migration.IDs(old: Legacy.Parts.concrete, new: V2.Parts.concrete)
    static let quartzCrystal = Migration.IDs(old: Legacy.Parts.quartzCrystal, new: V2.Parts.quartzCrystal)
    static let silica = Migration.IDs(old: Legacy.Parts.silica, new: V2.Parts.silica)
    static let aluminumScrap = Migration.IDs(old: Legacy.Parts.aluminumScrap, new: V2.Parts.aluminumScrap)
    static let copperPowder = Migration.IDs(old: Legacy.Parts.copperPowder, new: V2.Parts.copperPowder)
    
    static let mineralParts = [
        concrete,
        quartzCrystal,
        silica,
        aluminumScrap,
        copperPowder
    ]
}
