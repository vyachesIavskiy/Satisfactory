import StaticModels

private extension Building {
    init(id: String) {
        self.init(id: id, category: .miners)
    }
}

extension V2.Buildings {
    static let minerMK1 = Building(id: "building-miner-mk-1")
    static let minerMK2 = Building(id: "building-miner-mk-2")
    static let minerMK3 = Building(id: "building-miner-mk-3")
    
    static let minerBuildings = [
        minerMK1,
        minerMK2,
        minerMK3
    ]
}
