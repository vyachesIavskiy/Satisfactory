import StaticModels

private extension Building {
    init(id: String) {
        self.init(id: id, category: .fluidExtractors)
    }
}

extension V2.Buildings {
    static let waterExctractor = Building(id: "building-water-extractor")
    static let oilExctractor = Building(id: "building-oil-extractor")
    static let resourceWellPressurizer = Building(id: "building-resource-well-pressurizer")
    static let resourceWellExtractor = Building(id: "building-resource-well-extractor")
    
    static let fluidExtractorBuildings = [
        waterExctractor,
        oilExctractor,
        resourceWellPressurizer,
        resourceWellExtractor
    ]
}
