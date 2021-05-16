private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .windows)
    }
}

let panelWindow = Building(name: "Panel Window")
let singleWindow = Building(name: "Single Window")
let frameWindow = Building(name: "Frame Window")
let reinforcedWindow = Building(name: "Reinforced Window")

let Windows = [
    panelWindow,
    singleWindow,
    frameWindow,
    reinforcedWindow
]
