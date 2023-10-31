
extension LegacyToV2.Parts {
    static let biomass = Migration.IDs(old: Legacy.Parts.biomass, new: V2.Parts.biomass)
    static let solidBiofuel = Migration.IDs(old: Legacy.Parts.solidBiofuel, new: V2.Parts.solidBiofuel)
    static let fabric = Migration.IDs(old: Legacy.Parts.fabric, new: V2.Parts.fabric)
    
    static let biomassParts = [
        biomass,
        solidBiofuel,
        fabric
    ]
}
