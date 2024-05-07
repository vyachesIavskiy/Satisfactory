
extension LegacyToV2.Parts {
    static let leaves = Migration.IDs(old: Legacy.Parts.leaves, new: V2.Parts.leaves)
    static let wood = Migration.IDs(old: Legacy.Parts.wood, new: V2.Parts.wood)
    static let mycelia = Migration.IDs(old: Legacy.Parts.mycelia, new: V2.Parts.mycelia)
    static let flowerPetals = Migration.IDs(old: Legacy.Parts.flowerPetals, new: V2.Parts.flowerPetals)
    static let compactedCoal = Migration.IDs(old: Legacy.Parts.compactedCoal, new: V2.Parts.compactedCoal)
    
    static let fuelParts = [
        leaves,
        wood,
        mycelia,
        flowerPetals,
        compactedCoal
    ]
}
