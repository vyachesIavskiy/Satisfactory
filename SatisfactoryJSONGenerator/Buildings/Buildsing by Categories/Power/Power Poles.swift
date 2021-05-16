private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .powerPoles)
    }
}

let powerLine = Building(name: "Power Line")
let powerPoleMK1 = Building(name: "Power Pole MK.1")
let powerPoleMK2 = Building(name: "Power Pole MK.2")
let powerPoleMK3 = Building(name: "Power Pole MK.3")
let powerSwitch = Building(name: "Power Switch")

let PowerPoles = [
    powerLine,
    powerPoleMK1,
    powerPoleMK2,
    powerPoleMK3,
    powerSwitch
]
