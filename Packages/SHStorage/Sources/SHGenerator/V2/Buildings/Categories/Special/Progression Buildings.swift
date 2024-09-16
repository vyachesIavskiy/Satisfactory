import SHModels
import SHStaticModels

private extension Building.Static {
    init(id: String) {
        self.init(id: id, category: .fluidExtractors)
    }
}

extension V2.Buildings {
    static let spaceElevator = Building.Static(id: "building-space-elevator")
    
    static let progressionBuildings = [
        spaceElevator,
    ]
}
