
extension LegacyToV2.Parts {
    static let ironOre = Migration.IDs(old: Legacy.Parts.ironOre, new: V2.Parts.ironOre)
    static let copperOre = Migration.IDs(old: Legacy.Parts.copperOre, new: V2.Parts.copperOre)
    static let limestone = Migration.IDs(old: Legacy.Parts.limestone, new: V2.Parts.limestone)
    static let coal = Migration.IDs(old: Legacy.Parts.coal, new: V2.Parts.coal)
    static let cateriumOre = Migration.IDs(old: Legacy.Parts.cateriumOre, new: V2.Parts.cateriumOre)
    static let bauxite = Migration.IDs(old: Legacy.Parts.bauxite, new: V2.Parts.bauxite)
    static let rawQuartz = Migration.IDs(old: Legacy.Parts.rawQuartz, new: V2.Parts.rawQuartz)
    static let sulfur = Migration.IDs(old: Legacy.Parts.sulfur, new: V2.Parts.sulfur)
    static let uranium = Migration.IDs(old: Legacy.Parts.uranium, new: V2.Parts.uranium)
    
    static let oreParts = [
        ironOre,
        copperOre,
        limestone,
        coal,
        cateriumOre,
        bauxite,
        rawQuartz,
        sulfur,
        uranium
    ]
}
