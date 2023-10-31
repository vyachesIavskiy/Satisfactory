import StaticModels

private extension BuildingLegacy {
    init(id: String, name: String) {
        self.init(id: id, name: name, buildingType: "Generators")
    }
}

extension Legacy.Buildings {
    static let nuclearPowerPlant = BuildingLegacy(id: "building-nuclear-power-plant", name: "Nuclear Power Plant")
    
    static let generatorBuildings = [
        nuclearPowerPlant
    ]
}
