private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .miners)
    }
}

let minerMK1 = Building(name: "Miner MK.1")
let minerMK2 = Building(name: "Miner MK.2")
let minerMK3 = Building(name: "Miner MK.3")

let Miners = [
    minerMK1,
    minerMK2,
    minerMK3
]
