import Foundation
import SHModels

extension Pins.Persistent {
    public struct V2: Codable, Equatable {
        public var partIDs: Set<String>
        public var equipmentIDs: Set<String>
        public var recipeIDs: Set<String>
        
        public init(partIDs: Set<String> = [], equipmentIDs: Set<String> = [], recipeIDs: Set<String> = []) {
            self.partIDs = partIDs
            self.equipmentIDs = equipmentIDs
            self.recipeIDs = recipeIDs
        }
    }
}
