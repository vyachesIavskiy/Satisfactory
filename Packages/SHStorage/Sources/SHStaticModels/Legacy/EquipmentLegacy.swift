import Foundation
import SHModels

extension Equipment.Static {
    public struct Legacy: Decodable {
        public let id: String
        
        public init(id: String) {
            self.id = id
        }
    }
}
