
extension LegacyToV2.Parts {
    static let colorCartridge = Migration.IDs(old: Legacy.Parts.colorCartridge, new: V2.Parts.colorCartridge)
    static let ironRebar = Migration.IDs(old: Legacy.Parts.ironRebar, new: V2.Parts.ironRebar)
    static let stunRebar = Migration.IDs(old: Legacy.Parts.stunRebar, new: V2.Parts.stunRebar)
    static let shatterRebar = Migration.IDs(old: Legacy.Parts.shatterRebar, new: V2.Parts.shatterRebar)
    static let explosiveRebar = Migration.IDs(old: Legacy.Parts.explosiveRebar, new: V2.Parts.explosiveRebar)
    static let blackPowder = Migration.IDs(old: Legacy.Parts.blackPowder, new: V2.Parts.blackPowder)
    static let smokelessPowder = Migration.IDs(old: Legacy.Parts.smokelessPowder, new: V2.Parts.smokelessPowder)
    static let nobelisk = Migration.IDs(old: Legacy.Parts.nobelisk, new: V2.Parts.nobelisk)
    static let gasNobelisk = Migration.IDs(old: Legacy.Parts.gasNobelisk, new: V2.Parts.gasNobelisk)
    static let pulseNobelisk = Migration.IDs(old: Legacy.Parts.pulseNobelisk, new: V2.Parts.pulseNobelisk)
    static let clusterNobelisk = Migration.IDs(old: Legacy.Parts.clusterNobelisk, new: V2.Parts.clusterNobelisk)
    static let nukeNobelisk = Migration.IDs(old: Legacy.Parts.nukeNobelisk, new: V2.Parts.nukeNobelisk)
    static let rifleAmmo = Migration.IDs(old: Legacy.Parts.rifleAmmo, new: V2.Parts.rifleAmmo)
    static let homingRifleAmmo = Migration.IDs(old: Legacy.Parts.homingRifleAmmo, new: V2.Parts.homingRifleAmmo)
    static let turboRifleAmmo = Migration.IDs(old: Legacy.Parts.turboRifleAmmo, new: V2.Parts.turboRifleAmmo)
    static let gasFilter = Migration.IDs(old: Legacy.Parts.gasFilter, new: V2.Parts.gasFilter)
    static let iodineInfusedFilter = Migration.IDs(old: Legacy.Parts.iodineInfusedFilter, new: V2.Parts.iodineInfusedFilter)
    
    static let consumedParts = [
        colorCartridge,
        ironRebar,
        stunRebar,
        shatterRebar,
        explosiveRebar,
        blackPowder,
        smokelessPowder,
        nobelisk,
        gasNobelisk,
        pulseNobelisk,
        clusterNobelisk,
        nukeNobelisk,
        rifleAmmo,
        homingRifleAmmo,
        turboRifleAmmo,
        gasFilter,
        iodineInfusedFilter
    ]
}
