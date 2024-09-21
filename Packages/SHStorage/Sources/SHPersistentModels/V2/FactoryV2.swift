import Foundation
import SHModels

extension Factory.Persistent {
    package struct V2: Codable, Identifiable {
        package var id: UUID
        package var name: String
        package var creationDate: Date
        package var asset: Asset.Persistent.V2
        package var productionIDs: [UUID]
        
        package init(id: UUID, name: String, creationDate: Date, asset: Asset.Persistent.V2, productionIDs: [UUID]) {
            self.id = id
            self.name = name
            self.creationDate = creationDate
            self.asset = asset
            self.productionIDs = productionIDs
        }
    }
}
