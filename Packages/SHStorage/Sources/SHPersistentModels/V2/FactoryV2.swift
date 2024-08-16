import Foundation
import SHModels

extension Factory.Persistent {
    public struct V2: Codable, Identifiable {
        public var id: UUID
        public var name: String
        public var asset: Asset.Persistent.V2
        public var productionIDs: [UUID]
        
        public init(id: UUID, name: String, asset: Asset.Persistent.V2, productionIDs: [UUID]) {
            self.id = id
            self.name = name
            self.asset = asset
            self.productionIDs = productionIDs
        }
    }
}
