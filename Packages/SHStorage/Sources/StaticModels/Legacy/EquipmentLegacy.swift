import Foundation
import Models

extension Equipment.Static {
    public struct Legacy: Decodable {
        public let id: String
        public let name: String
        public let slot: String
        public let ammo: String?
        public let fuel: String?
        public let consumes: String?
        
        public init(id: String, name: String, slot: String, ammo: String?, fuel: String?, consumes: String?) {
            self.id = id
            self.name = name
            self.slot = slot
            self.ammo = ammo
            self.fuel = fuel
            self.consumes = consumes
        }
    }
}
