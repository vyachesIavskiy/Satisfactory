import Foundation
import Models

extension Part.Persistent {
    public struct Legacy: Decodable {
        public let id: String
        public let isPinned: Bool
        
        public init(id: String, isPinned: Bool) {
            self.id = id
            self.isPinned = isPinned
        }
    }
}
