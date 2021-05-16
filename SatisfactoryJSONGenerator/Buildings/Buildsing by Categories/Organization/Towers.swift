private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .towers)
    }
}

let lookoutTower = Building(name: "Lookout Tower")
let radarTower = Building(name: "Radar Tower")

let Towers = [
    lookoutTower,
    radarTower
]
