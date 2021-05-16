private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .lights)
    }
}

let streetLight = Building(name: "Street Light")
let ceilingLight = Building(name: "Ceiling Light")
let floodLightTower = Building(name: "Flood Light Tower")
let wallMountedFloodLight = Building(name: "Wall Mounted Flood Light")
let lightsControlPanel = Building(name: "Lights Control Panel")

let Lights = [
    streetLight,
    ceilingLight,
    floodLightTower,
    wallMountedFloodLight,
    lightsControlPanel
]
