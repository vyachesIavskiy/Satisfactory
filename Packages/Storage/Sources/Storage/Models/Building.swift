import StaticModels
import Models

extension Models.Building {
    init(_ building: StaticModels.Building) throws {
        try self.init(
            id: building.id,
            category: Category(fromID: building.id)
        )
    }
}
