
extension LegacyToV2.Parts {
    static let ironIngot = Migration.IDs(old: Legacy.Parts.ironIngot, new: V2.Parts.ironIngot)
    static let copperIngot = Migration.IDs(old: Legacy.Parts.copperIngot, new: V2.Parts.copperIngot)
    static let steelIngot = Migration.IDs(old: Legacy.Parts.steelIngot, new: V2.Parts.steelIngot)
    static let cateriumIngot = Migration.IDs(old: Legacy.Parts.cateriumIngot, new: V2.Parts.cateriumIngot)
    static let aluminumIngot = Migration.IDs(old: Legacy.Parts.aluminumIngot, new: V2.Parts.aluminumIngot)
    
    static let ingotParts = [
        ironIngot,
        copperIngot,
        steelIngot,
        cateriumIngot,
        aluminumIngot,
    ]
}
