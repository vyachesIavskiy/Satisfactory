import Foundation

struct Vehicle: Encodable {
    let id: String
    let name: String
    let fuel: [Part]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fuel
    }
    
    init(name: String, fuel: [Part]) {
        id = name.idFromName
        self.name = name
        self.fuel = fuel
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(fuel.map(\.id), forKey: .fuel)
    }
}

private let fuels = [
    leaves,
    wood,
    mycelia,
    alienCarapace,
    alienOrgans,
    flowerPetals,
    colorCartridge,
    fabric,
    biomass,
    solidBiofuel,
    coal,
    compactedCoal,
    petroleumCoke,
    packagedOil,
    packagedHeavyOilResidue,
    packagedFuel,
    packagedTurbofuel,
    packagedLiquidBiofuel,
    battery,
    uraniumFuelRod,
    plutoniumFuelRod
]

let tractor = Vehicle(name: "Tractor", fuel: fuels)
let truck = Vehicle(name: "Truck", fuel: fuels)
let explorer = Vehicle(name: "Explorer", fuel: fuels)
let cyberWagon = Vehicle(name: "Cyber Wagon", fuel: fuels)
let drone = Vehicle(name: "Drone", fuel: [battery])
let electricLocomotive = Vehicle(name: "Electric Locomotive", fuel: [])
let freightCar = Vehicle(name: "Freight Car", fuel: [])

let Vehicles = [
    tractor,
    truck,
    explorer,
    cyberWagon,
    drone,
    electricLocomotive,
    freightCar
]
