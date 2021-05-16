private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .motorVehicles)
    }
}

let truckStation = Building(name: "Truck Station")
let dronePort = Building(name: "Drone Port")

let MotorVehicles = [
    truckStation,
    dronePort
]
