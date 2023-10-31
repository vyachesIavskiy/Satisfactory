import StaticModels

private extension BuildingLegacy {
    init(id: String, name: String) {
        self.init(id: id, name: name, buildingType: "Smelters")
    }
}

extension Legacy.Buildings {
    static let smelter = BuildingLegacy(id: "building-smelter", name: "Smelter")
    static let foundry = BuildingLegacy(id: "building-foundry", name: "Foundry")
    
    static let smelterBuildings = [
        smelter,
        foundry
    ]
}
