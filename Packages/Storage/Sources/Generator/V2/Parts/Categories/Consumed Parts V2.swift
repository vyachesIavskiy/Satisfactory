import StaticModels

private extension Part {
    init(id: String) {
        self.init(id: id, category: .consumed, form: .solid)
    }
}

extension V2.Parts {
    static let colorCartridge = Part(id: "part-color-cartridge")
    static let ironRebar = Part(id: "part-iron-rebar")
    static let stunRebar = Part(id: "part-stun-rebar")
    static let shatterRebar = Part(id: "part-shatter-rebar")
    static let explosiveRebar = Part(id: "part-explosive-rebar")
    static let blackPowder = Part(id: "part-black-powder")
    static let smokelessPowder = Part(id: "part-smokeless-powder")
    static let nobelisk = Part(id: "part-nobelisk")
    static let gasNobelisk = Part(id: "part-gas-nobelisk")
    static let pulseNobelisk = Part(id: "part-pulse-nobelisk")
    static let clusterNobelisk = Part(id: "part-cluster-nobelisk")
    static let nukeNobelisk = Part(id: "part-nuke-nobelisk")
    static let rifleAmmo = Part(id: "part-rifle-ammo")
    static let homingRifleAmmo = Part(id: "part-homing-rifle-ammo")
    static let turboRifleAmmo = Part(id: "part-turbo-rifle-ammo")
    static let gasFilter = Part(id: "part-gas-filter")
    static let iodineInfusedFilter = Part(id: "part-iodine-infused-filter")
    
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
