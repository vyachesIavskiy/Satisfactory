import Foundation

struct Equipment: Codable, Resource, CustomStringConvertible {
    let id = UUID()
    let name: String
    let equipmentType: EquipmentType
    let fuel: EquipmentFuel?
    let ammo: EquipmentAmmo?
    
    init(name: String, equipmentType: EquipmentType, fuel: EquipmentFuel? = nil, ammo: EquipmentAmmo? = nil) {
        self.name = name
        self.equipmentType = equipmentType
        self.fuel = fuel
        self.ammo = ammo
    }
}

// MARK: - Hands
let xenoZapper = Equipment(name: "Xeno-Zapper", equipmentType: .hands)
let portableMiner = Equipment(name: "Portable Miner", equipmentType: .hands)
let chainsaw = Equipment(name: "Chainsaw", equipmentType: .hands, fuel: .biofuel)
let objectScanner = Equipment(name: "Object Scanner", equipmentType: .hands)
let beacon = Equipment(name: "Beacon", equipmentType: .hands)
let colorGun = Equipment(name: "Color Gun", equipmentType: .hands, ammo: .colorCartridge)
let xenoBasher = Equipment(name: "Xeno-Basher", equipmentType: .hands)
let factoryCart = Equipment(name: "Factory Cart™", equipmentType: .hands)
let medicalInhaler = Equipment(name: "Medical Inhaler", equipmentType: .hands)
let nutritionalInhaler = Equipment(name: "Nutritional Inhaler", equipmentType: .hands)
let nobeliskDetonator = Equipment(name: "Nobelisk Detonator", equipmentType: .hands, ammo: .nobelisk)
let rebbarGun = Equipment(name: "Rebbar Gun", equipmentType: .hands, ammo: .spikedRebar)

// MARK: - Body
let bladeRunners = Equipment(name: "Blade Runners", equipmentType: .body)
let jetpack = Equipment(name: "Jetpack", equipmentType: .body, fuel: .fuel)
let gasMask = Equipment(name: "Gas Mask", equipmentType: .body, fuel: .filter)
let hazmatSuit = Equipment(name: "Hazmat Suit", equipmentType: .body)
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
    medicalInhaler,
    nutritionalInhaler,
    nobeliskDetonator,
    rebbarGun,
    
    bladeRunners,
    jetpack,
    gasMask,
    hazmatSuit,
    parachute
]
