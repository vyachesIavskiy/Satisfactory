import Foundation
import SHModels

extension PowerProduction.Persistent {
    public struct V2: Codable, Identifiable, Hashable {
        public var id: UUID
        public var name: String
        public var asset: Asset.Persistent.V2
    }
}
