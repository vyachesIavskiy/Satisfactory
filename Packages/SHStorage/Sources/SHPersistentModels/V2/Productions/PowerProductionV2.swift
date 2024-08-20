import Foundation
import SHModels
import SHStaticModels

extension PowerProduction.Persistent {
    public struct V2: Codable, Identifiable, Hashable {
        public var id: UUID
        public var name: String
        public var asset: Asset.Persistent.V2
        
        public init(id: UUID, name: String, asset: Asset.Persistent.V2) {
            self.id = id
            self.name = name
            self.asset = asset
        }
        
        mutating func migrate(_ migration: Migration) {
            // TODO: Add migration
        }
    }
}
