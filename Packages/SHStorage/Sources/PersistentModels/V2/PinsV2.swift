import Foundation

extension Pins.Persistent {
    public struct V2: Codable {
        public var partIDs: Set<String>
        public var equipmentIDs: Set<String>
        public var recipeIDs: Set<String>
        
        public var isEmpty: Bool {
            partIDs.isEmpty && equipmentIDs.isEmpty && recipeIDs.isEmpty
        }
        
        public init(partIDs: Set<String> = [], equipmentIDs: Set<String> = [], recipeIDs: Set<String> = []) {
            self.partIDs = partIDs
            self.equipmentIDs = equipmentIDs
            self.recipeIDs = recipeIDs
        }
    }
}
