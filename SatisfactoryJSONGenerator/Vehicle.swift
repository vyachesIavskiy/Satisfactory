import Foundation

struct Vehicle: Encodable {
    let id: String
    let name: String
    
    init(name: String) {
        id = name.idFromName
        self.name = name
    }
}

let tractor = Vehicle(name: "Tractor")
let truck = Vehicle(name: "Truck")
let explorer = Vehicle(name: "Explorer")
let cyberWagon = Vehicle(name: "Cyber Wagon")
let drone = Vehicle(name: "Drone")
let electricLocomotive = Vehicle(name: "Electric Locomotive")
let freightCar = Vehicle(name: "Freight Car")

let Vehicles = [
    tractor,
    truck,
    explorer,
    drone,
    electricLocomotive,
    freightCar
]
