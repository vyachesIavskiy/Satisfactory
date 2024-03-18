import Models
import StaticModels

private extension Building.Static.Legacy {
    init(id: String, name: String) {
        self.init(id: id, name: name, buildingType: "Generators")
    }
}

extension Legacy.Buildings {
    static let nuclearPowerPlant = Building.Static.Legacy(id: "building-nuclear-power-plant", name: "Nuclear Power Plant")
    
    static let generatorBuildings = [
        nuclearPowerPlant
    ]
}
