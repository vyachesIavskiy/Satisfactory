import Foundation
import SHModels
import SHStaticModels

extension FromResourcesProduction.Persistent {
    package struct V2: Codable, Identifiable, Hashable {
        package var id: UUID
        package var name: String
        package var asset: Asset.Persistent.V2
        
        package init(id: UUID, name: String, asset: Asset.Persistent.V2) {
            self.id = id
            self.name = name
            self.asset = asset
        }
        
        mutating func migrate(_ migration: Migration) {
            // TODO: Add migration
        }
    }
}
