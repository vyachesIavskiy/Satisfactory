
extension LegacyToV2.Parts {
    static let plastic = Migration.IDs(old: Legacy.Parts.plastic, new: V2.Parts.plastic)
    static let rubber = Migration.IDs(old: Legacy.Parts.rubber, new: V2.Parts.rubber)
    static let polymerResin = Migration.IDs(old: Legacy.Parts.polymerResin, new: V2.Parts.polymerResin)
    static let petroleumCoke = Migration.IDs(old: Legacy.Parts.petroleumCoke, new: V2.Parts.petroleumCoke)
    
    static let oilProductsParts = [
        plastic,
        rubber,
        polymerResin,
        petroleumCoke,
    ]
}
