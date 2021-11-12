import Foundation

struct Equipment: Encodable, Item, CustomStringConvertible {
    let id: String
    let name: String
    let slot: EquipmentSlot
    let fuel: Part?
    let ammo: Part?
    let consumes: Part?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slot
        case fuel
        case ammo
        case consumes
    }
    
    init(
        name: String,
        slot: EquipmentSlot,
        fuel: Part? = nil,
        ammo: Part? = nil,
        consumes: Part? = nil
    ) {
        self.id = name.idFromName
        self.name = name
        self.slot = slot
        self.fuel = fuel
        self.ammo = ammo
        self.consumes = consumes
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(slot, forKey: .slot)
        if let fuel = fuel {
            try container.encode(fuel.id, forKey: .fuel)
        }
        if let ammo = ammo {
            try container.encode(ammo.id, forKey: .ammo)
        }
        if let consumes = consumes {
            try container.encode(consumes.id, forKey: .consumes)
        }
    }
}

// MARK: - Hands
let xenoZapper = Equipment(name: "Xeno-Zapper", slot: .hands)
let portableMiner = Equipment(name: "Portable Miner", slot: .hands)
let chainsaw = Equipment(name: "Chainsaw", slot: .hands, fuel: solidBiofuel)
let objectScanner = Equipment(name: "Object Scanner", slot: .hands)
let beacon = Equipment(name: "Beacon", slot: .hands) // 91
let rebarGun = Equipment(name: "Rebar Gun", slot: .hands, ammo: spikedRebar)
//let colorGun = Equipment(name: "Color Gun", equipmentType: .hands, ammo: colorCartridge)
let xenoBasher = Equipment(name: "Xeno-Basher", slot: .hands)
let zipline = Equipment(name: "Zipline", slot: .hands)
let factoryCart = Equipment(name: "Factory Cart™", slot: .hands)
let golderFactoryCart = Equipment(name: "Golden Factory Cart™", slot: .hands)
let medicinalInhaler = Equipment(name: "Medicinal Inhaler", slot: .hands)
let nobeliskDetonator = Equipment(name: "Nobelisk Detonator", slot: .hands, ammo: nobelisk)
let coffeCup = Equipment(name: "FICSIT™ Coffe Cup", slot: .hands)
let goldCoffeCup = Equipment(name: "FICSIT™ Gold Coffee Cup", slot: .hands)

// MARK: - Body
let bladeRunners = Equipment(name: "Blade Runners", slot: .body)
let parachute = Equipment(name: "Parachute", slot: .body)
let jetpack = Equipment(name: "Jetpack", slot: .body, fuel: packagedFuel)
let hoverPack = Equipment(name: "Hover Pack", slot: .body)
let gasMask = Equipment(name: "Gas Mask", slot: .body, consumes: gasFilter)
let hazmatSuit = Equipment(name: "Hazmat Suit", slot: .body, consumes: iodineInfusedFilter)

let Equipments = [
    xenoZapper,
    portableMiner,
    chainsaw,
    objectScanner,
    beacon,
    rebarGun,
//    colorGun,
    xenoBasher,
    zipline,
    factoryCart,
    golderFactoryCart,
    medicinalInhaler,
    nobeliskDetonator,
    coffeCup,
    goldCoffeCup,
    
    bladeRunners,
    parachute,
    jetpack,
    hoverPack,
    gasMask,
    hazmatSuit
]
