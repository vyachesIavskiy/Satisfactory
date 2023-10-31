import StaticModels

private extension Building {
    init(id: String) {
        self.init(id: id, category: .smelters)
    }
}

extension V2.Buildings {
    static let smelter = Building(id: "building-smelter")
    static let foundry = Building(id: "building-foundry")
    
    static let smelterBuildings = [
        smelter,
        foundry
    ]
}
