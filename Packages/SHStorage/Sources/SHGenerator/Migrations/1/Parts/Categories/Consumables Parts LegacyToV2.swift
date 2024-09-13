
extension LegacyToV2.Parts {
    static let gasFilter = Migration.IDs(old: Legacy.Parts.gasFilter, new: V2.Parts.gasFilter)
    static let iodineInfusedFilter = Migration.IDs(old: Legacy.Parts.iodineInfusedFilter, new: V2.Parts.iodineInfusedFilter)
    
    static let consumablesParts = [
        gasFilter,
        iodineInfusedFilter,
    ]
}
