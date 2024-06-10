import SHModels
import SHStaticModels

extension Building.Static {
    init(id: String, category: Category) {
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
