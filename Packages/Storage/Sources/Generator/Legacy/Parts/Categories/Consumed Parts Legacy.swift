import StaticModels

private extension PartLegacy {
    init(id: String) {
        self.init(
            id: id,
            name: id,
            partType: PartTypeLegacy.consumed.rawValue,
            tier: 0,
            milestone: 0,
            sortingPriority: 0,
            rawResource: false
        )
    }
}

extension Legacy.Parts {
    static let colorCartridge = PartLegacy(id: "color-cartridge")
    static let ironRebar = PartLegacy(id: "iron-rebar")
    static let stunRebar = PartLegacy(id: "stun-rebar")
    static let shatterRebar = PartLegacy(id: "shatter-rebar")
    static let explosiveRebar = PartLegacy(id: "explosive-rebar")
    static let blackPowder = PartLegacy(id: "black-powder")
    static let smokelessPowder = PartLegacy(id: "smokeless-powder")
    static let nobelisk = PartLegacy(id: "nobelisk")
    static let gasNobelisk = PartLegacy(id: "gas-nobelisk")
    static let pulseNobelisk = PartLegacy(id: "pulse-nobelisk")
    static let clusterNobelisk = PartLegacy(id: "cluster-nobelisk")
    static let nukeNobelisk = PartLegacy(id: "nuke-nobelisk")
    static let rifleAmmo = PartLegacy(id: "rifle-ammo")
    static let homingRifleAmmo = PartLegacy(id: "homing-rifle-ammo")
    static let turboRifleAmmo = PartLegacy(id: "turbo-rifle-ammo")
    static let gasFilter = PartLegacy(id: "gas-filter")
    static let iodineInfusedFilter = PartLegacy(id: "iodine-infused-filter")
    
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
