private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .railedVehicles)
    }
}

let trainStation = Building(name: "Train Station")
let freightPlatform = Building(name: "Freight Platform")
let fluidFreightPlatform = Building(name: "Fluid Freight Platform")
let emptyPlatform = Building(name: "Empty Platform")
let railway = Building(name: "Railway")

let RailedVehicles = [
    trainStation,
    freightPlatform,
    fluidFreightPlatform,
    emptyPlatform,
    railway
]
