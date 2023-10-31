import StaticModels

private extension Building {
    init(id: String) {
        self.init(id: id, category: .generators)
    }
}

extension V2.Buildings {
    static let nuclearPowerPlant = Building(id: "building-nuclear-power-plant")
    
    static let generatorBuildings = [
        nuclearPowerPlant
    ]
}
