import StaticModels
import enum Models.Category

private extension Equipment {
    init(
        id: String,
        category: Category = .hands,
        ammo: [Part]? = nil,
        fuel: [Part]? = nil,
        consumes: [Part]? = nil
    ) {
        self.init(
            id: id,
            category: category,
            slot: .hands,
            ammo: ammo,
            fuel: fuel,
            consumes: consumes
        )
    }
}

extension V2.Equipment {
    static let xenoZapper = Equipment(id: "equipment-xeno-zapper")
    static let portableMiner = Equipment(id: "equipment-portable-miner")
    static let objectScanner = Equipment(id: "equipment-object-scanner")
    static let beacon = Equipment(id: "equipment-beacon")
    static let rebarGun = Equipment(id: "equipment-rebar-gun", ammo: [
        V2.Parts.ironRebar
    ])
    static let medicinalInhaler = Equipment(id: "equipment-medicinal-inhaler")
    static let chainsaw = Equipment(id: "equipment-chainsaw", fuel: [V2.Parts.solidBiofuel])
    static let xenoBasher = Equipment(id: "equipment-xeno-basher")
    static let zipline = Equipment(id: "equipment-zipline")
    static let nobeliskDetonator = Equipment(id: "equipment-nobelisk-detonator", ammo: [
        V2.Parts.nobelisk
    ])
    static let rifle = Equipment(id: "equipment-rifle", ammo: [
        V2.Parts.rifleAmmo
    ])
    static let factoryCart = Equipment(id: "equipment-factory-cart", category: .special)
    static let coffeCup = Equipment(id: "equipment-ficsit-coffe-cup")
    static let goldenFactoryCart = Equipment(id: "equipment-golden-factory-cart", category: .special)
    static let goldCoffeCup = Equipment(id: "equipment-ficsit-gold-coffee-cup")
    static let candyCaneBasher = Equipment(id: "equipment-candy-cane-basher")
    static let boombox = Equipment(id: "equipment-boombox")
    
    static let handEquipment = [
        xenoZapper,
        portableMiner,
        objectScanner,
        beacon,
        rebarGun,
        medicinalInhaler,
        chainsaw,
        xenoBasher,
        zipline,
        nobeliskDetonator,
        rifle,
        factoryCart,
        coffeCup,
        goldenFactoryCart,
        goldCoffeCup,
        candyCaneBasher,
        boombox
    ]
}
