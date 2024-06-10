import SHModels
import SHStaticModels

private extension Building.Static {
    init(id: String) {
        self.init(id: id, category: .smelters)
    }
}

extension V2.Buildings {
    static let smelter = Building.Static(id: "building-smelter")
    static let foundry = Building.Static(id: "building-foundry")
    
    static let smelterBuildings = [
        smelter,
        foundry
    ]
}
