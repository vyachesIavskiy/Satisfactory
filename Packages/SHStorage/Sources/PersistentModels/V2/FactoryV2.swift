import Foundation
import Models

extension Factory.Persistent {
    public struct V2: Codable, Identifiable {
        public var id: UUID
        public var name: String
        public var image: Image
        public var productionIDs: [UUID]
        
        public init(id: UUID, name: String, image: Image, productionIDs: [UUID]) {
            self.id = id
            self.name = name
            self.image = image
            self.productionIDs = productionIDs
        }
    }
}

extension Factory.Persistent.V2 {
    public enum Image: Codable {
        case legacy
        case abbreviation
        case asset(name: String)
    }
}
