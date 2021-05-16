private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .smelters)
    }
}

let smelter = Building(name: "Smelter")
let foundry = Building(name: "Foundry")

let Smelters = [
    smelter,
    foundry
]
