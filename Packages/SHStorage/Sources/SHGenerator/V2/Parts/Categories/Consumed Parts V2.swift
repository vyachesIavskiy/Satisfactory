import Models
import StaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .consumed, form: .solid)
    }
}

extension V2.Parts {
    static let colorCartridge = Part.Static(id: "part-color-cartridge")
    static let ironRebar = Part.Static(id: "part-iron-rebar")
    static let stunRebar = Part.Static(id: "part-stun-rebar")
    static let shatterRebar = Part.Static(id: "part-shatter-rebar")
    static let explosiveRebar = Part.Static(id: "part-explosive-rebar")
    static let blackPowder = Part.Static(id: "part-black-powder")
    static let smokelessPowder = Part.Static(id: "part-smokeless-powder")
    static let nobelisk = Part.Static(id: "part-nobelisk")
    static let gasNobelisk = Part.Static(id: "part-gas-nobelisk")
    static let pulseNobelisk = Part.Static(id: "part-pulse-nobelisk")
    static let clusterNobelisk = Part.Static(id: "part-cluster-nobelisk")
    static let nukeNobelisk = Part.Static(id: "part-nuke-nobelisk")
    static let rifleAmmo = Part.Static(id: "part-rifle-ammo")
    static let homingRifleAmmo = Part.Static(id: "part-homing-rifle-ammo")
    static let turboRifleAmmo = Part.Static(id: "part-turbo-rifle-ammo")
    static let gasFilter = Part.Static(id: "part-gas-filter")
    static let iodineInfusedFilter = Part.Static(id: "part-iodine-infused-filter")
    
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
