
extension LegacyToV2.Parts {
    static let leaves = Migration.IDs(old: Legacy.Parts.leaves, new: V2.Parts.leaves)
    static let wood = Migration.IDs(old: Legacy.Parts.wood, new: V2.Parts.wood)
    static let mycelia = Migration.IDs(old: Legacy.Parts.mycelia, new: V2.Parts.mycelia)
    static let biomass = Migration.IDs(old: Legacy.Parts.biomass, new: V2.Parts.biomass)
    static let fabric = Migration.IDs(old: Legacy.Parts.fabric, new: V2.Parts.fabric)
    static let solidBiofuel = Migration.IDs(old: Legacy.Parts.solidBiofuel, new: V2.Parts.solidBiofuel)
    
    static let biomassParts = [
        leaves,
        wood,
        mycelia,
        biomass,
        fabric,
        solidBiofuel,
    ]
}
