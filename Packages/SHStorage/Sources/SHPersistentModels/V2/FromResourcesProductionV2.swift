import Foundation
import SHModels

extension FromResourcesProduction.Persistent {
    public struct V2: Codable, Identifiable, Hashable {
        public var id: UUID
        public var name: String
        public var asset: Asset.Persistent.V2
    }
}
