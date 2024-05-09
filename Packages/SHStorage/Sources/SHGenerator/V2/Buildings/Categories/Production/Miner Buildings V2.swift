import Models
import StaticModels

private extension Building.Static {
    init(id: String) {
        self.init(id: id, category: .miners)
    }
}

extension V2.Buildings {
    static let minerMK1 = Building.Static(id: "building-miner-mk-1")
    static let minerMK2 = Building.Static(id: "building-miner-mk-2")
    static let minerMK3 = Building.Static(id: "building-miner-mk-3")
    
    static let minerBuildings = [
        minerMK1,
        minerMK2,
        minerMK3
    ]
}
