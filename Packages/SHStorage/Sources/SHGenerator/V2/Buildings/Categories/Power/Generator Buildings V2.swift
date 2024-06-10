import SHModels
import SHStaticModels

private extension Building.Static {
    init(id: String) {
        self.init(id: id, category: .generators)
    }
}

extension V2.Buildings {
    static let nuclearPowerPlant = Building.Static(id: "building-nuclear-power-plant")
    
    static let generatorBuildings = [
        nuclearPowerPlant
    ]
}
