import SHModels
import SHStaticModels

private extension Building.Static {
    init(id: String) {
        self.init(id: id, category: .fluidExtractors)
    }
}

extension V2.Buildings {
    static let waterExctractor = Building.Static(id: "building-water-extractor")
    static let oilExctractor = Building.Static(id: "building-oil-extractor")
    static let resourceWellPressurizer = Building.Static(id: "building-resource-well-pressurizer")
    static let resourceWellExtractor = Building.Static(id: "building-resource-well-extractor")
    
    static let fluidExtractorBuildings = [
        waterExctractor,
        oilExctractor,
        resourceWellPressurizer,
        resourceWellExtractor
    ]
}
