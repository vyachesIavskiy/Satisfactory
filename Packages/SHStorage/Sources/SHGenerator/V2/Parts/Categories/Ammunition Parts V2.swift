import SHModels
import SHStaticModels

private extension Part.Static {
    init(id: String) {
        self.init(id: id, category: .ammunition, form: .solid)
    }
}

extension V2.Parts {
    static let blackPowder = Part.Static(id: "part-black-powder")
    static let smokelessPowder = Part.Static(id: "part-smokeless-powder")
    static let ironRebar = Part.Static(id: "part-iron-rebar")
    static let stunRebar = Part.Static(id: "part-stun-rebar")
    static let shatterRebar = Part.Static(id: "part-shatter-rebar")
    static let explosiveRebar = Part.Static(id: "part-explosive-rebar")
    static let nobelisk = Part.Static(id: "part-nobelisk")
    static let gasNobelisk = Part.Static(id: "part-gas-nobelisk")
    static let pulseNobelisk = Part.Static(id: "part-pulse-nobelisk")
    static let clusterNobelisk = Part.Static(id: "part-cluster-nobelisk")
    static let nukeNobelisk = Part.Static(id: "part-nuke-nobelisk")
    static let rifleAmmo = Part.Static(id: "part-rifle-ammo")
    static let homingRifleAmmo = Part.Static(id: "part-homing-rifle-ammo")
    static let turboRifleAmmo = Part.Static(id: "part-turbo-rifle-ammo")
    
    static let ammunitionParts = [
        blackPowder,
        smokelessPowder,
        ironRebar,
        stunRebar,
        shatterRebar,
        explosiveRebar,
        nobelisk,
        gasNobelisk,
        pulseNobelisk,
        clusterNobelisk,
        nukeNobelisk,
        rifleAmmo,
        homingRifleAmmo,
        turboRifleAmmo,
    ]
}
