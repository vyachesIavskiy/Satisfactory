import Models
import StaticModels

private extension Part.Static.Legacy {
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
    static let colorCartridge = Part.Static.Legacy(id: "color-cartridge")
    static let ironRebar = Part.Static.Legacy(id: "iron-rebar")
    static let stunRebar = Part.Static.Legacy(id: "stun-rebar")
    static let shatterRebar = Part.Static.Legacy(id: "shatter-rebar")
    static let explosiveRebar = Part.Static.Legacy(id: "explosive-rebar")
    static let blackPowder = Part.Static.Legacy(id: "black-powder")
    static let smokelessPowder = Part.Static.Legacy(id: "smokeless-powder")
    static let nobelisk = Part.Static.Legacy(id: "nobelisk")
    static let gasNobelisk = Part.Static.Legacy(id: "gas-nobelisk")
    static let pulseNobelisk = Part.Static.Legacy(id: "pulse-nobelisk")
    static let clusterNobelisk = Part.Static.Legacy(id: "cluster-nobelisk")
    static let nukeNobelisk = Part.Static.Legacy(id: "nuke-nobelisk")
    static let rifleAmmo = Part.Static.Legacy(id: "rifle-ammo")
    static let homingRifleAmmo = Part.Static.Legacy(id: "homing-rifle-ammo")
    static let turboRifleAmmo = Part.Static.Legacy(id: "turbo-rifle-ammo")
    static let gasFilter = Part.Static.Legacy(id: "gas-filter")
    static let iodineInfusedFilter = Part.Static.Legacy(id: "iodine-infused-filter")
    
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
