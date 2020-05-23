import Foundation

struct Vehicle: Codable {
    let id = UUID()
    let name: String
}

let tractor = Vehicle(name: "Tractor")
let explorer = Vehicle(name: "Explorer")
let truck = Vehicle(name: "Truck")
let electricLocomotive = Vehicle(name: "Electric Locomotive")
let freightCar = Vehicle(name: "Freight Car")

let Vehicles = [
    tractor,
    explorer,
    truck
]
