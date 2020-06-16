import Foundation

struct Equipment: Codable, Resource, CustomStringConvertible {
    let id = UUID()
    let name: String
    let equipmentType: EquipmentType
    let fuel: Part?
    let ammo: Part?
    
    init(name: String, equipmentType: EquipmentType, fuel: Part? = nil, ammo: Part? = nil) {
        self.name = name
        self.equipmentType = equipmentType
        self.fuel = fuel
        self.ammo = ammo
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(equipmentType, forKey: .equipmentType)
        if let fuel = fuel {
            try container.encode(fuel.id, forKey: .fuel)
        }
        if let ammo = ammo {
            try container.encode(ammo.id, forKey: .ammo)
        }
    }
}

// MARK: - Hands
let xenoZapper = Equipment(name: "Xeno-Zapper", equipmentType: .hands)
let portableMiner = Equipment(name: "Portable Miner", equipmentType: .hands)
let chainsaw = Equipment(name: "Chainsaw", equipmentType: .hands, fuel: solidBiofuel)
let objectScanner = Equipment(name: "Object Scanner", equipmentType: .hands)
let beacon = Equipment(name: "Beacon", equipmentType: .hands)
let colorGun = Equipment(name: "Color Gun", equipmentType: .hands, ammo: colorCartridge)
let xenoBasher = Equipment(name: "Xeno-Basher", equipmentType: .hands)
let factoryCart = Equipment(name: "Factory Cart™", equipmentType: .hands)
let medicinalInhaler = Equipment(name: "Medicinal Inhaler", equipmentType: .hands)
let nobeliskDetonator = Equipment(name: "Nobelisk Detonator", equipmentType: .hands, ammo: nobelisk)
let rebarGun = Equipment(name: "Rebar Gun", equipmentType: .hands, ammo: spikedRebar)

// MARK: - Body
let bladeRunners = Equipment(name: "Blade Runners", equipmentType: .body)
let jetpack = Equipment(name: "Jetpack", equipmentType: .body, fuel: packagedFuel)
let gasMask = Equipment(name: "Gas Mask", equipmentType: .body, fuel: gasFilter)
let hazmatSuit = Equipment(name: "Hazmat Suit", equipmentType: .body, fuel: iodineInfusedFilter)
let parachute = Equipment(name: "Parachute", equipmentType: .body)

let Equipments = [
    xenoZapper,
    portableMiner,
    chainsaw,
    objectScanner,
    beacon,
    colorGun,
    xenoBasher,
    factoryCart,
    medicinalInhaler,
    nobeliskDetonator,
    rebarGun,
    
    bladeRunners,
    jetpack,
    gasMask,
    hazmatSuit,
    parachute
]
