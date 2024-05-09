import Models
import StaticModels

private extension Building.Static.Legacy {
    init(id: String, name: String) {
        self.init(id: id, name: name, buildingType: "Smelters")
    }
}

extension Legacy.Buildings {
    static let smelter = Building.Static.Legacy(id: "smelter", name: "Smelter")
    static let foundry = Building.Static.Legacy(id: "foundry", name: "Foundry")
    
    static let smelterBuildings = [
        smelter,
        foundry
    ]
}
