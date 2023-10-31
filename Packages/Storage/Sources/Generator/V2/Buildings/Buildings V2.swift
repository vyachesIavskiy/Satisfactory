import StaticModels
import Models

extension StaticModels.Building {
    init(id: String, category: Models.Category) {
        self.init(id: id, categoryID: category.id)
    }
}

extension V2 {
    enum Buildings {
        static let all =
        generatorBuildings +
        fluidExtractorBuildings +
        manufacturerBuildings +
        minerBuildings +
        smelterBuildings +
        workstationBuildingsV2
    }
}
