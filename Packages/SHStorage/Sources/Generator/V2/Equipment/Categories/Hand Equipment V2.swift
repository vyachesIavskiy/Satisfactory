import Models
import StaticModels
import enum Models.Category

private extension Equipment.Static {
    init(
        id: String,
        category: Category = .hands,
        ammo: [Part.Static]? = nil,
        fuel: [Part.Static]? = nil,
        consumes: [Part.Static]? = nil
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
    static let xenoZapper = Equipment.Static(id: "equipment-xeno-zapper")
    static let portableMiner = Equipment.Static(id: "equipment-portable-miner")
    static let objectScanner = Equipment.Static(id: "equipment-object-scanner")
    static let beacon = Equipment.Static(id: "equipment-beacon")
    static let rebarGun = Equipment.Static(id: "equipment-rebar-gun", ammo: [
        V2.Parts.ironRebar
    ])
    static let medicinalInhaler = Equipment.Static(id: "equipment-medicinal-inhaler")
    static let chainsaw = Equipment.Static(id: "equipment-chainsaw", fuel: [V2.Parts.solidBiofuel])
    static let xenoBasher = Equipment.Static(id: "equipment-xeno-basher")
    static let zipline = Equipment.Static(id: "equipment-zipline")
    static let nobeliskDetonator = Equipment.Static(id: "equipment-nobelisk-detonator", ammo: [
        V2.Parts.nobelisk
    ])
    static let rifle = Equipment.Static(id: "equipment-rifle", ammo: [
        V2.Parts.rifleAmmo
    ])
    static let factoryCart = Equipment.Static(id: "equipment-factory-cart", category: .special)
    static let coffeCup = Equipment.Static(id: "equipment-ficsit-coffe-cup")
    static let goldenFactoryCart = Equipment.Static(id: "equipment-golden-factory-cart", category: .special)
    static let goldCoffeCup = Equipment.Static(id: "equipment-ficsit-gold-coffee-cup")
    static let candyCaneBasher = Equipment.Static(id: "equipment-candy-cane-basher")
    static let boombox = Equipment.Static(id: "equipment-boombox")
    
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
